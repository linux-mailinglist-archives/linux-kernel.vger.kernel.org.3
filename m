Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A452749BD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiAYVAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:00:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:39742 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbiAYVAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643144408; x=1674680408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WvdDyI6ECl0+Kf6KKbP3w+z33rVKPbyhr+wTU8wwZBc=;
  b=RieRfnSisnbDoK+y9oQtjejuEo5V5HdUQtiQwN3n7+yZNmt7QGe+ZGIT
   ri8kK6Hz8ndhugnmfUMHmWmCfLrM3SMmKgDfqJQnBC1yRT7gMO6vldZIY
   YoNr/8jqK6WMGlPgTxm1c6qB0GL/tnx71haHhjYubJOh0QMiqA9nbohay
   /jCCCCWCiyem48+DF/bcQ/NqW7JfAHJSEF/4YkAgLF9yD15mz4LAy3iBf
   WSAlKDl63E0f0GHl86ZUGSASVOvc1+27fexfs9HY27MMGGpe6SNgu8Sc5
   yFq2lTNt+82qiisIi7u/R7VW8CXxugq4Zs5gQICcZN66cZRSV0Ikndrtf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244013718"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="244013718"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 13:00:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="520545812"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2022 13:00:08 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/4] perf/x86/cstate: Add Raptor Lake support
Date:   Tue, 25 Jan 2022 15:57:49 -0800
Message-Id: <1643155071-98900-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643155071-98900-1-git-send-email-kan.liang@linux.intel.com>
References: <1643155071-98900-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Raptor Lake is Intel's successor to Alder lake. From the perspective of
Intel cstate residency counters, there is nothing changed compared with
Alder lake.

Share adl_cstates with Alder lake.
Update the comments for Raptor Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index c6262b1..5d77622 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -40,7 +40,7 @@
  * Model specific counters:
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
- *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL
+ *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -51,49 +51,50 @@
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL
+ *						TGL,TNT,RKL,ADL,RPL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL,RKL,ADL
+ *						ICL,TGL,RKL,ADL,RPL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL
+ *						KBL,CML,ICL,ICX,TGL,TNT,RKL,ADL,
+ *						RPL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
  *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
- *						ADL
+ *						ADL,RPL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL
+ *						TGL,TNT,RKL,ADL,RPL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
- *						KBL,CML,ICL,TGL,RKL,ADL
+ *						KBL,CML,ICL,TGL,RKL,ADL,RPL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
  *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
- *						ADL
+ *						ADL,RPL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
  *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
- *						ADL
+ *						ADL,RPL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL,ADL
+ *						TNT,RKL,ADL,RPL
  *			       Scope: Package (physical package)
  *
  */
@@ -680,6 +681,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.7.4

