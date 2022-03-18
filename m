Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0684DDBAF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 15:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbiCROb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 10:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbiCRObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 10:31:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4986055762
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:30:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q11so7063031pln.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WziS7bteCF6OfCEG8hp7WEVcZ4348Ta3b20GTAdH5KI=;
        b=ZEhWZACLHxqTLH9utNg7Z8OomwzUzraDSzrpwJkJIgzkNvWGAIhv7fkLT21sXh3BJW
         jdCGsUvbEHpcweTLQWRqXg5KK6NEWO3c5aCDip+yn8LvGIyy1ZV7pN45eycvqSgoo2cU
         71QT9HlpYH7sYUa8GrguzxJtUuwWl4XvpgTlmr7sEMQEcseY+7jUFdtVg7+JnpWUmdjM
         6/wU2v55PUVh9LNJuzCSzR6rH7eeixldZ0I+tl8sTq5STShvjUCt1wg94dpFAaj3x4zn
         oTzfmVtrQIrkRkQOjtBoSdAtujsdoq1tKzjmX+KsoF9F84n3WLALnP5MARtn6w11ZVRu
         vuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WziS7bteCF6OfCEG8hp7WEVcZ4348Ta3b20GTAdH5KI=;
        b=4VGI5PXlWniOUOjVexCi0biXQqamU7OCv2/MKTZN5RMSMg7zgBvJr4UUqOt32igNI+
         LeWoU7lnr3kEpah8vdfNH8x1wQYrECkNUvZmdPn728l+c1RoDTBPvMJVlPnr5s0ucOto
         tY5l2jBe5orwIxvvKQ8TwnAqOjCdm8n7HETN+znsrztQMgfLwaciGtGUJZbzO35Ux9EC
         M+d3ha8OWp7P2r4tQt7J/R9eaugtI5JeheL0za9QpY5mhOVNNFOA58i6TymqctZR5ghu
         sSQ9XZkkpI0bc7iYYf1tK3M7EgfrNpLYb+q8wVk2bpaCj7MQPiQL2BBy378QFvmi9OTH
         w5IA==
X-Gm-Message-State: AOAM530CBWnaHuSu74c836WfOma9Lt1dGpXewMG17vA7be9Dvw83UReP
        /ldBw24issOosMtPbWSaJusUDPU+b1s=
X-Google-Smtp-Source: ABdhPJw0EGjT0/O0eTquz0IWAjnnJetq7f59azUestepDvLoL7Jg/QcGTDMQhIM9DQEcAq7Ab0oCWg==
X-Received: by 2002:a17:90b:4b0d:b0:1bc:4cdb:ebe3 with SMTP id lx13-20020a17090b4b0d00b001bc4cdbebe3mr11495485pjb.176.1647613804470;
        Fri, 18 Mar 2022 07:30:04 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id o27-20020a63731b000000b0038232af858esm1349379pgc.65.2022.03.18.07.30.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2022 07:30:04 -0700 (PDT)
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
Subject: [PATCH V4 4/7] x86/entry: Move cld to the start of idtentry
Date:   Fri, 18 Mar 2022 22:30:13 +0800
Message-Id: <20220318143016.124387-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220318143016.124387-1-jiangshanlai@gmail.com>
References: <20220318143016.124387-1-jiangshanlai@gmail.com>
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
index 666109d56f6b..8121b9f3fceb 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -360,6 +360,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ENDBR
 	ASM_CLAC
+	cld
 
 	.if \has_error_code == 0
 		pushq	$-1			/* ORIG_RAX: no syscall to restart */
@@ -428,6 +429,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
+	cld
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
 
@@ -484,6 +486,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ENDBR
 	ASM_CLAC
+	cld
 
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
@@ -546,6 +549,7 @@ SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ENDBR
 	ASM_CLAC
+	cld
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
@@ -871,7 +875,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
@@ -989,7 +992,6 @@ SYM_CODE_END(paranoid_exit)
  */
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
-	cld
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1123,6 +1125,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	ASM_CLAC
+	cld
 
 	/* Use %rdx as our temp variable throughout */
 	pushq	%rdx
@@ -1142,7 +1145,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	swapgs
-	cld
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-- 
2.19.1.6.gb485710b

