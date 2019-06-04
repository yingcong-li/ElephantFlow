/*
Supported hash algorithms are:
  crc16, crc32, crc32_extend, crc32_lsb, crc32_msb, crc_16, 
  crc_16_buypass, crc_16_dds_110, crc_16_dect, crc_16_dnp, 
  crc_16_en_13757, crc_16_genibus, crc_16_maxim, crc_16_mcrf4xx, 
  crc_16_riello, crc_16_t10_dif, crc_16_teledisk, crc_16_usb, crc_32, 
  crc_32_bzip2, crc_32_mpeg, crc_32c, crc_32d, crc_32q, crc_64, 
  crc_64_jones, crc_64_we, crc_8, crc_8_darc, crc_8_i_code, crc_8_itu, 
  crc_8_maxim, crc_8_rohc, crc_8_wcdma, crc_aug_ccitt, crc_ccitt_false, 
  identity, identity_lsb, identity_msb, jamcrc, kermit, modbus, posix, 
  random, x_25, xfer, xmodem
  */

register count_min2_reg_1 {
	width: REG_MAX_WIDTH;
	instance_count: REG_MAX_LEN;
}
register count_min2_reg_2 {
	width: REG_MAX_WIDTH;
	instance_count: REG_MAX_LEN;
}
register count_min2_reg_3 {
	width: REG_MAX_WIDTH;
	instance_count: REG_MAX_LEN;
}
register count_min2_reg_4 {
	width: REG_MAX_WIDTH;
	instance_count: REG_MAX_LEN;
}

blackbox stateful_alu stateful_cm2_reg_1 {
	reg: count_min2_reg_1;
	update_lo_1_value: register_lo + 1;
	condition_lo: register_lo > THRESHOLD;
	output_predicate: condition_lo;
	output_value: combined_predicate;
	output_dst: md.cm2_1;
}
blackbox stateful_alu stateful_cm2_reg_2 {
	reg: count_min2_reg_2;
	update_lo_1_value: register_lo + 1;
	condition_lo: register_lo > THRESHOLD;
	output_predicate: condition_lo;
	output_value: combined_predicate;
	output_dst: md.cm2_2;
}
blackbox stateful_alu stateful_cm2_reg_3 {
	reg: count_min2_reg_3;
	update_lo_1_value: register_lo + 1;
	condition_lo: register_lo > THRESHOLD;
	output_predicate: condition_lo;
	output_value: combined_predicate;
	output_dst: md.cm2_3;
}
blackbox stateful_alu stateful_cm2_reg_4 {
	reg: count_min2_reg_4;
	update_lo_1_value: register_lo + 1;
	condition_lo: register_lo > THRESHOLD;
	output_predicate: condition_lo;
	output_value: combined_predicate;
	output_dst: md.cm2_4;
}
table count_min2_table_1 {
	actions {
		count_min2_act_1;
	}
}
table count_min2_table_2 {
	actions {
		count_min2_act_2;
	}
}
table count_min2_table_3 {
	actions {
		count_min2_act_3;
	}
}
table count_min2_table_4 {
	actions {
		count_min2_act_4;
	}
}
action count_min2_act_1 (){
	stateful_cm2_reg_1.execute_stateful_alu(md.index21);
}
action count_min2_act_2 (){
	stateful_cm2_reg_2.execute_stateful_alu(md.index22);
}
action count_min2_act_3 (){
	stateful_cm2_reg_3.execute_stateful_alu(md.index23);
}
action count_min2_act_4 (){
	stateful_cm2_reg_4.execute_stateful_alu(md.index24);
}

table set_cm2_nop_table {
	actions {
		set_cm2_nop_act;
	}
}
table set_cm2_cm2_table {
	actions {
		set_cm2_cm2_act;
	}
}
action set_cm2_nop_act (){
	modify_field(md.cm2, 0);
}
action set_cm2_cm2_act (){
	modify_field(md.cm2, 1);
}
control count_min2 {
    apply(count_min2_table_1);
    apply(count_min2_table_2);
    apply(count_min2_table_3);
    apply(count_min2_table_4);
    if (md.cm2_1 == 1 and md.cm2_2 == 1 and md.cm2_3 == 1 and md.cm2_4 == 1) {
		apply(set_cm2_cm2_table);
	}
	else apply(set_cm2_nop_table);
}
