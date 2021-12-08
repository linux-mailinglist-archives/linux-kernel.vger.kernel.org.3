Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC946D19D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhLHLM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbhLHLM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:12:26 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A95CC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 03:08:54 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i12so2152798pfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 03:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94qtwsHdBUcVzdr14fQH4QqeaELVSejvb9k+dDp4o2k=;
        b=gdJwJexPSIx1/o0kGlFH/3siK2BWmqN/Qya2wWAwRpJBABJCf7cZVPY1vV9uKphzCM
         wDiL42S9zLojg/9rYkV+8Gcyug0bNkhyprI3HL5IVv6FPdbDYpG0Q+9f1fcLvsLyHqlJ
         6d+3RCpxWxTSvIGQUyD3iKktmbGyZSKRYFR81PlrbYQogKQmi6fZOJTId9b93ecmVF2Q
         eT3UjTw/vZKqvqEL/qGLIrdAM1QDCdiqpnZVGVu3jSXv5teHhN5/T/g/zvUjMZ6G722x
         jjKFxOz0lcm/NslZErC/EI4Yi0rOzfoSzQ5g0N+HuIY4WjIjEBS0MHTo4NO9TZ3LRbFW
         TNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94qtwsHdBUcVzdr14fQH4QqeaELVSejvb9k+dDp4o2k=;
        b=p96UbQyolJtXZHYWZ0/Q7KRDnL7fTR+VbaDAbC3BI6AOPvy/mubI34jrgBq+/P81Z9
         BXOGPpLWeSa/artrIBZZxRCHrB0Tx9BpjdQ4bNVRzI+DnDzB8lGOlbM7dfOmnaNby7jh
         liEG5YF7ywWlC5m4/7w2G12Y+CU/SuVV60Z/EB4WjTOlmObNcp5f5nBt7PfUg0GslfMY
         89zzFymXWvx7+ojHU6D4D1uISyXCFaexzALNzk6vaMWSRbYz70w8qz6mPHSMupx3nHu1
         A84L/L7ZwwyhL86lYhI/u3CVJkySu2kVbMpFB5GeRcbckFQYAltMI1gTfmltUCv3HlBi
         WxFg==
X-Gm-Message-State: AOAM5320YsXGpGMdjJHyTP64N6X9EnUYOEBfJMaljl6/XHlJER8cZr5S
        HJflzt6ZB+Wp2NBeKNAcDYvoiAbyhnE=
X-Google-Smtp-Source: ABdhPJzMp2m1CIOe5Z9utqdinpuLznocfHk1h5+AWYqs9CoFg7FElyyIpiFD9TM9L0u194BTWXvhUw==
X-Received: by 2002:a62:8449:0:b0:4ad:56ba:2f1d with SMTP id k70-20020a628449000000b004ad56ba2f1dmr4928492pfd.37.1638961733585;
        Wed, 08 Dec 2021 03:08:53 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id d3sm3454696pfv.57.2021.12.08.03.08.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 03:08:53 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, xen-devel@lists.xenproject.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 05/11] x86/entry: Move cld to the start of idtentry
Date:   Wed,  8 Dec 2021 19:08:27 +0800
Message-Id: <20211208110833.65366-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211208110833.65366-1-jiangshanlai@gmail.com>
References: <20211208110833.65366-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Make it next to CLAC

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 72ceb4b70822..ee1d4adcdab0 100644
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
@@ -853,7 +857,6 @@ SYM_CODE_END(xen_failsafe_callback)
  */
 SYM_CODE_START_LOCAL(paranoid_entry)
 	UNWIND_HINT_FUNC
-	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
 
@@ -971,7 +974,6 @@ SYM_CODE_END(paranoid_exit)
  */
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
-	cld
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
 
@@ -1104,6 +1106,7 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	ASM_CLAC
+	cld
 
 	/* Use %rdx as our temp variable throughout */
 	pushq	%rdx
@@ -1123,7 +1126,6 @@ SYM_CODE_START(asm_exc_nmi)
 	 */
 
 	swapgs
-	cld
 	FENCE_SWAPGS_USER_ENTRY
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
 	movq	%rsp, %rdx
-- 
2.19.1.6.gb485710b

