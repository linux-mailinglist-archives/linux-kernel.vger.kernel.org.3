Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB14DDBB3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiCRObq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237313AbiCRObn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:31:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681236515A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:30:18 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t22so7119364plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRZsn+I4L3PF7mITZVsUF7pl5hGeYOR3Ot1UI7N3MG4=;
        b=AzpVs+jr/74rDuMGwlZ4YEaixxx5I3+qierhYh7q4Zq5O2OJALwT4Tkj1KUx8PnfZl
         fV4aiGNL0gdSfnFpSnjkC3ckbjrtGnffZvpVvBb8x38uwx+56hAq0XXyfn/xw8yN99gp
         oqR/JC+042XVxBqSXK/0V+jfP0h30JOCvHEP0RnYGycGQTGPkhtdKP9KPGaZVmC0YWRZ
         LBwLJv4U0k7yO+vmnRcFuDbSZsEZmvmFuQkOct3pED/YlZsHYEayqOaeIAFHSHnTseA0
         F+5YU6QR8JB867flZCtHwYGC20XJbs0YMOld1o8Co7rLy8qQZF0G/0UX+rR9BW2vy3cH
         Eb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRZsn+I4L3PF7mITZVsUF7pl5hGeYOR3Ot1UI7N3MG4=;
        b=t6yqUDgiN4luxQR805kKAvBpRhyiymOFmEthpyg7bOuVxmfWjzKCOjp9FWdx7jSXjI
         fSwfhFssytQK+CIWX9GoGWObr+AOhz1LbfGcO3BAAb1RTCdZ6+u5ICzk5cId7ix04jR/
         HHwSga3Z7gtwzStzfEsab6/15Rxte4DX0QJk5+VrodqOSkFQfk4foJPzGI656Tuw6J9j
         AMyQaFTGiKKlEicsk1PRSw5T427i1PvXOXYr+9ld6jqTUWYMOYyCKjG+jMLeljfsRVom
         x5wlW9y7TTfX1e+PHQWlLgk9tO8u2m1cF4UBsIH04Tvi6fl+C3vsKw+ojQ8UfZ+9S5b+
         Dqmw==
X-Gm-Message-State: AOAM530MoHKYzoG9ItfTGz22uSwsV8/JAtT1+Hg3wb390976jcOqb1Q3
        3twom3xHij+5RhDQl7q1wYsWjKDFhb4=
X-Google-Smtp-Source: ABdhPJyzCUjk2o8N2j8v4BfuvQQHAVverf7ShHV7YJrcXxY7IMRYoxQSd/GK2leaFIgsJ0ippUf8Nw==
X-Received: by 2002:a17:90a:bf91:b0:1b9:bda3:10ff with SMTP id d17-20020a17090abf9100b001b9bda310ffmr11395652pjs.38.1647613817769;
        Fri, 18 Mar 2022 07:30:17 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id oj2-20020a17090b4d8200b001bef79ea006sm13187606pjb.29.2022.03.18.07.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2022 07:30:17 -0700 (PDT)
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
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: [PATCH V4 6/7] x86/entry: Convert SWAPGS to swapgs and remove the definition of SWAPGS
Date:   Fri, 18 Mar 2022 22:30:15 +0800
Message-Id: <20220318143016.124387-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220318143016.124387-1-jiangshanlai@gmail.com>
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
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
index e9fe9f00d17c..9e8d0e259a7d 100644
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

