Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF12508CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355378AbiDTQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355482AbiDTQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:03:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3505EDFA8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:00:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id mm4-20020a17090b358400b001cb93d8b137so5350347pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqAuKIhNdsp4YazTmRTCNyekK9gIf2Fr30HqL/AT21U=;
        b=kcTggueZRyBry2gNLm758/g56VWZ6JLMZqrhmtnu/mTu6AG5AKp98T2/e+NZ0mZCHn
         /ewQjLbya27pojASo2zlW5t4flIEBnTrqUqO2FDTrIAyMUfcz+0j6ghO32pe9e5YgbnP
         3R9gqCTEIG+I8FZ1wk0ezM7/Hi7y/Z9uobefgSM4Mj6oUgaNBUn5W/5rEWB2/eyCPGb9
         vKrW5gIfDoJjYE0tOK8TAYwgb3w7hWRYzi3gqWgdp/f2QH0q1sfGPMgCX4EQ9YTycKN8
         KSWGSW8V90co+8ZiDg7jZH9PO+osz0qgSckg6/V4U0tVBWQtR2wxlC++hP+A1MDFABHk
         q/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqAuKIhNdsp4YazTmRTCNyekK9gIf2Fr30HqL/AT21U=;
        b=bWz8Kt332silGO6LwoHhRrDDVwLriW+ZM9iAXHc9IaYeKmrDQz0fgaRCreERAznvmK
         rw0z8uB74QHiXedzOtSAoFCkY6KLMWrNpS+Y1xlKtv2pX4ipsVDNkyxJZUuJGKrkt5rZ
         Lzj2PeNEzHs2rjlNDUx0175bn2Z1zGNpUJsQYw3volp1I7N+k87Sprq88jS36sMCxgJP
         Nyw3laegEyNHRACb1ZHzbAsVz4PlFXlorPldXHjVo3InN/Bxq/md0xbNGwvDiy0lta2U
         Vq6+lI3fS6LsGVlnsTZCqg8lXtPklo2Kohjvm+OFKSJhkftxELZHKVBGBq5HGaR2pdH2
         2llg==
X-Gm-Message-State: AOAM5314USBAbbTspxzOBEEUAN5HV2PkldCV8fwvOPXTUzEZV39GUxhu
        TXDpFUNbJml4ZWc/zYvoLUDIDA==
X-Google-Smtp-Source: ABdhPJxVGJb3srX6pyTEy8ykmEVC+CHqgaIViUcFSo9c8mikW+xm1RdaEcr6PMdPCjgljwCI/dWg5g==
X-Received: by 2002:a17:90b:1886:b0:1cb:8e79:8ebb with SMTP id mn6-20020a17090b188600b001cb8e798ebbmr5232229pjb.176.1650470436565;
        Wed, 20 Apr 2022 09:00:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e66:6380:7568:1633:647:d3a2])
        by smtp.gmail.com with ESMTPSA id h18-20020a63c012000000b0039cc3c323f7sm20198676pgg.33.2022.04.20.09.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:00:36 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mark.rutland@arm.com, mingo@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, broonie@kernel.org, ardb@kernel.org
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 2/2] arm64/ftrace: Make function graph use ftrace directly
Date:   Thu, 21 Apr 2022 00:00:06 +0800
Message-Id: <20220420160006.17880-2-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420160006.17880-1-zhouchengming@bytedance.com>
References: <20220420160006.17880-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

While in theory it would be possible to make a similar cleanup for
!FTRACE_WITH_REGS, this will require rework of the core code, and
so for now we only change the FTRACE_WITH_REGS implementation.

Tested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
v5:
 - Add reason why this patch only changed FTRACE_WITH_REGS
   implementation in the commit message as suggested by Mark.
 - Change to use nicer comment in ftrace_graph_func() as suggested
   by Mark, because the previous comment sounds like there's an bug
   to be fixed.
 - Add Tested-by and Reviewed-by tags from Mark, thanks.

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
index 4506c4a90ac1..f447c4a36f69 100644
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
+	 * When DYNAMIC_FTRACE_WITH_REGS is selected, `fregs` can never be NULL
+	 * and arch_ftrace_get_regs(fregs) will always give a non-NULL pt_regs
+	 * in which we can safely modify the LR.
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
2.35.2

