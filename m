Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395CA4C2832
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiBXJeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbiBXJeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:34:10 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B0D27AA08
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:33:28 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 139so1273938pge.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ur9wtD5hRziCyNtt0x078VkkIfEhwLa1NcuLg35lwx4=;
        b=tCOC3j3DRPC8L4v+mDSfN1fAt0wWb2cyyK3zkm+uVDGDoDrnpHoNaF/uLLFaWO6iGj
         UBl8ra8c/Ra+nggkq5+cor9kaAKMvHQZd05JnZF81t494fHnMs6t1uA/4gLBUP+/QrNX
         nOTSpgK4XuvoT7xDkd2jMH/kUl7RYhWqGUdMdQVdY+QsS72+f836hZ8IkEKZdYm8SyT6
         /QzXArkf58QcDzPpbkqBLBNe5wSC2Cm8zSMWs9sVlh8T6JRAXQ3zDk9keBepOPxCr9zv
         EqnhA/U3cUkmoJtyjicbKAq8Abak68yml0ZSRzL2lKk/u6+ETNUOtphQP8wF1I7mejce
         Vskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ur9wtD5hRziCyNtt0x078VkkIfEhwLa1NcuLg35lwx4=;
        b=i96mt2t/Q/ubf9TQ0x1i10EKN2Az2CcfCnRB0JExz95n7lF257NnpLo3+449GfCOBr
         p8ke1Y9D02uP7y47gCoXzKH+Ya3z6FqPWK11SwdiBM0KEkna2SZVLrTjGTH4ax6fde6U
         je5edTsgjEg7K6r5CRtl01fKMjoRv72hk7pHS46tvCl0L/8pumcc/ubnAl6+mefw08HY
         HfnK/t+WgP3rR7rQuoEK5ndzcYXB+sBzGKOZWOwRE3iZWFxHmtTNa9HOkcbf/eFd4ow1
         s/rI/4p96sKTn/NOvUbHwMffZlPqTNLS4Xl5P/TCQXCsMItOAuQfJF3XJCnUGsfc51nr
         PHsA==
X-Gm-Message-State: AOAM530slBtGnUyscZtHmEvAdYxvxNqxzVL7GF+shZWEAkBkBvLu95K/
        OiLjZWLQAolrJ98yKnGBHbK0DISWqNLwMg==
X-Google-Smtp-Source: ABdhPJyZz/IiG+PWxHVct5nQwUKfkF08wuXdEDJWf1nuV9VLNW7ezhCe4mXisB+A1XxUyHYlPADAdw==
X-Received: by 2002:a05:6a00:a10:b0:4c1:8ad1:81c5 with SMTP id p16-20020a056a000a1000b004c18ad181c5mr2028054pfh.42.1645695208202;
        Thu, 24 Feb 2022 01:33:28 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id 13sm2530988pfx.122.2022.02.24.01.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:27 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mark.rutland@arm.com, mingo@redhat.com,
        tglx@linutronix.de, catalin.marinas@arm.com, will@kernel.org,
        dave.hansen@linux.intel.com, broonie@kernel.org
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 3/3] arm64/ftrace: Make function graph use ftrace directly
Date:   Thu, 24 Feb 2022 17:32:51 +0800
Message-Id: <20220224093251.49971-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224093251.49971-1-zhouchengming@bytedance.com>
References: <20220224093251.49971-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
Changes in v3:
 - Add comments in ftrace_graph_func() as suggested by Steve.

Changes in v2:
 - Remove FTRACE_WITH_REGS ftrace_graph_caller asm as suggested by Mark.
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

