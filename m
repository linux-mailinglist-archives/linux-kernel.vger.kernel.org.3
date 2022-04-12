Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B604FE125
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354581AbiDLMyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355223AbiDLMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:48:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63D01BE95
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:15:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s137so14360105pgs.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5RIw3Y6iFyQPwywIArOqCVkO5sLf9t/GzdrB82aITI=;
        b=I1wYevuxtaS9lLUaPCx+RCwFaW38RY7DlLemfEmzjcYFDvvTkcgeY1LaNtemO00ecC
         TdSRY0Oa9GNs2MJ/5xNISNYYpP9Rh6s6rAjBpnRvztHk/Gj5hDZUcJlYyGDsYeTb1mCu
         9obdPHkW+ixlUWB+NjAypOeSbA88if21PMufKT61cgY4xWNkOJNJZ8IOq4JuVglNNfG8
         0B2Tu6jrYo6XQcXT100W0X0pE9h8XZfjXenqK2PlsWyfn6frDFzoQpDsnHUXPkYIHNfN
         I7h1WuwXFc6SnAlCga9YYmV5Jdj9oj7pri48IqYeYkFOhNbXGed9UzjoS7zsEI12Pa2+
         /NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5RIw3Y6iFyQPwywIArOqCVkO5sLf9t/GzdrB82aITI=;
        b=n4+1it2mooR1CvW9SxotF5ZQEd/gs/xCwauOy1nHUt23CD+FaeCwkFcE0UFFuDfuRH
         sNF2lWjmoO5Zc+PTeXI2g3AOwTf1E0APdjHicwRbeYILiWQTApReHoaMlvR2BtZQjgoa
         n5Zllqjjo/6eDj4JaFkK8aDUxxQkO5BeiM4rpZrwfjpjJe42dJYWBMVzoQaxTAForkIJ
         BbSoVUTONvyhd+p1pxoXIDof0a1MRZ/9+s4oKBud7R219bcOHU8JFxRrONTywSWIFGHi
         KCnWT6txuow+LJ0tMiz3twgx/QBfwke0ndeMwTXVkVM/GAQlZsTS4sup/MOdupvj3Wny
         5yug==
X-Gm-Message-State: AOAM530DczURmAuVCxQdZvW0PDjAW5qYEBJf7m7gPgtBMh2JAVJViasm
        HwS6hR2Pi+lwdVq2CMdxbiNLn/lmHZg=
X-Google-Smtp-Source: ABdhPJy8cZBru6/sIUb5kyQTBRAn1lSqPhw5iX3k5evZnJuDmrM/zdH2RXN4krEK1uS+vJfcuU6KJw==
X-Received: by 2002:a65:6951:0:b0:381:f10:ccaa with SMTP id w17-20020a656951000000b003810f10ccaamr29687821pgq.587.1649765715900;
        Tue, 12 Apr 2022 05:15:15 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id u18-20020a056a00125200b004fb112ee9b7sm35342414pfi.75.2022.04.12.05.15.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:15:15 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 3/7] x86/entry: Move PUSH_AND_CLEAR_REGS out of error_entry()
Date:   Tue, 12 Apr 2022 20:15:37 +0800
Message-Id: <20220412121541.4595-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220412121541.4595-1-jiangshanlai@gmail.com>
References: <20220412121541.4595-1-jiangshanlai@gmail.com>
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

error_entry() doesn't handle the stack balanced.  It includes
PUSH_AND_CLEAR_REGS which is commonly needed for all IDT entries and
can't pop the regs before it returns.

Move PUSH_AND_CLEAR_REGS out of error_entry() and make error_entry()
works on the stack normally.

After this, XENPV doesn't need error_entry() since PUSH_AND_CLEAR_REGS
is moved out and error_entry() can be converted to C code in future
since it doesn't fiddle the stack.

The text size will be enlarged:

size arch/x86/entry/entry_64.o.before:
   text	   data	    bss	    dec	    hex	filename
  17916	    384	      0	  18300	   477c	arch/x86/entry/entry_64.o

size --format=SysV arch/x86/entry/entry_64.o.before:
.entry.text                      5528      0
.orc_unwind                      6456      0
.orc_unwind_ip                   4304      0

size arch/x86/entry/entry_64.o.after:
   text	   data	    bss	    dec	    hex	filename
  26868	    384	      0	  27252	   6a74	arch/x86/entry/entry_64.o

size --format=SysV arch/x86/entry/entry_64.o.after:
.entry.text                      8200      0
.orc_unwind                     10224      0
.orc_unwind_ip                   6816      0

The tables .orc_unwind[_ip] are enlarged due to it adds many pushes.

But .entry.text in x86_64 is 2M aligned, enlarging it to 8.2k doesn't
enlarge the final text size.

And it will only increase the footprint when different interrupts and
exceptions happen unlikely heavily at the same time.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e1efc56fbcd4..835b798556fb 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -325,6 +325,9 @@ SYM_CODE_END(ret_from_fork)
  */
 .macro idtentry_body cfunc has_error_code:req
 
+	PUSH_AND_CLEAR_REGS
+	ENCODE_FRAME_POINTER
+
 	call	error_entry
 	movq	%rax, %rsp			/* switch to the task stack if from userspace */
 	ENCODE_FRAME_POINTER
@@ -987,8 +990,6 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
-- 
2.19.1.6.gb485710b

