Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8DA4FC800
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiDKXNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbiDKXNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5AE813F44
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649718662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2as6mtjudVOiULeslyVkRAt6GRQ4WTx58TIfrx090XI=;
        b=HPydSBjRNEtMxMXCC+lPuVm81zRcbV1qpSXRuy0oo7Ue+C4cEGN2YPWV4kGZ7jqhaUlNYG
        dwItw9uf6FTeD2kHzAXLWOkS6CEDx7Z/0eNtE8+/PfSIUGj4zUZLFlGkjsRaoJXlm9mkAf
        Ch1wFVnaUMQ105PnYx57wx0KMBhqvQU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-L5lcuskKNQORyQZ7aEA89g-1; Mon, 11 Apr 2022 19:11:01 -0400
X-MC-Unique: L5lcuskKNQORyQZ7aEA89g-1
Received: by mail-qv1-f69.google.com with SMTP id 33-20020a0c8024000000b0043d17ffb0bdso16897174qva.18
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2as6mtjudVOiULeslyVkRAt6GRQ4WTx58TIfrx090XI=;
        b=Vg/vUDm2lXdmiSiVaTUOy1FqQngO5/5v80OMMMlVtQYczn0vJRdN+tqHavztsvGOkQ
         sWb9xu7Klu81+njP/n02DueaAxUppgeI7cEoYgv98JZ8F0pSbtKfuU8NK1cPsrAWmRJ4
         /MecldN3rLvlDbNMHn44mGOx4A7OLrAurxJUpZ7wEECTUwOwDyyStodu8dr5sA45YmFV
         hcnyFABSNqvl4xixy8w4VeJwjGQUhMeCFjS3PMEos7AW3+CtQNw+a6t3Lmyt2/QfR6b6
         BwT6eyJdb3TpiXKii1/c0eEHHhXR1Po/mRod1Z3rivpdt01qfuLG66aX9e9KnaEVuGPl
         1iLg==
X-Gm-Message-State: AOAM531meWu8fbUePqdVnz2p2rr+BKNn3AQo6NPxf109VdOCnwIDZLLr
        nMXBncNWKnxnYUb4cij032zeb0NsQtWRJIGy8DFB1uAFSTbfReQV/5gne6d4Wp5OwpmA/F1MpVY
        NBsliT/xedNalLzY38olZyTpY
X-Received: by 2002:a05:6214:508e:b0:444:4ab8:46db with SMTP id kk14-20020a056214508e00b004444ab846dbmr1455411qvb.0.1649718661225;
        Mon, 11 Apr 2022 16:11:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymsLIMM/jbDt0gr1oxX5KokLO47ucantSDt21T0Cp0XuLxwvfQI1z1zCHOWVD5L23xVhaX8w==
X-Received: by 2002:a05:6214:508e:b0:444:4ab8:46db with SMTP id kk14-20020a056214508e00b004444ab846dbmr1455397qvb.0.1649718661029;
        Mon, 11 Apr 2022 16:11:01 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87d83000000b002e1d1b3df15sm27243500qtd.44.2022.04.11.16.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 16:11:00 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] x86/uaccess: Don't jump between functions
Date:   Mon, 11 Apr 2022 16:10:29 -0700
Message-Id: <9519e4853148b765e047967708f2b61e56c93186.1649718562.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649718562.git.jpoimboe@redhat.com>
References: <cover.1649718562.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For unwinding sanity, a function shouldn't jump to the middle of another
function.  Move the short string user copy code out to a separate
non-function code snippet.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/lib/copy_user_64.S | 87 ++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 8ca5ecf16dc4..9dec1b38a98f 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -53,12 +53,12 @@
 SYM_FUNC_START(copy_user_generic_unrolled)
 	ASM_STAC
 	cmpl $8,%edx
-	jb 20f		/* less then 8 bytes, go to byte copy loop */
+	jb .Lcopy_user_short_string_bytes
 	ALIGN_DESTINATION
 	movl %edx,%ecx
 	andl $63,%edx
 	shrl $6,%ecx
-	jz .L_copy_short_string
+	jz copy_user_short_string
 1:	movq (%rsi),%r8
 2:	movq 1*8(%rsi),%r9
 3:	movq 2*8(%rsi),%r10
@@ -79,37 +79,11 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 	leaq 64(%rdi),%rdi
 	decl %ecx
 	jnz 1b
-.L_copy_short_string:
-	movl %edx,%ecx
-	andl $7,%edx
-	shrl $3,%ecx
-	jz 20f
-18:	movq (%rsi),%r8
-19:	movq %r8,(%rdi)
-	leaq 8(%rsi),%rsi
-	leaq 8(%rdi),%rdi
-	decl %ecx
-	jnz 18b
-20:	andl %edx,%edx
-	jz 23f
-	movl %edx,%ecx
-21:	movb (%rsi),%al
-22:	movb %al,(%rdi)
-	incq %rsi
-	incq %rdi
-	decl %ecx
-	jnz 21b
-23:	xor %eax,%eax
-	ASM_CLAC
-	RET
+	jmp copy_user_short_string
 
 30:	shll $6,%ecx
 	addl %ecx,%edx
-	jmp 60f
-40:	leal (%rdx,%rcx,8),%edx
-	jmp 60f
-50:	movl %ecx,%edx
-60:	jmp .Lcopy_user_handle_tail /* ecx is zerorest also */
+	jmp .Lcopy_user_handle_tail
 
 	_ASM_EXTABLE_CPY(1b, 30b)
 	_ASM_EXTABLE_CPY(2b, 30b)
@@ -127,10 +101,6 @@ SYM_FUNC_START(copy_user_generic_unrolled)
 	_ASM_EXTABLE_CPY(14b, 30b)
 	_ASM_EXTABLE_CPY(15b, 30b)
 	_ASM_EXTABLE_CPY(16b, 30b)
-	_ASM_EXTABLE_CPY(18b, 40b)
-	_ASM_EXTABLE_CPY(19b, 40b)
-	_ASM_EXTABLE_CPY(21b, 50b)
-	_ASM_EXTABLE_CPY(22b, 50b)
 SYM_FUNC_END(copy_user_generic_unrolled)
 EXPORT_SYMBOL(copy_user_generic_unrolled)
 
@@ -191,7 +161,7 @@ EXPORT_SYMBOL(copy_user_generic_string)
 SYM_FUNC_START(copy_user_enhanced_fast_string)
 	ASM_STAC
 	/* CPUs without FSRM should avoid rep movsb for short copies */
-	ALTERNATIVE "cmpl $64, %edx; jb .L_copy_short_string", "", X86_FEATURE_FSRM
+	ALTERNATIVE "cmpl $64, %edx; jb copy_user_short_string", "", X86_FEATURE_FSRM
 	movl %edx,%ecx
 1:	rep movsb
 	xorl %eax,%eax
@@ -243,6 +213,53 @@ SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
+/*
+ * Finish memcpy of less than 64 bytes.  #AC should already be set.
+ *
+ * Input:
+ * rdi destination
+ * rsi source
+ * rdx count (< 64)
+ *
+ * Output:
+ * eax uncopied bytes or 0 if successful.
+ */
+SYM_CODE_START_LOCAL(copy_user_short_string)
+	movl %edx,%ecx
+	andl $7,%edx
+	shrl $3,%ecx
+	jz .Lcopy_user_short_string_bytes
+18:	movq (%rsi),%r8
+19:	movq %r8,(%rdi)
+	leaq 8(%rsi),%rsi
+	leaq 8(%rdi),%rdi
+	decl %ecx
+	jnz 18b
+.Lcopy_user_short_string_bytes:
+	andl %edx,%edx
+	jz 23f
+	movl %edx,%ecx
+21:	movb (%rsi),%al
+22:	movb %al,(%rdi)
+	incq %rsi
+	incq %rdi
+	decl %ecx
+	jnz 21b
+23:	xor %eax,%eax
+	ASM_CLAC
+	RET
+
+40:	leal (%rdx,%rcx,8),%edx
+	jmp 60f
+50:	movl %ecx,%edx		/* ecx is zerorest also */
+60:	jmp .Lcopy_user_handle_tail
+
+	_ASM_EXTABLE_CPY(18b, 40b)
+	_ASM_EXTABLE_CPY(19b, 40b)
+	_ASM_EXTABLE_CPY(21b, 50b)
+	_ASM_EXTABLE_CPY(22b, 50b)
+SYM_CODE_END(copy_user_short_string)
+
 /*
  * copy_user_nocache - Uncached memory copy with exception handling
  * This will force destination out of cache for more performance.
-- 
2.34.1

