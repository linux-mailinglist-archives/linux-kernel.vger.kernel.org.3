Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C852412B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349434AbiEKXnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349432AbiEKXnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:43:41 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD0D60DBC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:43:40 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id e185-20020a6369c2000000b003d822d1900eso1698894pgc.19
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=TAxiS/Ab5c7/hNi33nkS+3tREbvoK0JgsSTtBLjXVkU=;
        b=h89nNOgesg/Zplpl0ZYbjqjWzs5L+D0otRohm8XU+6Hv6kzBUyXDVofmGhGX1Bh+ex
         gVQRpNKzTjeMu7tX07SCLPcafM1dM1Bg0CwodQ7CKyDUZ9a48n5EXexk0vr9F+EHv6kE
         a9FuMi472lHKFi0mLSZrFF3RvMwe8VyBaIHtpjMFMjAdYjLleF3F8bbqLoVQmShpXux1
         DcLepZ6yhB1NSFvRrWy28V97zD0BsEnJbcqWYCXeHk8n26PMKvp2k6xd33to1nSAAKEv
         yJtZMQBMEK1xtHT02KDKbSg2Y8AfQbbYcRbVh5+0wyZHhXHXtsaGED2lDteu4vA9uOJ1
         TRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=TAxiS/Ab5c7/hNi33nkS+3tREbvoK0JgsSTtBLjXVkU=;
        b=Huw7UVh5mHnMTjGAz3JGchI0vkC0gi/cMwNIgpkN7rlP3Ma3AM9frzpTh+CdNtjWj3
         aR27q7aPtQz2LgFAVgqaFoVqEtQL+TEVysmn3cDV6kDsGK7e5fZ9zkmuYiRVEEKwqNMI
         uPZl4EvVJkdo6YLxsbBBqz0NtgCjrRiD5pMz0fdw2PjdBm1y/OJMa4/NdInzw9U6yJOJ
         rvnigHnP4hnZcgMa8Qo5tMYpBWfRaTU1p7SCzU0C+M4KydA3k6igL3wDCqlEUPlMr9MB
         2yQ2aK5XVRfr/TP+sujtTIOmd3Xk7I7yYoViE81FXavuuCORLzqyWj+plFPmrV7Dkldz
         kf2Q==
X-Gm-Message-State: AOAM531lhxlQoyOz1kjIsvyRWvWtMixzP25Bm2HN5BwdKSl2wgv+1qjl
        fcILSQ6C3bHuDGfuMNHCkuGXs9VfgRU=
X-Google-Smtp-Source: ABdhPJzSb+Lwdgqy/6LSwc2c3Q6c+j5VBj5Kf+iEbER8+WRuCWXi7dyura/z7bCijxTQFdxL07NwUPaTf8A=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:15d1:0:b0:50d:3db1:babd with SMTP id
 200-20020a6215d1000000b0050d3db1babdmr27415479pfv.19.1652312620124; Wed, 11
 May 2022 16:43:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 11 May 2022 23:43:31 +0000
In-Reply-To: <20220511234332.3654455-1-seanjc@google.com>
Message-Id: <20220511234332.3654455-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220511234332.3654455-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 1/2] x86/crash: Disable virt in core NMI crash handler to
 avoid double list_add
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

Disable virtualization in crash_nmi_callback() and skip the requested NMI
shootdown if a shootdown has already occurred, i.e. a callback has been
registered.  The NMI crash shootdown path doesn't play nice with multiple
invocations, e.g. attempting to register the NMI handler multiple times
will trigger a double list_add() and hang the system (in addition to
multiple other issues).  If "crash_kexec_post_notifiers" is specified on
the kernel command line, panic() will invoke crash_smp_send_stop() and
result in a second call to nmi_shootdown_cpus() during
native_machine_emergency_restart().

Invoke the callback _before_ disabling virtualization, as the current
VMCS needs to be cleared before doing VMXOFF.  Note, this results in a
subtle change in ordering between disabling virtualization and stopping
Intel PT on the responding CPUs.  While VMX and Intel PT do interact,
VMXOFF and writes to MSR_IA32_RTIT_CTL do not induce faults between one
another, which is all that matters when panicking.

WARN if nmi_shootdown_cpus() is called a second time with anything other
than the reboot path's "nop" handler, as bailing means the requested
isn't being invoked.  Punt true handling of multiple shootdown callbacks
until there's an actual use case for doing so (beyond disabling
virtualization).

Extract the disabling logic to a common helper to deduplicate code, and
to prepare for doing the shootdown in the emergency reboot path if SVM
is supported.

Note, prior to commit ed72736183c4 ("x86/reboot: Force all cpus to exit
VMX root if VMX is supported"), nmi_shootdown_cpus() was subtly protected
against a second invocation by a cpu_vmx_enabled() check as the kdump
handler would disable VMX if it ran first.

Fixes: ed72736183c4 ("x86/reboot: Force all cpus to exit VMX root if VMX is supported)
Cc: stable@vger.kernel.org
Reported-and-tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/all/20220427224924.592546-2-gpiccoli@igalia.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/reboot.h |  1 +
 arch/x86/kernel/crash.c       | 16 +--------------
 arch/x86/kernel/reboot.c      | 38 ++++++++++++++++++++++++++++++++---
 3 files changed, 37 insertions(+), 18 deletions(-)

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
index fa700b46588e..f9543a4e9b09 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -528,9 +528,9 @@ static inline void kb_wait(void)
 	}
 }
 
-static void vmxoff_nmi(int cpu, struct pt_regs *regs)
+static void nmi_shootdown_nop(int cpu, struct pt_regs *regs)
 {
-	cpu_emergency_vmxoff();
+	/* Nothing to do, the NMI shootdown handler disables virtualization. */
 }
 
 /* Use NMIs as IPIs to tell all CPUs to disable virtualization */
@@ -554,7 +554,7 @@ static void emergency_vmx_disable_all(void)
 		__cpu_emergency_vmxoff();
 
 		/* Halt and exit VMX root operation on the other CPUs. */
-		nmi_shootdown_cpus(vmxoff_nmi);
+		nmi_shootdown_cpus(nmi_shootdown_nop);
 	}
 }
 
@@ -802,6 +802,18 @@ static nmi_shootdown_cb shootdown_callback;
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
@@ -819,6 +831,12 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 
 	shootdown_callback(cpu, regs);
 
+	/*
+	 * Prepare the CPU for reboot _after_ invoking the callback so that the
+	 * callback can safely use virtualization instructions, e.g. VMCLEAR.
+	 */
+	cpu_crash_disable_virtualization();
+
 	atomic_dec(&waiting_for_crash_ipi);
 	/* Assume hlt works */
 	halt();
@@ -840,6 +858,20 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	unsigned long msecs;
 	local_irq_disable();
 
+	/*
+	 * Invoking multiple callbacks is not currently supported, registering
+	 * the NMI handler twice will cause a list_add() double add BUG().
+	 * The exception is the "nop" handler in the emergency reboot path,
+	 * which can run after e.g. kdump's shootdown.  Do nothing if the crash
+	 * handler has already run, i.e. has already prepared other CPUs, the
+	 * reboot path doesn't have any work of its to do, it just needs to
+	 * ensure all CPUs have prepared for reboot.
+	 */
+	if (shootdown_callback) {
+		WARN_ON_ONCE(callback != nmi_shootdown_nop);
+		return;
+	}
+
 	/* Make a note of crashing cpu. Will be used in NMI callback. */
 	crashing_cpu = safe_smp_processor_id();
 
-- 
2.36.0.512.ge40c2bad7a-goog

