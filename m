Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964934FA616
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiDII5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235914AbiDII5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:57:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E36222BD
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 01:55:34 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n8so9899720plh.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 01:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxJc/L4B08IhoXEXn1ImpzHE+tjcdedq5j1cVSzMG3A=;
        b=3qOIBb8Jc63it5q3BkitEvnGJJIt9oOJMkthl6v8VwWzmN6R2KtLakWlhEjg+A/1ko
         mklYTgy+r2B/6oLuE8dVcC22Qp3daAtEM5rUZ+80eImOUwqOw2WWCECTdh+Z8MKaNHj8
         mKRZBpoztcuhxjWop67fmqcVLZcHMHEf9veRlR6uBHgaJL7NX4PUDeZ7PsNtHwLMwVwg
         TRK1sB1mSlxGTngT/YrG5CweZGBP4oMztq2Py66OLNFjLckfMunm7qOAjUDVoEttb2TZ
         hXavJQMw+FLJ8vTlZw3ZRMWRANkCXGdTZ3AqBzTUMfP7SMpdRNnkuNFQOz8TVnFjCKF+
         IsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxJc/L4B08IhoXEXn1ImpzHE+tjcdedq5j1cVSzMG3A=;
        b=cLkUrlJr9VqRpd/g4qxiqlDr5a+Aauj+WAguhdB+IfQfbYmls07dCmJBC1GOxI4hPq
         sd+1tveXXw27C/3Ea5oF2bq8alqJoK/DG4tlHo1jm0A+YcdiAKIgl0agQYKEm6U1Ap8Q
         ugjeS8ms7xBVYH27DyLX8ItnUFau/+Db1Wr1B313OUm6jHwVkRvKNINYdzg6BTJgXw9Y
         XJeJC2laJBnryY2e/NTwvZ8M7V6KQzkVcnyH44yRurV6iw83u0FVLkgOi7Tf5dJxu0AG
         XukcLlNQEWXPvYhpKNIY7m7DnFgEaiD3SWaG7pAbFnCWL+KoDotl8M3lc8Eu8O4pZFZd
         b8Xg==
X-Gm-Message-State: AOAM530KoAkra8mHOZQkBcrDVUqGyLyZqCsBjx1+JkCD3mFieOOicfbZ
        iUyBaXzZJ/5zoo04eNwtS3+NUQ==
X-Google-Smtp-Source: ABdhPJwKiD1Z7MvHcHawqfJq5oN5AoDHGof8inJWY83SQt2a2oOa0tBZCgIdatlX99ybNsPoXojwYw==
X-Received: by 2002:a17:902:d512:b0:156:b23f:ed62 with SMTP id b18-20020a170902d51200b00156b23fed62mr23655101plg.147.1649494534033;
        Sat, 09 Apr 2022 01:55:34 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e6c:f010:3c21:7dc2:3a08:b6bc])
        by smtp.gmail.com with ESMTPSA id f192-20020a636ac9000000b0039836edcf42sm24460806pgc.85.2022.04.09.01.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 01:55:32 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        broonie@kernel.org, mark.rutland@arm.com, ardb@kernel.org,
        zhouchengming@bytedance.com, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com
Subject: [PATCH RESEND v3 2/2] arm64/ftrace: Make function graph use ftrace directly
Date:   Sat,  9 Apr 2022 16:55:00 +0800
Message-Id: <20220409085500.4549-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409085500.4549-1-zhouchengming@bytedance.com>
References: <20220409085500.4549-1-zhouchengming@bytedance.com>
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
2.20.1

