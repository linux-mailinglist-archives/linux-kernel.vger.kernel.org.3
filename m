Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCA524ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352845AbiELKvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352854AbiELKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:51:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1134133A12
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:51:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652352669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cDYZEyIkJfwRob8+m2Pey7phccZ669QNOKgx9WIn6UI=;
        b=wjWgwfnmQTffysLghK9JmB2do5nJeqbxvWoR+j5Oh0kjOR9gQCMhtB7JL34jBHByqRynzk
        4bIqvI3OKjKC602aXX+sssyKTZnWUPy11HR6cq/9ZflNFG2jFpi16HGsXexSferZOIvNLI
        WZPBbC7LaWelwcxIye9+hFExjlVRICS3F0VR4ZpKKbNprio2Z7skIdXV5OiJZt/rU2ejjO
        P3yOWVakiLGBnyT5TMHXR1f09z+fCUeiBH2bExfTjm7TVYA5byVezwgHv7+YV1pCINiVZE
        yfc7m36vAlq2/ZrmbukElCrwrUCnF8Ca7k6gMlKMF8qcxVw5MAClNcm1Pl68iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652352669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cDYZEyIkJfwRob8+m2Pey7phccZ669QNOKgx9WIn6UI=;
        b=WghJTq4F1yKMoQGGpE03O/74rWWGJ5UdV3CtkTUThzuBdA59/UgCVPyHWdbuspfdcFbk4m
        ixsZwfvCJjA5FDDw==
To:     Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 1/2] x86/crash: Disable virt in core NMI crash handler
 to avoid double list_add
In-Reply-To: <20220511234332.3654455-2-seanjc@google.com>
References: <20220511234332.3654455-1-seanjc@google.com>
 <20220511234332.3654455-2-seanjc@google.com>
Date:   Thu, 12 May 2022 12:51:08 +0200
Message-ID: <87wnervxb7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean,

On Wed, May 11 2022 at 23:43, Sean Christopherson wrote:
> @@ -840,6 +858,20 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
>  	unsigned long msecs;
>  	local_irq_disable();
>  
> +	/*
> +	 * Invoking multiple callbacks is not currently supported, registering
> +	 * the NMI handler twice will cause a list_add() double add BUG().
> +	 * The exception is the "nop" handler in the emergency reboot path,
> +	 * which can run after e.g. kdump's shootdown.  Do nothing if the crash
> +	 * handler has already run, i.e. has already prepared other CPUs, the
> +	 * reboot path doesn't have any work of its to do, it just needs to
> +	 * ensure all CPUs have prepared for reboot.

This is confusing at best. The double list add is just one part of the
problem, which would be trivial enough to fix.

The real point is that after the first shoot down all other CPUs are
stuck in crash_nmi_callback() and won't respond to the second NMI.

So trying to run this twice is completely pointless and guaranteed to
run into the timeout.

> +	 */
> +	if (shootdown_callback) {
> +		WARN_ON_ONCE(callback != nmi_shootdown_nop);
> +		return;

Instead of playing games with the callback pointer, I prefer to make
this all explicit. Delta patch below.

Thanks,

        tglx
---
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -528,10 +528,7 @@ static inline void kb_wait(void)
 	}
 }
 
-static void nmi_shootdown_nop(int cpu, struct pt_regs *regs)
-{
-	/* Nothing to do, the NMI shootdown handler disables virtualization. */
-}
+static inline void nmi_shootdown_cpus_on_restart(void);
 
 /* Use NMIs as IPIs to tell all CPUs to disable virtualization */
 static void emergency_vmx_disable_all(void)
@@ -554,7 +551,7 @@ static void emergency_vmx_disable_all(vo
 		__cpu_emergency_vmxoff();
 
 		/* Halt and exit VMX root operation on the other CPUs. */
-		nmi_shootdown_cpus(nmi_shootdown_nop);
+		nmi_shootdown_cpus_on_restart();
 	}
 }
 
@@ -829,7 +826,8 @@ static int crash_nmi_callback(unsigned i
 		return NMI_HANDLED;
 	local_irq_disable();
 
-	shootdown_callback(cpu, regs);
+	if (shootdown_callback)
+		shootdown_callback(cpu, regs);
 
 	/*
 	 * Prepare the CPU for reboot _after_ invoking the callback so that the
@@ -846,31 +844,30 @@ static int crash_nmi_callback(unsigned i
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
 
 	/*
-	 * Invoking multiple callbacks is not currently supported, registering
-	 * the NMI handler twice will cause a list_add() double add BUG().
-	 * The exception is the "nop" handler in the emergency reboot path,
-	 * which can run after e.g. kdump's shootdown.  Do nothing if the crash
-	 * handler has already run, i.e. has already prepared other CPUs, the
-	 * reboot path doesn't have any work of its to do, it just needs to
-	 * ensure all CPUs have prepared for reboot.
+	 * Aside of being pointless this would register the NMI handler
+	 * twice causing list corruption.
 	 */
-	if (shootdown_callback) {
-		WARN_ON_ONCE(callback != nmi_shootdown_nop);
+	if (WARN_ON_ONCE(crash_ipi_issued))
 		return;
-	}
 
 	/* Make a note of crashing cpu. Will be used in NMI callback. */
 	crashing_cpu = safe_smp_processor_id();
@@ -902,6 +899,12 @@ void nmi_shootdown_cpus(nmi_shootdown_cb
 	/* Leave the nmi callback set */
 }
 
+static inline void nmi_shootdown_cpus_on_restart(void)
+{
+	if (!crash_ipi_issued)
+		nmi_shootdown_cpus(NULL);
+}
+
 /*
  * Check if the crash dumping IPI got issued and if so, call its callback
  * directly. This function is used when we have already been in NMI handler.
@@ -929,6 +932,8 @@ void nmi_shootdown_cpus(nmi_shootdown_cb
 	/* No other CPUs to shoot down */
 }
 
+static inline void nmi_shootdown_cpus_on_restart(void) { }
+
 void run_crash_ipi_callback(struct pt_regs *regs)
 {
 }
