Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2DE52AF18
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiERARA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiERAQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:16:56 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0C377F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:16:55 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id c4-20020aa79524000000b005180f331899so303028pfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=rR9QT3FVOBG/jORwlMjkzEP1wf5ezoAh1SN5/FtrVoY=;
        b=FATeKh/LCpHK6gOSy0gpmtAfUOdYke2XGc3dJ8Hk3Pl1FyF3nl/egXhanbhZJlGBkI
         vSwXwaPVT0gwXBISR5DobJvih1f5ukLKTgfKZYMqu45YiyIOxI7FqCC17NMfyqzEVW3N
         e6/uqlg5cTi8eFkGt+je5HkOe8dxeIMRlRfBIPxaV3qRSlRjViHiWImOpos0vew0dfuc
         Ss4qVLJewDKxSA+WxJnbl/EOoO6wefHTPl/21drTNgPRAkn42q5XkWmGpPJaqRAA+K1R
         z52SBfDEP950vJw1M46aRekSt0ajx4TBzBTTl+k8nMtUX9MW+e85jwBvcpNuU09stk4v
         vHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=rR9QT3FVOBG/jORwlMjkzEP1wf5ezoAh1SN5/FtrVoY=;
        b=3L+DY7TBo4jVdInZpWaLr+XjJKU7r6X6jk2ej4/5bCrKlRUD0WCk9mkiJi6TJt27Cp
         AOckO9wQkjKtAxMsx1T5EgnlaY4HFSxk/ip+ZbQTE+grH08yTrUydgxKz+0qO3GVSwT1
         FdVdfCM//1AUDCGlUMYLhIw4KqAp8BXSLLg7jHV1kJPitsHAPvDd1e63ILxw/doFGhqm
         UH2gG+XYusLUp1mKvY14SYp25ytidfiwLbcX0yv6PuIhBs68e26rU0dnWwh3BRqxVwfn
         lNkkipVF2q+Wg/sJVPYnHOFcAn8RojRcxoW7ky6V62bG3EtFN8cPWqnzQoeRb/emPSbH
         OPMw==
X-Gm-Message-State: AOAM531DZ/wTrshElZOPgem0oIN+bhQlGHPscukN7Nlfmh+LTOVkrzYu
        34IFN70+4TlBWuU3H4jAKAxFr/Ou2sg=
X-Google-Smtp-Source: ABdhPJwVDC2ZTd4lkiIiSXmzAr/jhuj2aEPPI9OE+watZa8joZlD439lQPClC8VjFT5XfOxWqWYZrj2yaqc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e41:b0:1de:b2dc:b2e with SMTP id
 pi1-20020a17090b1e4100b001deb2dc0b2emr27643168pjb.69.1652833015045; Tue, 17
 May 2022 17:16:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 18 May 2022 00:16:45 +0000
In-Reply-To: <20220518001647.1291448-1-seanjc@google.com>
Message-Id: <20220518001647.1291448-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220518001647.1291448-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 1/3] x86/crash: Disable virt in core NMI crash handler to
 avoid double shootdown
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
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

Disable virtualization in crash_nmi_callback() and rework the
emergency_vmx_disable_all() path to do an NMI shootdown if and only if a
shootdown has not already occurred.   NMI crash shootdown fundamentally
can't support multiple invocations as responding CPUs are deliberately
put into halt state without unblocking NMIs.  But, the emergency reboot
path doesn't have any work of its own, it simply cares about disabling
virtualization, i.e. so long as a shootdown occurred, emergency reboot
doesn't care who initiated the shootdown, or when.

If "crash_kexec_post_notifiers" is specified on the kernel command line,
panic() will invoke crash_smp_send_stop() and result in a second call to
nmi_shootdown_cpus() during native_machine_emergency_restart().

Invoke the callback _before_ disabling virtualization, as the current
VMCS needs to be cleared before doing VMXOFF.  Note, this results in a
subtle change in ordering between disabling virtualization and stopping
Intel PT on the responding CPUs.  While VMX and Intel PT do interact,
VMXOFF and writes to MSR_IA32_RTIT_CTL do not induce faults between one
another, which is all that matters when panicking.

Harden nmi_shootdown_cpus() against multiple invocations to try and
capture any such kernel bugs via a WARN instead of hanging the system
during a crash/dump, e.g. prior to the recent hardening of
register_nmi_handler(), re-registering the NMI handler would trigger a
double list_add() and hang the system if CONFIG_BUG_ON_DATA_CORRUPTION=y.

 list_add double add: new=ffffffff82220800, prev=ffffffff8221cfe8, next=ffffffff82220800.
 WARNING: CPU: 2 PID: 1319 at lib/list_debug.c:29 __list_add_valid+0x67/0x70
 Call Trace:
  __register_nmi_handler+0xcf/0x130
  nmi_shootdown_cpus+0x39/0x90
  native_machine_emergency_restart+0x1c9/0x1d0
  panic+0x237/0x29b

Extract the disabling logic to a common helper to deduplicate code, and
to prepare for doing the shootdown in the emergency reboot path if SVM
is supported.

Note, prior to commit ed72736183c4 ("x86/reboot: Force all cpus to exit
VMX root if VMX is supported"), nmi_shootdown_cpus() was subtly protected
against a second invocation by a cpu_vmx_enabled() check as the kdump
handler would disable VMX if it ran first.

Fixes: ed72736183c4 ("x86/reboot: Force all cpus to exit VMX root if VMX is supported)
Cc: stable@vger.kernel.org
Reported-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/all/20220427224924.592546-2-gpiccoli@igalia.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/reboot.h |  1 +
 arch/x86/kernel/crash.c       | 16 +--------
 arch/x86/kernel/reboot.c      | 66 ++++++++++++++++++++++++++++-------
 3 files changed, 56 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/reboot.h b/arch/x86/include/asm/reboot.h
index 04c17be9b5fd..8f2da36435a6 100644
--- a/arch/x86/include/asm/reboot.h
+++ b/arch/x86/include/asm/reboot.h
@@ -25,6 +25,7 @@ void __noreturn machine_real_restart(unsigned int type);
 #define MRR_BIOS	0
 #define MRR_APM		1
 
+void cpu_crash_disable_virtualization(void);
 typedef void (*nmi_shootdown_cb)(int, struct pt_regs*);
 void nmi_panic_self_stop(struct pt_regs *regs);
 void nmi_shootdown_cpus(nmi_shootdown_cb callback);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e8326a8d1c5d..fe0cf83843ba 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -81,15 +81,6 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
 	 */
 	cpu_crash_vmclear_loaded_vmcss();
 
-	/* Disable VMX or SVM if needed.
-	 *
-	 * We need to disable virtualization on all CPUs.
-	 * Having VMX or SVM enabled on any CPU may break rebooting
-	 * after the kdump kernel has finished its task.
-	 */
-	cpu_emergency_vmxoff();
-	cpu_emergency_svm_disable();
-
 	/*
 	 * Disable Intel PT to stop its logging
 	 */
@@ -148,12 +139,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	 */
 	cpu_crash_vmclear_loaded_vmcss();
 
-	/* Booting kdump kernel with VMX or SVM enabled won't work,
-	 * because (among other limitations) we can't disable paging
-	 * with the virt flags.
-	 */
-	cpu_emergency_vmxoff();
-	cpu_emergency_svm_disable();
+	cpu_crash_disable_virtualization();
 
 	/*
 	 * Disable Intel PT to stop its logging
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index fa700b46588e..e67737418f7d 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -528,10 +528,7 @@ static inline void kb_wait(void)
 	}
 }
 
-static void vmxoff_nmi(int cpu, struct pt_regs *regs)
-{
-	cpu_emergency_vmxoff();
-}
+static inline void nmi_shootdown_cpus_on_restart(void);
 
 /* Use NMIs as IPIs to tell all CPUs to disable virtualization */
 static void emergency_vmx_disable_all(void)
@@ -554,7 +551,7 @@ static void emergency_vmx_disable_all(void)
 		__cpu_emergency_vmxoff();
 
 		/* Halt and exit VMX root operation on the other CPUs. */
-		nmi_shootdown_cpus(vmxoff_nmi);
+		nmi_shootdown_cpus_on_restart();
 	}
 }
 
@@ -802,6 +799,18 @@ static nmi_shootdown_cb shootdown_callback;
 static atomic_t waiting_for_crash_ipi;
 static int crash_ipi_issued;
 
+void cpu_crash_disable_virtualization(void)
+{
+	/*
+	 * Disable virtualization, i.e. VMX or SVM, so that INIT is recognized
+	 * during reboot.  VMX blocks INIT if the CPU is post-VMXON, and SVM
+	 * blocks INIT if GIF=0.  Note, CLGI #UDs if SVM isn't enabled, so it's
+	 * easier to just disable SVM unconditionally.
+	 */
+	cpu_emergency_vmxoff();
+	cpu_emergency_svm_disable();
+}
+
 static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 {
 	int cpu;
@@ -817,7 +826,14 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 		return NMI_HANDLED;
 	local_irq_disable();
 
-	shootdown_callback(cpu, regs);
+	if (shootdown_callback)
+		shootdown_callback(cpu, regs);
+
+	/*
+	 * Prepare the CPU for reboot _after_ invoking the callback so that the
+	 * callback can safely use virtualization instructions, e.g. VMCLEAR.
+	 */
+	cpu_crash_disable_virtualization();
 
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
@@ -828,18 +844,32 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 	return NMI_HANDLED;
 }
 
-/*
- * Halt all other CPUs, calling the specified function on each of them
+/**
+ * nmi_shootdown_cpus - Stop other CPUs via NMI
+ * @callback:	Optional callback to be invoked from the NMI handler
  *
- * This function can be used to halt all other CPUs on crash
- * or emergency reboot time. The function passed as parameter
- * will be called inside a NMI handler on all CPUs.
+ * The NMI handler on the remote CPUs invokes @callback, if not
+ * NULL, first and then disables virtualization to ensure that
+ * INIT is recognized during reboot.
+ *
+ * nmi_shootdown_cpus() can only be invoked once. After the first
+ * invocation all other CPUs are stuck in crash_nmi_callback() and
+ * cannot respond to a second NMI.
  */
 void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 {
 	unsigned long msecs;
+
 	local_irq_disable();
 
+	/*
+	 * Avoid certain doom if a shootdown already occurred; re-registering
+	 * the NMI handler will cause list corruption, modifying the callback
+	 * will do who knows what, etc...
+	 */
+	if (WARN_ON_ONCE(crash_ipi_issued))
+		return;
+
 	/* Make a note of crashing cpu. Will be used in NMI callback. */
 	crashing_cpu = safe_smp_processor_id();
 
@@ -867,7 +897,17 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 		msecs--;
 	}
 
-	/* Leave the nmi callback set */
+	/*
+	 * Leave the nmi callback set, shootdown is a one-time thing.  Clearing
+	 * the callback could result in a NULL pointer dereference if a CPU
+	 * (finally) responds after the timeout expires.
+	 */
+}
+
+static inline void nmi_shootdown_cpus_on_restart(void)
+{
+	if (!crash_ipi_issued)
+		nmi_shootdown_cpus(NULL);
 }
 
 /*
@@ -897,6 +937,8 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	/* No other CPUs to shoot down */
 }
 
+static inline void nmi_shootdown_cpus_on_restart(void) { }
+
 void run_crash_ipi_callback(struct pt_regs *regs)
 {
 }
-- 
2.36.0.550.gb090851708-goog

