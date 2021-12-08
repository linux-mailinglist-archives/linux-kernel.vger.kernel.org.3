Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D1E46D19A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhLHLMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhLHLMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:12:14 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05557C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:08:43 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id k26so2128548pfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 03:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=74fcl84eMF3trMMN2JVz1x4AFBWc9HU1GFAGLmUM5eE=;
        b=VKlr4hE6P3/KVxbIhcLJDA0sF52nL0lnTLSlQue1EOi6nOPZmlq7+N6t34Z4nlAn6S
         6NYswFiLZFVt72m7dLmKsXjcv49Tzn4Vfnpcat4WRibMq/7lLfmYUvxqlDrF2qI/vqdA
         5aiicTqsTeo5rZI/iqEDgXPe0X06ShRim5daAufoj+27dBC6vjm3F6QWqdhhrBeccdlx
         vioUF/TKnCwOTAFHjtjXkA2ZHEBTUJBfBC9YS2QXCQak02LJEkZyHt3r3mxI7EG3xklk
         0XSnYu5Z2L1fze0kQgB0lt62j14Jn3CZPbd5zi5beWbTOrpQnWraqlF9nD9BmgP3hxz8
         xxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=74fcl84eMF3trMMN2JVz1x4AFBWc9HU1GFAGLmUM5eE=;
        b=yx0NqUKp1QeKqGOirE0FASlMt/WQ49qR23OG3klt3vCsTgcO41GNwBUmKqcU7Kbmjx
         JKLX5H+qabTOeltc5jU3uVmhT4LIT+f3kXf3IMZFnqFApkpP8t824NTt2Ag6K9Nukcw7
         f5CdXSu7DnFY1bj/3or3Rlu0H7FVnd0a4PeGNt1d+l4/j9V9PTkag+DAz66rhRkLhvEL
         +KxjQFdVQPT49kDNjoNAAmMGNPiX+5TLu/iSyxVIdA/1EJvXEkzu1TslLe9rfyilx2oN
         Gb73FPECXpsf1ugTkUVpFxZmOz7Kl1+bLECt4NRurcx+Lj99P5OSCt8OH1+Q7+NvbZMW
         zLqQ==
X-Gm-Message-State: AOAM532KdX5meCGviIANW2ME2UCJpHPtkDczEOxpLocXECmy9qtbzr+y
        onLrwj7txWUG0msqIq9x0rdhaBAimXI=
X-Google-Smtp-Source: ABdhPJwdwD0NWVFtmrZKBdCkBw1nVwlMCHpLBoT9j05zLnwJyoppx7uciS4Kg9RdTDjqkCWrZh05WA==
X-Received: by 2002:a63:e43:: with SMTP id 3mr29449478pgo.73.1638961722423;
        Wed, 08 Dec 2021 03:08:42 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id a16sm2254924pgm.57.2021.12.08.03.08.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 03:08:41 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 03/11] x86/entry: Switch the stack after error_entry() returns
Date:   Wed,  8 Dec 2021 19:08:25 +0800
Message-Id: <20211208110833.65366-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211208110833.65366-1-jiangshanlai@gmail.com>
References: <20211208110833.65366-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

error_entry() calls sync_regs() to settle/copy the pt_regs and switches
the stack directly after sync_regs().  But error_entry() itself is also
a function call, the switching has to handle the return address of it
together, which causes the work complicated and tangly.

Switching to the stack after error_entry() makes the code simpler and
intuitive.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f8faff3ca61e..6baa7413f7eb 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -323,6 +323,8 @@ SYM_CODE_END(ret_from_fork)
 .macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
+	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
@@ -981,14 +983,10 @@ SYM_CODE_START_LOCAL(error_entry)
 	/* We have user CR3.  Change to kernel CR3. */
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
 
+	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 .Lerror_entry_from_usermode_after_swapgs:
 	/* Put us onto the real thread stack. */
-	popq	%r12				/* save return addr in %12 */
-	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
 	call	sync_regs
-	movq	%rax, %rsp			/* switch stack */
-	ENCODE_FRAME_POINTER
-	pushq	%r12
 	ret
 
 	/*
@@ -1020,6 +1018,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 */
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
+	leaq	8(%rsp), %rax			/* return pt_regs pointer */
 	ret
 
 .Lbstep_iret:
@@ -1040,12 +1039,9 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * Pretend that the exception came from user mode: set up pt_regs
 	 * as if we faulted immediately after IRET.
 	 */
-	popq	%r12				/* save return addr in %12 */
-	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
+	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 	call	fixup_bad_iret
-	mov	%rax, %rsp
-	ENCODE_FRAME_POINTER
-	pushq	%r12
+	mov	%rax, %rdi
 	jmp	.Lerror_entry_from_usermode_after_swapgs
 SYM_CODE_END(error_entry)
 
-- 
2.19.1.6.gb485710b

