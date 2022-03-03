Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214014CB58F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiCCDyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiCCDyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:54:51 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C0B1451F2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:54:06 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s1so3379321plg.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 19:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Ch1JNDNo51YVs+vsacZ59NwHAxiNSMO9ntOA4v94+Q=;
        b=O3r0h/dm6t6rNSpfl/sKfCk8T0wcjUuRcpNKoUyFVzbqyINK3z1DhUkcm0DGfvluzt
         jR8UdaaPAAZLoFn2PZa9TdbvDz2PLohq5iDzAz6YeVAlSlttvpAp33v7V7u3yVe5HDKb
         zyJyQbzSLuHQfF56eRTTMcEaUJI3ClFfZ80gNK8GXAwoVJIYMZZcdrMZqxT8ZOl63F4z
         GKGpzG8vpY5Zyv3+SpzJp6xPWQVf9ts8z757aKXMelvRPriZzWM09vi4zrjZXYEBkOii
         qq7g1UGh1F2huejbiY/XlmnlQVOP74j07BqH2RNHfT/t4WvONfG4D/PQleUhtO07xknl
         RaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Ch1JNDNo51YVs+vsacZ59NwHAxiNSMO9ntOA4v94+Q=;
        b=fIzLHUhI1wHcsiNVwol63FsQUOqE4qkgi1cOmYynmZ0zeZ9wHKnBDfeIqBETwHo4xi
         HGlHTC1KYFtO6f4IvkWuB+NC3dJ0MsX2Xwt2ChPU1ycFJV9+DoCcMQt4F4rRlixhphvH
         zdNxR6wi+Jcm2xu9jSoh615Cn6zInerJCEtt1h3z9yZ06j8xAwgX+2JE9975c2HcGVQX
         5O4HNPQI22Z68m1uaBvgpa1DTlg5+5ZQBw8mGZcTEEeY2XYtPK2dSBL3LLNZP0p8sVYj
         YAa9XfMOW20OGsNPt41NI7LQL/eSEfEbPM75y7WelEchkHcIjKK9SKdwIsh0jimDN9wp
         ra5g==
X-Gm-Message-State: AOAM531lOn0LjzJz9NUt0WrKZHj9iRoq8q1j29n6deiK6QRUYN/jmYSP
        BfKa9qDKdqWGmP7dfXpTOOeoicd+XWA=
X-Google-Smtp-Source: ABdhPJyAZhUyzX32PUWoZ5vXF2AAfID8mqPgHlZfXnTsY31wiMC90VN0OjRbZ9KIrpr0+C+oOMdmAA==
X-Received: by 2002:a17:902:da91:b0:151:8e79:8307 with SMTP id j17-20020a170902da9100b001518e798307mr8889827plx.8.1646279646003;
        Wed, 02 Mar 2022 19:54:06 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id mu9-20020a17090b388900b001bef86b7d92sm3620509pjb.24.2022.03.02.19.54.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2022 19:54:05 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V2 1/7] x86/traps: Move pt_regs only in fixup_bad_iret()
Date:   Thu,  3 Mar 2022 11:54:28 +0800
Message-Id: <20220303035434.20471-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220303035434.20471-1-jiangshanlai@gmail.com>
References: <20220303035434.20471-1-jiangshanlai@gmail.com>
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
index 466df3e50276..24846284eda5 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1039,9 +1039,12 @@ SYM_CODE_START_LOCAL(error_entry)
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
index 6221be7cafc3..1cdd7e8bcba7 100644
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
index 7ef00dee35be..2b1f049afb14 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -816,13 +816,8 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
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
@@ -832,19 +827,19 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
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

