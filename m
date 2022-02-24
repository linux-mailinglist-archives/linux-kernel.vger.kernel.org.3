Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2E64C2827
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiBXJeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiBXJdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:53 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C04726A39E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:33:23 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id iq13-20020a17090afb4d00b001bc4437df2cso1546076pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Um2hOoO992A8z0y3YtWZVlugWm1fUhrmcXQ/7RYGwh8=;
        b=dmY9TiLAQ/Sks9iO7V4G62Iq0F4qlBMW21+hDyL33W+fC59uEKCeH1kQPz7H/qXr4X
         SvVBePgkVfp2+ZdtGoFrz4RZA/MnbhKe1Y+gZUU8kHjNRYAdc+x2DtDHGt3jwK9Cb00C
         TkG5V3K39mgV+oebLPqYz8Hv/fUqlOzTKV7wyjPfam74HRRaVwDI7B29oSg2sxF4/xTS
         np6kqdrSTbTA3AohcQZa4LYTE0N5FePEQb0d0FnaZdZkN0Kn0Sn2o1Ce6tFhYruXHP2Q
         8nmbW3JYmXV0GJJDCQj3unSGk3/Cwdu+a9DjeDZp2/Fy96EP0/UCgyNTa256oPuvM3oB
         Vgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Um2hOoO992A8z0y3YtWZVlugWm1fUhrmcXQ/7RYGwh8=;
        b=h1lUJsGUAHfF28f63cqi4NXMb5056811/rHYkhfe331SZnyatMIF2JBZR2/hapxS7a
         M3BiWterxHcCBbysHHEB89sWOHeIEUllfaKM/akGm/9GUs6YU4GeNQeaWXG2Dslq0ewa
         fogfn3hdSWUagB35k219fahxSlxJMtfHnXxEHt45weO5UWvtni1tChxxC4ww3KtBiAaE
         yAk+0XAcru8YsXwHDsWtH9qney1MGGh9leO2GAHSebPpzctNUTRpHT3zeofhG1Ql/MBX
         JoOnBr2J1pWAfhpbP62DepTp+vG3E7gnM5HCvv62IWjqzIvTJ3JPAxY5lqdiKn2R5gYE
         9n9A==
X-Gm-Message-State: AOAM53176vKfcjPKADi9auTmiNenDc52nyDbIJEWGPm/jukOlfxxIMIH
        wbVOYtz8duLVPYzj/gTCIwc9zQ==
X-Google-Smtp-Source: ABdhPJxLfTLxRibEEIi3LQRH2mR/4H/gW2oqwevUc7iY2J2LFlnQXH9WaCZ0SWn98k92VCGYf8fjjQ==
X-Received: by 2002:a17:90a:4891:b0:1b9:81c:8774 with SMTP id b17-20020a17090a489100b001b9081c8774mr1930738pjh.8.1645695202689;
        Thu, 24 Feb 2022 01:33:22 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id 13sm2530988pfx.122.2022.02.24.01.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:22 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     rostedt@goodmis.org, mark.rutland@arm.com, mingo@redhat.com,
        tglx@linutronix.de, catalin.marinas@arm.com, will@kernel.org,
        dave.hansen@linux.intel.com, broonie@kernel.org
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        qirui.001@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 2/3] x86/ftrace: cleanup graph tracer
Date:   Thu, 24 Feb 2022 17:32:50 +0800
Message-Id: <20220224093251.49971-2-zhouchengming@bytedance.com>
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

Put CONFIG_DYNAMIC_FTRACE related code after prepare_ftrace_return(),
in which we define ftrace_graph_func() for graph_ops in
DYNAMIC_FTRACE_WITH_ARGS case, then define ftrace_graph_caller
enable and disable functions in the #else case to override.

Since ftrace_graph_caller enable and disable functions have weak
versions in Ftrace core code, we don't need to override them in the
DYNAMIC_FTRACE_WITH_ARGS case. This patch is just a cleanup,
doesn't have functional changes actually.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 arch/x86/kernel/ftrace.c | 78 +++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 46 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 7cc540e6de0c..e49c9d3e986b 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -583,51 +583,6 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-
-#ifdef CONFIG_DYNAMIC_FTRACE
-
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
-extern void ftrace_graph_call(void);
-static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
-{
-	return text_gen_insn(JMP32_INSN_OPCODE, (void *)ip, (void *)addr);
-}
-
-static int ftrace_mod_jmp(unsigned long ip, void *func)
-{
-	const char *new;
-
-	new = ftrace_jmp_replace(ip, (unsigned long)func);
-	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
-	return 0;
-}
-
-int ftrace_enable_ftrace_graph_caller(void)
-{
-	unsigned long ip = (unsigned long)(&ftrace_graph_call);
-
-	return ftrace_mod_jmp(ip, &ftrace_graph_caller);
-}
-
-int ftrace_disable_ftrace_graph_caller(void)
-{
-	unsigned long ip = (unsigned long)(&ftrace_graph_call);
-
-	return ftrace_mod_jmp(ip, &ftrace_stub);
-}
-#else /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
-int ftrace_enable_ftrace_graph_caller(void)
-{
-	return 0;
-}
-
-int ftrace_disable_ftrace_graph_caller(void)
-{
-	return 0;
-}
-#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
-#endif /* !CONFIG_DYNAMIC_FTRACE */
-
 /*
  * Hook the return address and push it in the stack of return addrs
  * in current thread info.
@@ -666,6 +621,8 @@ void prepare_ftrace_return(unsigned long ip, unsigned long *parent,
 	ftrace_test_recursion_unlock(bit);
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
@@ -675,6 +632,35 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 
 	prepare_ftrace_return(ip, (unsigned long *)stack, 0);
 }
-#endif
+#else
+extern void ftrace_graph_call(void);
+static const char *ftrace_jmp_replace(unsigned long ip, unsigned long addr)
+{
+	return text_gen_insn(JMP32_INSN_OPCODE, (void *)ip, (void *)addr);
+}
 
+static int ftrace_mod_jmp(unsigned long ip, void *func)
+{
+	const char *new;
+
+	new = ftrace_jmp_replace(ip, (unsigned long)func);
+	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
+	return 0;
+}
+
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	unsigned long ip = (unsigned long)(&ftrace_graph_call);
+
+	return ftrace_mod_jmp(ip, &ftrace_graph_caller);
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	unsigned long ip = (unsigned long)(&ftrace_graph_call);
+
+	return ftrace_mod_jmp(ip, &ftrace_stub);
+}
+#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
+#endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
2.20.1

