Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975BD56A0DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbiGGLGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234799AbiGGLGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:06:05 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FFD2F00D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 04:06:04 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o18so16660167pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 04:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0rE1v9ONr28BkWdPM3nxjfIYuOOL3YuVoqV9XeUl+AE=;
        b=ljb3Ar3ozqk8TtOYXJ76znXwwMrVo/bdbZaHaMq1YTH3a28/N2+1eY9jSorWeI5+0C
         +y/mBBI/u381rSRni2JbN6Y/q9s6DZihyqqGCnz1etwRRslNwDE+TepaTpc31cIOqZgQ
         wV2BKX7V4dbYbbdqGVTnSqOmOA6jyjN0kZcWL8GbQc5kUUTQYcs8VdYZf4nrMRNU/SCQ
         +eEl/byJmKFXBKCXVjMvSl3UzUs2Jr6NA5zVQ0gogDCbE0OChEsyj6zuUsMUlPfqjOe5
         faQ0F61Ei0Ii2l1SyrzpX4huiFP1ErMG72AXetMCMzHMkYfgeuOvIqgF7QxP1PKNQpNH
         yHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0rE1v9ONr28BkWdPM3nxjfIYuOOL3YuVoqV9XeUl+AE=;
        b=RuvtMUE2J7htRl5wXGmTM/g2rHc3/UMB4t1VmV5K35oXo8Nq/D0P7+EJCW/PL9YZFI
         OlelCi9xDiynJzAlc3fffoncom/w9dKT2NXkVBreSyEQ86Wd+APKDm3vnvEF9/KyJ0Iv
         uFC4wYWek7Gj/zo1GwqfJ1a9DdE9GPaowTz4ZECPfmWB9LMbRbgXbpgtXPpSfBjK04L5
         MEU6himWocsoLta+tfCjRRKUmR327uQUwLSGR8EniS76Uo5YN8GZs5iAjcgOg6IAzB+0
         onu3dRb3cVQfZ4rmNl42pSnoOi9MMQrdi9zzXUllxm9YVJMKjSWN3ndele22OhwAVI5x
         QGdw==
X-Gm-Message-State: AJIora8eMfbEFmVATGa9A/tc4+Y6t9NMSkXThY5YSuGtJoTBgn88iLRT
        7+JLX1f/zCD/Is0QzGIhdsLl+yj5BgB6aQ==
X-Google-Smtp-Source: AGRyM1t8BOMQQikPZMARvP7l4hhlXzBGqMI70Us8ad+5zsJvgcRagUnPKLaqTtGYWKTiJ7SWuHPIFQ==
X-Received: by 2002:a05:6a00:14d3:b0:528:486d:d576 with SMTP id w19-20020a056a0014d300b00528486dd576mr29182793pfu.24.1657191963643;
        Thu, 07 Jul 2022 04:06:03 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id 72-20020a62174b000000b005289a50e4c2sm1046403pfx.23.2022.07.07.04.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 04:06:03 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
Date:   Thu,  7 Jul 2022 19:05:11 +0800
Message-Id: <20220707110511.52129-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
References: <20220707110511.52129-1-zhengqi.arch@bytedance.com>
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

Since softirqs are handled on the per-CPU IRQ stack,
let's support HAVE_IRQ_EXIT_ON_IRQ_STACK which causes
the core code to invoke __do_softirq() directly without
going through do_softirq_own_stack().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 arch/arm64/Kconfig                 |  1 +
 arch/arm64/include/asm/exception.h |  4 +++-
 arch/arm64/kernel/entry-common.c   | 30 ++++++++++++++++++++----------
 arch/arm64/kernel/entry.S          |  6 ++++--
 arch/arm64/kernel/irq.c            |  5 +++--
 5 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 402e16fec02a..89f6368b705e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -231,6 +231,7 @@ config ARM64
 	select TRACE_IRQFLAGS_SUPPORT
 	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select HAVE_SOFTIRQ_ON_OWN_STACK
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index d94aecff9690..8bff0aa7ab50 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -54,7 +54,9 @@ asmlinkage void el0t_32_fiq_handler(struct pt_regs *regs);
 asmlinkage void el0t_32_error_handler(struct pt_regs *regs);
 
 asmlinkage void call_on_irq_stack(struct pt_regs *regs,
-				  void (*func)(struct pt_regs *));
+				  void (*func)(struct pt_regs *),
+				  void (*do_func)(struct pt_regs *,
+						  void (*)(struct pt_regs *)));
 asmlinkage void asm_exit_to_user_mode(struct pt_regs *regs);
 
 void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs);
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index c75ca36b4a49..935d1ab150b5 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -266,14 +266,16 @@ static void __sched arm64_preempt_schedule_irq(void)
 }
 
 static void do_interrupt_handler(struct pt_regs *regs,
-				 void (*handler)(struct pt_regs *))
+				 void (*handler)(struct pt_regs *),
+				 void (*do_handler)(struct pt_regs *,
+						    void (*)(struct pt_regs *)))
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
 	if (on_thread_stack())
-		call_on_irq_stack(regs, handler);
+		call_on_irq_stack(regs, handler, do_handler);
 	else
-		handler(regs);
+		do_handler(regs, handler);
 
 	set_irq_regs(old_regs);
 }
@@ -441,22 +443,32 @@ asmlinkage void noinstr el1h_64_sync_handler(struct pt_regs *regs)
 	}
 }
 
+static void nmi_handler(struct pt_regs *regs, void (*handler)(struct pt_regs *))
+{
+	handler(regs);
+}
+
 static __always_inline void __el1_pnmi(struct pt_regs *regs,
 				       void (*handler)(struct pt_regs *))
 {
 	arm64_enter_nmi(regs);
-	do_interrupt_handler(regs, handler);
+	do_interrupt_handler(regs, handler, nmi_handler);
 	arm64_exit_nmi(regs);
 }
 
+static void irq_handler(struct pt_regs *regs, void (*handler)(struct pt_regs *))
+{
+	irq_enter_rcu();
+	handler(regs);
+	irq_exit_rcu();
+}
+
 static __always_inline void __el1_irq(struct pt_regs *regs,
 				      void (*handler)(struct pt_regs *))
 {
 	enter_from_kernel_mode(regs);
 
-	irq_enter_rcu();
-	do_interrupt_handler(regs, handler);
-	irq_exit_rcu();
+	do_interrupt_handler(regs, handler, irq_handler);
 
 	arm64_preempt_schedule_irq();
 
@@ -699,9 +711,7 @@ static void noinstr el0_interrupt(struct pt_regs *regs,
 	if (regs->pc & BIT(55))
 		arm64_apply_bp_hardening();
 
-	irq_enter_rcu();
-	do_interrupt_handler(regs, handler);
-	irq_exit_rcu();
+	do_interrupt_handler(regs, handler, irq_handler);
 
 	exit_to_user_mode(regs);
 }
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 254fe31c03a0..1c351391f6bd 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -867,7 +867,9 @@ NOKPROBE(ret_from_fork)
 
 /*
  * void call_on_irq_stack(struct pt_regs *regs,
- * 		          void (*func)(struct pt_regs *));
+ * 		          void (*func)(struct pt_regs *)
+ * 			  void (*do_func)(struct pt_regs *,
+ *					  void (*)(struct pt_regs *)));
  *
  * Calls func(regs) using this CPU's irq stack and shadow irq stack.
  */
@@ -886,7 +888,7 @@ SYM_FUNC_START(call_on_irq_stack)
 
 	/* Move to the new stack and call the function there */
 	mov	sp, x16
-	blr	x1
+	blr	x2
 
 	/*
 	 * Restore the SP from the FP, and restore the FP and LR from the frame
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index e6aa37672fd4..54cd418d47ef 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -72,14 +72,15 @@ static void init_irq_stacks(void)
 }
 #endif
 
-static void ____do_softirq(struct pt_regs *regs)
+static void ____do_softirq(struct pt_regs *regs,
+			   void (*handler)(struct pt_regs *))
 {
 	__do_softirq();
 }
 
 void do_softirq_own_stack(void)
 {
-	call_on_irq_stack(NULL, ____do_softirq);
+	call_on_irq_stack(NULL, NULL, ____do_softirq);
 }
 
 static void default_handle_irq(struct pt_regs *regs)
-- 
2.20.1

