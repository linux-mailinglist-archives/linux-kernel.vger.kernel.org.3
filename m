Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7044D4D9574
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbiCOHkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345543AbiCOHkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:40:42 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEDA4B84F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:39:29 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u2so581107ple.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOyx9E8tfL4n6GqsVbEY5LNO7I69yL8/5cHJdSeUlTc=;
        b=A37fPEIAk9vlJKK8W1H1KcJvNWGCYODPXC+G8E1xOjSCPugsbEaIR3GXp8YgdYULCm
         CsKJFVU/2Zj2Y9G0lyfgorVMQ5A6b/iuUi7oM6r9oiHtBgWoIjkFdHzGGjNb2wDwtexN
         RxhdoaYc/Bam9UU8SQkKC5PyNZmuCGOOy4E/cbKVPfTmzik35OVCoDQ+tneYR58DfD7f
         Kcn35qwCOMXkwWjaJhgE8jxMEn42pmfEOjavLGktAJSf22XJg1QvvRdLrAdfw3FDvHpN
         XK8dooK7uFgWGqaZPwMX6EypS2c/1kVrBIc1ntucJqh+V5ngqQPcX4KGP6xPngEZT2cj
         VOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOyx9E8tfL4n6GqsVbEY5LNO7I69yL8/5cHJdSeUlTc=;
        b=LgSKK2Uq0geRCKb7NSaHFL4+RYw2UH0E7p66bwlRxVIN7XB3jnb8nPviGbxYqBCA+z
         IJNAoiEvkr7188DfbkX/uy+oFv1ZxAqzSaggEHuCjOKqYJ0VwEfyEYlx3UZfPN8vHF+E
         mDfMpw4Sr+1Ip1C1HGZTbi4XHhytLatWWzKv+ydN0rd2EfJpsh+2++NQouqB6uEYmTbn
         +34s2XFYUlPa64fONhW1U7l41sq2Mn7nqhctKCcZoC1KZr07+QIql9z2ObCO9Sxx4AGu
         oZuI2PVKY46EtlQneNbyBp3CBCrw4fMpfq6J15lo7X8IySy4HfeKtL7aTh4/Np5deZZ2
         U+2g==
X-Gm-Message-State: AOAM530EvqCi9aZwP0+Nw5jKMnpotudxCQW419AmNZnjEgD31SRpyn8e
        qO+0kgl8DhBQuxOZjWWRFpacdrdGEiI=
X-Google-Smtp-Source: ABdhPJyL/ka9uuvEAKTGTaOjlN+mcOao1BFGRvE5QVkhp1rC74coMo131TFXLbXJNB/MrTyISoT82g==
X-Received: by 2002:a17:902:8492:b0:14d:5ddc:9df6 with SMTP id c18-20020a170902849200b0014d5ddc9df6mr26482713plo.15.1647329968339;
        Tue, 15 Mar 2022 00:39:28 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id j8-20020a056a00174800b004f6f3bfd054sm24443381pfc.94.2022.03.15.00.39.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2022 00:39:28 -0700 (PDT)
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH V3 2/7] x86/traps: Move pt_regs only in fixup_bad_iret()
Date:   Tue, 15 Mar 2022 15:39:44 +0800
Message-Id: <20220315073949.7541-3-jiangshanlai@gmail.com>
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

fixup_bad_iret() and sync_regs() have similar arguments and do similar
work that copies full or partial pt_regs to a place and switches stack
after return.  They are quite the same, but fixup_bad_iret() not only
copies the pt_regs but also the return address of error_entry() while
sync_regs() copies the pt_regs only and the return address of
error_entry() was preserved and handled in ASM code.

This patch makes fixup_bad_iret() work like sync_regs() and the
handling of the return address of error_entry() is moved in ASM code.

It removes the need to use the struct bad_iret_stack, simplifies
fixup_bad_iret() and makes the ASM error_entry() call fixup_bad_iret()
as the same as calling sync_regs() which adds readability because
the calling patterns are exactly the same.

It is prepared for later patch to do the stack switch after the
error_entry() which simplifies the code further.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S    |  5 ++++-
 arch/x86/include/asm/traps.h |  2 +-
 arch/x86/kernel/traps.c      | 17 ++++++-----------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 47ed97cbf46c..37505331b7f1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1073,9 +1073,12 @@ SYM_CODE_START_LOCAL(error_entry)
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
index 1563fb995005..9fe9cd9d3eeb 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -892,13 +892,8 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 }
 #endif
 
-struct bad_iret_stack {
-	void *error_entry_ret;
-	struct pt_regs regs;
-};
-
 asmlinkage __visible noinstr
-struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
+struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs)
 {
 	/*
 	 * This is called from entry_64.S early in handling a fault
@@ -908,19 +903,19 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
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

