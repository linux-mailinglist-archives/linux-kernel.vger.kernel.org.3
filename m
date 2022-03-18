Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5084DDBAB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbiCRObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbiCRObG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:31:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D555370F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:29:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id n18so7086712plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Gsw2FtcQ99RccR2kNPSNup46xZKy3zNYSA/XBeg9M0=;
        b=WFWQjDi7YrzVgEMTXGrmg6GVxuQBb/zYntzqeASVfz+KB7+74aoNpFur1pcm5jVyY2
         L7s0dMH2wmv/lIwX6E+qCLGbhn5Uutz7GPuWTnVRq4q0pOq+xbJkYdxGFRpZyEaiE1/T
         9glm7MW/hBpt0O2hFMJjrKQEJa3amST6oWeBwrKIsr/8DnYSGCmUuFz1tARXZjmT5SM0
         WeR+z9IzHFKNc3n9gBXczYts3Btod7rZ3oJYEG/WtJVwQj6YagU+TwHuIasvrpnpSCQ/
         DABJnzVtJaSTYLx9h0BR118/kQ28K4DZ4ZdjYGe70lE+hxqmRoL3gkm2FMI5tsceVs66
         3iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Gsw2FtcQ99RccR2kNPSNup46xZKy3zNYSA/XBeg9M0=;
        b=MTj2S0NOyVXEExQD8Vdc/m7gNFkm1wbsVm3SvOF+0V+dW3C55g4ZOki9lRSuaiXhWr
         xS52XQtmlB6efjWXxpqToclV94Mv0IRe5TAEACsl34wGpL3n0xp+/EX2zUl0Embm/CKX
         WS3/GWpTx4hAKADOeUD02sh7yPAeHDS427nokdqqikTZ+28xARuVfm8VxFpQYQwIDeLX
         k1FiUd16b556nuCw6GgrzIleiYQhawaYjHfXNoP2mUachQa3m78peDqgW3ZIaZak+hFc
         BAHFj3+P54PtN6P2HuqQfPUfhDO05hPbWEfC+GOAcg9RDJB/+fiabr8ZlQxTIDpAyi6y
         hAFw==
X-Gm-Message-State: AOAM533tJJyNv1GOygsFZvbUnF3DUkM/ysaJF9mKy0F7TvYJ36PGwxCb
        urcb0mT83+oYcmxd2Ou0CuXyUrqrWgk=
X-Google-Smtp-Source: ABdhPJyF/GlEAMrjIGf6kttwu/emtz8/+lAzt9WHKWTY0aCzRq/U0OoYC4CylaUYEIwSpsZHEvw0gw==
X-Received: by 2002:a17:902:e5cc:b0:154:1c96:2e5b with SMTP id u12-20020a170902e5cc00b001541c962e5bmr1410821plf.94.1647613786038;
        Fri, 18 Mar 2022 07:29:46 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id kk12-20020a17090b4a0c00b001bed1ff3717sm8452612pjb.6.2022.03.18.07.29.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2022 07:29:45 -0700 (PDT)
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
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH V4 1/7] x86/traps: Move pt_regs only in fixup_bad_iret()
Date:   Fri, 18 Mar 2022 22:30:10 +0800
Message-Id: <20220318143016.124387-2-jiangshanlai@gmail.com>
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

