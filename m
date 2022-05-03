Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6460D517C38
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 05:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiECDYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 23:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiECDYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 23:24:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2E533E0A
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 20:20:52 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h1so13739739pfv.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 20:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x61TjLKwnlPP/1Q/z1UHB85PFlxeFJXks6RYgmVkwuc=;
        b=iXYClFs+HWZ4g95as2fyx9dN6umKDVfdPfMOgeeXq1YD+Crki+bpt7fhpQ4rcCe/VX
         mADF6JsQl3FLiqepNL/BA7AB0vXrUxTtOGj9Z/sSEqtKqbyMifwxk47RG0ZTnWxSzHJe
         bZ4XgjrHfcNMlq/Y+Ao2ao8wNz1pb8PWjdFtbDbnYxwKRdHn6u6BbZ4cqr7XOSh4Jj1B
         KpxrPqAnTsSP2aUHBAlewzK2SwgqHEItUjSD3FT4vjsHkU1DZOWb3sGomgCatb76wBrn
         Bh4YC2ryd9RNUBhjXRJXelmWBk8ct2Mhbc3Llxzmhb4s4RN+8gIDRpZXXXxyb3nNNUBw
         Ex6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x61TjLKwnlPP/1Q/z1UHB85PFlxeFJXks6RYgmVkwuc=;
        b=aSHhkWdovUVGoW4t5qQFH3BqfmRLfDOXbtSk6R78ZQvAkMF4MHVRCX/2ZRgpQYiWyX
         jiaXREEuBCxS6dsjJsSSoHhIacId9f2j3MyhPCBt2susRPB13ZacqOG4TYZUCD2s6Ael
         P4NRHsfvlJlJx8S1mP0xiPfSEptT6SgxBJskJ4Co8RC+0SxgoU8VxxEAEaJoZ0ZYy7QG
         Taikgtr1r9t18fJXf6w9zS1fdECAOCu77pRYk2FWlZlnVWn0K4zy9eQCdi8rb5IlRiaZ
         zWe2ID8PEZ9aqIxwmiAjmL/ZojpkerfBPdIE8VIeI7UFApbpgwTapGx1gPe5FvRwbgcK
         uxPQ==
X-Gm-Message-State: AOAM5313kMKI/vOK5dqGxPSxF9M+/DiTqkCTku4X3mvQNLIqDZ5wMEad
        VnfA+8SCIt+HWQ3ccNSKoT3x4hTVfkw=
X-Google-Smtp-Source: ABdhPJwIJaYiXyDx8XCMWi6AiESvXSZzHhrbf5VnJ2C4/dkUn4HNJwq/+9PI8RUCXpaA6TSn/z+jPw==
X-Received: by 2002:a05:6a00:1352:b0:50d:ecff:f06c with SMTP id k18-20020a056a00135200b0050decfff06cmr7592097pfu.6.1651548051873;
        Mon, 02 May 2022 20:20:51 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id z21-20020aa791d5000000b0050dc76281ddsm5395704pfa.183.2022.05.02.20.20.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 May 2022 20:20:51 -0700 (PDT)
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
Subject: [PATCH V7 3/6] x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()
Date:   Tue,  3 May 2022 11:21:04 +0800
Message-Id: <20220503032107.680190-4-jiangshanlai@gmail.com>
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

The macro idtentry calls error_entry() unconditionally even on XENPV.
But the code XENPV needs in error_entry() is PUSH_AND_CLEAR_REGS only.

And PUSH_AND_CLEAR_REGS in error_entry() makes the stack not return to
its original place when the function returns, which means it is not
possible to convert it to a C function.

Move PUSH_AND_CLEAR_REGS out of error_entry(), add a function to wrap
PUSH_AND_CLEAR_REGS and call it before error_entry().

It will allow for error_entry() to be not called on XENPV and for
error_entry() to be converted to C code.

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

