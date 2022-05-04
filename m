Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B6A519B91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347193AbiEDJ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347138AbiEDJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:27:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1782625C4A;
        Wed,  4 May 2022 02:23:25 -0700 (PDT)
Date:   Wed, 04 May 2022 09:23:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651656203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IglNAkUMgW4aOox6ETlq6rcqA9FgejcGDcW3R1wHdA=;
        b=gZ7JxnMYR7LuRMwox4TtAZPDpl5LxgLiUyNugV97Yi49tsor+sTO1mjQWwGxcA9/8L8oBB
        kqFp1T98mT8c48CWb59o2HK/C7iu7gDrI+uEVziyfB30JseWTVW85WQ1kf9y7fF5aixleg
        6LJdJeKdD+IOpSB4lSpR2P0UO+NQF26RJ2nZ2yn6OJFaUDsKGTdl37WhuOf69T48uoop25
        9YX75Fz2Dm6EcGPRSE4asP/qdptXKJT4UrXGmjCqgzfAfCxtsmOWCLBt3b4XvPB5f67ZXy
        eyMIl8qBvy1z+abTOKfTnWhtyaXikwFCcz0a86eqXIFbyBBJCYhx6NS+uYAQtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651656203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IglNAkUMgW4aOox6ETlq6rcqA9FgejcGDcW3R1wHdA=;
        b=wjWaLUDANI2goNClbn9E4XUHK58xEwluZa0fqePrsmfuDf699JIUWlzLF0ckR8bkx5rlGa
        xbInC9s1I9epYfBg==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/core: Detect available counters
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C68a6d9688df189267db26530378870edd34f7b06=2E16505?=
 =?utf-8?q?15382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C68a6d9688df189267db26530378870edd34f7b06=2E165051?=
 =?utf-8?q?5382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165165620267.4207.5262108083231235324.tip-bot2@tip-bot2>
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

Commit-ID:     56e026a7ca3f92b8e44359e1f705febd1833f701
Gitweb:        https://git.kernel.org/tip/56e026a7ca3f92b8e44359e1f705febd1833f701
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 21 Apr 2022 11:16:56 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 May 2022 11:18:26 +02:00

perf/x86/amd/core: Detect available counters

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, use CPUID leaf 0x80000022 EBX to detect the
number of Core PMCs. This offers more flexibility if the
counts change in later processor families.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/68a6d9688df189267db26530378870edd34f7b06.1650515382.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c        |  6 ++++++
 arch/x86/include/asm/perf_event.h | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index b70dfa0..52fd794 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1186,6 +1186,7 @@ static const struct attribute_group *amd_attr_update[] = {
 
 static int __init amd_core_pmu_init(void)
 {
+	union cpuid_0x80000022_ebx ebx;
 	u64 even_ctr_mask = 0ULL;
 	int i;
 
@@ -1206,9 +1207,14 @@ static int __init amd_core_pmu_init(void)
 
 	/* Check for Performance Monitoring v2 support */
 	if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
+		ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
+
 		/* Update PMU version for later usage */
 		x86_pmu.version = 2;
 
+		/* Find the number of available Core PMCs */
+		x86_pmu.num_counters = ebx.split.num_core_pmc;
+
 		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
 	}
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8199fc5..c6cc07f 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -186,6 +186,18 @@ union cpuid28_ecx {
 	unsigned int            full;
 };
 
+/*
+ * AMD "Extended Performance Monitoring and Debug" CPUID
+ * detection/enumeration details:
+ */
+union cpuid_0x80000022_ebx {
+	struct {
+		/* Number of Core Performance Counters */
+		unsigned int	num_core_pmc:4;
+	} split;
+	unsigned int		full;
+};
+
 struct x86_pmu_capability {
 	int		version;
 	int		num_counters_gp;
@@ -368,6 +380,11 @@ struct pebs_xmm {
 };
 
 /*
+ * AMD Extended Performance Monitoring and Debug cpuid feature detection
+ */
+#define EXT_PERFMON_DEBUG_FEATURES		0x80000022
+
+/*
  * IBS cpuid feature detection
  */
 
