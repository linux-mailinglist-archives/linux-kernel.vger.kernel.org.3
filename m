Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE950A1BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354323AbiDUONq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388989AbiDUONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:13:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE3B39801
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j17so5111469pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xotWSQoi2wlC3vMI8lQ8RpO96nR6JNjKt6GYA46wjrE=;
        b=pjNI1Q77AFi1u+2joRb0n9LSA4X44lF8YcvmFtsrruF/a/zCTo5TK5y5YqePbWVxmY
         YDSgkD0uIWOyy7ksc2kRKGtVYubOS13sQfyEuXJbnEK0YJDWcJoT+OmXPHMy98yL4j+x
         d4FoRqX/+hfZLxwgwm7E6TeDCZAeeMjiv7S1yhN2Jh+RD63jE/7FSBMKwGd2mXdDL1gV
         TIgcQOM12/b/8RA3t0DpMZG++C5r47qKmKNHTU5vPGvRX4G0tBUbGcF4dzP1ZgNLVph7
         D+H9ZItAjMy7kOGJL+RueOqGvZIAiJCHxzxlgxK669spcxZYaRBf1zQwsrMdtwO/Q8Om
         6hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xotWSQoi2wlC3vMI8lQ8RpO96nR6JNjKt6GYA46wjrE=;
        b=t6d59nKsoP7NwUHExNMMFXNqNwqtRUYWAVjHZaUVzxE9A0cuO/SPlnr6Jh6bGba3LV
         b2AtsdTMeqLREEXsAdPoNgTvdAn84C3mYufUCoy8WhJhbD7FnF6SVS+ox7K8Flcx9Jxy
         MkfECstBaKDL33ZmIbWOhjP2iMw3UzNktc6OAvaZQ2twKjh8+Nm2M1p2/VJsxy+vBQ5o
         7/mVSEwt4JMmTgNKpjMlO1hnjbDCsUiOOlqND6l4K+vxMspKvPYm9KdeqEJ8uTkTv8em
         cdy1Th48uKJkYViZh/aSVqxFktkacUoIxEkc+3K0Z7vrDSCZo8QwuNpbF3Owbx0QpFk6
         PnGg==
X-Gm-Message-State: AOAM530NHXdaozUefqrIrTQ+CDgCD8lB0opQotv2/bMpoiWoH79QSlX9
        B4DGXDx1NRffJMD6fmPbFhCkb/X24F0=
X-Google-Smtp-Source: ABdhPJw83mvSMViR2B7qB7NFwgKLwu8gRFDFTiq5fcykxX1b8HibPFkvTIxPGHXq7xlNZ+v659WgSg==
X-Received: by 2002:a63:4945:0:b0:398:efe8:3b7a with SMTP id y5-20020a634945000000b00398efe83b7amr24313534pgk.106.1650550236962;
        Thu, 21 Apr 2022 07:10:36 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id i1-20020a17090a650100b001cd8e9ea22asm2908963pjj.52.2022.04.21.07.10.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 07:10:36 -0700 (PDT)
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
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 4/8] x86/entry: Move cld to the start of idtentry macro
Date:   Thu, 21 Apr 2022 22:10:51 +0800
Message-Id: <20220421141055.316239-5-jiangshanlai@gmail.com>
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

Make it next to CLAC

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b1cef3b0a7ab..ab6ab6d3dab5 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -371,6 +371,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ENDBR
 	ASM_CLAC
+	cld
 
 	.if \has_error_code == 0
 		pushq	$-1			/* ORIG_RAX: no syscall to restart */
@@ -439,6 +440,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
+	cld
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
 
@@ -495,6 +497,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
+	cld
 
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
@@ -557,6 +560,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ENDBR
 	ASM_CLAC
+	cld
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
@@ -882,7 +886,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
@@ -1000,7 +1003,6 @@ SYM_CODE_END(paranoid_exit)
  */
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
-	cld
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1134,6 +1136,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	ASM_CLAC
+	cld
 
 	/* Use %rdx as our temp variable throughout */
 	pushq	%rdx
@@ -1153,7 +1156,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	swapgs
-	cld
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-- 
2.19.1.6.gb485710b

