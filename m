Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA78D470C30
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344416AbhLJVG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344333AbhLJVGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:06:40 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E9AC0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j204-20020a2523d5000000b005c21574c704so18394437ybj.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aGq1t3UBPNLbGBO0cQEXWQw+b8Nm2AIcbQy9bLaNLuA=;
        b=eSzI/C/Q+bsQEiJYPLfpBtoGQRtVOCTKN8Zi3tbDHFybOIxFQymr7CZKi1tSeY+PW4
         SX7UGQfPq/gdMGKHiLaJY6oxHHG03kSKZQ797ikKi9Cy9Ojo42Wvjpo85GdZhsHOpQ9t
         +FfADPVKYoPU8qSkkyOzcQPFNi5n/0yWJH+6bU8qXckeZKBKYq0/26R5yth+/UXxeMoe
         4Snx8Uyf/tDCc7M+vDg/uBg1e74M3lIhwxaKBPny4LbiUz2isQV57sEowInmIPzyfmy3
         vWjk1rRjGeN6YmeArUn2enc2I0//QnN4/y0LO9HphnOjVx6lB9Zi9YyIXhZNLovC1CoM
         q7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aGq1t3UBPNLbGBO0cQEXWQw+b8Nm2AIcbQy9bLaNLuA=;
        b=vo9zUVoLqJM28zDZiX3yruk0jIfEjJ6GQa4NC8SqNAQNxBq3yzBVJuaHZNjeqhodY4
         cRCCfvCqQLXccqkgWLASA861arAoWBIXRfCxPcoYOC4RcoAc0hWnj3Z0Qxu9Bg3VP3Jp
         kCiUnkESLeJgDHBriGa4f75eadAgzYJOI/AZNBQce7liaLpqXm4kTJqTjmfRdd1yYJik
         JpKMTa73hSqvaKX3dxLsvSroAwnAdw9vObDDFq7iDT1Hn23wf9CZ9dUqspeCCgoMoT9h
         37S+p9xEwXTCFTgUsxiwu7Zm/CBP/ldeCzrzA8NWOAewGoXmuHKXz9K9y5aj+7MgNx18
         s8Og==
X-Gm-Message-State: AOAM533qFCQ8LCgS9ijBOCp2b9nUO5kzkInuvkY4q0Kxsp0tMGC7Gm3K
        0y4hnqjNt8K5iCwNrBbacBtG7Zsb1FxL+96uEcQjHe74hlQeY1hXhykP8BiFXca7oGEbYfm/3sU
        KnMFwYEXkicni7t4ivNi8c+1drZzRp9Xzd+SV7LkB22o69UI1+z1S0clpsURbc02OsId6dGJX
X-Google-Smtp-Source: ABdhPJyBT0rRhAE+uyVPc5xp0vxxIaTxF3utMSIjJ4924PlyU19iKMwRRuHRp99v6NqvqKQ37z2eDVxYDUlW
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7416:17a6:6678:d4d5])
 (user=eranian job=sendgmr) by 2002:a25:aaaf:: with SMTP id
 t44mr17446368ybi.167.1639170183681; Fri, 10 Dec 2021 13:03:03 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:02:22 -0800
In-Reply-To: <20211210210229.2991238-1-eranian@google.com>
Message-Id: <20211210210229.2991238-8-eranian@google.com>
Mime-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 07/14] perf/x86/amd: make Zen3 branch sampling opt-in
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a kernel config option to make support
for AMD Zen3 Branch Sampling (BRS) an opt-in compile
time option.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/Kconfig      |  8 ++++++
 arch/x86/events/amd/Makefile |  3 ++-
 arch/x86/events/perf_event.h | 49 ++++++++++++++++++++++++++++--------
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index d6cdfe631674..1dc002ef66da 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -44,4 +44,12 @@ config PERF_EVENTS_AMD_UNCORE
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called 'amd-uncore'.
+
+config PERF_EVENTS_AMD_BRS
+	depends on PERF_EVENTS && CPU_SUP_AMD
+	tristate "AMD Zen3 Branch Sampling support"
+	help
+	  Enable AMD Zen3 branch sampling support (BRS) which samples up to
+	  16 consecutive taken branches in registers.
+
 endmenu
diff --git a/arch/x86/events/amd/Makefile b/arch/x86/events/amd/Makefile
index cf323ffab5cd..b9f5d4610256 100644
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
index 74552845d942..a4715bfcb801 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1212,6 +1212,8 @@ static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 #ifdef CONFIG_CPU_SUP_AMD
 
 int amd_pmu_init(void);
+
+#ifdef CONFIG_PERF_EVENTS_AMD_BRS
 int amd_brs_init(void);
 void amd_brs_disable(void);
 void amd_brs_enable(void);
@@ -1246,25 +1248,52 @@ static inline void amd_pmu_brs_del(struct perf_event *event)
 
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
-- 
2.34.1.173.g76aa8bc2d0-goog

