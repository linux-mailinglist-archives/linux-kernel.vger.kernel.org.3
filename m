Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489814E29FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351712AbiCUOLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348803AbiCUODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:03:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4401543480;
        Mon, 21 Mar 2022 07:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647871274; x=1679407274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hIen9Z7wLd+Ry77Vwb3icZYihUovoSxjvkDO2KRoaVY=;
  b=mT7UgVxIlxCv7wvTC6TyeGM7hNjy3+m2JwODO1nIv1EkFqMatyJCCPUN
   REIpMwrvUjxlPgT7aKGvlyBYBiR20az+kCHb8K3ZbAyYYkHFGagx6FW6J
   xtw9jyQLN/EXw7AaQ7pegfZMR/I4N9aOu50yV2F1SV1bg74AOrh5GaWDo
   gcS341QLjJKgIRWH63NrYVBCCQeykhAubHxtmbsqpgLlTdeIedBY6To8a
   HoLx6ZFsLQNdP5RGyYSN1OlgPwnpMAcUaiwzDf2+aSoMhhFpBtle2xBDP
   Xji2HX+sjlSDmQAQCHmDchnBArzUiImc4X5OgRld93EIhO4j1lb+o0vAg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="255121571"
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="255121571"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 07:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,198,1643702400"; 
   d="scan'208";a="716506931"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2022 07:01:08 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     ak@linux.intel.com, ahmad.yasin@intel.com,
        zhengjun.xing@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf script: Add 'brstackinsnlen' for branch stacks
Date:   Mon, 21 Mar 2022 07:00:12 -0700
Message-Id: <1647871212-184070-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

When analyzing with the perf script, it's useful to understand the
captured instruction and the next sequential instruction. To calculate
the address of the next sequential instruction, the length of the
captured instruction is required. For example, you can’t know the next
sequential instruction after an unconditional branch unless you
calculate that based on its length.

For branch stacks, the current perf script only prints the instruction
bytes with 'brstackinsn', but lack of instruction length.

Add 'brstackinsnlen' to print the instruction length.

$perf script -F ip,brstackinsn,brstackinsnlen --xed
     7fa555be8f75
        _start:
        00007fa555be8090        mov %rsp, %rdi          ilen: 3
        00007fa555be8093        callq  0x7fa555be8ea0   ilen: 5 # PRED
102 cycles [102] 0.02 IPC
        _dl_start+38:
        00007fa555be8ec6        movq  %rdx,0x227853(%rip)       ilen: 7
        00007fa555be8ecd        leaq  0x227f94(%rip),%rdx       ilen: 7

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-script.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fa478dd..5a7b2b0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -124,6 +124,7 @@ enum perf_output_field {
 	PERF_OUTPUT_DATA_PAGE_SIZE  = 1ULL << 33,
 	PERF_OUTPUT_CODE_PAGE_SIZE  = 1ULL << 34,
 	PERF_OUTPUT_INS_LAT         = 1ULL << 35,
+	PERF_OUTPUT_BRSTACKINSNLEN  = 1ULL << 36,
 };
 
 struct perf_script {
@@ -191,6 +192,7 @@ struct output_option {
 	{.str = "data_page_size", .field = PERF_OUTPUT_DATA_PAGE_SIZE},
 	{.str = "code_page_size", .field = PERF_OUTPUT_CODE_PAGE_SIZE},
 	{.str = "ins_lat", .field = PERF_OUTPUT_INS_LAT},
+	{.str = "brstackinsnlen", .field = PERF_OUTPUT_BRSTACKINSNLEN},
 };
 
 enum {
@@ -488,7 +490,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		       "selected. Hence, no address to lookup the source line number.\n");
 		return -EINVAL;
 	}
-	if (PRINT_FIELD(BRSTACKINSN) && !allow_user_set &&
+	if ((PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN)) && !allow_user_set &&
 	    !(evlist__combined_branch_type(session->evlist) & PERF_SAMPLE_BRANCH_ANY)) {
 		pr_err("Display of branch stack assembler requested, but non all-branch filter set\n"
 		       "Hint: run 'perf record -b ...'\n");
@@ -1122,10 +1124,17 @@ static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
 
 static int ip__fprintf_jump(uint64_t ip, struct branch_entry *en,
 			    struct perf_insn *x, u8 *inbuf, int len,
-			    int insn, FILE *fp, int *total_cycles)
+			    int insn, FILE *fp, int *total_cycles,
+			    struct perf_event_attr *attr)
 {
-	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t#%s%s%s%s", ip,
-			      dump_insn(x, ip, inbuf, len, NULL),
+	int ilen = 0;
+	int printed = fprintf(fp, "\t%016" PRIx64 "\t%-30s\t", ip,
+			      dump_insn(x, ip, inbuf, len, &ilen));
+
+	if (PRINT_FIELD(BRSTACKINSNLEN))
+		printed += fprintf(fp, "ilen: %d\t", ilen);
+
+	printed += fprintf(fp, "#%s%s%s%s",
 			      en->flags.predicted ? " PRED" : "",
 			      en->flags.mispred ? " MISPRED" : "",
 			      en->flags.in_tx ? " INTX" : "",
@@ -1211,7 +1220,8 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 		printed += ip__fprintf_sym(entries[nr - 1].from, thread,
 					   x.cpumode, x.cpu, &lastsym, attr, fp);
 		printed += ip__fprintf_jump(entries[nr - 1].from, &entries[nr - 1],
-					    &x, buffer, len, 0, fp, &total_cycles);
+					    &x, buffer, len, 0, fp, &total_cycles,
+					    attr);
 		if (PRINT_FIELD(SRCCODE))
 			printed += print_srccode(thread, x.cpumode, entries[nr - 1].from);
 	}
@@ -1242,14 +1252,17 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			printed += ip__fprintf_sym(ip, thread, x.cpumode, x.cpu, &lastsym, attr, fp);
 			if (ip == end) {
 				printed += ip__fprintf_jump(ip, &entries[i], &x, buffer + off, len - off, ++insn, fp,
-							    &total_cycles);
+							    &total_cycles, attr);
 				if (PRINT_FIELD(SRCCODE))
 					printed += print_srccode(thread, x.cpumode, ip);
 				break;
 			} else {
 				ilen = 0;
-				printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", ip,
+				printed += fprintf(fp, "\t%016" PRIx64 "\t%s", ip,
 						   dump_insn(&x, ip, buffer + off, len - off, &ilen));
+				if (PRINT_FIELD(BRSTACKINSNLEN))
+					printed += fprintf(fp, "\tilen: %d", ilen);
+				printed += fprintf(fp, "\n");
 				if (ilen == 0)
 					break;
 				if (PRINT_FIELD(SRCCODE))
@@ -1292,16 +1305,23 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 			      machine, thread, &x.is64bit, &x.cpumode, false);
 		if (len <= 0)
 			goto out;
-		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", sample->ip,
-			dump_insn(&x, sample->ip, buffer, len, NULL));
+		ilen = 0;
+		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", sample->ip,
+			dump_insn(&x, sample->ip, buffer, len, &ilen));
+		if (PRINT_FIELD(BRSTACKINSNLEN))
+			printed += fprintf(fp, "\tilen: %d", ilen);
+		printed += fprintf(fp, "\n");
 		if (PRINT_FIELD(SRCCODE))
 			print_srccode(thread, x.cpumode, sample->ip);
 		goto out;
 	}
 	for (off = 0; off <= end - start; off += ilen) {
 		ilen = 0;
-		printed += fprintf(fp, "\t%016" PRIx64 "\t%s\n", start + off,
+		printed += fprintf(fp, "\t%016" PRIx64 "\t%s", start + off,
 				   dump_insn(&x, start + off, buffer + off, len - off, &ilen));
+		if (PRINT_FIELD(BRSTACKINSNLEN))
+			printed += fprintf(fp, "\tilen: %d", ilen);
+		printed += fprintf(fp, "\n");
 		if (ilen == 0)
 			break;
 		if (arch_is_branch(buffer + off, len - off, x.is64bit) && start + off != sample->ip) {
@@ -1459,7 +1479,7 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 		for (i = 0; i < sample->insn_len; i++)
 			printed += fprintf(fp, " %02x", (unsigned char)sample->insn[i]);
 	}
-	if (PRINT_FIELD(BRSTACKINSN))
+	if (PRINT_FIELD(BRSTACKINSN) || PRINT_FIELD(BRSTACKINSNLEN))
 		printed += perf_sample__fprintf_brstackinsn(sample, thread, attr, machine, fp);
 
 	return printed;
@@ -3716,7 +3736,7 @@ int cmd_script(int argc, const char **argv)
 		     "Valid types: hw,sw,trace,raw,synth. "
 		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
-		     "brstacksym,flags,bpf-output,brstackinsn,brstackoff,"
+		     "brstacksym,flags,bpf-output,brstackinsn,brstackinsnlen,brstackoff,"
 		     "callindent,insn,insnlen,synth,phys_addr,metric,misc,ipc,tod,"
 		     "data_page_size,code_page_size,ins_lat",
 		     parse_output_fields),
-- 
2.7.4

