Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE426472FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbhLMPDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbhLMPDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:03:35 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC36C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:03:35 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id r130so15215791pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItSUmJxyBLtb2r60ddS30nw2ro+BC+I1KbynkWffoWM=;
        b=MUWg3e4EHO3QCDI3YmVm/qEXv6rw1HV8bNsBsPR+IhV0uZ9+WAwvm4BBK9G7w2zML4
         cxJJ4XjBju17fWvvbjV1fRerTz7tg+IFgK+HzGMaKHI1d+e3EcoueV2btCy1nMq58H1E
         rkRUe4O4AMBc0zxWjyRYCgM5+H19+tKBzP4xS8iCsvdvuCbISUVKh2mlLIjENPovrjOR
         /5ETaBIlzTaxWw9ye19qHljOS7nTvKydWGGnfyAB700QnZ8NHqAQrrAvIe48mIYy+idb
         5CpSUj+6DgGxm8CUFFkKwgP3NiAXGCDDtr0NWoBteBriM02nFKP4qWk4v/Q2wrAa+ehj
         uAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItSUmJxyBLtb2r60ddS30nw2ro+BC+I1KbynkWffoWM=;
        b=rFn+wBe3O/UJMWvHzyF0buKQcX76aSLC0uS2JF4qLumXMI3DcxnWVYbeaQXozaGdem
         y3tfkSp+b2CChF1FAwsXSECUGqMIUONB1ofIdp+tZrk8ZRM12DtgvpWu88nMB4nI0QQQ
         pSvD0tnZTgxd69gBDfSSl9gswzlb2Vzs3KZpW5fwdsK6SuHN9FsFHbBPdM6kZwsYAPk7
         31YTYI21rHVZWfkFbEAkFD3vnOyA5xoL+Gj4vK2VVL04d9JMUCcltqn4Ja2NxAESlfTj
         UCl70ZISwY4p4dORlfI6jL0CcWmoVMPXVDgFG3R0Kb4Vf4YEGmds6M+xyBRR9hZkG/FI
         jegQ==
X-Gm-Message-State: AOAM531CCP4UNY66z17jAiJu5fH9ri96bn3Ux6hDjo+X+cvNjMnuBut8
        BliDnAY+Xs3q7LIPBKsia4zE5dVpggkLXg==
X-Google-Smtp-Source: ABdhPJxiOC5J58a1ZhGHLleG+AjyNXeyVmUAtQu7IsllSWlEHzjLN3UjNwoMPCl4ZJCGIk4rY9v36w==
X-Received: by 2002:a65:654f:: with SMTP id a15mr53389946pgw.195.1639407815116;
        Mon, 13 Dec 2021 07:03:35 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id j16sm14753973pfj.16.2021.12.13.07.03.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 07:03:34 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/4] x86/entry: Make paranoid_exit() callable
Date:   Mon, 13 Dec 2021 23:03:37 +0800
Message-Id: <20211213150340.9419-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211213150340.9419-1-jiangshanlai@gmail.com>
References: <20211213150340.9419-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Move the last JMP out of paranoid_exit() and make it callable.

It will allow asm_exc_nmi() to call it and avoid duplicated code.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 44dadea935f7..3dc3cec03425 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -439,7 +439,8 @@ SYM_CODE_START(\asmsym)
 
 	call	\cfunc
 
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
@@ -516,7 +517,8 @@ SYM_CODE_START(\asmsym)
 	 * identical to the stack in the IRET frame or the VC fall-back stack,
 	 * so it is definitely mapped even with PTI enabled.
 	 */
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack */
 .Lfrom_usermode_switch_stack_\@:
@@ -546,7 +548,8 @@ SYM_CODE_START(\asmsym)
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
 	call	\cfunc
 
-	jmp	paranoid_exit
+	call	paranoid_exit
+	jmp	restore_regs_and_return_to_kernel
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -935,7 +938,7 @@ SYM_CODE_END(paranoid_entry)
  *     Y        User space GSBASE, must be restored unconditionally
  */
 SYM_CODE_START_LOCAL(paranoid_exit)
-	UNWIND_HINT_REGS
+	UNWIND_HINT_REGS offset=8
 	/*
 	 * The order of operations is important. RESTORE_CR3 requires
 	 * kernel GSBASE.
@@ -951,16 +954,17 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 
 	/* With FSGSBASE enabled, unconditionally restore GSBASE */
 	wrgsbase	%rbx
-	jmp		restore_regs_and_return_to_kernel
+	ret
 
 .Lparanoid_exit_checkgs:
 	/* On non-FSGSBASE systems, conditionally do SWAPGS */
 	testl		%ebx, %ebx
-	jnz		restore_regs_and_return_to_kernel
+	jnz		.Lparanoid_exit_done
 
 	/* We are returning to a context with user GSBASE */
 	swapgs
-	jmp		restore_regs_and_return_to_kernel
+.Lparanoid_exit_done:
+	ret
 SYM_CODE_END(paranoid_exit)
 
 /*
-- 
2.19.1.6.gb485710b

