Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEFA4F3841
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376475AbiDELWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241544AbiDEIsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D7F29CA1;
        Tue,  5 Apr 2022 01:36:44 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6e2iJkeD9BAyrtexCx29/YLmPPgQrYaKKMMH1f5kNFY=;
        b=T3fYhTNGIYFMiTFJkzVHz65w6orILINqyZtainHt50O30opdV5YwMYyPSGlgoQRB8aG6lZ
        Sjr+VjA5HqZcOXvOdP5ssl8x1jYE26FQ+kuWEshGs9m8fcexu7Gunk7+QzBu9kykEensB2
        bOmAOERN7vYcuA3PVXCeZQP9+UGmsibjvExWrCcrVQrEtUAy/dYbUvV6ihosWwTc/1QJKd
        Bg42bspMA7ZxUsrBCVQnQwaIWemL4w+kvsJShBs+BxmnvLaJ1jzDrbiGupBQXJaLAEptM4
        lIS68IW05x+j5BXzJJWkxNZgVsKpCaXfoz6VbmT0oOLWrmFK2+smJG5lRGQsdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6e2iJkeD9BAyrtexCx29/YLmPPgQrYaKKMMH1f5kNFY=;
        b=7CUa6rguA9S3hrGua12J/7pi+DilzGKFN1HGfnBJmGAY/0BkzY6+sivoDRsPKsIvqUGtAX
        8AvXg6wQnpJOGrAQ==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Make Zen3 branch sampling opt-in
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322221517.2510440-8-eranian@google.com>
References: <20220322221517.2510440-8-eranian@google.com>
MIME-Version: 1.0
Message-ID: <164914779922.389.2109110195997565044.tip-bot2@tip-bot2>
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

Commit-ID:     cc37e520a236069c0de0e7ea455082fa11c73b12
Gitweb:        https://git.kernel.org/tip/cc37e520a236069c0de0e7ea455082fa11c73b12
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Tue, 22 Mar 2022 15:15:11 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:38 +02:00

perf/x86/amd: Make Zen3 branch sampling opt-in

Add a kernel config option CONFIG_PERF_EVENTS_AMD_BRS
to make the support for AMD Zen3 Branch Sampling (BRS) an opt-in
compile time option.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220322221517.2510440-8-eranian@google.com
---
 arch/x86/events/Kconfig      |  8 ++++++-
 arch/x86/events/amd/Makefile |  3 +-
 arch/x86/events/perf_event.h | 49 +++++++++++++++++++++++++++--------
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index d6cdfe6..09c5696 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -44,4 +44,12 @@ config PERF_EVENTS_AMD_UNCORE
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called 'amd-uncore'.
+
+config PERF_EVENTS_AMD_BRS
+	depends on PERF_EVENTS && CPU_SUP_AMD
+	bool "AMD Zen3 Branch Sampling support"
+	help
+	  Enable AMD Zen3 branch sampling support (BRS) which samples up to
+	  16 consecutive taken branches in registers.
+
 endmenu
diff --git a/arch/x86/events/amd/Makefile b/arch/x86/events/amd/Makefile
index cf323ff..b9f5d46 100644
--- a/arch/x86/events/amd/Makefile
+++ b/arch/x86/events/amd/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CPU_SUP_AMD)		+= core.o brs.o
+obj-$(CONFIG_CPU_SUP_AMD)		+= core.o
+obj-$(CONFIG_PERF_EVENTS_AMD_BRS)	+= brs.o
 obj-$(CONFIG_PERF_EVENTS_AMD_POWER)	+= power.o
 obj-$(CONFIG_X86_LOCAL_APIC)		+= ibs.o
 obj-$(CONFIG_PERF_EVENTS_AMD_UNCORE)	+= amd-uncore.o
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d91ff2c..ef27aee 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1218,6 +1218,8 @@ static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 #ifdef CONFIG_CPU_SUP_AMD
 
 int amd_pmu_init(void);
+
+#ifdef CONFIG_PERF_EVENTS_AMD_BRS
 int amd_brs_init(void);
 void amd_brs_disable(void);
 void amd_brs_enable(void);
@@ -1252,25 +1254,52 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 
 void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool sched_in);
 
-/*
- * check if BRS is activated on the CPU
- * active defined as it has non-zero users and DBG_EXT_CFG.BRSEN=1
- */
-static inline bool amd_brs_active(void)
+static inline s64 amd_brs_adjust_period(s64 period)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	if (period > x86_pmu.lbr_nr)
+		return period - x86_pmu.lbr_nr;
 
-	return cpuc->brs_active;
+	return period;
+}
+#else
+static inline int amd_brs_init(void)
+{
+	return 0;
 }
+static inline void amd_brs_disable(void) {}
+static inline void amd_brs_enable(void) {}
+static inline void amd_brs_drain(void) {}
+static inline void amd_brs_lopwr_init(void) {}
+static inline void amd_brs_disable_all(void) {}
+static inline int amd_brs_setup_filter(struct perf_event *event)
+{
+	return 0;
+}
+static inline void amd_brs_reset(void) {}
 
-static inline s64 amd_brs_adjust_period(s64 period)
+static inline void amd_pmu_brs_add(struct perf_event *event)
 {
-	if (period > x86_pmu.lbr_nr)
-		return period - x86_pmu.lbr_nr;
+}
+
+static inline void amd_pmu_brs_del(struct perf_event *event)
+{
+}
+
+static inline void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool sched_in)
+{
+}
 
+static inline s64 amd_brs_adjust_period(s64 period)
+{
 	return period;
 }
 
+static inline void amd_brs_enable_all(void)
+{
+}
+
+#endif
+
 #else /* CONFIG_CPU_SUP_AMD */
 
 static inline int amd_pmu_init(void)
