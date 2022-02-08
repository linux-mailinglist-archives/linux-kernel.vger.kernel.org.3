Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369234AE491
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388255AbiBHWcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386854AbiBHVRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:17:13 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A8BC0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:17:10 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id 4-20020a170902c20400b0014d61c5a5b1so302826pll.14
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dEWqa6ll67+XS8zqG5upDAQcRA944Vkil3rbd3Ql4r0=;
        b=sVdAXqy5YQYAyluM+87YKfNCyBV41r86ejBj1FZy0iA4BBvN7GyaIF7fUMqCc+x/pR
         8VaW5oS5h4lk16chyDzoA1ASUeb97LlgAQ009oc06roZ37sE3wf8pUuVgPP4ZcaAR4hZ
         vJ6X9lVX6jY7pSAHG4tInnGftXISZvlNNqCYV2cYohESxGprVC4FN/GYHZ9RfRjg7zR4
         n0wwD1Gj8Q0EQzGErPr+CURkEsZcDXmOjfcJuz4KVCfLdbWVJFyMoFfLaUyeXRekAzm1
         1H6Ebs+yaye61ncsW9WC5qeOfNfFO9mVZ5IaiW6YkiAT3ecuOrNST+6t8Mp7gk9Wyo2R
         fO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dEWqa6ll67+XS8zqG5upDAQcRA944Vkil3rbd3Ql4r0=;
        b=JcE94RaSMDa+3ldSc1bFKrbUPpP81irz3UjZ1SpGXn8S1sXByQstvRAHjailH86lmH
         W8K4m3I3MCaxBBYfDnCWBMrztvAapUzC2VP+zNuR67j2zwHu32Fpg1WQWLUDN0DoLvUv
         7i+BGQF6q4ZkWoVr/OrSDrj1gNdWfCTKrkutvga527MSJjmaCvE/tnXYwPdP4TYLgu0U
         cAy33MP6raefnhg4fl4eKCSTXWh/8Fxlmv6X15hz3pdushWPucwxpj72OBx3/GlAVnUJ
         LEVV9R5sd+J5fBHnX8zPcdyPaB30kj6V30aU/ftutRiZah0FtM7pMRmYNaC9OwPFU6wI
         8HRQ==
X-Gm-Message-State: AOAM530p0Ck6NpBT/qeAeOAo6jKBxs7/YYTmCq9a5WP9Adm//uTVT0SW
        KMp9JPVdtgH/JeQARkScfLZjoif7lMIt26nrDMaNVSO8HDUbFJBobf4EpjTVHN1C6j+bf8HSh5b
        J/voAvP9V//4xvzVeTZ516sERKC3jZjYdrcIOvHAzd++xtsq2qiMHKqIoQU8RjgbMEpmdjSBC
X-Google-Smtp-Source: ABdhPJwHX2WZBSwLZnHLKP/cSYAhGuwYChAF9oD04o7EmDNAEjoAD27twBuQi5uJjrewhDa+XJlVUiGvJuSJ
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:6875:3c51:69be:6e2c])
 (user=eranian job=sendgmr) by 2002:a17:902:6a83:: with SMTP id
 n3mr6441644plk.139.1644355030018; Tue, 08 Feb 2022 13:17:10 -0800 (PST)
Date:   Tue,  8 Feb 2022 13:16:32 -0800
In-Reply-To: <20220208211637.2221872-1-eranian@google.com>
Message-Id: <20220208211637.2221872-8-eranian@google.com>
Mime-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 07/12] perf/x86/amd: make Zen3 branch sampling opt-in
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kernel config option CONFIG_PERF_EVENTS_AMD_BRS
to make the support for AMD Zen3 Branch Sampling (BRS) an opt-in
compile time option.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/Kconfig      |  8 ++++++
 arch/x86/events/amd/Makefile |  3 ++-
 arch/x86/events/perf_event.h | 49 ++++++++++++++++++++++++++++--------
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index d6cdfe631674..09c56965750a 100644
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
2.35.0.263.gb82422642f-goog

