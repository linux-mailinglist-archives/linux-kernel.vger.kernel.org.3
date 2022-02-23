Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1494C0ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbiBWJCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbiBWJCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:02:30 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5766D3ED22
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:02:02 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id i1so4210879plr.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jx0LTc0N+EqTRUoVpsY/zDn3O9ZublQZdNNSFkzii3k=;
        b=H0R3ytHwp9OBRo6b/aVZ8Azyll88PPU6VQJ234gY7Okl+/ur4wGelu1As95AG2pyeu
         1Wfew9oG4HX0mKj/Ohx/zuu5R6AAB4yh0jBOOCMCJmGAgoJrhiW/kt1J08L3ushq3TlN
         1qRl9Pnj0dSbrPS+9Hqa4sm/aHospu6tMFDcUoQVderPt11m+vcf8B1PW5/PiJP2+fE5
         gRnqY/eVmeVQ4bwNkgfSvjPPaUxfoO7X92pROYltBsqDDpWMIzPVsaAoHNsc1HD+mC7T
         x8uI5vqi10GP3PBPsdiRckKz5Y+IaSAK+e4O/l341Au7SScVSd7dzwaGMu7N+qAgLJoy
         /rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jx0LTc0N+EqTRUoVpsY/zDn3O9ZublQZdNNSFkzii3k=;
        b=oQHr0Ex8lJ6g1Rbdf0GfR9f0OK+2+Z0J4uIxkK5fwwXU24RNFdEzIbvywnb+gSF4Y/
         QRyhJNzYZh5X47nIxQD/DoguZHMkZIjxqT6UboHpgnTgWJmaPl95qIi+CfiSjUeR2nks
         9EAM4mDnNhXLcee7YfZGgvA65QdPyjLxBbgRZR5/O8C9anwoLo9jRZZFrH9+252Ir66N
         V21S12KT2f7cCFXHlzGr6zEwb8UU74nvjGVehRrTQWPNMN6UQxt9PPqF81QdXgi0z+Gg
         PKjNSZS3nu1iielXXlHvKB4rUP68Hfda+7t38DoyOUp33vjj7n0NNMyoyORrNSQkdRXh
         NqfQ==
X-Gm-Message-State: AOAM531+MvayUfALU5b/SMtXs6PePBqxnwY0N/zxV/zhpOcPhuiTNk5P
        sJyCxDHTUFvTSs84K2JBX/7kLA==
X-Google-Smtp-Source: ABdhPJxLFEuiyqS5P+gCUFh/N4Vv2amAuHnweDzs5jGyekk/G6NXXpplZ5JdTbebgLPzMfuy0fWZlA==
X-Received: by 2002:a17:90b:400c:b0:1bc:7190:5696 with SMTP id ie12-20020a17090b400c00b001bc71905696mr7454045pjb.109.1645606921754;
        Wed, 23 Feb 2022 01:02:01 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id k9sm21458694pfc.157.2022.02.23.01.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 01:02:01 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 2/2] arm64/ftrace: Make function graph use ftrace directly
Date:   Wed, 23 Feb 2022 17:01:32 +0800
Message-Id: <20220223090132.10114-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223090132.10114-1-zhouchengming@bytedance.com>
References: <20220223090132.10114-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we do in commit 0c0593b45c9b ("x86/ftrace: Make function graph
use ftrace directly"), we don't need special hook for graph tracer,
but instead we use graph_ops:func function to install return_hooker.

Since commit 3b23e4991fb6 ("arm64: implement ftrace with regs") add
implementation for FTRACE_WITH_REGS on arm64, we can easily adopt
the same cleanup on arm64. And this cleanup only changes the
FTRACE_WITH_REGS implementation, so the mcount-based implementation
is unaffected.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 arch/arm64/include/asm/ftrace.h  |  7 +++++++
 arch/arm64/kernel/entry-ftrace.S | 17 -----------------
 arch/arm64/kernel/ftrace.c       | 12 ++++++++++++
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 1494cfa8639b..dbc45a4157fa 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -80,8 +80,15 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 struct dyn_ftrace;
+struct ftrace_ops;
+struct ftrace_regs;
+
 int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 #define ftrace_init_nop ftrace_init_nop
+
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs);
+#define ftrace_graph_func ftrace_graph_func
 #endif
 
 #define ftrace_return_address(n) return_address(n)
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index e535480a4069..d42a205ef625 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -97,12 +97,6 @@ SYM_CODE_START(ftrace_common)
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	bl	ftrace_stub
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL) // ftrace_graph_caller();
-	nop				// If enabled, this will be replaced
-					// "b ftrace_graph_caller"
-#endif
-
 /*
  * At the callsite x0-x8 and x19-x30 were live. Any C code will have preserved
  * x19-x29 per the AAPCS, and we created frame records upon entry, so we need
@@ -127,17 +121,6 @@ ftrace_common_return:
 	ret	x9
 SYM_CODE_END(ftrace_common)
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-SYM_CODE_START(ftrace_graph_caller)
-	ldr	x0, [sp, #S_PC]
-	sub	x0, x0, #AARCH64_INSN_SIZE	// ip (callsite's BL insn)
-	add	x1, sp, #S_LR			// parent_ip (callsite's LR)
-	ldr	x2, [sp, #PT_REGS_SIZE]	   	// parent fp (callsite's FP)
-	bl	prepare_ftrace_return
-	b	ftrace_common_return
-SYM_CODE_END(ftrace_graph_caller)
-#endif
-
 #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
 /*
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 4506c4a90ac1..aeac174507a8 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -268,6 +268,17 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
+	unsigned long *parent = (unsigned long *)&procedure_link_pointer(regs);
+
+	prepare_ftrace_return(ip, parent, frame_pointer(regs));
+}
+#else
 /*
  * Turn on/off the call to ftrace_graph_caller() in ftrace_caller()
  * depending on @enable.
@@ -297,5 +308,6 @@ int ftrace_disable_ftrace_graph_caller(void)
 {
 	return ftrace_modify_graph_caller(false);
 }
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.20.1

