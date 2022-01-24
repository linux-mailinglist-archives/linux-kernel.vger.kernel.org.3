Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54D9497A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbiAXIma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:42:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:62595 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242273AbiAXImQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643013736; x=1674549736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kKu64js75pIInjB+0/NtD/yf7Z3KzousYXaExP2l5Ig=;
  b=mefd9F2KFwsusZgFOzb1BQIMrCyx+GgPEK5jtw5jD2scYE5kBFW2nCtu
   p7MZzK/7h86OKSNxURRyIYmY5hDzhcaqeRMEkSWnifORTEFltQSOCe5je
   OLrMaEJC6+R+mYwnGGUTMdv1/B9CIUuqvVCPhT6AFiQtwz4mzLkmHgWLj
   KX6nmobVlju/WACdaoTXRU/V33AWlgBVFRiBCuu1Iwc9IJ095ug1eLAM/
   ofJ09pBRlGNd5jHCzzcRJqiX5ImijzCQZAf2MLJ1MxOW19RaGvQMUDEyh
   ybKHloOjtuOBxpEgm9rrQdglt2Hpuaft/zOG1j52xz8QYbnZeCKhP9TQx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245778355"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245778355"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 00:42:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627417006"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga004.jf.intel.com with ESMTP; 24 Jan 2022 00:42:13 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/25] perf intel-pt: decoder: Add config bit definitions
Date:   Mon, 24 Jan 2022 10:41:41 +0200
Message-Id: <20220124084201.2699795-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124084201.2699795-1-adrian.hunter@intel.com>
References: <20220124084201.2699795-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tidy up config bit constants to use #define.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index e8613cbda331..f3e5c2dfee25 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -46,6 +46,10 @@
 
 #define MAX_TIMESTAMP (~0ULL)
 
+#define INTEL_PT_CFG_PASS_THRU	BIT_ULL(0)
+#define INTEL_PT_CFG_PWR_EVT_EN	BIT_ULL(4)
+#define INTEL_PT_CFG_BRANCH_EN	BIT_ULL(13)
+
 struct range {
 	u64 start;
 	u64 end;
@@ -953,7 +957,8 @@ static bool intel_pt_branch_enable(struct intel_pt *pt)
 
 	evlist__for_each_entry(pt->session->evlist, evsel) {
 		if (intel_pt_get_config(pt, &evsel->core.attr, &config) &&
-		    (config & 1) && !(config & 0x2000))
+		    (config & INTEL_PT_CFG_PASS_THRU) &&
+		    !(config & INTEL_PT_CFG_BRANCH_EN))
 			return false;
 	}
 	return true;
@@ -3429,7 +3434,7 @@ static int intel_pt_synth_events(struct intel_pt *pt,
 		id += 1;
 	}
 
-	if (pt->synth_opts.pwr_events && (evsel->core.attr.config & 0x10)) {
+	if (pt->synth_opts.pwr_events && (evsel->core.attr.config & INTEL_PT_CFG_PWR_EVT_EN)) {
 		attr.config = PERF_SYNTH_INTEL_MWAIT;
 		err = intel_pt_synth_event(session, "mwait", &attr, id);
 		if (err)
-- 
2.25.1

