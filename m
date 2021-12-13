Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A274472FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbhLMPDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhLMPDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:03:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECEBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:03:42 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so11362427plf.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hJwijpzMhoemmdJvFmudMWTP4Nq09IHw0RlJ2NYTKQg=;
        b=m2aQ0wzohjpaPwlk/4/TI5NJL6Lx7UhjeG4Zai2SEpGab/FNLp9XabPLjj2UdD5eK5
         rLOR2cqrjSYknAWnEBh0MtSC3zI9XrKk1Ckwyfak/ceHCnKKXuhB94OiiGjZjxUJCqQF
         gtR15Z9IdgaeFYOlnzramri+90L8o00EefpR7/ZJxmKcOv/m4XXPvUSz6eiNAaCkf2J0
         DW8Pz//GO7J2gsksWiWPjuG8TigOv0jpD5Z3au7xRlDk2niss3JLUlHflQ4IdKijizRm
         xBjlZxOWsfqhZGCJb4euThUaqkNJZZnmDi0IrIH31k4Ur98XSrOaDmmXGnfxnSqvfPBO
         8PwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hJwijpzMhoemmdJvFmudMWTP4Nq09IHw0RlJ2NYTKQg=;
        b=3NJF8JaHDHTBOgxLUKZIbgMQ/gWg0M/WVSPLk4NArWAiQLAi67pem7GhUnD40jPFde
         KI5ucFVAXjtB9GS55ljCGQ+2rKNcGF0qJveDEuyX0lTB5hEBQCKb0L5sdDR9pf7+N2dG
         iFiCS9c80psTjbnArJz00WNTtXsI4neczWHUwNhXOmL1v2YMqTlJeWuXSNMOCQfqEvMO
         /GgT0HKv09ULMe01CDOMibB0nMK/XIJVd9FQpGgxZ6zL4lESIn+pGGwf2zjPQKFr+Tr8
         8IJfhSP6oyC/BEioKLHwEQl/VraW6IpIefS5Rd+aic/WTn8sEkeN4kdawqOG31wjNTXY
         mAdw==
X-Gm-Message-State: AOAM533TGjqr/XpB9x2qe/Wnl9ePypariePezHSsBbWd7dHbesSarVf7
        +fBMny6oV9Ud3jGmIyUWf1tHOQKZq1vAmQ==
X-Google-Smtp-Source: ABdhPJxXu0A5a8i0U7P1Xp1pTWPaWZRx7VeHb/8o793TBGJdQUk8tYJkUM2Jo4OpryjdU9GuA7nwcA==
X-Received: by 2002:a17:90b:1d83:: with SMTP id pf3mr44985333pjb.5.1639407822005;
        Mon, 13 Dec 2021 07:03:42 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id l186sm10536763pga.24.2021.12.13.07.03.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 07:03:41 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/4] x86/entry: Call paranoid_exit() in asm_exc_nmi()
Date:   Mon, 13 Dec 2021 23:03:38 +0800
Message-Id: <20211213150340.9419-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211213150340.9419-1-jiangshanlai@gmail.com>
References: <20211213150340.9419-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The code between "call exc_nmi" and nmi_restore is as the same as
paranoid_exit(), so we can just use paranoid_exit() instead of the open
duplicated code.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 34 +++++-----------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3dc3cec03425..47ff4abd87b5 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -920,8 +920,7 @@ SYM_CODE_END(paranoid_entry)
 
 /*
  * "Paranoid" exit path from exception stack.  This is invoked
- * only on return from non-NMI IST interrupts that came
- * from kernel space.
+ * only on return from IST interrupts that came from kernel space.
  *
  * We may be returning to very strange contexts (e.g. very early
  * in syscall entry), so checking for preemption here would
@@ -1354,11 +1353,7 @@ end_repeat_nmi:
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 
 	/*
-	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
-	 * as we should not be calling schedule in NMI context.
-	 * Even with normal interrupts enabled. An NMI should not be
-	 * setting NEED_RESCHED or anything that normal interrupts and
-	 * exceptions might do.
+	 * Use paranoid_entry to handle SWAPGS and CR3.
 	 */
 	call	paranoid_entry
 	UNWIND_HINT_REGS
@@ -1367,31 +1362,12 @@ end_repeat_nmi:
 	movq	$-1, %rsi
 	call	exc_nmi
 
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
-
 	/*
-	 * The above invocation of paranoid_entry stored the GSBASE
-	 * related information in R/EBX depending on the availability
-	 * of FSGSBASE.
-	 *
-	 * If FSGSBASE is enabled, restore the saved GSBASE value
-	 * unconditionally, otherwise take the conditional SWAPGS path.
+	 * Use paranoid_exit to handle SWAPGS and CR3, but no need to use
+	 * restore_regs_and_return_to_kernel as we must handle nested NMI.
 	 */
-	ALTERNATIVE "jmp nmi_no_fsgsbase", "", X86_FEATURE_FSGSBASE
-
-	wrgsbase	%rbx
-	jmp	nmi_restore
-
-nmi_no_fsgsbase:
-	/* EBX == 0 -> invoke SWAPGS */
-	testl	%ebx, %ebx
-	jnz	nmi_restore
-
-nmi_swapgs:
-	swapgs
+	call	paranoid_exit
 
-nmi_restore:
 	POP_REGS
 
 	/*
-- 
2.19.1.6.gb485710b

