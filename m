Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F19656B5F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiGHJuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237867AbiGHJuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:50:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B376E81498
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:50:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so1396846pjl.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4jkOqxcIBQLQ5eXTZyOJgkqi8V8OLaYB23LUkp1ByWQ=;
        b=1BQ/tfXanGFpMFjNAcJaktjsNTJO2Ix+TlfvkM8+DRdCM+TQJgbOKjIpF3MiANq3It
         c7hfVkGdQsdjKCLbbEjWgodkcKTUPOfsQ6bXqxpiuCSzKmawmYzxWzqxIYAtM+fdJ4uL
         2OsyvV/scdUurXA5YlvqJksdhJTMcVKWIWjLknH5i/+aSa8x+VpWW9MImoS3Ci1or+x1
         gIPYJorcVidrhYhYcDv5VzHBlb1o7j9vdkigw011F5prGRrWR5v00fjrkajH1kev1V5X
         Ldr88ehPn9JaZeJXLtdyI6Xa+KiFoYshqug9TIK+3oWpNP0xmI+X1IjMPOJ2nvxpdN6T
         me+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4jkOqxcIBQLQ5eXTZyOJgkqi8V8OLaYB23LUkp1ByWQ=;
        b=LtTUg0BxzGw7JjXeAoB/TYrCKu5tvaM3p1EiBcq3Sw3nZBRNe/W+sKL4nAVxPbdiIo
         fmkUCsOd9KVstUHk+WSYdYAYAhIZ19zF11n2Mk495WaefWCDnLDGqxupo/Gz+bL3AMtq
         t1G0VneNm01TbZKgPE6sC9PL7u2ZjjYy5giMabPqXikr5M0utSgDbWpYG2SbVxDCAG0U
         UbDObXbJ5Kr/2pmdlL3giBz0f+QWddYhlDfZV3TIuccPOw9TKRl24OqFwwT2vE3+H3wQ
         rsC4u8k9i8aD7RSzvyBizq4Nxi4qIbIZsJdaK2tXVLxIXr6Yqk2bB6iSCDerQrYrWYwE
         gx4w==
X-Gm-Message-State: AJIora/CJomajoJNywYnych37anvNNgqOY+H6ZecCOsRy4yukkKfSF5r
        eRwDoxcHRNJfTZH13IuezOwoHw==
X-Google-Smtp-Source: AGRyM1u7AMj7GkfbB3EyA7uxddW7w0Or4OxuSPugOlKsXFvBWgXG7+x3nFx/fqpi5m0+YBUIZ0NXMw==
X-Received: by 2002:a17:903:2686:b0:16b:d663:5b4f with SMTP id jf6-20020a170903268600b0016bd6635b4fmr2773886plb.129.1657273817282;
        Fri, 08 Jul 2022 02:50:17 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id c18-20020a621c12000000b0051bbd79fc9csm28551035pfc.57.2022.07.08.02.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 02:50:16 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 1/2] arm64: run softirqs on the per-CPU IRQ stack
Date:   Fri,  8 Jul 2022 17:49:49 +0800
Message-Id: <20220708094950.41944-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220708094950.41944-1-zhengqi.arch@bytedance.com>
References: <20220708094950.41944-1-zhengqi.arch@bytedance.com>
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

Currently arm64 supports per-CPU IRQ stack, but softirqs
are still handled in the task context.

Since any call to local_bh_enable() at any level in the task's
call stack may trigger a softirq processing run, which could
potentially cause a task stack overflow if the combined stack
footprints exceed the stack's size, let's run these softirqs
on the IRQ stack as well.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/arm64/Kconfig      |  1 +
 arch/arm64/kernel/irq.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4c1e1d2d2f8b..be0a9f0052ee 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -230,6 +230,7 @@ config ARM64
 	select HAVE_ARCH_USERFAULTFD_MINOR if USERFAULTFD
 	select TRACE_IRQFLAGS_SUPPORT
 	select TRACE_IRQFLAGS_NMI_SUPPORT
+	select HAVE_SOFTIRQ_ON_OWN_STACK
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index bda49430c9ea..c36ad20a52f3 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -22,6 +22,7 @@
 #include <linux/vmalloc.h>
 #include <asm/daifflags.h>
 #include <asm/vmap_stack.h>
+#include <asm/exception.h>
 
 /* Only access this in an NMI enter/exit */
 DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
@@ -71,6 +72,18 @@ static void init_irq_stacks(void)
 }
 #endif
 
+#ifndef CONFIG_PREEMPT_RT
+static void ____do_softirq(struct pt_regs *regs)
+{
+	__do_softirq();
+}
+
+void do_softirq_own_stack(void)
+{
+	call_on_irq_stack(NULL, ____do_softirq);
+}
+#endif
+
 static void default_handle_irq(struct pt_regs *regs)
 {
 	panic("IRQ taken without a root IRQ handler\n");
-- 
2.20.1

