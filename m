Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1703A54827B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbiFMI3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbiFMI3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:29:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3984C1A074;
        Mon, 13 Jun 2022 01:29:06 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:29:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655108944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=El0/lmQHtq7omgI8LCcZHVTLCGcJfVYoNwsJAGUDouQ=;
        b=GJfmQ4cC2bu0hkKgUbrAHvR+ADMwnt7ByFgBTNDvX/LLZZels63OgGMt/hpm/4yldr2etP
        WmBSD+5S585CaSVifg9ot9qbsZbDJitd6/vwbtQpIzzDh8Ex4hXdj9V7SSfnagdC2+3/3C
        9hRBnStw+gw6WM8h3ndUPrEJxpjESoEWVHjsQfYxy5KCA5GzCDeXUuhuRaCDjJmWyNFXjp
        GpHW9eehecjYLXw9VdwoIPTHaDlqW3zjXp3P/8mMfYPlTeZHMwN2gDY43cpMwZVbmQn8Gh
        rPiYRtCVKpGkatydUVgkxAFTFTv6aVSbYcWp8PXAeKXiRjUjFFOKTugjflcF8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655108944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=El0/lmQHtq7omgI8LCcZHVTLCGcJfVYoNwsJAGUDouQ=;
        b=gErji1lM2j3dghtZjlTxW0ZesZWbhesKAIpRY1tXpCrstmjJ+rY5tqIiiTdrvwCp9jHFiQ
        xWt9M+QYOh8AEkBA==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Detect available DF counters
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cbac7b2806561e03f2acc7fdc9db94f102df80e1d=2E16529?=
 =?utf-8?q?54372=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cbac7b2806561e03f2acc7fdc9db94f102df80e1d=2E165295?=
 =?utf-8?q?4372=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165510894372.4207.6081140723094981410.tip-bot2@tip-bot2>
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

Commit-ID:     16b48c3f5ed85b8017526b1acacf5115461b489a
Gitweb:        https://git.kernel.org/tip/16b48c3f5ed85b8017526b1acacf5115461b489a
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 19 May 2022 15:33:32 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:15:13 +02:00

perf/x86/amd/uncore: Detect available DF counters

If AMD Performance Monitoring Version 2 (PerfMonV2) is
supported, use CPUID leaf 0x80000022 EBX to detect the
number of Data Fabric (DF) PMCs. This offers more
flexibility if the counts change in later processor
families.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/bac7b2806561e03f2acc7fdc9db94f102df80e1d.1652954372.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c      | 10 ++++++++++
 arch/x86/include/asm/perf_event.h |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index c3e218d..233dd40 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -30,6 +30,7 @@
 #undef pr_fmt
 #define pr_fmt(fmt)	"amd_uncore: " fmt
 
+static int pmu_version;
 static int num_counters_llc;
 static int num_counters_nb;
 static bool l3_mask;
@@ -629,6 +630,7 @@ static int __init amd_uncore_init(void)
 {
 	struct attribute **df_attr = amd_uncore_df_format_attr;
 	struct attribute **l3_attr = amd_uncore_l3_format_attr;
+	union cpuid_0x80000022_ebx ebx;
 	int ret = -ENODEV;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
@@ -638,6 +640,9 @@ static int __init amd_uncore_init(void)
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;
 
+	if (boot_cpu_has(X86_FEATURE_PERFMON_V2))
+		pmu_version = 2;
+
 	num_counters_nb	= NUM_COUNTERS_NB;
 	num_counters_llc = NUM_COUNTERS_L2;
 	if (boot_cpu_data.x86 >= 0x17) {
@@ -666,6 +671,11 @@ static int __init amd_uncore_init(void)
 		if (ret)
 			goto fail_nb;
 
+		if (pmu_version >= 2) {
+			ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
+			num_counters_nb = ebx.split.num_df_pmc;
+		}
+
 		pr_info("%d %s %s counters detected\n", num_counters_nb,
 			boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ?  "HYGON" : "",
 			amd_nb_pmu.name);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 409725e..af157aa 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -194,6 +194,9 @@ union cpuid_0x80000022_ebx {
 	struct {
 		/* Number of Core Performance Counters */
 		unsigned int	num_core_pmc:4;
+		unsigned int	reserved:6;
+		/* Number of Data Fabric Counters */
+		unsigned int	num_df_pmc:6;
 	} split;
 	unsigned int		full;
 };
