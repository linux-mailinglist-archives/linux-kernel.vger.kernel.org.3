Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1014FE103
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353858AbiDLMt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355235AbiDLMsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:48:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6571D0DE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:15:22 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s21so12557480pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EDbKvqEOe0G0GOJ/eQXOz2J1+f7HIDM3jsOjaLAEHZE=;
        b=Y2d57wk55T/SGsZnhJmFBO604T4+8z9jtkirmnOW3Z11AufEV0/ML1meu03rKqrgLg
         SanGSe+ShF7WRYO7WgsEeH9cVeRocvvWO0USlIUgBEN4pQVpFwLXCFnf7rLmoFxzY+pO
         zyAoWTdrWtYeUMNwTtHDZ3Bk3Pe+mm67lLj0NMRJalTk4YFQks0bBEmytlnY4DhBCKbB
         c4hj0+6045xZf7heSrxKA6Hqv/g6HBzaDBjH3BmZ2xD3TzCr6XRhGjHCDjhXzOAmNMD5
         F1/IVgmIu1/k7wo6qlC9BAI1Pmswnn0PkycZEBvVw9R2YQclv23dlBvEhtLT6aumQoCY
         iELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EDbKvqEOe0G0GOJ/eQXOz2J1+f7HIDM3jsOjaLAEHZE=;
        b=ptKF0MJaZxGuAc4ndtV6kK2WougqDBAVgvfTpbBZdm9PEsEb+NLUS1E79FsH0AQ8Zx
         Pm1KdAwdLauhn/qw6spk4RWNLAzrkj9DjmVx40bQ+UbVUPxJE1MyJZ6FT+ilTSC79PRT
         yVeKwQFdKoWkq7ZHUbhW2j35AgBegRKUivtZu55dNE6rLr8+DGsho17HDJQZcFBti3BK
         DpN8OlsHOpCSLI+Xe+suvnMU/qSJi5019kjK1h51Gr1LEdL5kQYQOThjy8kFk2/SC7dd
         p4HH0FDboI0mkfMAoYHPUKcFSXPlAfxLAUrWU4HLs49YeyRoqPTEnhF92mVb4wU9Ycxh
         huiw==
X-Gm-Message-State: AOAM531VUymZK+rUZPbMfyj5+EEBtW4vYLL5annmzYIHzo9olbON1B9J
        GqjjGOfp0JRfe75gUXwMX/P4xp45OyE=
X-Google-Smtp-Source: ABdhPJxGscyFzKVrObMTtHYlWSAEI0L+zf6pjRQt1Jg9ZbWDjw6SVOdh4LNQfPHbEBXRZsVCTa2luQ==
X-Received: by 2002:a63:f24c:0:b0:383:c279:e662 with SMTP id d12-20020a63f24c000000b00383c279e662mr30554747pgk.303.1649765722143;
        Tue, 12 Apr 2022 05:15:22 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090a454a00b001c96a912aa0sm2977907pjm.3.2022.04.12.05.15.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Apr 2022 05:15:21 -0700 (PDT)
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
Subject: [PATCH V5 4/7] x86/entry: Move cld to the start of idtentry macro
Date:   Tue, 12 Apr 2022 20:15:38 +0800
Message-Id: <20220412121541.4595-5-jiangshanlai@gmail.com>
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

Make it next to CLAC

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry_64.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 835b798556fb..7b6a0f15bb20 100644
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

