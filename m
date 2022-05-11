Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30C752412C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 01:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349449AbiEKXn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 19:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349466AbiEKXn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 19:43:57 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FCB70911
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:43:52 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id bj12-20020a056a02018c00b003a9eebaad34so1698844pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 16:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=JtrG0Prmhr3vTXS8nWuYYpYreCaFB4jpf2e8MRiZPjM=;
        b=e91y02DAWbubPKpcnfJaF8RXew9U7HmcVhFnnRSorWEJIF+xtGw9gYd/o6jByKTmH5
         mYhRViuefbFj2gkEG3pbnMANbfFNqjz6DJ4NDUJJ1pIbf4HoX8aHS7NLQfuUJqKqvMhv
         Sq8yDrFKqM/UX4zAafWN8RBlKpUoT6K3Cb3VdHRoqXi47QWvj9G1llm4281LvPyY0w+u
         w3f8vlx5KtNSjdnhoMSnFPWx0Uz5zL2o8YWbnltfEG1e/VI816mpO+N5AMY9vJMnvZ7T
         Z0KbSevGrEsInCZ20NWaNekREBrEgrNYPEiDf4U7QtgKIflx6bMSPyl9AVDHye3si88T
         dHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=JtrG0Prmhr3vTXS8nWuYYpYreCaFB4jpf2e8MRiZPjM=;
        b=4344cBVPJSSLplmFa4+jvjB9uLLSKdn9waRckRfxFelRpqGWJtFnmncCdLdHvOy0fn
         oLuSAzAxfQYHaV+ytO5npen7RqHbT/w9Em7tLpb55uUJ05602Xh0da6vIM1Zkb+r1wh6
         XEBHO01caSdrvRsroKnSsrfuDWLaAboMwr18450QdhKhoNYAJrwnUkfdSfkFDPoo3h3N
         TiVLqives4Lzlw3TSgcyvc0jz1jhclimzneslI/LTGvRmFpYlZUQEmNPAsEmGT/gDlgX
         hDe1jQEhst7CHupK6YHVfUqn7+Dg+KwxRaD1P7sPdqPBVdkmoWp/K4p2BQiqu6bqLhje
         iw9A==
X-Gm-Message-State: AOAM530XnXqYPmroNItP4caqqIGVw0zBdnTltpVYYDD4Jn4TH4C71oNs
        OJLW0InYRni5BFHOX0RT4JOa4z5cop0=
X-Google-Smtp-Source: ABdhPJxHLQMii3mrtX56N6obwbLOhtAoUbfM/fvBvnNgeIwM71qKfeQHFW/gH0KGVpy0KZsdnj9C7wEdOo8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:bd14:0:b0:50d:4bec:ff78 with SMTP id
 a20-20020a62bd14000000b0050d4becff78mr27275096pff.71.1652312621887; Wed, 11
 May 2022 16:43:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 11 May 2022 23:43:32 +0000
In-Reply-To: <20220511234332.3654455-1-seanjc@google.com>
Message-Id: <20220511234332.3654455-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220511234332.3654455-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 2/2] x86/reboot: Disable virtualization in an emergency if SVM
 is supported
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
 arch/x86/kernel/reboot.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index f9543a4e9b09..33c1f4883b27 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -533,27 +533,29 @@ static void nmi_shootdown_nop(int cpu, struct pt_regs *regs)
 	/* Nothing to do, the NMI shootdown handler disables virtualization. */
 }
 
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
+	if (cpu_has_vmx() || cpu_has_svm(NULL)) {
+		/* Safely force _this_ CPU out of VMX/SVM operation. */
+		if (cpu_has_vmx())
+			__cpu_emergency_vmxoff();
+		else
+			cpu_emergency_svm_disable();
 
-		/* Halt and exit VMX root operation on the other CPUs. */
+		/* Disable VMX/SVM and halt on other CPUs. */
 		nmi_shootdown_cpus(nmi_shootdown_nop);
 	}
 }
@@ -590,7 +592,7 @@ static void native_machine_emergency_restart(void)
 	unsigned short mode;
 
 	if (reboot_emergency)
-		emergency_vmx_disable_all();
+		emergency_reboot_disable_virtualization();
 
 	tboot_shutdown(TB_SHUTDOWN_REBOOT);
 
-- 
2.36.0.512.ge40c2bad7a-goog

