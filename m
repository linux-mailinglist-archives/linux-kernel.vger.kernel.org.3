Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4285E4A63C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiBAS01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:26:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:60474 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbiBAS00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643739986; x=1675275986;
  h=from:to:cc:subject:date:message-id;
  bh=IoVOK8NbvIMcBLVOOCUAyvtTa2FpyVUrNVwk0g0DRj8=;
  b=FKcoRSuepuoun4W6uliFPVCre6R+sqAP0e8t4MOCzopNNqKcNFWd1MtA
   KFjYo2qNiw8tVIK9x7mfahXqqZSpwR00JpOUa1rDZZGKBFKv4XI3IoWDm
   6EMnMdcENzInbcBBBHEQYRTroEBWNjH9JaFXWx8L0dlzAf3Ov5960OdT6
   +1YqZ57tj7vPGxVrttrKGB5esiAmNxIqNNaZ/wuVuKgy7tUuE7Dl+qP5f
   x2/S0JeGpEso3lcqKSilYMJ4iS3WEYHyNaZlKwwtGtssoEboK0nA4ifnu
   CoHn1q45r5UWwk0J6rZsdexzei8d8AMWmw7JHfZ8hQy2xNfdc2UA96CSd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247527581"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="247527581"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 10:26:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="565681616"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga001.jf.intel.com with ESMTP; 01 Feb 2022 10:26:09 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/3] perf/x86/intel: Enable PEBS format 5
Date:   Tue,  1 Feb 2022 13:23:21 -0800
Message-Id: <1643750603-100733-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The new PEBS Record Format 5 is similar to the PEBS Record Format 4. The
only difference is the layout of the Counter Reset fields of the PEBS
Config Buffer in the DS area. For the PEBS format 4, the Counter Reset
fields allocation is for 8 general-purpose counters followed by 4
fixed-function counters. For the PEBS format 5, the Counter Reset fields
allocation is for 32 general-purpose counters followed by 16
fixed-function counters.

Extend the MAX_PEBS_EVENTS to 32. Add MAX_PEBS_EVENTS_FMT4 for the
previous platform. Except for the DS auto-reload code, other places
already assume 32 counters. Only check the PEBS_FMT in the DS
auto-reload code.

Extend the MAX_FIXED_PEBS_EVENTS to 16, which only impacts the size of
struct debug_store and some local temporary variables. The size of
struct debug_store increases 288B, which is small and should be
acceptable.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c      | 14 +++++++++++---
 arch/x86/include/asm/intel_ds.h |  5 +++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2e21536..376cc3d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1203,7 +1203,10 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 	if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
 		base = MSR_RELOAD_FIXED_CTR0;
 		idx = hwc->idx - INTEL_PMC_IDX_FIXED;
-		value = ds->pebs_event_reset[MAX_PEBS_EVENTS + idx];
+		if (x86_pmu.intel_cap.pebs_format < 5)
+			value = ds->pebs_event_reset[MAX_PEBS_EVENTS_FMT4 + idx];
+		else
+			value = ds->pebs_event_reset[MAX_PEBS_EVENTS + idx];
 	}
 	wrmsrl(base + idx, value);
 }
@@ -1232,8 +1235,12 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 		}
 	}
 
-	if (idx >= INTEL_PMC_IDX_FIXED)
-		idx = MAX_PEBS_EVENTS + (idx - INTEL_PMC_IDX_FIXED);
+	if (idx >= INTEL_PMC_IDX_FIXED) {
+		if (x86_pmu.intel_cap.pebs_format < 5)
+			idx = MAX_PEBS_EVENTS_FMT4 + (idx - INTEL_PMC_IDX_FIXED);
+		else
+			idx = MAX_PEBS_EVENTS + (idx - INTEL_PMC_IDX_FIXED);
+	}
 
 	/*
 	 * Use auto-reload if possible to save a MSR write in the PMI.
@@ -2204,6 +2211,7 @@ void __init intel_ds_init(void)
 			break;
 
 		case 4:
+		case 5:
 			x86_pmu.drain_pebs = intel_pmu_drain_pebs_icl;
 			x86_pmu.pebs_record_size = sizeof(struct pebs_basic);
 			if (x86_pmu.intel_cap.pebs_baseline) {
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index 8380c3dd..2f9eeb5 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -7,8 +7,9 @@
 #define PEBS_BUFFER_SIZE	(PAGE_SIZE << 4)
 
 /* The maximal number of PEBS events: */
-#define MAX_PEBS_EVENTS		8
-#define MAX_FIXED_PEBS_EVENTS	4
+#define MAX_PEBS_EVENTS_FMT4	8
+#define MAX_PEBS_EVENTS		32
+#define MAX_FIXED_PEBS_EVENTS	16
 
 /*
  * A debug store configuration.
-- 
2.7.4

