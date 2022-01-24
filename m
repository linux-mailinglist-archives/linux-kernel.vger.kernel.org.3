Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B149497A80
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242342AbiAXImx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:62621 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242303AbiAXImg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013756; x=1674549756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/k3Yf24BGItlCOwE1O7iCZbvBiqf5oyYyQH/dJtIBI=;
  b=ZXwLCoN3mXMI0H3X/2TpJZoIPRNJbWhzWknGB3LVS0FNOwi36JfUEtOo
   nFwMxA44VlUjfyqCRzPwyv1+IdinC1vIOCoAn+QKy/MrpBfuREPDGKm3H
   0HJ4iwUtFsBkt6uJV+JLTaETWvqHbFcsvQXfToDwmDxEDi6ZhbfogWDuo
   NCuDwlH/aar1lT85dkHQRecN1XFs9LAdcIRb7xQCQGayTaFQwgYTpXLxv
   Mj2DQhaIVTmPug8VY2Qn0DydClmUNnH8JQivUVelOcrCnW3ZjOV7AiReS
   gUYDCfueDHHqRETVDn2s2GlGqgz2VzKKAmpOMiRu4kxhB+O1Vh795V5BB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778437"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778437"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417151"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:33 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 14/25] perf intel-pt: Synthesize CFE / EVD event
Date:   Mon, 24 Jan 2022 10:41:50 +0200
Message-Id: <20220124084201.2699795-15-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synthesize an attribute event and sample events for Intel PT Event Trace
events represented by CFE and EVD packets.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 62 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 23cb272e3d03..1e07a3c03102 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -49,6 +49,7 @@
 #define INTEL_PT_CFG_PASS_THRU	BIT_ULL(0)
 #define INTEL_PT_CFG_PWR_EVT_EN	BIT_ULL(4)
 #define INTEL_PT_CFG_BRANCH_EN	BIT_ULL(13)
+#define INTEL_PT_CFG_EVT_EN	BIT_ULL(31)
 
 struct range {
 	u64 start;
@@ -120,6 +121,9 @@ struct intel_pt {
 	bool sample_pebs;
 	struct evsel *pebs_evsel;
 
+	u64 evt_sample_type;
+	u64 evt_id;
+
 	u64 tsc_bit;
 	u64 mtc_bit;
 	u64 mtc_freq_bits;
@@ -2166,6 +2170,45 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	return err;
 }
 
+static int intel_pt_synth_events_sample(struct intel_pt_queue *ptq)
+{
+	struct intel_pt *pt = ptq->pt;
+	union perf_event *event = ptq->event_buf;
+	struct perf_sample sample = { .ip = 0, };
+	struct {
+		struct perf_synth_intel_evt cfe;
+		struct perf_synth_intel_evd evd[INTEL_PT_MAX_EVDS];
+	} raw;
+	int i;
+
+	if (intel_pt_skip_event(pt))
+		return 0;
+
+	intel_pt_prep_p_sample(pt, ptq, event, &sample);
+
+	sample.id        = ptq->pt->evt_id;
+	sample.stream_id = ptq->pt->evt_id;
+
+	raw.cfe.type     = ptq->state->cfe_type;
+	raw.cfe.reserved = 0;
+	raw.cfe.ip       = !!(ptq->state->flags & INTEL_PT_FUP_IP);
+	raw.cfe.vector   = ptq->state->cfe_vector;
+	raw.cfe.evd_cnt  = ptq->state->evd_cnt;
+
+	for (i = 0; i < ptq->state->evd_cnt; i++) {
+		raw.evd[i].et       = 0;
+		raw.evd[i].evd_type = ptq->state->evd[i].type;
+		raw.evd[i].payload  = ptq->state->evd[i].payload;
+	}
+
+	sample.raw_size = perf_synth__raw_size(raw) +
+			  ptq->state->evd_cnt * sizeof(struct perf_synth_intel_evd);
+	sample.raw_data = perf_synth__raw_data(&raw);
+
+	return intel_pt_deliver_synth_event(pt, event, &sample,
+					    pt->evt_sample_type);
+}
+
 static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
 				pid_t pid, pid_t tid, u64 ip, u64 timestamp)
 {
@@ -2272,6 +2315,14 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 			return err;
 	}
 
+	if (pt->synth_opts.intr_events) {
+		if (state->type & INTEL_PT_EVT) {
+			err = intel_pt_synth_events_sample(ptq);
+			if (err)
+				return err;
+		}
+	}
+
 	if (pt->sample_pwr_events) {
 		if (state->type & INTEL_PT_PSB_EVT) {
 			err = intel_pt_synth_psb_sample(ptq);
@@ -3469,6 +3520,17 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 		id += 1;
 	}
 
+	if (pt->synth_opts.intr_events && (evsel->core.attr.config & INTEL_PT_CFG_EVT_EN)) {
+		attr.config = PERF_SYNTH_INTEL_EVT;
+		err = intel_pt_synth_event(session, "evt", &attr, id);
+		if (err)
+			return err;
+		pt->evt_sample_type = attr.sample_type;
+		pt->evt_id = id;
+		intel_pt_set_event_name(evlist, id, "evt");
+		id += 1;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

