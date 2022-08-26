Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7226D5A31EB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbiHZWSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345274AbiHZWRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:17:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF4AE7258;
        Fri, 26 Aug 2022 15:16:12 -0700 (PDT)
Date:   Fri, 26 Aug 2022 22:16:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661552170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxs9gL6DusgacpQMEUHdAzEPgwiDETcwxTGkzwo0fNM=;
        b=E1saB1X8WJ5zKY3IToL5xXEKS/3no4rPcABnnEaBLw6tu5d7c4Wj9kVIj0iwgbvkOlhyhm
        Y5E0khzdXml6OtZnKjgL72tv3dSxtikwa+WroCYLCZEHeWNJws/z04y/jPSnjOzTeutpHs
        0SvHJ6dxymiyAK5GHjPcm1X3qGZekAqWhSPKtkwkI1M55yF/VewW9MyKoSPwe/4Q8nGhsj
        B4BbxBl0Nc+Hyvq4DPJyq7EPTgjJlFZYvXc6ShB9FoQeRUuQJeIp4rBJBg4/AU6VmfJrHR
        E6xzHUBn0rzRZaLRmjwSsJ7epHpSckZR00e5AKjTnL5ZAeNrdnsqchCSWzvP4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661552170;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxs9gL6DusgacpQMEUHdAzEPgwiDETcwxTGkzwo0fNM=;
        b=y0SKBFfmwGXyREirGxWRKTVlf9tX2C5Zz1A97KVJAjxSbZITOyTN5wyHZ7bdV9akHDEo8I
        CCVMlGtDPphk2tDQ==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/core: Add generic branch record interfaces
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cb75dbc32663cb395f0d701167e952c6a6b0445a3=2E16602?=
 =?utf-8?q?11399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cb75dbc32663cb395f0d701167e952c6a6b0445a3=2E166021?=
 =?utf-8?q?1399=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <166155216858.401.7812468505762276879.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     706460a96fc654e80b6bed1f562b00d2ce9f2f4d
Gitweb:        https://git.kernel.org/tip/706460a96fc654e80b6bed1f562b00d2ce9f2f4d
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 11 Aug 2022 17:59:51 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 27 Aug 2022 00:05:42 +02:00

perf/x86/amd/core: Add generic branch record interfaces

AMD processors that are capable of recording branches support either Branch
Sampling (BRS) or Last Branch Record (LBR). In preparation for adding Last
Branch Record Extension Version 2 (LbrExtV2) support, introduce new static
calls which act as gateways to call into the feature-dependent functions
based on what is available on the processor.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/b75dbc32663cb395f0d701167e952c6a6b0445a3.1660211399.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 2f524cf..ef35207 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -330,6 +330,8 @@ static inline bool amd_is_pair_event_code(struct hw_perf_event *hwc)
 	}
 }
 
+DEFINE_STATIC_CALL_RET0(amd_pmu_branch_hw_config, *x86_pmu.hw_config);
+
 static int amd_core_hw_config(struct perf_event *event)
 {
 	if (event->attr.exclude_host && event->attr.exclude_guest)
@@ -349,7 +351,7 @@ static int amd_core_hw_config(struct perf_event *event)
 		event->hw.flags |= PERF_X86_EVENT_PAIR;
 
 	if (has_branch_stack(event))
-		return amd_brs_hw_config(event);
+		return static_call(amd_pmu_branch_hw_config)(event);
 
 	return 0;
 }
@@ -518,8 +520,14 @@ static struct amd_nb *amd_alloc_nb(int cpu)
 	return nb;
 }
 
+typedef void (amd_pmu_branch_reset_t)(void);
+DEFINE_STATIC_CALL_NULL(amd_pmu_branch_reset, amd_pmu_branch_reset_t);
+
 static void amd_pmu_cpu_reset(int cpu)
 {
+	if (x86_pmu.lbr_nr)
+		static_call(amd_pmu_branch_reset)();
+
 	if (x86_pmu.version < 2)
 		return;
 
@@ -576,7 +584,6 @@ static void amd_pmu_cpu_starting(int cpu)
 	cpuc->amd_nb->nb_id = nb_id;
 	cpuc->amd_nb->refcnt++;
 
-	amd_brs_reset();
 	amd_pmu_cpu_reset(cpu);
 }
 
@@ -771,16 +778,20 @@ static void amd_pmu_v2_disable_all(void)
 	amd_pmu_check_overflow();
 }
 
+DEFINE_STATIC_CALL_NULL(amd_pmu_branch_add, *x86_pmu.add);
+
 static void amd_pmu_add_event(struct perf_event *event)
 {
 	if (needs_branch_stack(event))
-		amd_pmu_brs_add(event);
+		static_call(amd_pmu_branch_add)(event);
 }
 
+DEFINE_STATIC_CALL_NULL(amd_pmu_branch_del, *x86_pmu.del);
+
 static void amd_pmu_del_event(struct perf_event *event)
 {
 	if (needs_branch_stack(event))
-		amd_pmu_brs_del(event);
+		static_call(amd_pmu_branch_del)(event);
 }
 
 /*
@@ -1184,13 +1195,6 @@ static ssize_t amd_event_sysfs_show(char *page, u64 config)
 	return x86_event_sysfs_show(page, config, event);
 }
 
-static void amd_pmu_sched_task(struct perf_event_context *ctx,
-				 bool sched_in)
-{
-	if (sched_in && x86_pmu.lbr_nr)
-		amd_pmu_brs_sched_task(ctx, sched_in);
-}
-
 static u64 amd_pmu_limit_period(struct perf_event *event, u64 left)
 {
 	/*
@@ -1375,8 +1379,14 @@ static int __init amd_core_pmu_init(void)
 	 */
 	if (boot_cpu_data.x86 >= 0x19 && !amd_brs_init()) {
 		x86_pmu.get_event_constraints = amd_get_event_constraints_f19h;
-		x86_pmu.sched_task = amd_pmu_sched_task;
+		x86_pmu.sched_task = amd_pmu_brs_sched_task;
 		x86_pmu.limit_period = amd_pmu_limit_period;
+
+		static_call_update(amd_pmu_branch_hw_config, amd_brs_hw_config);
+		static_call_update(amd_pmu_branch_reset, amd_brs_reset);
+		static_call_update(amd_pmu_branch_add, amd_pmu_brs_add);
+		static_call_update(amd_pmu_branch_del, amd_pmu_brs_del);
+
 		/*
 		 * put_event_constraints callback same as Fam17h, set above
 		 */
