Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909A34DA193
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350719AbiCORwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbiCORwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:52:36 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AB55130A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647366684; x=1678902684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ZBs2WmIJK+gkVpayynSj0LA0+cFSOrZwR7W3ic+d43g=;
  b=iJ2TtZKUzdHFZXlPAXy5dt46lSpOuZSNs5m2slhiGV5hndmA5BOiZBTl
   HNTqgIIM3B8sEhpxcVAzsGwR7/SjiLdsr2tg1UmdCVKaEKCRkD8UKrQ6w
   WSAjkRSEAU2Pb1ka4Yfh1fwzdTmlwTWMNr0O5ZftLW3bB4ZUWEjJKkHw7
   MRBBC+RzaYFYrHAP2Osm4AegzPGqnJ7MHL1EKAj5atnBpo0JqmQ7jnLIE
   dTSPRcCYlTrygSGR7CF9YmAQSur6+Z67pctZKMwckxt84+W/g0ibaFyVg
   yWMN28ay5j5S251+YtdPm9vLyo+9kh+Wgw8Cdu6EtW3N/IhM37x1fpuGT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="317106858"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="317106858"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 10:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="613358392"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga004.fm.intel.com with ESMTP; 15 Mar 2022 10:46:37 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 2/4] perf/x86/cstate: Add Raptor Lake support
Date:   Tue, 15 Mar 2022 10:45:58 -0700
Message-Id: <1647366360-82824-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
References: <1647366360-82824-1-git-send-email-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

No changes since V1

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

