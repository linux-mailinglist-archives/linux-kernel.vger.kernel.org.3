Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC657497A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242288AbiAXImj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:62597 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242247AbiAXImW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013742; x=1674549742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PyojuQg3ggflEwcudqiK5B58tv0p5xeRIcr4Ys+Gnqw=;
  b=eeO+oFTEfVlKQ5sPrXg3+iXp9HFlALvBTY2ruSW7vbxAXKgyoJw00TtT
   9vpUgLNN33QL6DDEFzsc6crDdGqEJ3G0pi0CfYWisC25Fd1+P5ZZ/OEge
   bger+Jkfb4Nm8jvSEebhcVpKq6vn7gBdAQEKJxhflWfaWugqBnsBB2beo
   2H0Br0i5k/ldcvIPNwYsS+65dxvWG75zPq/GnCqWCsea2vMLElFmMKAI/
   keYgwj4Qw0hDJ7oEJmiX+uAV09LPz3o2n2io0dgSJ+EIv7zLEM9KSTf1i
   eKJwBTWjoPyA8rFwIsWsqM79vWkQVabH0t1McwdThbmFwv/MBr98cCWbx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778364"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778364"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417042"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:18 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/25] perf intel-pt: decoder: Add CFE and EVD processing
Date:   Mon, 24 Jan 2022 10:41:43 +0200
Message-Id: <20220124084201.2699795-8-adrian.hunter@intel.com>
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
Intel PT feature called Event Trace which requires 2 new packets CFE and
EVD. Each Event Trace event is represented by a CFE packet that is
preceded by zero or more EVD packets. It may be bound to a following FUP
packet that provides the IP.

Event Trace exposes details about asynchronous events. The CFE packet
contains a type field to identify one of the following:

	 1	INTR		interrupt, fault, exception, NMI
	 2	IRET		interrupt return
	 3	SMI		system management interrupt
	 4	RSM		resume from system management mode
	 5	SIPI		startup interprocessor interrupt
	 6	INIT		INIT signal
	 7	VMENTRY		VM-Entry
	 8	VMEXIT		VM-Entry
	 9	VMEXIT_INTR	VM-Exit due to interrupt
	10	SHUTDOWN	Shutdown

For more details, refer to the Intel SDM, Intel Processor Trace chapter.

Add processing to the decoder for the new packets.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 .../util/intel-pt-decoder/intel-pt-decoder.c  | 62 +++++++++++++++++++
 .../util/intel-pt-decoder/intel-pt-decoder.h  | 17 +++++
 2 files changed, 79 insertions(+)

diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 5792d536b458..1a39119706d6 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -213,6 +213,8 @@ struct intel_pt_decoder {
 	bool set_fup_pwre;
 	bool set_fup_exstop;
 	bool set_fup_bep;
+	bool set_fup_cfe_ip;
+	bool set_fup_cfe;
 	bool sample_cyc;
 	unsigned int fup_tx_flags;
 	unsigned int tx_flags;
@@ -223,6 +225,7 @@ struct intel_pt_decoder {
 	uint64_t timestamp_insn_cnt;
 	uint64_t sample_insn_cnt;
 	uint64_t stuck_ip;
+	struct intel_pt_pkt fup_cfe_pkt;
 	int max_loops;
 	int no_progress;
 	int stuck_ip_prd;
@@ -231,6 +234,8 @@ struct intel_pt_decoder {
 	const unsigned char *next_buf;
 	size_t next_len;
 	unsigned char temp_buf[INTEL_PT_PKT_MAX_SZ];
+	int evd_cnt;
+	struct intel_pt_evd evd[INTEL_PT_MAX_EVDS];
 };
 
 static uint64_t intel_pt_lower_power_of_2(uint64_t x)
@@ -1214,6 +1219,9 @@ static void intel_pt_clear_fup_event(struct intel_pt_decoder *decoder)
 	decoder->set_fup_pwre = false;
 	decoder->set_fup_exstop = false;
 	decoder->set_fup_bep = false;
+	decoder->set_fup_cfe_ip = false;
+	decoder->set_fup_cfe = false;
+	decoder->evd_cnt = 0;
 }
 
 static bool intel_pt_fup_event(struct intel_pt_decoder *decoder)
@@ -1223,6 +1231,23 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder)
 
 	decoder->state.type &= ~INTEL_PT_BRANCH;
 
+	if (decoder->set_fup_cfe_ip || decoder->set_fup_cfe) {
+		bool ip = decoder->set_fup_cfe_ip;
+
+		decoder->set_fup_cfe_ip = false;
+		decoder->set_fup_cfe = false;
+		decoder->state.type |= INTEL_PT_EVT;
+		if (!ip && decoder->pge)
+			decoder->state.type |= INTEL_PT_BRANCH;
+		decoder->state.cfe_type = decoder->fup_cfe_pkt.count;
+		decoder->state.cfe_vector = decoder->fup_cfe_pkt.payload;
+		decoder->state.evd_cnt = decoder->evd_cnt;
+		decoder->state.evd = decoder->evd;
+		decoder->evd_cnt = 0;
+		if (ip || decoder->pge)
+			decoder->state.flags |= INTEL_PT_FUP_IP;
+		ret = true;
+	}
 	if (decoder->set_fup_tx_flags) {
 		decoder->set_fup_tx_flags = false;
 		decoder->tx_flags = decoder->fup_tx_flags;
@@ -1540,6 +1565,19 @@ static int intel_pt_mode_tsx(struct intel_pt_decoder *decoder, bool *no_tip)
 	return 0;
 }
 
+static int intel_pt_evd(struct intel_pt_decoder *decoder)
+{
+	if (decoder->evd_cnt >= INTEL_PT_MAX_EVDS) {
+		intel_pt_log_at("ERROR: Too many EVD packets", decoder->pos);
+		return -ENOSYS;
+	}
+	decoder->evd[decoder->evd_cnt++] = (struct intel_pt_evd){
+		.type = decoder->packet.count,
+		.payload = decoder->packet.payload,
+	};
+	return 0;
+}
+
 static uint64_t intel_pt_8b_tsc(uint64_t timestamp, uint64_t ref_timestamp)
 {
 	timestamp |= (ref_timestamp & (0xffULL << 56));
@@ -3250,8 +3288,32 @@ static int intel_pt_walk_trace(struct intel_pt_decoder *decoder)
 			goto next;
 
 		case INTEL_PT_CFE:
+			decoder->fup_cfe_pkt = decoder->packet;
+			decoder->set_fup_cfe = true;
+			if (!decoder->pge) {
+				intel_pt_fup_event(decoder);
+				return 0;
+			}
+			break;
+
 		case INTEL_PT_CFE_IP:
+			decoder->fup_cfe_pkt = decoder->packet;
+			err = intel_pt_get_next_packet(decoder);
+			if (err)
+				return err;
+			if (decoder->packet.type == INTEL_PT_FUP) {
+				decoder->set_fup_cfe_ip = true;
+				no_tip = true;
+			} else {
+				intel_pt_log_at("ERROR: Missing FUP after CFE",
+						decoder->pos);
+			}
+			goto next;
+
 		case INTEL_PT_EVD:
+			err = intel_pt_evd(decoder);
+			if (err)
+				return err;
 			break;
 
 		default:
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
index 8fd68f7a0963..59ef4b41ec67 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.h
@@ -35,6 +35,7 @@ enum intel_pt_sample_type {
 	INTEL_PT_TRACE_END	= 1 << 10,
 	INTEL_PT_BLK_ITEMS	= 1 << 11,
 	INTEL_PT_PSB_EVT	= 1 << 12,
+	INTEL_PT_EVT		= 1 << 13,
 };
 
 enum intel_pt_period_type {
@@ -209,6 +210,18 @@ struct intel_pt_vmcs_info {
 	bool error_printed;
 };
 
+/*
+ * Maximum number of event trace data in one go, assuming at most 1 per type
+ * and 6-bits of type in the EVD packet.
+ */
+#define INTEL_PT_MAX_EVDS 64
+
+/* Event trace data from EVD packet */
+struct intel_pt_evd {
+	int type;
+	uint64_t payload;
+};
+
 struct intel_pt_state {
 	enum intel_pt_sample_type type;
 	bool from_nr;
@@ -234,6 +247,10 @@ struct intel_pt_state {
 	int insn_len;
 	char insn[INTEL_PT_INSN_BUF_SZ];
 	struct intel_pt_blk_items items;
+	int cfe_type;
+	int cfe_vector;
+	int evd_cnt;
+	struct intel_pt_evd *evd;
 };
 
 struct intel_pt_insn;
-- 
2.25.1

