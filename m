Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C07A4F386E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376831AbiDELYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbiDEIsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:48:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D462AE09;
        Tue,  5 Apr 2022 01:36:49 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:36:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649147798;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5geXpxjvPe814KNLb/sN9jiLCNyqM2BsadEeVroj2c=;
        b=AQp4XHXLkBNLpKVS2ZkZTHBog9mm3OeJ0AO86QbOyKQNV11W+dRc+g9OYEQ+KcuRfSlXHI
        0jn1nM/WdcC1/N8feEklIvZcgRsNMMSkAGndJXTzHL/3AGXJrT6TVByFGWavXfCF5uiuek
        7RyEjVa+6kZ9/whJANOJnapATRVi4QC7T0Vt2fjKkk7YJWGudqnCKQM113rJ/UZj3DSN/9
        bRpJJMHspABgfWTj7MjPS0tIdfUPc0JuvgUNpVwrJepVsy5koyWWtoD/1TUXGgTSk27CZb
        WOdQ9xfyy98cge2vSigWWof3B32WbGPzQWyVekzIIWiVJdHnFY9v4/r9FdumaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649147798;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5geXpxjvPe814KNLb/sN9jiLCNyqM2BsadEeVroj2c=;
        b=waW1gpvuNo7jZSe8lciWI4fELkaGayOA1mcmRu06XoXFoI1N07xPFGv3P7/wim9I+s5W0D
        OdTxsFmmUWkqdjDw==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Add idle hooks for branch sampling
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220322221517.2510440-10-eranian@google.com>
References: <20220322221517.2510440-10-eranian@google.com>
MIME-Version: 1.0
Message-ID: <164914779753.389.8152356106310343006.tip-bot2@tip-bot2>
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

Commit-ID:     d5616bac7adadbf42a3b63b8717e75eb82a2cc2c
Gitweb:        https://git.kernel.org/tip/d5616bac7adadbf42a3b63b8717e75eb82a2cc2c
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Tue, 22 Mar 2022 15:15:13 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 10:24:38 +02:00

perf/x86/amd: Add idle hooks for branch sampling

On AMD Fam19h Zen3, the branch sampling (BRS) feature must be disabled before
entering low power and re-enabled (if was active) when returning from low
power. Otherwise, the NMI interrupt may be held up for too long and cause
problems. Stopping BRS will cause the NMI to be delivered if it was held up.

Define a perf_amd_brs_lopwr_cb() callback to stop/restart BRS.  The callback
is protected by a jump label which is enabled only when AMD BRS is detected.
In all other cases, the callback is never called.

Signed-off-by: Stephane Eranian <eranian@google.com>
[peterz: static_call() and build fixes]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220322221517.2510440-10-eranian@google.com
---
 arch/x86/events/amd/brs.c         | 33 ++++++++++++++++++++++++++++++-
 arch/x86/events/amd/core.c        |  4 ++++-
 arch/x86/events/perf_event.h      |  1 +-
 arch/x86/include/asm/perf_event.h | 23 +++++++++++++++++++++-
 4 files changed, 61 insertions(+)

diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
index 40461c3..895c821 100644
--- a/arch/x86/events/amd/brs.c
+++ b/arch/x86/events/amd/brs.c
@@ -7,6 +7,7 @@
  * Contributed by Stephane Eranian <eranian@google.com>
  */
 #include <linux/kernel.h>
+#include <linux/jump_label.h>
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
 
@@ -329,3 +330,35 @@ void amd_pmu_brs_sched_task(struct perf_event_context *ctx, bool sched_in)
 	if (sched_in)
 		amd_brs_poison_buffer();
 }
+
+/*
+ * called from ACPI processor_idle.c or acpi_pad.c
+ * with interrupts disabled
+ */
+void perf_amd_brs_lopwr_cb(bool lopwr_in)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	union amd_debug_extn_cfg cfg;
+
+	/*
+	 * on mwait in, we may end up in non C0 state.
+	 * we must disable branch sampling to avoid holding the NMI
+	 * for too long. We disable it in hardware but we
+	 * keep the state in cpuc, so we can re-enable.
+	 *
+	 * The hardware will deliver the NMI if needed when brsmen cleared
+	 */
+	if (cpuc->brs_active) {
+		cfg.val = get_debug_extn_cfg();
+		cfg.brsmen = !lopwr_in;
+		set_debug_extn_cfg(cfg.val);
+	}
+}
+
+DEFINE_STATIC_CALL_NULL(perf_lopwr_cb, perf_amd_brs_lopwr_cb);
+EXPORT_STATIC_CALL_TRAMP_GPL(perf_lopwr_cb);
+
+void __init amd_brs_lopwr_init(void)
+{
+	static_call_update(perf_lopwr_cb, perf_amd_brs_lopwr_cb);
+}
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index f7bce83..8e1e818 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/perf_event.h>
+#include <linux/jump_label.h>
 #include <linux/export.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -1225,6 +1226,9 @@ static int __init amd_core_pmu_init(void)
 		/*
 		 * put_event_constraints callback same as Fam17h, set above
 		 */
+
+		/* branch sampling must be stopped when entering low power */
+		amd_brs_lopwr_init();
 	}
 
 	x86_pmu.attr_update = amd_attr_update;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ef27aee..3b03245 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1226,6 +1226,7 @@ void amd_brs_enable(void);
 void amd_brs_enable_all(void);
 void amd_brs_disable_all(void);
 void amd_brs_drain(void);
+void amd_brs_lopwr_init(void);
 void amd_brs_disable_all(void);
 int amd_brs_setup_filter(struct perf_event *event);
 void amd_brs_reset(void);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 58d9e4b..8199fc5 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PERF_EVENT_H
 #define _ASM_X86_PERF_EVENT_H
 
+#include <linux/static_call.h>
+
 /*
  * Performance event hw details:
  */
@@ -513,6 +515,27 @@ static inline void intel_pt_handle_vmx(int on)
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_AMD)
  extern void amd_pmu_enable_virt(void);
  extern void amd_pmu_disable_virt(void);
+
+#if defined(CONFIG_PERF_EVENTS_AMD_BRS)
+
+#define PERF_NEEDS_LOPWR_CB 1
+
+/*
+ * architectural low power callback impacts
+ * drivers/acpi/processor_idle.c
+ * drivers/acpi/acpi_pad.c
+ */
+extern void perf_amd_brs_lopwr_cb(bool lopwr_in);
+
+DECLARE_STATIC_CALL(perf_lopwr_cb, perf_amd_brs_lopwr_cb);
+
+static inline void perf_lopwr_cb(bool lopwr_in)
+{
+	static_call_mod(perf_lopwr_cb)(lopwr_in);
+}
+
+#endif /* PERF_NEEDS_LOPWR_CB */
+
 #else
  static inline void amd_pmu_enable_virt(void) { }
  static inline void amd_pmu_disable_virt(void) { }
