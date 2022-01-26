Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EED49D636
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiAZXfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbiAZXfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:35:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523BDC06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b61-20020a25a243000000b006126ea65191so2368971ybi.19
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=krIXxvC+be6RpLbuXXi+utIDD3YUAtbOGqDgMPL0DEs=;
        b=Hhax+8QZ5G/HCsum9KF837edB16MSoRYszJlVboUSsOeFs2TWu4Ejy66qPAa/jNiYN
         2qVACYjnGLOdNI8J9kjUz1yFCxNSPkfEP2A1GVvPSgX2twQsya3FzFgkHFTJ8gt1Ogl7
         YpQzcyba0h1pICKXpuHlLrVVECli42Jyr1iVIvhE3/s66808IcHo/Zs0C0/K6wbT7nnI
         OnSizWjMMkHPXPY5WMq5BWVEL8d/sKDiI98ZGKg8E3EW0guC4KfRDHOTiV9Xuy84JQa0
         s4EXr1IbWHBwmwR45j6YE7s+1IpKEdH5Q2QtvZR+MSEXIhQfVqtGm1EU/0wMtPkgqscS
         EVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=krIXxvC+be6RpLbuXXi+utIDD3YUAtbOGqDgMPL0DEs=;
        b=HyX1so0Ws7kXZadrhnJT/wjo0S5zmhZ1KSePnt979lMHD1JF/aU4M1ycXvSRsyH/TP
         mikXtEXgvmCrPL4QGex+olvlKAgVqtrCbDwAanZA/sPcoBGC/LMUCedPyt5tvrHFtnWa
         8KZBwaSXQR8IiRuFWvQWVO5iHy11crI6KLlCkLGCzUuYrWaN34K9Y2exLBAUwsBC7MT/
         AUMNF3Mekj4yy0pZ8m7oCrhkxRLJjwC2Y5NsVMsUpn48I0Y9gi5CZA6GPUu2m2j3UlTz
         Sr59TvRe7F9dcj8r6yOBh77zOkTpDd6q2q2nPbOvSqQoQ4Z2s1ud9lEqzMbMz//2Vksf
         ZaUQ==
X-Gm-Message-State: AOAM533LBRkQiH3S7fQioI59l0+/CvpA8KKbbAU8dynAcJtIh2luR7F0
        I2H+7XuVjTJR0OJIJwPPm2ZuNwkSe1LTiduGFVehjE25srzM8JuIwUPfGAZRM124nmnnyv0fAaw
        wWK3zQzdZRWAdRDW9xGfWdam3N+X3H5a4+bMyx9SzcWqa4sewmT8mxjbsSYyDu+up9XL6unri
X-Google-Smtp-Source: ABdhPJxXMhl/Jlo1Jnr1iVoExf3l+kpSJmjflXjpBgsIzrQJGSiHfC6ZprpgndKYVkArnQAN+KiT7PUhDNtc
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:9ce0:6f20:c145:eac])
 (user=eranian job=sendgmr) by 2002:a81:5594:: with SMTP id
 j142mr1ywb.36.1643240130852; Wed, 26 Jan 2022 15:35:30 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:34:48 -0800
In-Reply-To: <20220126233454.3362047-1-eranian@google.com>
Message-Id: <20220126233454.3362047-8-eranian@google.com>
Mime-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v5 07/13] perf/x86/amd: make Zen3 branch sampling opt-in
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
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
index 25b037b571e4..4d050579dcbd 100644
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
-- 
2.35.0.rc0.227.g00780c9af4-goog

