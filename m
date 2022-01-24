Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75627497A81
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbiAXInD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:43:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:62624 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242277AbiAXImk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013760; x=1674549760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dtfim9SEIDgnFiNewz+c+/ywOrcl4zmpQfWGZ7QNPtc=;
  b=nTeyo3q4Rq64JPvWjxywUym6w2RGvAn2IS5O2f5upaI6LjDAgfJpWxvA
   bFwb8J80AztMT3CB1Fwtuwr2P+g5Vu+aDs2kr0bZBePbx2KjO9jZGOlQF
   Qz/ClqPxBXH1xxq5F62xwTj58y6u4eLxDbKBC/yVZwtmLWHXXueHTkaKb
   iffqkeEKfgJdnPB+GcR6dfbafl370Mo3MscBm0mw037u8pdpry9gB9HaT
   M2bnUwIJR7Tu6m5O80XoHjUqkZSHS23Wc1CU+kmRO1TbiUyHxuWoBJXug
   1IOSe/QiMAagEQ2alpuPqN2nrhY4Wczqpzu4wVryUOKfArJZ+GrM+inUv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778440"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778440"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417166"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:36 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 15/25] perf intel-pt: Synthesize iflag event
Date:   Mon, 24 Jan 2022 10:41:51 +0200
Message-Id: <20220124084201.2699795-16-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synthesize an attribute event and sample events for changes to the
interrupt flag represented by the MODE.Exec packet.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 52 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 1e07a3c03102..c5b860c842f0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -124,6 +124,9 @@ struct intel_pt {
 	u64 evt_sample_type;
 	u64 evt_id;
 
+	u64 iflag_chg_sample_type;
+	u64 iflag_chg_id;
+
 	u64 tsc_bit;
 	u64 mtc_bit;
 	u64 mtc_freq_bits;
@@ -2209,6 +2212,39 @@ static int intel_pt_synth_events_sample(struct intel_pt_queue *ptq)
 					    pt->evt_sample_type);
 }
 
+static int intel_pt_synth_iflag_chg_sample(struct intel_pt_queue *ptq)
+{
+	struct intel_pt *pt = ptq->pt;
+	union perf_event *event = ptq->event_buf;
+	struct perf_sample sample = { .ip = 0, };
+	struct perf_synth_intel_iflag_chg raw;
+
+	if (intel_pt_skip_event(pt))
+		return 0;
+
+	intel_pt_prep_p_sample(pt, ptq, event, &sample);
+
+	sample.id = ptq->pt->iflag_chg_id;
+	sample.stream_id = ptq->pt->iflag_chg_id;
+
+	raw.flags = 0;
+	raw.iflag = ptq->state->to_iflag;
+
+	if (ptq->state->type & INTEL_PT_BRANCH) {
+		raw.via_branch = 1;
+		raw.branch_ip = ptq->state->to_ip;
+	} else {
+		sample.addr = 0;
+	}
+	sample.flags = ptq->flags;
+
+	sample.raw_size = perf_synth__raw_size(raw);
+	sample.raw_data = perf_synth__raw_data(&raw);
+
+	return intel_pt_deliver_synth_event(pt, event, &sample,
+					    pt->iflag_chg_sample_type);
+}
+
 static int intel_pt_synth_error(struct intel_pt *pt, int code, int cpu,
 				pid_t pid, pid_t tid, u64 ip, u64 timestamp)
 {
@@ -2321,6 +2357,11 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 			if (err)
 				return err;
 		}
+		if (state->type & INTEL_PT_IFLAG_CHG) {
+			err = intel_pt_synth_iflag_chg_sample(ptq);
+			if (err)
+				return err;
+		}
 	}
 
 	if (pt->sample_pwr_events) {
@@ -3531,6 +3572,17 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 		id += 1;
 	}
 
+	if (pt->synth_opts.intr_events && pt->cap_event_trace) {
+		attr.config = PERF_SYNTH_INTEL_IFLAG_CHG;
+		err = intel_pt_synth_event(session, "iflag", &attr, id);
+		if (err)
+			return err;
+		pt->iflag_chg_sample_type = attr.sample_type;
+		pt->iflag_chg_id = id;
+		intel_pt_set_event_name(evlist, id, "iflag");
+		id += 1;
+	}
+
 	return 0;
 }
 
-- 
2.25.1

