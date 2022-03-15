Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F874D957C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbiCOHlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345555AbiCOHlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:41:13 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919674B436
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:40:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id l8so7805123pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amuoYMRnXO7FCaFWCvrHLYYAmtkhMgtyIXyJeMSribs=;
        b=O5UI23mfzMei9S129vyjFDLG5nlO/dxGYSigcINb8ZWYFkp8iYSf3JJP2pQEYs0hJR
         u4SwAUUjcqDr0sWCjyyNLO4OpVRaA7V19OO2Ao3fYrwA0qD85PiXZ7VmFEGwSLdG1Wlf
         8xYuS4NNf98Q4xA2bQ5WEWTykfCxgsxLJFmuPmoYNSYaBelPoJiEyvPXLRrTuqvD3i3w
         AfLDQ87l4AnrCiOqMCo6/qUmN3ihK3MSAr0/gHz8JaZtdEZ4L/Bx3s7+dFarq2B+Lsgb
         Xs7Byn0XczyYJhnwF/ZtoWtHQ38jmRFv64GoNgLklZeifMtk/mhPp1P0mc9T8/NtLdq0
         J37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amuoYMRnXO7FCaFWCvrHLYYAmtkhMgtyIXyJeMSribs=;
        b=2vvaSOthBr5XG9AyccD+AuCHa5wbDG1haRgaRmu6m0K8KeZF+3NF9WDm/hW+IUP4Qi
         ZLD68e1mg/SpAB68sQAG/ErpM2NinN1n571CDQy4JKCEUKY+Udwo0bymo5/MIxRgKFJ2
         s/1Zt+LizxuOKglORB65tKHAIfCDdXaP5rkW2ENz93AQK+Nc3Ny+VI06OypafHMp9qqg
         fJloWoRUR9sa/t15HuTjuZpLrDRGxZNsz/u88c1gxqglbhWDN1W3mjtLfwUIcSVMrQlg
         JKSm5u9jV0TWOp8U3cDXknAFFVfWg71PK/JVRIZNr3i2ocwvP+eT/QDc+5kR60qraduO
         TNoA==
X-Gm-Message-State: AOAM530wng/P1b1btDxuXChEU7K8ioTSeFM+cj6W9hxjyaEUdNqGJBDe
        zG1+ir2UGYNXYRgdYCb91zTtdNTXAvk=
X-Google-Smtp-Source: ABdhPJwzhabjS0Ov7qsHNlSu6iIov9cD4PDgTrfp6hOiSS66sxdu4O4BqOgK8qLDhEXWkyeEcYbf1A==
X-Received: by 2002:a63:d44c:0:b0:380:8c48:e040 with SMTP id i12-20020a63d44c000000b003808c48e040mr23572043pgj.14.1647329999895;
        Tue, 15 Mar 2022 00:39:59 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id u17-20020a056a00159100b004f763ac761fsm22306203pfk.33.2022.03.15.00.39.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2022 00:39:59 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH V3 7/7] x86/entry: Convert SWAPGS to swapgs and remove the definition of SWAPGS
Date:   Tue, 15 Mar 2022 15:39:49 +0800
Message-Id: <20220315073949.7541-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220315073949.7541-1-jiangshanlai@gmail.com>
References: <20220315073949.7541-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

XENPV doesn't use swapgs_restore_regs_and_return_to_usermode(),
error_entry() and entry_SYSENTER_compat(), so the PV-awared SWAPGS in
them can be changed to swapgs.  There is no user of the SWAPGS anymore
after this change.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S        | 6 +++---
 arch/x86/entry/entry_64_compat.S | 2 +-
 arch/x86/include/asm/irqflags.h  | 8 --------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ec885c2107de..e20eabaa56b8 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1023,7 +1023,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We entered from user mode or we're pretending to have entered
 	 * from user mode due to an IRET fault.
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
@@ -1055,7 +1055,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * gsbase and proceed.  We'll fix up the exception and land in
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
-	SWAPGS
+	swapgs
 
 	/*
 	 * Issue an LFENCE to prevent GS speculation, regardless of whether it is a
@@ -1076,7 +1076,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We came from an IRET to user mode, so we have user
 	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 2b7496a36f65..6866151bbef3 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -50,7 +50,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	UNWIND_HINT_EMPTY
 	ENDBR
 	/* Interrupts are off on entry. */
-	SWAPGS
+	swapgs
 
 	pushq	%rax
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 111104d1c2cd..7793e52d6237 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -137,14 +137,6 @@ static __always_inline void arch_local_irq_restore(unsigned long flags)
 	if (!arch_irqs_disabled_flags(flags))
 		arch_local_irq_enable();
 }
-#else
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_XEN_PV
-#define SWAPGS	ALTERNATIVE "swapgs", "", X86_FEATURE_XENPV
-#else
-#define SWAPGS	swapgs
-#endif
-#endif
 #endif /* !__ASSEMBLY__ */
 
 #endif
-- 
2.19.1.6.gb485710b

