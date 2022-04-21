Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EEF50A1B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388997AbiDUONc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389159AbiDUONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:13:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4B339801
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so5327629pjf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yX2Rm860a2FPnjvkxlraogE+1n6tD0A0599HJAgUvAg=;
        b=jsT0ubLxYr2PAs9MQccEF/bY8DOmorhOBKB14fD8aQWyoKeApKk6LINvqcZMdAwz9d
         nnxKCOmlmkloQeczjlFnH6NDffKoT6LAWZ26v5BnLd/b3APNUiG9XeGPo5xU9sj6i8HL
         7nG3Oa1I61OQsHgJ+YKuoz0/WUh2S3a6PSoxSLvIfjCedec9vordx7W3y1gIQEds43pQ
         bWOcyvv982Wfq+HnaOkv/wy09E85kLwaJRIJVMuErfLU/7fCywmOa30MUf5Eg5LspkEu
         ea9bFfAKBI69Um2hyVLxE1pY3HZb9p5SGp6WKcJSSpz1r6v3SrlGu6K49GbAllDeUMop
         4kZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yX2Rm860a2FPnjvkxlraogE+1n6tD0A0599HJAgUvAg=;
        b=oC6VizmwNeNN7Hgq6leWR+IQ8ZGEScLqGAf68NgI7DGupIoo8whajccDIBzCYrTxn4
         fsH+VauPWwKsJ8reeP5AE3OMb9HegHDPzIthOxIWpbxIj+e7NN9U3BfNbxMqBWBRvYUl
         YIufk0cBjn5c/ymUzz/JFA7SWbQ0dcqf8oRUHmzx10YW5zwIyjTvf2uKmD+b5wa0tiaI
         E1AJCIFA6Jfc18jwqTPauZU3Ut66gdQSvB5h4UNaT+Imy+ZIoIl4T19S8jEQ4F8Msp2S
         kcTMtyL//Cwa4M8+nqmzVX/bW7nrW2tNXhMCS7nS5tpKVlO/WdOzG7WR1YjRY8Oe26B6
         BBfQ==
X-Gm-Message-State: AOAM532sruqnq0HMw6P7JRYepK+KhsELwDDbeNxwECJnoK3JICmUAjR/
        +dI2+RKs6zlnQBC1ytREMsWjO8V0JTc=
X-Google-Smtp-Source: ABdhPJwfysNYrUkSwt0GfUQ2TixKQwWoHFBsUZM/qYLpobWdN/RLLTd6L2lItR6rceTlAxKof9hh7g==
X-Received: by 2002:a17:90b:4c45:b0:1d2:acdc:71d4 with SMTP id np5-20020a17090b4c4500b001d2acdc71d4mr10685468pjb.39.1650550230497;
        Thu, 21 Apr 2022 07:10:30 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id 64-20020a17090a0fc600b001d5f22845bdsm2671853pjz.1.2022.04.21.07.10.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 07:10:30 -0700 (PDT)
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
Subject: [PATCH V6 3/8] x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()
Date:   Thu, 21 Apr 2022 22:10:50 +0800
Message-Id: <20220421141055.316239-4-jiangshanlai@gmail.com>
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

The macro idtentry calls error_entry() unconditionally even on XENPV.
But the code XENPV needs in error_entry() is PUSH_AND_CLEAR_REGS only.
And error_entry() also calls sync_regs() which has to deal with the
case of XENPV via an extra branch so that it doesn't copy the pt_regs.

And PUSH_AND_CLEAR_REGS in error_entry() makes the stack not return to
its original place when the function returns, which means it is not
possible to convert it to a C function.

Move PUSH_AND_CLEAR_REGS out of error_entry(), add a function to wrap
PUSH_AND_CLEAR_REGS and call it before error_entry().

The new function call adds two instructions (CALL and RET) for every
interrupt or exception.  It will allow for error_entry() to be not
called on XENPV which allows for sync_regs() to reduce a branch.  It
will also allow for error_entry() to be converted to C code that can
use inlined sync_regs() and save a function call again.

Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ca3e99e08a44..b1cef3b0a7ab 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -318,6 +318,14 @@ SYM_CODE_END(ret_from_fork)
 #endif
 .endm
 
+/* Save all registers in pt_regs */
+SYM_CODE_START_LOCAL(push_and_clear_regs)
+	UNWIND_HINT_FUNC
+	PUSH_AND_CLEAR_REGS save_ret=1
+	ENCODE_FRAME_POINTER 8
+	RET
+SYM_CODE_END(push_and_clear_regs)
+
 /**
  * idtentry_body - Macro to emit code calling the C function
  * @cfunc:		C function to be called
@@ -325,6 +333,9 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry_body cfunc has_error_code:req
 
+	call push_and_clear_regs
+	UNWIND_HINT_REGS
+
 	call	error_entry
 	movq	%rax, %rsp			/* switch to the task stack if from userspace */
 	ENCODE_FRAME_POINTER
@@ -985,13 +996,11 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 SYM_CODE_END(paranoid_exit)
 
 /*
- * Save all registers in pt_regs, and switch GS if needed.
+ * Switch GS and CR3 if needed.
  */
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
-- 
2.19.1.6.gb485710b

