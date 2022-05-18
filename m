Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8F052AF19
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbiERARC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbiERAQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:16:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43818377F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:16:57 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v10-20020a17090a0c8a00b001c7a548e4f7so2250172pja.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 17:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7mzm6qjp3Yai3B3eF57KZR4+IRYh/smYTo1V52UGyPA=;
        b=mADzZIq8tgjzX1Icd5MTvHVL3DMKraxuenM7VA62zM/HpQgWSd+BUH6roMy8Flnn0m
         Oj6JLdSkoa4CWEV+r3PWdbwsbw/b04baqhyerktWitfsOzcNNqte7moS6lTMK1SkartZ
         8ulL8+55uTJVYUI4wIV3AwXuRXlaScpE6ofVMQQ8hIVvEKi4w4b+q4szqvTFhE99UI2w
         ZhGgPp+O/T4ZWnMMDXuL0WOB+uy+Tfy2eH+6Sw2qDhJ8caIiR9u0GPUMHzrUhFXGcNSQ
         3fcl+nDhTD6TvOkzfwt3Y3leQBMDkgS6izYuVPWuprk7lu8FNe+AyWkrfOMHN7Nm70gz
         huww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7mzm6qjp3Yai3B3eF57KZR4+IRYh/smYTo1V52UGyPA=;
        b=OEb19p8K9zjtZoBuvJ1wf+0KDrOPG4I2vrDRfB5zLvmYNKUZ3RLGD5c1+eIpnYByXU
         NKrCj2Usm1saVG/E2oMZblQR32lU/t9kdZ9OmqhpWejZ+dGmfh2ymOr9mJbW65jnB360
         rYML5eCEKq/hTRBnVF4TK+SbaEwAu2e9Bom/GvtGGNhVTNua14r44jtV3WCdM08ADE5j
         YZWS0hgLSyXY0jO6v2pohnWVw+fMt1+zbXpvVbw4NfWPxm+lDkJ+wf0c5jLh0qb8QKEe
         ou+aQ2hkgP8YZbFBA5ydNfirXMeYgmUxp1f3Vqu9KwBIDdXfxCfa4fUQbu0KhR3cMAxY
         MGJw==
X-Gm-Message-State: AOAM532ZFyPvxVUI//+qmpa5/w/95AnX0Lwpj5m14MisgkAvIMheVNA4
        zb7Iwy/SItkaY6mb9T1ro6FsSPetTEY=
X-Google-Smtp-Source: ABdhPJygTCCF+Hnb7HRTg8yNr37g9LpbXVaCpCe5YKtrwNXKsySOcfhf9HByxNerW9gAueXGX+txNxRe/90=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:9044:b0:15d:1c51:5bef with SMTP id
 w4-20020a170902904400b0015d1c515befmr24620576plz.170.1652833016740; Tue, 17
 May 2022 17:16:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 18 May 2022 00:16:46 +0000
In-Reply-To: <20220518001647.1291448-1-seanjc@google.com>
Message-Id: <20220518001647.1291448-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220518001647.1291448-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 2/3] x86/reboot: Disable virtualization in an emergency if
 SVM is supported
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

Disable SVM on all CPUs via NMI shootdown during an emergency reboot.
Like VMX, SVM can block INIT and thus prevent bringing up other CPUs via
INIT-SIPI-SIPI.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/reboot.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index e67737418f7d..0aba4a37f3f9 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -530,27 +530,26 @@ static inline void kb_wait(void)
 
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
+	 * the system, as VMX and SVM block INIT when running in the host.
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
+	if (cpu_has_vmx() || cpu_has_svm(NULL)) {
+		/* Safely force _this_ CPU out of VMX/SVM operation. */
+		cpu_crash_disable_virtualization();
 
-		/* Halt and exit VMX root operation on the other CPUs. */
+		/* Disable VMX/SVM and halt on other CPUs. */
 		nmi_shootdown_cpus_on_restart();
 	}
 }
@@ -587,7 +586,7 @@ static void native_machine_emergency_restart(void)
 	unsigned short mode;
 
 	if (reboot_emergency)
-		emergency_vmx_disable_all();
+		emergency_reboot_disable_virtualization();
 
 	tboot_shutdown(TB_SHUTDOWN_REBOOT);
 
-- 
2.36.0.550.gb090851708-goog

