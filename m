Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376C050A1C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389036AbiDUONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389111AbiDUONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:13:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D003968F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso5290088pjj.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhqdV4bppKv2NJnLqEsRygbCN8xm6iT8adOuIjwb7P4=;
        b=V96tI2wYuISOCbp1lDUZQBAMHT+LAjVjqnuxRitXqkXtuPpJY0DSTgsv4UZv7duHH2
         JtoQcoh/Cz1vhiAoJF3ghX2h0j9Q9yM2J0qQpHhWaTTq+ZvEvMI+7YRTXvPkDlDDGfQw
         Qd1/yvUVZlkbGmFiT1suuTurm5A3PueJPKlqNGIY7eEwzYVvf61nrYPlqz4NUp0dSYPu
         deL1/H92jw7OFBC1Y/0yC+C55BWtz3v/8YtWrmIQRBBLVML/RTDVt7dg00EGha8eAxBb
         uHuAUtMVTY7qyEtcloQG+jt6LmVHPsMk6SriskmsKR+ZFa0Kob/d7cq4Tf4yGur0Ik+1
         hCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhqdV4bppKv2NJnLqEsRygbCN8xm6iT8adOuIjwb7P4=;
        b=jtacY+NKkcPfOqANojcDItqIcRa1D7gJlSv1kAgs3iX4a1NboODfxQrsB5ZA+R9PPs
         Cvk2LiNnTizuMTPxvreOJF9bPc65weiXmTxVmg/GV0HKloKRVlp38n5n+WKFMv52Wb1z
         t63SUOAE83PcFWsgfzNc4aFTMQJHi8sr0Tjz6tHHqjglMFnCfS9odNIuQ00uuHSgyzYD
         CuD1jjRmxwO0rPvShCGxbnlbHE+Ibcu+g1AmM5C/VHFWbMGccg1gtBOou9emKn2YsPYU
         GhWlLq9yHfVU1wdEbJeX2LzTYzPrzWU+C2D3cVFvVTEBMR/a2xFfzCE7ybixSQMo1QIP
         oTwA==
X-Gm-Message-State: AOAM530gV/isKkkkaPIshAByj5z3XyaQ3O1+vEMsZHs9c47n3w+d/IEk
        y5L9PQo3Hn5JVRheIDh2ahQBlYH/UB0=
X-Google-Smtp-Source: ABdhPJzs7x0iUgxo54kX5jLiEBQ7imBeXRblDMU6hzS7hH3vxGJzrTfIg4iBybrw08BAhIE5lE8pUw==
X-Received: by 2002:a17:902:f690:b0:158:d6ee:b1f9 with SMTP id l16-20020a170902f69000b00158d6eeb1f9mr25232846plg.80.1650550217898;
        Thu, 21 Apr 2022 07:10:17 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id a133-20020a621a8b000000b0050acaab7b29sm6288193pfa.31.2022.04.21.07.10.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 07:10:17 -0700 (PDT)
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
Subject: [PATCH V6 1/8] x86/traps: Move pt_regs only in fixup_bad_iret()
Date:   Thu, 21 Apr 2022 22:10:48 +0800
Message-Id: <20220421141055.316239-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220421141055.316239-1-jiangshanlai@gmail.com>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

