Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6943B4FE0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354399AbiDLMwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355250AbiDLMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:48:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254191EAD9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:15:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a21so2415978pfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9X2SrqoTs43koF8W1YEyPB7oiXm2DF9WYmlTb3V7PA=;
        b=lQLilr+Q2g87EtVVPRkynme+ys+unhl7MuT0MI1fPPleOe3LCLXtn0geYCy4JxzqfE
         dxUkJRUAW8BcXKan8vkglpGtWOnLfw1uW7UBvsjoAn7wjZqRu630HO5ukKaf/zUnQF41
         hx96WGUZoVdVW0L1Zgg6ZzVQoJJEmTJWrb1NT2H7DZIgYHdw1H8uOqmgvQMhve0fSSHD
         JYhqnA2kGKcIlewMPJoFXpSF8qwr9p4URhQl+Oz0qXWUAS+JcANj8qMDk3H7doYze6gv
         hGf+O6aaD31GkgKtap63TvHDKeVipbnKKqGKb7gIcCTCbikv0tjAYE2E5Z9ApVOOny3E
         74Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9X2SrqoTs43koF8W1YEyPB7oiXm2DF9WYmlTb3V7PA=;
        b=QfrgkJk0rmQsV1C0AgqRoNP968hrODxn24IUmkcrxWm6oWDhpnCdfdj56JP7pqP+td
         XJLG5LdbLFaQIT00ppuS1v6ZVzBnIhJ9pVvVaEdqQGLe1F3mWxllQowzCjoqlVMdRFYN
         RjHPCt8kJl2r3AwnBcoWGNfY5JSM8RS1RMtTQzXgVB0Dm8PeRwBkyVSEDrh6V/64/Ox1
         af+5kUJrKMTM1vGoANwYfCpQg2PSWVwRL6yzQvmhDAGERVEUKyMPDQi0c2b8RrwZfehP
         lSk4CTeYnS5jULKrgigVkDV77S1l38jClmK/SBuxuZoFh4hMttR1jjkjFNc78nokShd7
         R/Ew==
X-Gm-Message-State: AOAM5323pV70Pb+RfsiqincjoNykIeTN772jGx4kYwaNsbUqs4hi713i
        JAufZYgSJXh0TTYZ3CGr+ez7jfUix50=
X-Google-Smtp-Source: ABdhPJwUwSEjOQ6f0fkqphrVXFPI2eKvjFOkDqm44pnqo65ZzNs8bqOQfpk2u4QAWn9N7S5xk/kh6Q==
X-Received: by 2002:a05:6a00:1ac8:b0:4fa:917f:c1aa with SMTP id f8-20020a056a001ac800b004fa917fc1aamr4312157pfv.2.1649765735470;
        Tue, 12 Apr 2022 05:15:35 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id ng17-20020a17090b1a9100b001c9f79927bfsm3060878pjb.25.2022.04.12.05.15.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:15:35 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH V5 6/7] x86/entry: Convert SWAPGS to swapgs and remove the definition of SWAPGS
Date:   Tue, 12 Apr 2022 20:15:40 +0800
Message-Id: <20220412121541.4595-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220412121541.4595-1-jiangshanlai@gmail.com>
References: <20220412121541.4595-1-jiangshanlai@gmail.com>
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
error_entry() and entry_SYSENTER_compat().

Change the PV-compatible SWAPGS to the ASM instruction swapgs in these
functions.

Also remove the definition of SWAPGS since there is no user of the
SWAPGS anymore.

Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S        | 6 +++---
 arch/x86/entry/entry_64_compat.S | 2 +-
 arch/x86/include/asm/irqflags.h  | 8 --------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3aca7815fe79..6611032979d9 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1008,7 +1008,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We entered from user mode or we're pretending to have entered
 	 * from user mode due to an IRET fault.
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
@@ -1040,7 +1040,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * gsbase and proceed.  We'll fix up the exception and land in
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
-	SWAPGS
+	swapgs
 
 	/*
 	 * Issue an LFENCE to prevent GS speculation, regardless of whether it is a
@@ -1061,7 +1061,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * We came from an IRET to user mode, so we have user
 	 * gsbase and CR3.  Switch to kernel gsbase and CR3:
 	 */
-	SWAPGS
+	swapgs
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4fdb007cddbd..c5aeb0819707 100644
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

