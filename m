Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E431524AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352901AbiELK5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349512AbiELK5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:57:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D00EABAB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:57:08 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652353027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=grjUomL2E+JtA+UjZH9AVyARolluKP570HRi18UPmiI=;
        b=cWiUbSOzXbXSlNiud5qW/QKW8RYV41LT1brGzUR72bVDKNT5/YFRDWopodXTkQZyJmQyLA
        g6lcpVI3hpdg7yzfARgrxQeheHDHJFj8+yIgcw5lq12AnP6gqHnxZnGQYvUdmo+LzKx2V5
        aXxt2yYyv3YHYdeVz91lpJiHYiu9c/waBUj9YBjjVaWYItAP8T63OQPijyJ/3UkFyhcB1d
        CDV2yrUQAeRXnro/Ivf7qPkzVZeL8o8OKexm3upuX2IuynviQ9ufl6BNYVyRt//JYrtUZm
        vXi+ykZXpXljjhQMtWt5ZyTQOro5j9t39hqmrKsJ27Zl8NvWx1Wkz0egVI6UgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652353027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=grjUomL2E+JtA+UjZH9AVyARolluKP570HRi18UPmiI=;
        b=V7s+lpSjGe220JOzNr7KtiPfiwmIp4xr1GTdj89tou8FJ5u17lUEi9hTtzUtFUN2HQaDTi
        Ah146k8bf+0ORsCg==
To:     Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH 2/2] x86/reboot: Disable virtualization in an emergency
 if SVM is supported
In-Reply-To: <20220511234332.3654455-3-seanjc@google.com>
References: <20220511234332.3654455-1-seanjc@google.com>
 <20220511234332.3654455-3-seanjc@google.com>
Date:   Thu, 12 May 2022 12:57:06 +0200
Message-ID: <87tu9vvx19.ffs@tglx>
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

On Wed, May 11 2022 at 23:43, Sean Christopherson wrote:
> Disable SVM on all CPUs via NMI shootdown during an emergency reboot.
> Like VMX, SVM can block INIT and thus prevent bringing up other CPUs via
> INIT-SIPI-SIPI.

With the delta patch applied, I'd make that:

--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -530,29 +530,25 @@ static inline void kb_wait(void)
 
 static inline void nmi_shootdown_cpus_on_restart(void);
 
-/* Use NMIs as IPIs to tell all CPUs to disable virtualization */
-static void emergency_vmx_disable_all(void)
+static void emergency_reboot_disable_virtualization(void)
 {
 	/* Just make sure we won't change CPUs while doing this */
 	local_irq_disable();
 
 	/*
-	 * Disable VMX on all CPUs before rebooting, otherwise we risk hanging
-	 * the machine, because the CPU blocks INIT when it's in VMX root.
+	 * Disable virtualization on all CPUs before rebooting to avoid hanging
+	 * the system, as VMX and SVM block INIT when running in the host
 	 *
 	 * We can't take any locks and we may be on an inconsistent state, so
-	 * use NMIs as IPIs to tell the other CPUs to exit VMX root and halt.
+	 * use NMIs as IPIs to tell the other CPUs to disable VMX/SVM and halt.
 	 *
-	 * Do the NMI shootdown even if VMX if off on _this_ CPU, as that
-	 * doesn't prevent a different CPU from being in VMX root operation.
+	 * Do the NMI shootdown even if virtualization is off on _this_ CPU, as
+	 * other CPUs may have virtualization enabled.
 	 */
-	if (cpu_has_vmx()) {
-		/* Safely force _this_ CPU out of VMX root operation. */
-		__cpu_emergency_vmxoff();
+	cpu_crash_disable_virtualization();
 
-		/* Halt and exit VMX root operation on the other CPUs. */
+	if (cpu_has_vmx() || cpu_has_svm(NULL))
 		nmi_shootdown_cpus_on_restart();
-	}
 }
 
 
@@ -587,7 +583,7 @@ static void native_machine_emergency_res
 	unsigned short mode;
 
 	if (reboot_emergency)
-		emergency_vmx_disable_all();
+		emergency_reboot_disable_virtualization();
 
 	tboot_shutdown(TB_SHUTDOWN_REBOOT);
 
