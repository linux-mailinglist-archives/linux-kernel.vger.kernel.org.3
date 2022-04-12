Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3278C4FE0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353987AbiDLMtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355075AbiDLMsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:48:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F8510FC8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:15:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b2-20020a17090a010200b001cb0c78db57so2770634pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OXdbOjDTkc/lpsO0bVF0UBH7oeBmsD70Aq3u3kuhfAc=;
        b=iousPDZm7gaCaJiaNiPDPozbAWMZQJje+klmUZbut6nLSHAbk7zDfFClWHWRSAxmtf
         wV+SI7tVRfOKiy7MuTsWMszMPaTiZvQyqQc/q0VTsXkiDBBAo5ke/wlet77AW2rBkCnp
         JUmUjORcH4fFhl8MGZtAHqtF4PPP8r1pUCPEOq3tms9ZRHmKLRNuoVyglW5nyedoiVO7
         w7ltGPsccnFypmVDPINdO4bNlc8hdLtfmdKWSpXlvERfL8YR4n0g+x5jbVQVcKlQcgzD
         xyt8VC1uZpP/fgLEgXcmcnpllGnDC/CWh3/iNWRCApaODZt5Fwd9s0anm500LFFGHkAd
         BJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OXdbOjDTkc/lpsO0bVF0UBH7oeBmsD70Aq3u3kuhfAc=;
        b=Wx0r/o+se14DkBXryL97asayWW35LZeuXv2pPT1kR+Wl36Fa2HYEw25hMmArvUXcZJ
         w0hF1f7GMYSKw4wMK2ZHVPgcivJ+AsqG6P9ff3kZI/tVW8+3O5ZrEd5z1TSPl/sj074c
         PyDTy6dXKntlMUp0h/Bx2grCiC2cYg/sViMkaxc8UsI/FUMcLW9ERFglC71jXkyg5PUB
         4QDmf4ZSmJ7kc5MzGizc8WcBQPlXM4FZRTZqs3Vgb9YZ0px/6fTkXWwfJ9v3Iq24LcyJ
         MANpNmWIdjHXVYQiRvTseieQwWZWFQ1S/UXNjbeSfLLwT1JzOtFxWPfeVEx8Wyo+OKi3
         /6Hg==
X-Gm-Message-State: AOAM532QA4VNVHQ4jZPk48GQdN7s8+SXmQAb8jKOifBvoEYsCT/wR7gb
        eYdmfQGuxgZpQTe4ka3sHEmtl361TjU=
X-Google-Smtp-Source: ABdhPJyDgpTIQAaALd/s3TdLNwfSjuSwhkNOpj10p/VRwS3aBLftHdln7iSASsjNzpt6kjsDqqVHQg==
X-Received: by 2002:a17:902:d48b:b0:158:558d:c58a with SMTP id c11-20020a170902d48b00b00158558dc58amr11703141plg.105.1649765702627;
        Tue, 12 Apr 2022 05:15:02 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id np8-20020a17090b4c4800b001c70aeab380sm3019859pjb.41.2022.04.12.05.15.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:15:02 -0700 (PDT)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V5 1/7] x86/traps: Move pt_regs only in fixup_bad_iret()
Date:   Tue, 12 Apr 2022 20:15:35 +0800
Message-Id: <20220412121541.4595-2-jiangshanlai@gmail.com>
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

Always stash the address error_entry() is going to return to, in %r12
and get rid of the void *error_entry_ret; slot in struct bad_iret_stack
which was supposed to account for it and pt_regs pushed on the stack.

After this, both fixup_bad_iret() and sync_regs() can work on a
struct pt_regs pointer directly.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S    |  5 ++++-
 arch/x86/include/asm/traps.h |  2 +-
 arch/x86/kernel/traps.c      | 18 ++++++------------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4faac48ebec5..e9d896717ab4 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1058,9 +1058,12 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * Pretend that the exception came from user mode: set up pt_regs
 	 * as if we faulted immediately after IRET.
 	 */
-	mov	%rsp, %rdi
+	popq	%r12				/* save return addr in %12 */
+	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
 	call	fixup_bad_iret
 	mov	%rax, %rsp
+	ENCODE_FRAME_POINTER
+	pushq	%r12
 	jmp	.Lerror_entry_from_usermode_after_swapgs
 SYM_CODE_END(error_entry)
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 35317c5c551d..47ecfff2c83d 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -13,7 +13,7 @@
 #ifdef CONFIG_X86_64
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
-struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
+struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs);
 void __init trap_init(void);
 asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
 #endif
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a4e2efde5d1f..111b18d57a54 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -898,13 +898,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 }
 #endif
 
-struct bad_iret_stack {
-	void *error_entry_ret;
-	struct pt_regs regs;
-};
-
-asmlinkage __visible noinstr
-struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
+asmlinkage __visible noinstr struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs)
 {
 	/*
 	 * This is called from entry_64.S early in handling a fault
@@ -914,19 +908,19 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 	 * just below the IRET frame) and we want to pretend that the
 	 * exception came from the IRET target.
 	 */
-	struct bad_iret_stack tmp, *new_stack =
-		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+	struct pt_regs tmp, *new_stack =
+		(struct pt_regs *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
 
 	/* Copy the IRET target to the temporary storage. */
-	__memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
+	__memcpy(&tmp.ip, (void *)bad_regs->sp, 5*8);
 
 	/* Copy the remainder of the stack from the current stack. */
-	__memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
+	__memcpy(&tmp, bad_regs, offsetof(struct pt_regs, ip));
 
 	/* Update the entry stack */
 	__memcpy(new_stack, &tmp, sizeof(tmp));
 
-	BUG_ON(!user_mode(&new_stack->regs));
+	BUG_ON(!user_mode(new_stack));
 	return new_stack;
 }
 #endif
-- 
2.19.1.6.gb485710b

