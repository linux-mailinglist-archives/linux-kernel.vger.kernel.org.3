Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546AE517C2E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 05:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiECDYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 23:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiECDYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 23:24:10 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C0829804
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 20:20:39 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q76so10032828pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 20:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhqdV4bppKv2NJnLqEsRygbCN8xm6iT8adOuIjwb7P4=;
        b=hdWE9vWA3cARnrc1tOi5iCsSFHSQFQlN+HOy8FZ5QgW9l4vDv2ycAjuqNCwfWJl2Xh
         MopVuBcO3BChOZZ5ZVZIf0NEBUlORQmrnZmsC5UiHwUZNRCcghcykVfYeZ8nC3ehn6jl
         NYWCrN938I/L+otm47htYDvb4PX97qvEMKNOhKhF7ZCUTYZZME4CsX5a5quh9NqTjg2N
         ZQlR6MkhIkOevdWVJ0Oqyj1ygiLawuu/0smBBEvsls8fB7/oCbsjZDV8nhA10qwZOQSm
         /D1kG3a2xyvJLIuy7ykeNpPh4tSDinmByGvVmDcumAwhrYGO1Y/V3C5WuzFLhPGwErj/
         RI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhqdV4bppKv2NJnLqEsRygbCN8xm6iT8adOuIjwb7P4=;
        b=wMLDS1AxOXim9AMUn9RjceNaTN8UqCKV8jBk4u5YZR+39QJoxLTP3VUNkSJBaneE8M
         jdHiFfk03ilkzKU/XHZ1YGPC3YNmS9pLfr2qFMoH9CJgy3GKspbIjxJgf5Aj+BxmG4Sn
         lV5ENOTEjt2QS2hGpWHVFLg6P2vpKRFknfHOVQlOjSgZAhE08d4Bb8SkApT/DfMoF2eW
         T6U+39Q/06fmm3zIZB27PJxB3aNWskx56MBfcwA7uh5+L+7SWPQgSqDEj2zh2iaICDPx
         CKMNbnP8V0iVnwFhRXGj5XInjC+rDppBhLhFmZFH3/fSigKk37Qsw86+bao/US/3LI5G
         W5Rw==
X-Gm-Message-State: AOAM533BbbJj30hdHs1mc8i6YaCOmlnRPXSXagT6rqsB/3nrJX4Tgrqh
        tiMnqKSuh9aywUO9lS6c+AdZBob1XLk=
X-Google-Smtp-Source: ABdhPJwzjaJ09Og9yjQOqDMoVOoS0NJ/yoVNZ/p7AqRR5GJ+iJa7is7ictXnEAmbz+Tk9B5Y6x77ZA==
X-Received: by 2002:a05:6a00:ad0:b0:4e1:2d96:2ab0 with SMTP id c16-20020a056a000ad000b004e12d962ab0mr13936845pfl.3.1651548038640;
        Mon, 02 May 2022 20:20:38 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902f64700b0015e8d4eb1fdsm5378948plg.71.2022.05.02.20.20.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 20:20:38 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V7 1/6] x86/traps: Move pt_regs only in fixup_bad_iret()
Date:   Tue,  3 May 2022 11:21:02 +0800
Message-Id: <20220503032107.680190-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220503032107.680190-1-jiangshanlai@gmail.com>
References: <20220503032107.680190-1-jiangshanlai@gmail.com>
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
index 73d958522b6a..ecbfca3cc18c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1061,9 +1061,12 @@ SYM_CODE_START_LOCAL(error_entry)
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

