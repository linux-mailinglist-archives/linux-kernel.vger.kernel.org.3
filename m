Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C1D497A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242332AbiAXImu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:62581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242280AbiAXImd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013753; x=1674549753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=80FwOptK+NyvzMxAvsXk1UZZR379CjXnJm/8N8Ci5Po=;
  b=kBb80V6AiLWg/pXbGV27aN4n+tNEMrrqx2hcnlZq9N2Iq/NlpYu3JyFC
   TDahv6xDUgAOpAMvJX/AmPaThOLBZNwhLM5Q2zWMxgU40qfWmN1/0hluQ
   93W3z2KmgV5MGrzwEeAmpSAXuVvjkuH4imTevY7ey/7rHWbQO3Fkjmxgf
   f5Ucd58YchZS0HIOTA0d4ptB4FfPeSSP5rxXKX2kBICd/uT7AHvbpWdk9
   dOAeat/pdOXz+hXKErw8dZMpwv9DH5lQYY7GnYeIWY7QXYYgInt6aMjnx
   WSyWgSbnA647RE9PJDe/GSCEyN3ARjDJKJLATNdRRCL0x8u9s2ohbm4KZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778434"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778434"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417135"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:31 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/25] perf intel-pt: Record Event Trace capability flag
Date:   Mon, 24 Jan 2022 10:41:49 +0200
Message-Id: <20220124084201.2699795-14-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change to the MODE.Exec packet means processing must distinguish
between the old and new cases. Record the Event Trace capability flag to
make that possible.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c |  7 +++++++
 tools/perf/util/intel-pt.c          | 10 +++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 6df0dc00d73a..8c31578d6f4a 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -306,6 +306,7 @@ intel_pt_info_priv_size(struct auxtrace_record *itr, struct evlist *evlist)
 
 	ptr->priv_size = (INTEL_PT_AUXTRACE_PRIV_MAX * sizeof(u64)) +
 			 intel_pt_filter_bytes(filter);
+	ptr->priv_size += sizeof(u64); /* Cap Event Trace */
 
 	return ptr->priv_size;
 }
@@ -335,6 +336,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	unsigned long max_non_turbo_ratio;
 	size_t filter_str_len;
 	const char *filter;
+	int event_trace;
 	__u64 *info;
 	int err;
 
@@ -357,6 +359,9 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 	if (perf_pmu__scan_file(intel_pt_pmu, "max_nonturbo_ratio",
 				"%lu", &max_non_turbo_ratio) != 1)
 		max_non_turbo_ratio = 0;
+	if (perf_pmu__scan_file(intel_pt_pmu, "caps/event_trace",
+				"%d", &event_trace) != 1)
+		event_trace = 0;
 
 	filter = intel_pt_find_filter(session->evlist, ptr->intel_pt_pmu);
 	filter_str_len = filter ? strlen(filter) : 0;
@@ -407,6 +412,8 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
 		info += len >> 3;
 	}
 
+	*info++ = event_trace;
+
 	return 0;
 }
 
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index f3e5c2dfee25..23cb272e3d03 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -75,6 +75,7 @@ struct intel_pt {
 	bool mispred_all;
 	bool use_thread_stack;
 	bool callstack;
+	bool cap_event_trace;
 	unsigned int br_stack_sz;
 	unsigned int br_stack_sz_plus;
 	int have_sched_switch;
@@ -3795,7 +3796,7 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 	}
 
 	info = &auxtrace_info->priv[INTEL_PT_FILTER_STR_LEN] + 1;
-	info_end = (void *)info + auxtrace_info->header.size;
+	info_end = (void *)auxtrace_info + auxtrace_info->header.size;
 
 	if (intel_pt_has(auxtrace_info, INTEL_PT_FILTER_STR_LEN)) {
 		size_t len;
@@ -3834,6 +3835,13 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
 		intel_pt_print_info_str("Filter string", pt->filter);
 	}
 
+	if ((void *)info < info_end) {
+		pt->cap_event_trace = *info++;
+		if (dump_trace)
+			fprintf(stdout, "  Cap Event Trace     %d\n",
+				pt->cap_event_trace);
+	}
+
 	pt->timeless_decoding = intel_pt_timeless_decoding(pt);
 	if (pt->timeless_decoding && !pt->tc.time_mult)
 		pt->tc.time_mult = 1;
-- 
2.25.1

