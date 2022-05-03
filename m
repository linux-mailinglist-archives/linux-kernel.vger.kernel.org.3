Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07248518CCB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240823AbiECTFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241415AbiECTEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:04:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D772C139;
        Tue,  3 May 2022 12:01:08 -0700 (PDT)
Date:   Tue, 03 May 2022 19:01:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651604466;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OumlaU28lzkih11meghn2+Sg/F9ZBPslQJhsTtBhFXY=;
        b=TXXHGX4HF05N8nkBrzYv4JMU9bHq9GFhCfrlxqF5lUDaXgxNEyiuX1+D+KWxyAGXthz39h
        K8cJ/zAzTYzaOcS5GY9wz/Mce5hDlBQPxFHEYpA0dooHBUcTK8hW4CxeWdMXYLRSguLxhC
        tMgjX1KM7p0Z3PmyiJpbGQpmOLmTIe/EFSnebFbD7gb1OPEIpoSpxTBnlHfPTn6whyI6LV
        tBeLTQmLWyFsBZaD5tsEZClQHXerWhC2bKwpqkglbE+D7J1x9z/xj+R4JF8q7Zh1+qtqRF
        1tSIuE2lTjfAmaMyTzfHqRL/P28HGb7Dfws9XzmBP+j3nV0j1kDlW8LwhXiS6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651604466;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OumlaU28lzkih11meghn2+Sg/F9ZBPslQJhsTtBhFXY=;
        b=TKCs3fGHx57/zv2qVQP3kKnkGNWlm4KuUqorB9YoIaZQ8q6Y+u9Ao33rYlQbVvi3nYoJlQ
        3s1FEPgEzt63E4Cw==
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Borislav Petkov <bp@suse.de>, Juergen Gross <jgross@suse.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220503032107.680190-4-jiangshanlai@gmail.com>
References: <20220503032107.680190-4-jiangshanlai@gmail.com>
MIME-Version: 1.0
Message-ID: <165160446526.4207.9233904078820341765.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     ee774dac0da1543376a69fd90840af6aa86879b3
Gitweb:        https://git.kernel.org/tip/ee774dac0da1543376a69fd90840af6aa86879b3
Author:        Lai Jiangshan <jiangshan.ljs@antgroup.com>
AuthorDate:    Thu, 21 Apr 2022 22:10:50 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 03 May 2022 11:42:59 +02:00

x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()

The macro idtentry() (through idtentry_body()) calls error_entry()
unconditionally even on XENPV. But XENPV needs to only push and clear
regs.

PUSH_AND_CLEAR_REGS in error_entry() makes the stack not return to its
original place when the function returns, which means it is not possible
to convert it to a C function.

Carve out PUSH_AND_CLEAR_REGS out of error_entry() and into a separate
function and call it before error_entry() in order to avoid calling
error_entry() on XENPV.

It will also allow for error_entry() to be converted to C code that can
use inlined sync_regs() and save a function call.

  [ bp: Massage commit message. ]

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20220503032107.680190-4-jiangshanlai@gmail.com
---
 arch/x86/entry/entry_64.S | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index ca3e99e..b1cef3b 100644
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
 
