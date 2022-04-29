Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A351559C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380776AbiD2UcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380724AbiD2UcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:32:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A89D64D2;
        Fri, 29 Apr 2022 13:28:53 -0700 (PDT)
Date:   Fri, 29 Apr 2022 20:28:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651264132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3bEHuKi/YMtv9yUz8Pb4UvupMyQsMqoyGrOGFMm4vY=;
        b=GY8ujBD+YmSu23VwfObpb8enX1tZR0BTv127IeTDjO83+ybRLulgVlNqS7pD060yhVMllr
        ZfrhW3HTPmdZ+mZWEuZXREHIe6g7T0FX2a7PJ9Ugo6c1+l/LqiilKO3D5ec2vVa6UMnVew
        pItB6f6DvVAEsu7EAzK+6u4UilnUxeZrYtqycRFU4D0FTFoY3A3aIJPjph/HzUYQu7UE4z
        X0xEu2VdDIjN4d2WDpBIAAtYs9TJFiTqb3EA1HVFyYOJtz8olARs74I848vq3x3PR+PyO3
        DQtmUu+YnawguZHDNC4D5FyEUZmkkKe4HgLwN+p0XUkyujUOtS/A3jjgqbdKsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651264132;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v3bEHuKi/YMtv9yUz8Pb4UvupMyQsMqoyGrOGFMm4vY=;
        b=FD8Gv4jA2yhoJRqK0j8FtKRNqCKdjuoFA36GgsB+DF9Yp2wiodeKe3tRJQmBPNLeJEWhcB
        eCiLw35P6hwC+uBA==
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
Message-ID: <165126413115.4207.11010123916736399975.tip-bot2@tip-bot2>
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

Commit-ID:     baf0f4a6733095d7443a07e5db5525376c1c9bd5
Gitweb:        https://git.kernel.org/tip/baf0f4a6733095d7443a07e5db5525376c1c9bd5
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 21 Apr 2022 11:16:56 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 29 Apr 2022 11:06:27 +02:00

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
 
