Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3958C497A83
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbiAXInS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:43:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:62621 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242411AbiAXImv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013771; x=1674549771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P/dMgwg1V0hlBxLmQZn3s/GYLfkoLYgxBcveFlmrccs=;
  b=SCEu8cTOJkPvmkwLTvhAjHWIXPx4DwADjaLUMrM8uSaPxR91LVEcRy9C
   qVZb8FahFhoBtnahP96dgz6+GBqGjx4OYCw4Ic3pM74RiXWkm7aYKGTrw
   uBCFP+8+Xc/CdKhRrlMn2yf7h9GcnddraaletWlJZcJCOqQi4stF4FKlq
   sYsbBM4mB7/iODmqnHlqKxswYt/Ikrlmn8ADSX26Q1/F2KdGnoRUR20ZE
   t147xTlMezd/MiHXvgoZNfj89PXJKsi6t5Y7S9bA/QpthlGzyPQkRpszR
   bIQ+Cgfde4U1p8y0dWrqCK+jaiS8BCcgdqgxjNbPRULcWAd+2RtTDq80R
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778465"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778465"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417197"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:40 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 17/25] perf intel-pt: Force 'quick' mode when TNT is disabled
Date:   Mon, 24 Jan 2022 10:41:53 +0200
Message-Id: <20220124084201.2699795-18-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not possible to walk the executable code without TNT packets, so
force 'quick' mode when TNT is disabled, because 'quick' mode does not walk
the code.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index d76e4b865cb0..ec43d364d0de 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -50,6 +50,7 @@
 #define INTEL_PT_CFG_PWR_EVT_EN	BIT_ULL(4)
 #define INTEL_PT_CFG_BRANCH_EN	BIT_ULL(13)
 #define INTEL_PT_CFG_EVT_EN	BIT_ULL(31)
+#define INTEL_PT_CFG_TNT_DIS	BIT_ULL(55)
 
 struct range {
 	u64 start;
@@ -972,6 +973,19 @@ static bool intel_pt_branch_enable(struct intel_pt *pt)
 	return true;
 }
 
+static bool intel_pt_disabled_tnt(struct intel_pt *pt)
+{
+	struct evsel *evsel;
+	u64 config;
+
+	evlist__for_each_entry(pt->session->evlist, evsel) {
+		if (intel_pt_get_config(pt, &evsel->core.attr, &config) &&
+		    config & INTEL_PT_CFG_TNT_DIS)
+			return true;
+	}
+	return false;
+}
+
 static unsigned int intel_pt_mtc_period(struct intel_pt *pt)
 {
 	struct evsel *evsel;
@@ -1227,6 +1241,10 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 	params.first_timestamp = pt->first_timestamp;
 	params.max_loops = pt->max_loops;
 
+	/* Cannot walk code without TNT, so force 'quick' mode */
+	if (params.branch_enable && intel_pt_disabled_tnt(pt) && !params.quick)
+		params.quick = 1;
+
 	if (pt->filts.cnt > 0)
 		params.pgd_ip = intel_pt_pgd_ip;
 
-- 
2.25.1

