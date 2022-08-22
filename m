Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C52E59BC28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiHVJBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiHVJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:00:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE642E9CC;
        Mon, 22 Aug 2022 02:00:54 -0700 (PDT)
Date:   Mon, 22 Aug 2022 09:00:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661158852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReOXIpSfOPpncnKDF2n09CmwdD8oZwTAkLarVmVMwBM=;
        b=eo4OYCOhtnrOupq56/if2MTuMjfnzwxBy+TBDqGurxUhp+Us7k0H0DxpH0b3dUATUgbpSM
        6GaptnM3zuO0ZN8nuQX+drff9LcQjL6It0Z2KUsV+WXNX4DVU/apYRIZ/V4xgD255oIb4H
        c33b8hl6yTwa4Qq1RHSyPeIsVZQUkKTDWVEz9oOBXTpM8ymyKoyPJEFH7Yeu170mWuinDo
        aylsr588HqIVzWOp00d0aV87PhxieaIap7kMaWPUv0gQTz45FcggZfrrZuADF25cJ6+qBD
        7I5T+j3sg3+DFuzQHJXBkkY69mXNUZRAtK9VlWA4ZWnVkp3SUWk5eCSe7Je5TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661158852;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReOXIpSfOPpncnKDF2n09CmwdD8oZwTAkLarVmVMwBM=;
        b=vZ5hW3kOo/tO3PMjJa3rTb34KiaKceR0HnIPRIKpvuXq014ukhw5GwGxF2wRdq88NIUuhZ
        Is0pZbxPnt4i5iBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/core: Set pebs_capable and
 PMU_FL_PEBS_ALL for the Baseline
Cc:     Like Xu <likexu@tencent.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220816114057.51307-1-likexu@tencent.com>
References: <20220816114057.51307-1-likexu@tencent.com>
MIME-Version: 1.0
Message-ID: <166115885174.401.8267835272671684126.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7d3598868aaee05eb738d1c3115616b867e7530a
Gitweb:        https://git.kernel.org/tip/7d3598868aaee05eb738d1c3115616b867e7530a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 16 Aug 2022 19:40:57 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 Aug 2022 19:47:31 +02:00

perf/x86/core: Set pebs_capable and PMU_FL_PEBS_ALL for the Baseline

The SDM explicitly states that PEBS Baseline implies Extended PEBS.
For cpu model forward compatibility (e.g. on ICX, SPR, ADL), it's
safe to stop doing FMS table thing such as setting pebs_capable and
PMU_FL_PEBS_ALL since it's already set in the intel_ds_init().

The Goldmont Plus is the only platform which supports extended PEBS
but doesn't have Baseline. Keep the status quo.

Reported-by: Like Xu <likexu@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/20220816114057.51307-1-likexu@tencent.com
---
 arch/x86/events/intel/core.c | 4 ----
 arch/x86/events/intel/ds.c   | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2db9349..cb98a05 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6291,10 +6291,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_aliases = NULL;
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.pebs_block = true;
-		x86_pmu.pebs_capable = ~0ULL;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
-		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 
@@ -6337,10 +6335,8 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_aliases = NULL;
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.pebs_block = true;
-		x86_pmu.pebs_capable = ~0ULL;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
-		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
 		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.lbr_pt_coexist = true;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba60427..ac6dd4c 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2262,6 +2262,7 @@ void __init intel_ds_init(void)
 					PERF_SAMPLE_BRANCH_STACK |
 					PERF_SAMPLE_TIME;
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
+				x86_pmu.pebs_capable = ~0ULL;
 				pebs_qual = "-baseline";
 				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
