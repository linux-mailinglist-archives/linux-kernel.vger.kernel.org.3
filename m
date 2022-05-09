Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663E152010E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238295AbiEIP2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiEIP17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:27:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D30F2B031E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652109845; x=1683645845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NoOuv2sVQKVnkCazGHVLdKtPkXcHV8vFl+UvJJbw3v4=;
  b=Ojo+jM462I9uHxct8Qb5TTgK4o4qVdbZMExgE4fRsRsKTAR+sUaEFlHq
   zphi/q1+Nq9FKPciaRYlsPvvAwaAJemWs5uXRDvJl42LTTk5XgrFb4fdw
   2L2A+EULTH4vFLsDDtYgg6rZYLx89wvq9KtE5KOndFFBMfwmx+uIFyZxu
   mLeQVLfTy3FqvV4WQdPwSV8TrMY9C91B/a6dkqTytTrDmPl7ntE9art4N
   WzfH3rhgduG4Gy7XR815si9uvPvxqO7xZOyeL7vSDX8TQhkqsqYCCv66N
   uPdB/u9dcCaco97p9XqkZ09mKknNpNx6IkIFHJMYLkXtFFT8LBbFo00+7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="294306856"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="294306856"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 08:24:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="592705298"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2022 08:24:03 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] perf intel-pt: Add support for emulated ptwrite
Date:   Mon,  9 May 2022 18:23:58 +0300
Message-Id: <20220509152400.376613-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509152400.376613-1-adrian.hunter@intel.com>
References: <20220509152400.376613-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptwrite is an Intel x86 instruction that writes arbitrary values into an
Intel PT trace. It is not supported on all hardware, so provide an
alternative that makes use of TNT packets to convey the payload data.
TNT packets encode Taken/Not-taken conditional branch information, so
taking branches based on the payload value will encode the value into
the TNT packet. Refer to the changes to the documentation file
perf-intel-pt.txt in this patch for an example.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt    | 88 +++++++++++++++++
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 99 ++++++++++++++++++-
 .../util/intel-pt-decoder/intel-pt-decoder.h  |  1 +
 .../intel-pt-decoder/intel-pt-insn-decoder.c  |  1 +
 .../intel-pt-decoder/intel-pt-insn-decoder.h  |  1 +
 tools/perf/util/intel-pt.c                    | 37 ++++++-
 6 files changed, 224 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 92532d0d3618..8acd704e8a39 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -468,6 +468,8 @@ ptw		Enable PTWRITE packets which are produced when a ptwrite instruction
 		which contains "1" if the feature is supported and
 		"0" otherwise.
 
+		As an alternative, refer to "Emulated PTWRITE" further below.
+
 fup_on_ptw	Enable a FUP packet to follow the PTWRITE packet.  The FUP packet
 		provides the address of the ptwrite instruction.  In the absence of
 		fup_on_ptw, the decoder will use the address of the previous branch
@@ -1471,6 +1473,92 @@ In that case the --itrace q option is forced because walking executable code
 to reconstruct the control flow is not possible.
 
 
+Emulated PTWRITE
+----------------
+
+Later perf tools support a method to emulate the ptwrite instruction, which
+can be useful if hardware does not support the ptwrite instruction.
+
+Instead of using the ptwrite instruction, a function is used which produces
+a trace that encodes the payload data into TNT packets.  Here is an example
+of the function:
+
+ #include <stdint.h>
+
+ void perf_emulate_ptwrite(uint64_t x)
+ __attribute__((externally_visible, noipa, no_instrument_function, naked));
+
+ #define PERF_EMULATE_PTWRITE_8_BITS \
+                 "1: shl %rax\n"     \
+                 "   jc 1f\n"        \
+                 "1: shl %rax\n"     \
+                 "   jc 1f\n"        \
+                 "1: shl %rax\n"     \
+                 "   jc 1f\n"        \
+                 "1: shl %rax\n"     \
+                 "   jc 1f\n"        \
+                 "1: shl %rax\n"     \
+                 "   jc 1f\n"        \
+                 "1: shl %rax\n"     \
+                 "   jc 1f\n"        \
+                 "1: shl %rax\n"     \
+                 "   jc 1f\n"        \
+                 "1: shl %rax\n"     \
+                 "   jc 1f\n"
+
+ /* Undefined instruction */
+ #define PERF_EMULATE_PTWRITE_UD2        ".byte 0x0f, 0x0b\n"
+
+ #define PERF_EMULATE_PTWRITE_MAGIC        PERF_EMULATE_PTWRITE_UD2 ".ascii \"perf,ptwrite  \"\n"
+
+ void perf_emulate_ptwrite(uint64_t x __attribute__ ((__unused__)))
+ {
+          /* Assumes SysV ABI : x passed in rdi */
+         __asm__ volatile (
+                 "jmp 1f\n"
+                 PERF_EMULATE_PTWRITE_MAGIC
+                 "1: mov %rdi, %rax\n"
+                 PERF_EMULATE_PTWRITE_8_BITS
+                 PERF_EMULATE_PTWRITE_8_BITS
+                 PERF_EMULATE_PTWRITE_8_BITS
+                 PERF_EMULATE_PTWRITE_8_BITS
+                 PERF_EMULATE_PTWRITE_8_BITS
+                 PERF_EMULATE_PTWRITE_8_BITS
+                 PERF_EMULATE_PTWRITE_8_BITS
+                 PERF_EMULATE_PTWRITE_8_BITS
+                 "1: ret\n"
+         );
+ }
+
+For example, a test program with the function above:
+
+ #include <stdio.h>
+ #include <stdint.h>
+ #include <stdlib.h>
+
+ #include "perf_emulate_ptwrite.h"
+
+ int main(int argc, char *argv[])
+ {
+         uint64_t x = 0;
+
+         if (argc > 1)
+                 x = strtoull(argv[1], NULL, 0);
+         perf_emulate_ptwrite(x);
+         return 0;
+ }
+
+Can be compiled and traced:
+
+ $ gcc -Wall -Wextra -O3 -g -o eg_ptw eg_ptw.c
+ $ perf record -e intel_pt//u ./eg_ptw 0x1234567890abcdef
+ [ perf record: Woken up 1 times to write data ]
+ [ perf record: Captured and wrote 0.017 MB perf.data ]
+ $ perf script --itrace=ew
+           eg_ptw 19875 [007]  8061.235912:     ptwrite:  IP: 0 payload: 0x1234567890abcdef      55701249a196 perf_emulate_ptwrite+0x16 (/home/user/eg_ptw)
+ $
+
+
 EXAMPLE
 -------
 
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index e1d8f7504cbe..0ac860c8dd2b 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -137,6 +137,7 @@ struct intel_pt_decoder {
 	bool in_psb;
 	bool hop;
 	bool leap;
+	bool emulated_ptwrite;
 	bool vm_time_correlation;
 	bool vm_tm_corr_dry_run;
 	bool vm_tm_corr_reliable;
@@ -481,6 +482,8 @@ static int intel_pt_ext_err(int code)
 		return INTEL_PT_ERR_LOST;
 	case -ELOOP:
 		return INTEL_PT_ERR_NELOOP;
+	case -ECONNRESET:
+		return INTEL_PT_ERR_EPTW;
 	default:
 		return INTEL_PT_ERR_UNK;
 	}
@@ -497,6 +500,7 @@ static const char *intel_pt_err_msgs[] = {
 	[INTEL_PT_ERR_LOST]   = "Lost trace data",
 	[INTEL_PT_ERR_UNK]    = "Unknown error!",
 	[INTEL_PT_ERR_NELOOP] = "Never-ending loop (refer perf config intel-pt.max-loops)",
+	[INTEL_PT_ERR_EPTW]   = "Broken emulated ptwrite",
 };
 
 int intel_pt__strerror(int code, char *buf, size_t buflen)
@@ -1535,17 +1539,108 @@ static int intel_pt_walk_tip(struct intel_pt_decoder *decoder)
 	return intel_pt_bug(decoder);
 }
 
+struct eptw_data {
+	int bit_countdown;
+	uint64_t payload;
+};
+
+static int intel_pt_eptw_lookahead_cb(struct intel_pt_pkt_info *pkt_info)
+{
+	struct eptw_data *data = pkt_info->data;
+	int nr_bits;
+
+	switch (pkt_info->packet.type) {
+	case INTEL_PT_PAD:
+	case INTEL_PT_MNT:
+	case INTEL_PT_MODE_EXEC:
+	case INTEL_PT_MODE_TSX:
+	case INTEL_PT_MTC:
+	case INTEL_PT_FUP:
+	case INTEL_PT_CYC:
+	case INTEL_PT_CBR:
+	case INTEL_PT_TSC:
+	case INTEL_PT_TMA:
+	case INTEL_PT_PIP:
+	case INTEL_PT_VMCS:
+	case INTEL_PT_PSB:
+	case INTEL_PT_PSBEND:
+	case INTEL_PT_PTWRITE:
+	case INTEL_PT_PTWRITE_IP:
+	case INTEL_PT_EXSTOP:
+	case INTEL_PT_EXSTOP_IP:
+	case INTEL_PT_MWAIT:
+	case INTEL_PT_PWRE:
+	case INTEL_PT_PWRX:
+	case INTEL_PT_BBP:
+	case INTEL_PT_BIP:
+	case INTEL_PT_BEP:
+	case INTEL_PT_BEP_IP:
+	case INTEL_PT_CFE:
+	case INTEL_PT_CFE_IP:
+	case INTEL_PT_EVD:
+		break;
+
+	case INTEL_PT_TNT:
+		nr_bits = data->bit_countdown;
+		if (nr_bits > pkt_info->packet.count)
+			nr_bits = pkt_info->packet.count;
+		data->payload <<= nr_bits;
+		data->payload |= pkt_info->packet.payload >> (64 - nr_bits);
+		data->bit_countdown -= nr_bits;
+		return !data->bit_countdown;
+
+	case INTEL_PT_TIP_PGE:
+	case INTEL_PT_TIP_PGD:
+	case INTEL_PT_TIP:
+	case INTEL_PT_BAD:
+	case INTEL_PT_OVF:
+	case INTEL_PT_TRACESTOP:
+	default:
+		return 1;
+	}
+
+	return 0;
+}
+
+static int intel_pt_emulated_ptwrite(struct intel_pt_decoder *decoder)
+{
+	int n = 64 - decoder->tnt.count;
+	struct eptw_data data = {
+		.bit_countdown = n,
+		.payload = decoder->tnt.payload >> n,
+	};
+
+	decoder->emulated_ptwrite = false;
+	intel_pt_log("Emulated ptwrite detected\n");
+
+	intel_pt_pkt_lookahead(decoder, intel_pt_eptw_lookahead_cb, &data);
+	if (data.bit_countdown)
+		return -ECONNRESET;
+
+	decoder->state.type = INTEL_PT_PTW;
+	decoder->state.from_ip = decoder->ip;
+	decoder->state.to_ip = 0;
+	decoder->state.ptw_payload = data.payload;
+	return 0;
+}
+
 static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 {
 	struct intel_pt_insn intel_pt_insn;
 	int err;
 
 	while (1) {
+		if (decoder->emulated_ptwrite)
+			return intel_pt_emulated_ptwrite(decoder);
 		err = intel_pt_walk_insn(decoder, &intel_pt_insn, 0);
-		if (err == INTEL_PT_RETURN)
+		if (err == INTEL_PT_RETURN) {
+			decoder->emulated_ptwrite = intel_pt_insn.emulated_ptwrite;
 			return 0;
-		if (err)
+		}
+		if (err) {
+			decoder->emulated_ptwrite = false;
 			return err;
+		}
 
 		if (intel_pt_insn.op == INTEL_PT_OP_RET) {
 			if (!decoder->return_compression) {
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index efb2cb3ae0ca..c773028df80e 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -58,6 +58,7 @@ enum {
 	INTEL_PT_ERR_LOST,
 	INTEL_PT_ERR_UNK,
 	INTEL_PT_ERR_NELOOP,
+	INTEL_PT_ERR_EPTW,
 	INTEL_PT_ERR_MAX,
 };
 
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 9d5e65cec89b..1376077183f7 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -32,6 +32,7 @@ static void intel_pt_insn_decoder(struct insn *insn,
 	int ext;
 
 	intel_pt_insn->rel = 0;
+	intel_pt_insn->emulated_ptwrite = false;
 
 	if (insn_is_avx(insn)) {
 		intel_pt_insn->op = INTEL_PT_OP_OTHER;
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.h
index c2861cfdd768..e3338b56a75f 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.h
@@ -37,6 +37,7 @@ enum intel_pt_insn_branch {
 struct intel_pt_insn {
 	enum intel_pt_insn_op		op;
 	enum intel_pt_insn_branch	branch;
+	bool				emulated_ptwrite;
 	int				length;
 	int32_t				rel;
 	unsigned char			buf[INTEL_PT_INSN_BUF_SZ];
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index ec43d364d0de..c7e115fefe7d 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -530,6 +530,7 @@ struct intel_pt_cache_entry {
 	u64				byte_cnt;
 	enum intel_pt_insn_op		op;
 	enum intel_pt_insn_branch	branch;
+	bool				emulated_ptwrite;
 	int				length;
 	int32_t				rel;
 	char				insn[INTEL_PT_INSN_BUF_SZ];
@@ -616,6 +617,7 @@ static int intel_pt_cache_add(struct dso *dso, struct machine *machine,
 	e->byte_cnt = byte_cnt;
 	e->op = intel_pt_insn->op;
 	e->branch = intel_pt_insn->branch;
+	e->emulated_ptwrite = intel_pt_insn->emulated_ptwrite;
 	e->length = intel_pt_insn->length;
 	e->rel = intel_pt_insn->rel;
 	memcpy(e->insn, intel_pt_insn->buf, INTEL_PT_INSN_BUF_SZ);
@@ -702,6 +704,28 @@ static int intel_pt_get_guest(struct intel_pt_queue *ptq)
 	return 0;
 }
 
+static inline bool intel_pt_jmp_16(struct intel_pt_insn *intel_pt_insn)
+{
+	return intel_pt_insn->rel == 16 && intel_pt_insn->branch == INTEL_PT_BR_UNCONDITIONAL;
+}
+
+#define PTWRITE_MAGIC		"\x0f\x0bperf,ptwrite  "
+#define PTWRITE_MAGIC_LEN	16
+
+static bool intel_pt_emulated_ptwrite(struct dso *dso, struct machine *machine, u64 offset)
+{
+	unsigned char buf[PTWRITE_MAGIC_LEN];
+	ssize_t len;
+
+	len = dso__data_read_offset(dso, machine, offset, buf, PTWRITE_MAGIC_LEN);
+	if (len == PTWRITE_MAGIC_LEN && !memcmp(buf, PTWRITE_MAGIC, PTWRITE_MAGIC_LEN)) {
+		intel_pt_log("Emulated ptwrite signature found\n");
+		return true;
+	}
+	intel_pt_log("Emulated ptwrite signature not found\n");
+	return false;
+}
+
 static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 				   uint64_t *insn_cnt_ptr, uint64_t *ip,
 				   uint64_t to_ip, uint64_t max_insn_cnt,
@@ -764,6 +788,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 				*ip += e->byte_cnt;
 				intel_pt_insn->op = e->op;
 				intel_pt_insn->branch = e->branch;
+				intel_pt_insn->emulated_ptwrite = e->emulated_ptwrite;
 				intel_pt_insn->length = e->length;
 				intel_pt_insn->rel = e->rel;
 				memcpy(intel_pt_insn->buf, e->insn,
@@ -795,8 +820,18 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 
 			insn_cnt += 1;
 
-			if (intel_pt_insn->branch != INTEL_PT_BR_NO_BRANCH)
+			if (intel_pt_insn->branch != INTEL_PT_BR_NO_BRANCH) {
+				bool eptw;
+				u64 offs;
+
+				if (!intel_pt_jmp_16(intel_pt_insn))
+					goto out;
+				/* Check for emulated ptwrite */
+				offs = offset + intel_pt_insn->length;
+				eptw = intel_pt_emulated_ptwrite(al.map->dso, machine, offs);
+				intel_pt_insn->emulated_ptwrite = eptw;
 				goto out;
+			}
 
 			if (max_insn_cnt && insn_cnt >= max_insn_cnt)
 				goto out_no_cache;
-- 
2.25.1

