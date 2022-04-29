Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5558E51559E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380775AbiD2Ucc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380729AbiD2UcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:32:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D8D5EA5;
        Fri, 29 Apr 2022 13:28:54 -0700 (PDT)
Date:   Fri, 29 Apr 2022 20:28:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651264133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p86MzKcOBzUomU9z71NSuR5iSi0g8/xOjfzoAYCowOY=;
        b=4FqND3EpBFgpDIvDYQZXxBmLVtOFs5o5TpcgtyQ67N6p0APWE+p4k7yJMG+bmnDwU3V0Et
        Ia/wPnrHYnKVFfViIicq0/kzRYQ97li7yzFaTytLH5Gq2hVSszeTHZwYQ7PkBTmiTq04h3
        rCK0s5GGXQXFiRK8WRXLcA8UOVzDNKvfsc4NVv34yij/ltwqqBG55fCMkDQAaHeHHDCTqU
        zTfP8m6U/2LXPwoP7qakAWJ2nIMzaoIa/CfASgmsfcUC/4wKTuWU+AIUC8D254EsDbiPP9
        rJndEqmyp67OTdyO72KlH1nd4i+zYSQNnk3FpyTOD5xI3FAkNkxDMmKyQUYaFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651264133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p86MzKcOBzUomU9z71NSuR5iSi0g8/xOjfzoAYCowOY=;
        b=kOkUxU0Ik8504t/1hRiByS7XHHTrp9B7x9ZshapZNa62dpDa10BLsMzamfQct3gtWV42cW
        1axaLmCOM9RJBHBg==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/core: Detect PerfMonV2 support
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cdc8672ecbddff394e088ca8abf94b089b8ecc2e7=2E16505?=
 =?utf-8?q?15382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cdc8672ecbddff394e088ca8abf94b089b8ecc2e7=2E165051?=
 =?utf-8?q?5382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165126413207.4207.8677027600794947168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     28c332ff4d11060ed3b4a2029016ba9a83f1bceb
Gitweb:        https://git.kernel.org/tip/28c332ff4d11060ed3b4a2029016ba9a83f1bceb
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 21 Apr 2022 11:16:55 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Apr 2022 11:06:26 +02:00

perf/x86/amd/core: Detect PerfMonV2 support

AMD Performance Monitoring Version 2 (PerfMonV2) introduces
some new Core PMU features such as detection of the number
of available PMCs and managing PMCs using global registers
namely, PerfCntrGlobalCtl and PerfCntrGlobalStatus.

Clearing PerfCntrGlobalCtl and PerfCntrGlobalStatus ensures
that all PMCs are inactive and have no pending overflows
when CPUs are onlined or offlined.

The PMU version (x86_pmu.version) now indicates PerfMonV2
support and will be used to bypass the new features on
unsupported processors.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/dc8672ecbddff394e088ca8abf94b089b8ecc2e7.1650515382.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8e1e818..b70dfa0 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -19,6 +19,9 @@ static unsigned long perf_nmi_window;
 #define AMD_MERGE_EVENT ((0xFULL << 32) | 0xFFULL)
 #define AMD_MERGE_EVENT_ENABLE (AMD_MERGE_EVENT | ARCH_PERFMON_EVENTSEL_ENABLE)
 
+/* PMC Enable and Overflow bits for PerfCntrGlobal* registers */
+static u64 amd_pmu_global_cntr_mask __read_mostly;
+
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -578,6 +581,18 @@ static struct amd_nb *amd_alloc_nb(int cpu)
 	return nb;
 }
 
+static void amd_pmu_cpu_reset(int cpu)
+{
+	if (x86_pmu.version < 2)
+		return;
+
+	/* Clear enable bits i.e. PerfCntrGlobalCtl.PerfCntrEn */
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+
+	/* Clear overflow bits i.e. PerfCntrGLobalStatus.PerfCntrOvfl */
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, amd_pmu_global_cntr_mask);
+}
+
 static int amd_pmu_cpu_prepare(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
@@ -625,6 +640,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	cpuc->amd_nb->refcnt++;
 
 	amd_brs_reset();
+	amd_pmu_cpu_reset(cpu);
 }
 
 static void amd_pmu_cpu_dead(int cpu)
@@ -644,6 +660,8 @@ static void amd_pmu_cpu_dead(int cpu)
 
 		cpuhw->amd_nb = NULL;
 	}
+
+	amd_pmu_cpu_reset(cpu);
 }
 
 /*
@@ -1185,6 +1203,15 @@ static int __init amd_core_pmu_init(void)
 	x86_pmu.eventsel	= MSR_F15H_PERF_CTL;
 	x86_pmu.perfctr		= MSR_F15H_PERF_CTR;
 	x86_pmu.num_counters	= AMD64_NUM_COUNTERS_CORE;
+
+	/* Check for Performance Monitoring v2 support */
+	if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
+		/* Update PMU version for later usage */
+		x86_pmu.version = 2;
+
+		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
+	}
+
 	/*
 	 * AMD Core perfctr has separate MSRs for the NB events, see
 	 * the amd/uncore.c driver.
