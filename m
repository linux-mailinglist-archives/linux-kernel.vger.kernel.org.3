Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2161C497A78
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbiAXIm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242269AbiAXImY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013744; x=1674549744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VnPfKu67JpoqD34YR6ej2Xei5mq8EIJy+6OGhLkBtXE=;
  b=hWtRZJkLFxaUb4ZlUQD4G9RmI50lHD9tHCEe1APNmh7jFE1mEqbPzhjC
   nx1ZtMt3cE5aFChCZe5eQelAyAfKUGn0Euw8YLyp6pwvageFnR4si01bp
   ZU9ziftgae+7TuqF9yXeAMfmF5a7T3Y3FJNXjamr0SXa+tU1t6ogamF8E
   nrf/HrZHUazoP5bmgMlB9Vcs884eKMAj4svWK7uXBnPBVFXzza7BBYokD
   I6E8U5uwLXR0jtFlaKngQOOTCPWfMGNQEg55BUkTmjiOiRG35Zs819kiv
   RSfDwNeZRaN+slBIqWe5jaBaz3ERlVeA59evonzWP6eIRse9e1nScPVNP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778388"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778388"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417059"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:20 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/25] perf intel-pt: decoder: Add MODE.Exec IFLAG processing
Date:   Mon, 24 Jan 2022 10:41:44 +0200
Message-Id: <20220124084201.2699795-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of Intel SDM (https://www.intel.com/sdm) version 076, there is a new
Intel PT feature called Event Trace which adds a bit to the existing
MODE.Exec packet to record the interrupt flag.

Previously, the MODE.Exec packet did not generate any events, so the
new processing required is practically the same as a new packet.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 129 ++++++++++++++++--
 .../util/intel-pt-decoder/intel-pt-decoder.h  |   4 +
 2 files changed, 121 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 1a39119706d6..e1d8f7504cbe 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -144,6 +144,8 @@ struct intel_pt_decoder {
 	bool vm_tm_corr_continuous;
 	bool nr;
 	bool next_nr;
+	bool iflag;
+	bool next_iflag;
 	enum intel_pt_param_flags flags;
 	uint64_t pos;
 	uint64_t last_ip;
@@ -215,6 +217,7 @@ struct intel_pt_decoder {
 	bool set_fup_bep;
 	bool set_fup_cfe_ip;
 	bool set_fup_cfe;
+	bool set_fup_mode_exec;
 	bool sample_cyc;
 	unsigned int fup_tx_flags;
 	unsigned int tx_flags;
@@ -1102,6 +1105,52 @@ static void intel_pt_sample_insn(struct intel_pt_decoder *decoder)
 	decoder->state.type |= INTEL_PT_INSTRUCTION;
 }
 
+/*
+ * Sample FUP instruction at the same time as reporting the FUP event, so the
+ * instruction sample gets the same flags as the FUP event.
+ */
+static void intel_pt_sample_fup_insn(struct intel_pt_decoder *decoder)
+{
+	struct intel_pt_insn intel_pt_insn;
+	uint64_t max_insn_cnt, insn_cnt = 0;
+	int err;
+
+	decoder->state.insn_op = INTEL_PT_OP_OTHER;
+	decoder->state.insn_len = 0;
+
+	if (!decoder->branch_enable || !decoder->pge || decoder->hop ||
+	    decoder->ip != decoder->last_ip)
+		return;
+
+	if (!decoder->mtc_insn)
+		decoder->mtc_insn = true;
+
+	max_insn_cnt = intel_pt_next_sample(decoder);
+	if (max_insn_cnt != 1)
+		return;
+
+	err = decoder->walk_insn(&intel_pt_insn, &insn_cnt, &decoder->ip,
+				 0, max_insn_cnt, decoder->data);
+	/* Ignore error, it will be reported next walk anyway */
+	if (err)
+		return;
+
+	if (intel_pt_insn.branch != INTEL_PT_BR_NO_BRANCH) {
+		intel_pt_log_at("ERROR: Unexpected branch at FUP instruction", decoder->ip);
+		return;
+	}
+
+	decoder->tot_insn_cnt += insn_cnt;
+	decoder->timestamp_insn_cnt += insn_cnt;
+	decoder->sample_insn_cnt += insn_cnt;
+	decoder->period_insn_cnt += insn_cnt;
+
+	intel_pt_sample_insn(decoder);
+
+	decoder->state.type |= INTEL_PT_INSTRUCTION;
+	decoder->ip += intel_pt_insn.length;
+}
+
 static int intel_pt_walk_insn(struct intel_pt_decoder *decoder,
 			      struct intel_pt_insn *intel_pt_insn, uint64_t ip)
 {
@@ -1211,6 +1260,39 @@ static int intel_pt_walk_insn(struct intel_pt_decoder *decoder,
 	return err;
 }
 
+static void intel_pt_mode_exec_status(struct intel_pt_decoder *decoder)
+{
+	bool iflag = decoder->packet.count & INTEL_PT_IFLAG;
+
+	decoder->exec_mode = decoder->packet.payload;
+	decoder->iflag = iflag;
+	decoder->next_iflag = iflag;
+	decoder->state.from_iflag = iflag;
+	decoder->state.to_iflag = iflag;
+}
+
+static void intel_pt_mode_exec(struct intel_pt_decoder *decoder)
+{
+	bool iflag = decoder->packet.count & INTEL_PT_IFLAG;
+
+	decoder->exec_mode = decoder->packet.payload;
+	decoder->next_iflag = iflag;
+}
+
+static void intel_pt_sample_iflag(struct intel_pt_decoder *decoder)
+{
+	decoder->state.type |= INTEL_PT_IFLAG_CHG;
+	decoder->state.from_iflag = decoder->iflag;
+	decoder->state.to_iflag = decoder->next_iflag;
+	decoder->iflag = decoder->next_iflag;
+}
+
+static void intel_pt_sample_iflag_chg(struct intel_pt_decoder *decoder)
+{
+	if (decoder->iflag != decoder->next_iflag)
+		intel_pt_sample_iflag(decoder);
+}
+
 static void intel_pt_clear_fup_event(struct intel_pt_decoder *decoder)
 {
 	decoder->set_fup_tx_flags = false;
@@ -1222,11 +1304,14 @@ static void intel_pt_clear_fup_event(struct intel_pt_decoder *decoder)
 	decoder->set_fup_cfe_ip = false;
 	decoder->set_fup_cfe = false;
 	decoder->evd_cnt = 0;
+	decoder->set_fup_mode_exec = false;
+	decoder->iflag = decoder->next_iflag;
 }
 
-static bool intel_pt_fup_event(struct intel_pt_decoder *decoder)
+static bool intel_pt_fup_event(struct intel_pt_decoder *decoder, bool no_tip)
 {
 	enum intel_pt_sample_type type = decoder->state.type;
+	bool sample_fup_insn = false;
 	bool ret = false;
 
 	decoder->state.type &= ~INTEL_PT_BRANCH;
@@ -1248,6 +1333,12 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder)
 			decoder->state.flags |= INTEL_PT_FUP_IP;
 		ret = true;
 	}
+	if (decoder->set_fup_mode_exec) {
+		decoder->set_fup_mode_exec = false;
+		intel_pt_sample_iflag(decoder);
+		sample_fup_insn = no_tip;
+		ret = true;
+	}
 	if (decoder->set_fup_tx_flags) {
 		decoder->set_fup_tx_flags = false;
 		decoder->tx_flags = decoder->fup_tx_flags;
@@ -1304,6 +1395,8 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder)
 	if (ret) {
 		decoder->state.from_ip = decoder->ip;
 		decoder->state.to_ip = 0;
+		if (sample_fup_insn)
+			intel_pt_sample_fup_insn(decoder);
 	} else {
 		decoder->state.type = type;
 	}
@@ -1336,7 +1429,7 @@ static int intel_pt_walk_fup(struct intel_pt_decoder *decoder)
 			bool no_tip = decoder->pkt_state != INTEL_PT_STATE_FUP;
 
 			decoder->pkt_state = INTEL_PT_STATE_IN_SYNC;
-			if (intel_pt_fup_event(decoder) && no_tip)
+			if (intel_pt_fup_event(decoder, no_tip) && no_tip)
 				return 0;
 			return -EAGAIN;
 		}
@@ -1388,6 +1481,7 @@ static int intel_pt_walk_tip(struct intel_pt_decoder *decoder)
 		return err;
 
 	intel_pt_update_nr(decoder);
+	intel_pt_sample_iflag_chg(decoder);
 
 	if (intel_pt_insn.branch == INTEL_PT_BR_INDIRECT) {
 		if (decoder->pkt_state == INTEL_PT_STATE_TIP_PGD) {
@@ -1502,6 +1596,7 @@ static int intel_pt_walk_tnt(struct intel_pt_decoder *decoder)
 			decoder->state.to_ip = decoder->last_ip;
 			decoder->ip = decoder->last_ip;
 			intel_pt_update_nr(decoder);
+			intel_pt_sample_iflag_chg(decoder);
 			return 0;
 		}
 
@@ -1944,7 +2039,7 @@ static int intel_pt_walk_psbend(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_MODE_EXEC:
-			decoder->exec_mode = decoder->packet.payload;
+			intel_pt_mode_exec_status(decoder);
 			break;
 
 		case INTEL_PT_PIP:
@@ -2078,6 +2173,7 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 				decoder->state.to_ip = decoder->ip;
 			}
 			intel_pt_update_nr(decoder);
+			intel_pt_sample_iflag_chg(decoder);
 			return 0;
 
 		case INTEL_PT_PIP:
@@ -2095,7 +2191,7 @@ static int intel_pt_walk_fup_tip(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_MODE_EXEC:
-			decoder->exec_mode = decoder->packet.payload;
+			intel_pt_mode_exec(decoder);
 			break;
 
 		case INTEL_PT_VMCS:
@@ -2777,6 +2873,7 @@ static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, in
 		decoder->state.from_ip = decoder->ip;
 		decoder->state.to_ip = 0;
 		intel_pt_update_nr(decoder);
+		intel_pt_sample_iflag_chg(decoder);
 		return HOP_RETURN;
 
 	case INTEL_PT_FUP:
@@ -2791,10 +2888,10 @@ static int intel_pt_hop_trace(struct intel_pt_decoder *decoder, bool *no_tip, in
 			decoder->state.type = INTEL_PT_INSTRUCTION;
 			decoder->state.from_ip = decoder->ip;
 			decoder->state.to_ip = 0;
-			intel_pt_fup_event(decoder);
+			intel_pt_fup_event(decoder, *no_tip);
 			return HOP_RETURN;
 		}
-		intel_pt_fup_event(decoder);
+		intel_pt_fup_event(decoder, *no_tip);
 		decoder->state.type |= INTEL_PT_INSTRUCTION | INTEL_PT_BRANCH;
 		*err = intel_pt_walk_fup_tip(decoder);
 		if (!*err && decoder->state.to_ip)
@@ -3058,6 +3155,7 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 						decoder->pos);
 				break;
 			}
+			intel_pt_sample_iflag_chg(decoder);
 			intel_pt_set_ip(decoder);
 			decoder->state.from_ip = 0;
 			decoder->state.to_ip = decoder->ip;
@@ -3090,7 +3188,7 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 			intel_pt_set_last_ip(decoder);
 			if (!decoder->branch_enable || !decoder->pge) {
 				decoder->ip = decoder->last_ip;
-				if (intel_pt_fup_event(decoder))
+				if (intel_pt_fup_event(decoder, no_tip))
 					return 0;
 				no_tip = false;
 				break;
@@ -3172,8 +3270,15 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_MODE_EXEC:
-			decoder->exec_mode = decoder->packet.payload;
-			break;
+			intel_pt_mode_exec(decoder);
+			err = intel_pt_get_next_packet(decoder);
+			if (err)
+				return err;
+			if (decoder->packet.type == INTEL_PT_FUP) {
+				decoder->set_fup_mode_exec = true;
+				no_tip = true;
+			}
+			goto next;
 
 		case INTEL_PT_MODE_TSX:
 			/* MODE_TSX need not be followed by FUP */
@@ -3291,7 +3396,7 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 			decoder->fup_cfe_pkt = decoder->packet;
 			decoder->set_fup_cfe = true;
 			if (!decoder->pge) {
-				intel_pt_fup_event(decoder);
+				intel_pt_fup_event(decoder, true);
 				return 0;
 			}
 			break;
@@ -3403,7 +3508,7 @@ static int intel_pt_walk_psb(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_MODE_EXEC:
-			decoder->exec_mode = decoder->packet.payload;
+			intel_pt_mode_exec_status(decoder);
 			break;
 
 		case INTEL_PT_MODE_TSX:
@@ -3522,7 +3627,7 @@ static int intel_pt_walk_to_ip(struct intel_pt_decoder *decoder)
 			break;
 
 		case INTEL_PT_MODE_EXEC:
-			decoder->exec_mode = decoder->packet.payload;
+			intel_pt_mode_exec_status(decoder);
 			break;
 
 		case INTEL_PT_MODE_TSX:
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 59ef4b41ec67..efb2cb3ae0ca 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -17,6 +17,7 @@
 
 #define INTEL_PT_IN_TX		(1 << 0)
 #define INTEL_PT_ABORT_TX	(1 << 1)
+#define INTEL_PT_IFLAG		(1 << 2)
 #define INTEL_PT_ASYNC		(1 << 2)
 #define INTEL_PT_FUP_IP		(1 << 3)
 #define INTEL_PT_SAMPLE_IPC	(1 << 4)
@@ -36,6 +37,7 @@ enum intel_pt_sample_type {
 	INTEL_PT_BLK_ITEMS	= 1 << 11,
 	INTEL_PT_PSB_EVT	= 1 << 12,
 	INTEL_PT_EVT		= 1 << 13,
+	INTEL_PT_IFLAG_CHG	= 1 << 14,
 };
 
 enum intel_pt_period_type {
@@ -226,6 +228,8 @@ struct intel_pt_state {
 	enum intel_pt_sample_type type;
 	bool from_nr;
 	bool to_nr;
+	bool from_iflag;
+	bool to_iflag;
 	int err;
 	uint64_t from_ip;
 	uint64_t to_ip;
-- 
2.25.1

