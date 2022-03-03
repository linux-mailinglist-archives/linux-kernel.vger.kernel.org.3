Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404FD4CB590
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiCCDy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiCCDy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:54:57 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A3D1451D0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:54:13 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z11so3392187pla.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 19:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Yli9jTaZ5y64WLdYDskkhp8+lf/DoxMu8sBiimgBJA=;
        b=mhpaiJrkGn+gx6Dv2Kz2rb/ouR7jgkk54f6aM5JApEeVqliV2RSWrkxmuNIbS18wUf
         vvthfgflqzpunGGmbf+p0Y1h5oujMWcMIejuUmKJ9lFK6zyi/J7CwKMmX9S93BHmqfPm
         F5BcRV2/S1mozzgS++Qq53dJBSaAmCBudd8RxLkkw5Q8OI9pzkydq51kD5m8SdWbRwzn
         p4wj6RfFei1LF91VxSS4mi8GNWpYLVzq/I5Is+Juqr+z9+s7DIDM6CPTuMi4vWecEecu
         gqZ1ITVxxgTfkhMxtNSetQC6uwlJZM33VKV6iv002LcpU9iF0eBb7JQ5vw+V+f61nrMk
         BjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Yli9jTaZ5y64WLdYDskkhp8+lf/DoxMu8sBiimgBJA=;
        b=lY6hodNDhBC7mSjpr2IMMob4P57oV1HLItA5z2kTxFqzwWIjQGFoLm7q4PjBEmMiea
         wLUnuQZMfmFt/28qT/hlWKW2NZK4PzMscMk+HxZL9PR+N5DXsv/gPAFAi8wgCJevdUbT
         M42sA73JIfbM/ThfyAlxCbBtxCwnDFYU7DkA0BEVEuLQwb2ZN6bEpyYEjxob6CaDzBof
         v+MKbmHLpgwD/JzRImSnvx4+blri4V+g22785iB2+VxOUCaBs+hmVpvlkSZffj9SdSSS
         WBTqvI4f+1gmmlD2QdBaqMGtTOt2ym0eE/TYJfPkpEY8DHDQj/qDnjcPNSt9CfwJ1AFX
         OC3g==
X-Gm-Message-State: AOAM5329btIm0h3+6zEtetmKsER6s1jkuPReVXooe/nzjSmBWwhM2a8E
        W08ov08D9FeCF2hx9PIYhCJXJv6nzSM=
X-Google-Smtp-Source: ABdhPJwLJWdxe6X5OlH5LZGn99ii3secOEJ8bdFBRTs1P86lIqK9LM8+14eaJWtumbx0Rx4NXmWfPQ==
X-Received: by 2002:a17:903:11d1:b0:151:9fb2:9858 with SMTP id q17-20020a17090311d100b001519fb29858mr4158697plh.136.1646279652833;
        Wed, 02 Mar 2022 19:54:12 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id v12-20020a637a0c000000b0037c5bd8ecfcsm36163pgc.7.2022.03.02.19.54.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2022 19:54:12 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 2/7] x86/entry: Switch the stack after error_entry() returns
Date:   Thu,  3 Mar 2022 11:54:29 +0800
Message-Id: <20220303035434.20471-3-jiangshanlai@gmail.com>
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

error_entry() calls sync_regs() to settle/copy the pt_regs and switches
the stack directly after sync_regs().  But error_entry() itself is also
a function call, the switching has to handle the return address of it
together, which causes the work complicated and tangly.

Switching to the stack after error_entry() makes the code simpler and
intuitive.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 24846284eda5..a51cad2b7fff 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -323,6 +323,8 @@ SYM_CODE_END(ret_from_fork)
 .macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
+	movq	%rax, %rsp			/* switch stack settled by sync_regs() */
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
@@ -980,14 +982,10 @@ SYM_CODE_START_LOCAL(error_entry)
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
 	RET
 
 	/*
@@ -1019,6 +1017,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	 */
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
+	leaq	8(%rsp), %rax			/* return pt_regs pointer */
 	RET
 
 .Lbstep_iret:
@@ -1039,12 +1038,9 @@ SYM_CODE_START_LOCAL(error_entry)
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

