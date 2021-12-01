Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3E4464461
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbhLABGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345983AbhLABF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:05:57 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A5C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:37 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s2-20020a632142000000b0032173c0daf1so11170205pgm.16
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dMHfAPgwJ610W2xv5L0YPUnwpik14sAebjjlMd/TP68=;
        b=BMq7fnlDwLtKYiPRQGpFISnmspqhwfZXfSaLdGu524Xtx+6CBwOSWp8kVF16qFi1iY
         HvGmhz7BFiNZU6weObKDxpkeWRWOpVtRa04ZW2ltkt2B/NTpyNp3lAgyVk3GisgVH2Lq
         XpdzQw+JXy1MMgHOMCRQQ1mXtqIOtr3Zt6egeavXmsy6JKXX+3+OgagtUc3BnxH0sat+
         3ZQ869viCRaJplkdab0+lBO6EF5hzP5sILpeiCgfpmm4CdzxYForqP0sgF66++SdTh1V
         PI04x3usXcX9WdW5pgUFzn4tGh48UpOKgFcFsHZJUkockxF9x4dV3jPMyxUyw6pDiP+I
         LJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dMHfAPgwJ610W2xv5L0YPUnwpik14sAebjjlMd/TP68=;
        b=lsl7dfFPeqhqnjnAca6KOtf5IFtEacFLZ4rA8fsaJLPpQVfQoxnbfE7+f97104+xxg
         yLsm8fK1/6hzGxp0QCXF+DJ4yYOLLxcaWc/HBkGGnTjgfNkfV7P64nGxmUlCtsN9v92I
         5yrPt9itAI2u6ouNcXLjHYxGfzgLIPN+i04ibIZqcR3z98+6jyXKyd6nQzL92R1WQCe+
         mC2SrF06LmTdgDO+UjUJqhKvHSEuF/VAmftsWraY5zLwrd2R3Hlhxe1VeLRDoKTSgKa4
         9WqktUeL6r53grtyz38Q2lMGondZW4Hyj0N2dQSiKN/f8fB9X3syXt773VaO7XdvZ5x3
         zM+w==
X-Gm-Message-State: AOAM532ldmSetCKEWSemIrMIyd17GOg62nshc4nTrAvbvfGRp/3sqJky
        1dOp0YavZOqfR05cxg6O5a31DMWkKmeyAkfzemTRjN6ifq0+odpLBWS2FUZxrczPX4Zsja5A+J8
        sGqr0ir1IDdZqf9Slui8zqFEZuprihDlnOwaUmR6VGag/G4IguNyw5j8/aHHuUBRnETaotR5W
X-Google-Smtp-Source: ABdhPJwzr8aF3/7RnK57vXMp7WOZ0cjYg2pXCo93TjVuaPpjXNwl2BUPWXSLnfbHOukAcmXGkbwn28q0rc0y
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:8776:d8e0:bb50:a95a])
 (user=eranian job=sendgmr) by 2002:a17:90a:8043:: with SMTP id
 e3mr3289997pjw.130.1638320556840; Tue, 30 Nov 2021 17:02:36 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:02:11 -0800
In-Reply-To: <20211201010217.886919-1-eranian@google.com>
Message-Id: <20211201010217.886919-8-eranian@google.com>
Mime-Version: 1.0
References: <20211201010217.886919-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 07/13] perf/x86/amd: make Zen3 branch sampling opt-in
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
2.34.0.rc2.393.gf8c9666880-goog

