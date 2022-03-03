Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9F24CB592
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiCCDzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiCCDzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:55:10 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5FE1451D0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:54:25 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e2so3386727pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 19:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xi68o3LflOcJSjUAfCp8Eoq36gaPXd65N0Lh9gWJYs=;
        b=ChfhB9Q1kgf/HK+IvTlWJSoEe7i7wRN7jW+tLSNaZYf3qVVOVUTFZ8feF9bKd47/9g
         avHCxxhlbyUiX169fh2S8gdAafEtssa6ara44eJCjzdXGcUSAM1jW7MAEPdTT2F4mg8p
         B9bUq+eeA1JwGEBoZn1+0IEulPYR8jYCZ+OE7LgPS8eI81ljAYkLxaOvF2KHwCgvGWVi
         KkTSh4ceX5qGSOInRyqbgRoWfXl4/tHVPHEp8XkvmlbdAujalCF2L6deYKeJLDNFdrmU
         JLzCmxak3kaVex5DTyt3+sxWKWJa6uGB/rc94pM/6e5hA/JimowneArLhcgOzd4HrCnD
         d+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xi68o3LflOcJSjUAfCp8Eoq36gaPXd65N0Lh9gWJYs=;
        b=CvkQZhp/i05ROJQGj2kfHOsIlHE9zYZoySRLfOah84kpIMe7zipSExjcafACwy3XnN
         YHt5XeZd/AQzhCqVtZsCr0zmcWC/TgVU9WRrpCaSjNLjFoBXcKIfiFp8BPejjNQkTm0o
         JYGjyVTJg7PpZZYz8hqs1r6XjzJjMF/kPZJqlhhVwEoFuhvjhv1Dn0YhCHq1aK+4Rfpj
         jArPKwTPHLkB0R3hPYL2ig6PSeCo5entQJMffeKg7Tf2Tb5ks+gXt4PG1/eDSFcLFmiX
         pEDidpOTfNFt5xsxbyBGsw30bwjPkVK9A3qOQQLIN2Tw6X1jO/u7Sx3ylupctQd8HrDn
         OaRA==
X-Gm-Message-State: AOAM532h+Mrs49cMgBdKxCZxeCkcbCjmJn1zW2nq2OMR3sOTFD/xQNIV
        63wP+ku8mRuxmcYCMscFKj1rEkFo5/E=
X-Google-Smtp-Source: ABdhPJx9vlpkZP7hoE3xxjO/freHx46CvxGDExvwku0oaXYuPlqsKDL6avcM0qFHzLzGEG9697dV5g==
X-Received: by 2002:a17:90b:8d:b0:1bc:4273:251b with SMTP id bb13-20020a17090b008d00b001bc4273251bmr3190332pjb.141.1646279664726;
        Wed, 02 Mar 2022 19:54:24 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id a8-20020aa795a8000000b004f670c2ef2esm358174pfk.163.2022.03.02.19.54.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2022 19:54:24 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 4/7] x86/entry: Move cld to the start of idtentry
Date:   Thu,  3 Mar 2022 11:54:31 +0800
Message-Id: <20220303035434.20471-5-jiangshanlai@gmail.com>
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

Make it next to CLAC

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3ca64bad4697..630bf8164a09 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -356,6 +356,7 @@ SYM_CODE_END(ret_from_fork)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ASM_CLAC
+	cld
 
 	.if \has_error_code == 0
 		pushq	$-1			/* ORIG_RAX: no syscall to restart */
@@ -423,6 +424,7 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ASM_CLAC
+	cld
 
 	pushq	$-1			/* ORIG_RAX: no syscall to restart */
 
@@ -478,6 +480,7 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS
 	ASM_CLAC
+	cld
 
 	/*
 	 * If the entry is from userspace, switch stacks and treat it as
@@ -539,6 +542,7 @@ SYM_CODE_END(\asmsym)
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=8
 	ASM_CLAC
+	cld
 
 	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
 	call	paranoid_entry
@@ -852,7 +856,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
@@ -970,7 +973,6 @@ SYM_CODE_END(paranoid_exit)
  */
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
-	cld
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1103,6 +1105,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	ASM_CLAC
+	cld
 
 	/* Use %rdx as our temp variable throughout */
 	pushq	%rdx
@@ -1122,7 +1125,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	swapgs
-	cld
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-- 
2.19.1.6.gb485710b

