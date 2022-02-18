Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7674BC2DC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 00:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbiBRXZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 18:25:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237091AbiBRXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 18:25:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4236327AA32
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:25:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u67-20020a25ab49000000b006245b3bce67so1046300ybi.16
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eCaYVVXfa2SwGUCmQsm0SaCHrhyXcm35MmZLyku8l3o=;
        b=mCpu+kZWGLMO6jAi0wStGMczKuOVP6KMgJ/FHjn0Y3efeqUsIT3XruVsh7sMLytrX9
         0gWMSeYqWdzPE6qlfm1ArKGc7DUvrKnF4AtcivERnWDmEbBUr8XHRfA9j/Mj81MVTZd0
         5OehfPNzP4+aIT7up2Be4K2kSWl+rXnPOzLLv6UEovwlcTZQbatWHqSlybLK5g0oT/FA
         UnC+Yol50L4of7s8a6C1SISsra0m+kTxonqv0xNlMrQ/tTHvgvy86k2cTBX6cBNOYNH1
         9YYPVRAeMG1+ouGFgNmu/px+z67C4D/FEsKkBGq/aq3lV2HooJXlaXIahMg6quwewV7z
         2fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eCaYVVXfa2SwGUCmQsm0SaCHrhyXcm35MmZLyku8l3o=;
        b=tR3/aQnf4waOB/v6gDqU2oJwPh3U/Pgk/EeSr5get4QIgUfOKyP+PGoG7FmcuKTd2Z
         0kEfFGfjH9wN0u35EV1r6fjIRJZVjx4HD62w4V3UX1ELKsXq6upJpnUQOWsVxANd8gs7
         sAuwQ/tL4dHJv2kyYVovJljc2DBrY/viFVIjVTjcq7SaUisZ9itROYct4Rsn15BpoDfd
         PW69RpozW7zdXSid86Fm4cC9tduXlPijfpH/Zr90tjzqunoSNa98VUdx1lBcOIMnyoiF
         xOKPX8qXtCITpwRYYnE4gTL4wo5gWEgpHjbRbHngU0i3tweFNJ51ceFREEgt/HIZKqtw
         hkdw==
X-Gm-Message-State: AOAM531n+FPeGaDteouGgxqvcmYaRCkPbPEYkLSc82M2Juz5BBrUHGOJ
        wmkAm+RIZ83qp97nr1F0xCtZQL/yHg==
X-Google-Smtp-Source: ABdhPJwxhhcbTCt0y2zPly+KVOlFDMPfcz/lWMpFh38T3yeFtNM2l4YsyGo50MKoTLaVBRacvZPrm9ZaXg==
X-Received: from swine1.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:42e])
 (user=swine job=sendgmr) by 2002:a25:58f:0:b0:624:d68:8f21 with SMTP id
 137-20020a25058f000000b006240d688f21mr9498552ybf.237.1645226732486; Fri, 18
 Feb 2022 15:25:32 -0800 (PST)
Date:   Fri, 18 Feb 2022 15:25:21 -0800
Message-Id: <20220218232521.961040-1-swine@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH] x86/apic: retpoline mitigation for send_IPI
From:   Pete Swain <swine@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, Pete Swain <swine@google.com>
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

adds INDIRECT_CALL wrappers to hot paths

Signed-off-by: Pete Swain <swine@google.com>
---
 arch/x86/include/asm/smp.h            | 8 ++++++--
 arch/x86/kernel/apic/ipi.c            | 5 ++++-
 arch/x86/kernel/apic/x2apic_cluster.c | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 81a0211a372d..1e239583b5a8 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_SMP_H
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
+#include <linux/indirect_call_wrapper.h>
 #include <asm/percpu.h>
 
 #include <asm/thread_info.h>
@@ -114,9 +115,13 @@ static inline void smp_send_reschedule(int cpu)
 	smp_ops.smp_send_reschedule(cpu);
 }
 
+void native_send_call_func_single_ipi(int cpu);
+
 static inline void arch_send_call_function_single_ipi(int cpu)
 {
-	smp_ops.send_call_func_single_ipi(cpu);
+
+	INDIRECT_CALL_1(smp_ops.send_call_func_single_ipi,
+			native_send_call_func_single_ipi, cpu);
 }
 
 static inline void arch_send_call_function_ipi_mask(const struct cpumask *mask)
@@ -144,7 +149,6 @@ void cond_wakeup_cpu0(void);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
-void native_send_call_func_single_ipi(int cpu);
 void x86_idle_thread_init(unsigned int cpu, struct task_struct *idle);
 
 void smp_store_boot_cpu_info(void);
diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index d1fb874fbe64..e376c6e433a6 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -71,9 +71,12 @@ void native_smp_send_reschedule(int cpu)
 	apic->send_IPI(cpu, RESCHEDULE_VECTOR);
 }
 
+INDIRECT_CALLABLE_DECLARE(void __weak x2apic_send_IPI(int cpu, int vector));
+
 void native_send_call_func_single_ipi(int cpu)
 {
-	apic->send_IPI(cpu, CALL_FUNCTION_SINGLE_VECTOR);
+	INDIRECT_CALL_1(apic->send_IPI, x2apic_send_IPI,
+			cpu, CALL_FUNCTION_SINGLE_VECTOR);
 }
 
 void native_send_call_func_ipi(const struct cpumask *mask)
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index e696e22d0531..53ea00793ee0 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -31,7 +31,7 @@ static int x2apic_acpi_madt_oem_check(char *oem_id, char *oem_table_id)
 	return x2apic_enabled();
 }
 
-static void x2apic_send_IPI(int cpu, int vector)
+INDIRECT_CALLABLE_SCOPE void x2apic_send_IPI(int cpu, int vector)
 {
 	u32 dest = x86_cpu_to_logical_apicid[cpu];
 
-- 
2.35.1.473.g83b2b277ed-goog

