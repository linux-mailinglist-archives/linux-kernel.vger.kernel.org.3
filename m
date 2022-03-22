Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539154E4903
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiCVWRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiCVWRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:17:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880BC53706
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h8-20020a25e208000000b00628c0565607so15577721ybe.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7qNmmGdeOZfhSMOT7dCrcgJQwc8RsaRFAUQUg+lLang=;
        b=GE1fkQSG5UPK9yaBOk8BPYrtG1GL8BXl7+NGttFKQ+cJthceRepKDcVxfFWEaRfBE1
         ckAsenBftKkABGhW8mB/aFrSW5uuFKtXbpWgc+lkS/U6/63xgfI647u25IUL4QyWtp0w
         u4Wqdi2ME2dL+fcdFhqZbbrYfyOl9U8sXqjBjnfdY/3LPgOPlBttyh60cnhBDqzPiy4V
         VTqrMTzlL9mbzIW7zp6/ZYLqg6DW69rmremv8XduyMKHRoey18L8TU2uf03n/nFVOEFy
         WR0vuADpZInZrg3IN8ZjrT/e8TcWEHNFUjZ7lmHDEo553wPhnhetbOn8WiR+DlJ71ZK0
         u6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7qNmmGdeOZfhSMOT7dCrcgJQwc8RsaRFAUQUg+lLang=;
        b=LWGrFTO/rudNfNop5jaEKhIt56zFd8qUfqBkebF58J+i78hkwoevZSpgza+zU1LPFG
         f+rGZq8ri0F46CDnksv6OoUwnziWsmAPWHX4LZxMdxZ8b7Num6dudwL4XRCuPv2hlVIB
         BWY+AHfUTw4mCcljOc+XvhzNp8+HUUEwzoWZReq4OmQtkhYPqy+fZt5VtiO0pw/xlDIi
         gDVCyoLlMbLhTjtdD8JRUKTQFE5bMfFgzkabXCj2IXcJzCaVwzoj/k4yn7yh+ByZ1eR3
         LhVdFwzLbFNPeGrKLRW8cjTxR45VgpIQKZOX5RxcRfWkiJDMaDDis0HwP+3AhW/7/8eM
         e+UQ==
X-Gm-Message-State: AOAM531IV+RI6Q7+LSwJ5p3Z0nyYgLhoFI6Hg9HmejnC6F4quR/buTI3
        6Nv+sOuwDVb8VB7N87blWfPssPpWJtXXfMpOLDOKU658cJKFl2zNrW+wZJCwIjwJ9aapf/L6xNW
        LzwMZfBjm4gbf4RICs8epHxWE6DY9Ps8I6eQUWYnVxxVSsHqo/bhOeVfAEwydxNq0XBHkRYMz
X-Google-Smtp-Source: ABdhPJwhoiDQ88LuSGeOkBVk+NzZlC9VxWnNNrRnEvUWD7IUchPhBkAD0OGNSHEQzq1JWSkKFrnM91nBN9FZ
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:1817:acc9:c45f:d133])
 (user=eranian job=sendgmr) by 2002:a25:c58b:0:b0:629:5064:894c with SMTP id
 v133-20020a25c58b000000b006295064894cmr29761335ybe.590.1647987342642; Tue, 22
 Mar 2022 15:15:42 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:15:11 -0700
In-Reply-To: <20220322221517.2510440-1-eranian@google.com>
Message-Id: <20220322221517.2510440-8-eranian@google.com>
Mime-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v7 07/13] perf/x86/amd: make Zen3 branch sampling opt-in
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, rafael@kernel.org,
        ravi.bangoria@amd.com, sandipan.das@amd.com
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
2.35.1.894.gb6a874cedc-goog

