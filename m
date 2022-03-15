Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EBB4D9579
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345542AbiCOHlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345589AbiCOHlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:41:03 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD1B4B853
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:39:47 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id u17so16124485pfk.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DWK/XTWgXvQZrveqfBhyRmFNTbe4j+HdjdwbIGTRxxk=;
        b=mfDT8vFJmN9G2/6m4sTwQrGlFRG4zcNQd/FkhNb0O1AvNwki5P+PMvvXcq7j1tFa/t
         D+hebPoBq+BNdUSQKw5S3kW+Os5FnlW95ewCsYVaQPACovR6wSB7+Q5pS8BQqDKS1CC/
         DXNWIVNczWAU3T2BhZJTjqCrWdJ3ZQQBUdzrabFezsBA5eIaOlZo0wwFG4AxExkAFq8S
         hZSLd2O1tS34WIzD0BVXIxF4kxC4+RxPdEJVU5N05XHVAK+t0TqHpPsgv7jBDXqmrt/b
         oAkUhd1Dt1r3rNl7KELlmLp+JTHpdUeCDFkPEKoRwMUp9Ic4Cn2E49XPnU3Zh9ziLq+E
         +LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWK/XTWgXvQZrveqfBhyRmFNTbe4j+HdjdwbIGTRxxk=;
        b=6NG6WFmWb2GjV6wSc8tWGn1ZbpcK6gZMYQ3h2KGx+lN0wsTbQXlNhwlCOFC6pe6YJ4
         DFAiF79dhKkn2nxmSsgXpJswCzWrvB21uKa+UvGkjNHXMHAjNRnXnbABQJHOECdwmcHa
         OBzuvFHw9NGFBSxIJdHHGMCYu3N8YH28R2j7zBB6jcUpyPzTzZssxR6Dm3QPeb61mVCY
         HdYYu/PwlbMh46eOqzpvuRrhTFGD3YKE01A5Gv23OEvMmoe1Oiu6EdTqGyg8vOnugim4
         2gEdZBrfz4mecIwMi71Zo9bO1fiid9iJuZya60ZtgS22rrFi0G+ObM5bIeue4iYy+WF7
         o1zg==
X-Gm-Message-State: AOAM533/8ld0osu3/9pT+0yBDChIB8acEGaULho1gds/9ardEL65pXj4
        eYCweL7Gzzu8wzEJBvA2n1KiqVaacQw=
X-Google-Smtp-Source: ABdhPJyQvrgJWZ2unWQKfqZsh9FFF4as/wfSFGiIyM/g/Vt+U3MG3RkDLCSD42eyczsYZXs6klc1vQ==
X-Received: by 2002:a05:6a00:2311:b0:4e1:52bf:e466 with SMTP id h17-20020a056a00231100b004e152bfe466mr27189712pfh.77.1647329987055;
        Tue, 15 Mar 2022 00:39:47 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id ay5-20020a056a00300500b004f6d510af4asm20992174pfb.124.2022.03.15.00.39.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Mar 2022 00:39:46 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 5/7] x86/entry: Move cld to the start of idtentry
Date:   Tue, 15 Mar 2022 15:39:47 +0800
Message-Id: <20220315073949.7541-6-jiangshanlai@gmail.com>
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

Make it next to CLAC

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 903da9119e7a..e4a07276fd1c 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -360,6 +360,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ENDBR
 	ASM_CLAC
+	cld
 
 	.if \has_error_code == 0
 		pushq	$-1			/* ORIG_RAX: no syscall to restart */
@@ -446,6 +447,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
+	cld
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
 
@@ -502,6 +504,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
+	cld
 
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
@@ -564,6 +567,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ENDBR
 	ASM_CLAC
+	cld
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
@@ -886,7 +890,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
@@ -1004,7 +1007,6 @@ SYM_CODE_END(paranoid_exit)
  */
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
-	cld
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1138,6 +1140,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	ASM_CLAC
+	cld
 
 	/* Use %rdx as our temp variable throughout */
 	pushq	%rdx
@@ -1157,7 +1160,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	swapgs
-	cld
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-- 
2.19.1.6.gb485710b

