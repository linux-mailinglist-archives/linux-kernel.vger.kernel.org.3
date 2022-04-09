Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C104FA94E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242522AbiDIPir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242517AbiDIPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:38:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7DE34BB7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 08:36:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c2so10334494pga.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yfbk8YJkO//wfC3mJ2T20Db/FP4L/j3qSerCnlz9i+M=;
        b=YveU6rx6be8uqAtvTK5nxIhRQlNG8tkPZgVx4KX9/LBzeGuVHQrwdYGNqxHFZutA/T
         ZVdODDmD+P473i3UjFfZFQYMMjVdabEZ0Dr3ycUBQxG3l51Nt1Q3mw60ATe/5zp3ljIG
         jQhkd217LFuyW2Nw+gNeBwasm2xfEdQsJ+zBJyEa69gUPnHuK4v+nPykzUKCbAQFhYMA
         AfPevwBjje+B5I/M4HqbnJA3bcE0mEsuWg0tSv7SYqHgK1YU1c86mDQErTdtTld0oVfm
         vtLZSQVZW4Ew678Lh/6sE41Bhb5/wpZh9VdWVkgk9CuFEzcD/cgL5TsWmD9HfEnGxAij
         ZlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfbk8YJkO//wfC3mJ2T20Db/FP4L/j3qSerCnlz9i+M=;
        b=CU1FsD6ltNV0yHCe1W3xSp3eiR3PHMoAokL7U6dciQW+pcU4jSsN2uceAAMyHQzx4L
         xMoQeVTNmRD+5HbyMYQ6fbbytceA2cqdDro+3g7vrfrN5uUtsydhNoNm7+wH/eH1cLr7
         DTg95F3tii/K/J4y/7+Hj8Goy3fJ+3+qKryokFhSmfhe4kuwvA52GPeY2zg63pf+7bvB
         nDAVMJYmTWnulvMEUJougJvfFZ6b+Jb4hazNwg/CPb9ZUoj1H3CNX9BnJqWRZVc4a+js
         5gP4lbLA18NssxSottUkwLXNX4K/NG2o2fOClx5JK3X9ag22EScCII7VyxXY6Ish6bKW
         3lmw==
X-Gm-Message-State: AOAM531AlfomsFkjpD6thj3uDivbbcXPi7P4AN1ldVjRUGpz5upyBsPL
        i1V1lIb2QkOWu5Yin1H6gG9nzA==
X-Google-Smtp-Source: ABdhPJycD0dD91CG7kEkTLbxTXmVdVAHHzba7SjMipmiVy3X3ZoW3XBhGBd24G+A47ZmTPScjV0TUg==
X-Received: by 2002:a05:6a00:1388:b0:505:9b0b:ba61 with SMTP id t8-20020a056a00138800b005059b0bba61mr3508875pfg.4.1649518589987;
        Sat, 09 Apr 2022 08:36:29 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6c:f010:e956:3be0:d6a3:f6ba])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090ade0100b001cb3feaddfcsm4810546pjv.2.2022.04.09.08.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 08:36:28 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        broonie@kernel.org, mark.rutland@arm.com, ardb@kernel.org,
        zhouchengming@bytedance.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
Subject: [PATCH v4 2/2] arm64/ftrace: Make function graph use ftrace directly
Date:   Sat,  9 Apr 2022 23:35:54 +0800
Message-Id: <20220409153554.14470-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409153554.14470-1-zhouchengming@bytedance.com>
References: <20220409153554.14470-1-zhouchengming@bytedance.com>
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
the same cleanup on arm64.

And this cleanup only changes the FTRACE_WITH_REGS implementation,
so the mcount-based implementation is unaffected.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v3:
 - Add comments in ftrace_graph_func() as suggested by Steve. Thanks.

v2:
 - Remove FTRACE_WITH_REGS ftrace_graph_caller asm, thanks Mark.
---
 arch/arm64/include/asm/ftrace.h  |  7 +++++++
 arch/arm64/kernel/entry-ftrace.S | 17 -----------------
 arch/arm64/kernel/ftrace.c       | 17 +++++++++++++++++
 3 files changed, 24 insertions(+), 17 deletions(-)

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
index 4506c4a90ac1..35eb7c9b5e53 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -268,6 +268,22 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
+		       struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	/*
+	 * Athough graph_ops doesn't have FTRACE_OPS_FL_SAVE_REGS set in flags,
+	 * regs can't be NULL in DYNAMIC_FTRACE_WITH_REGS. By design, it should
+	 * be fixed when DYNAMIC_FTRACE_WITH_ARGS is implemented.
+	 */
+	struct pt_regs *regs = arch_ftrace_get_regs(fregs);
+	unsigned long *parent = (unsigned long *)&procedure_link_pointer(regs);
+
+	prepare_ftrace_return(ip, parent, frame_pointer(regs));
+}
+#else
 /*
  * Turn on/off the call to ftrace_graph_caller() in ftrace_caller()
  * depending on @enable.
@@ -297,5 +313,6 @@ int ftrace_disable_ftrace_graph_caller(void)
 {
 	return ftrace_modify_graph_caller(false);
 }
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.35.1

