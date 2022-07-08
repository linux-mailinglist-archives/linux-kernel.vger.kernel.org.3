Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D275E56B5FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiGHJu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237851AbiGHJuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:50:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322278149D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:50:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j12so9142101plj.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 02:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CInbfRCxTX+lwwkZS0ynkKJhKDRk8XEefCQvvOFfbPc=;
        b=ClhBVlZfVVoQ+wE0Sn6Rnn1/9c8DzQQe6ttcNMbc2xCavg3qotM59YLWu/VmdcfDjC
         2DJ0fsVR6N6KQUBChyvfwf78+eeIySZ3Gd+rrBvOc1Zwpxqk0SPqZuJDlaPMbZ8q2uuv
         UbHbx3qw3QiWfWMGiH3eUEdJuZjQ1icnwBtF7/+KfuV14dv4X3q8TQRtjMyFxWQ2idjz
         kUttfKOA/lct8cgjojawMCX32ZbjJsFfkyjnQho4+dLR9Bg9QKmSo7/dilbHTPw9XkVN
         K3KP3eroLTaBUHozYSNI19itv3VkatfEFZ8jLYOpUSjAluVakIZi3REAXmjCe45f0Mot
         aULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CInbfRCxTX+lwwkZS0ynkKJhKDRk8XEefCQvvOFfbPc=;
        b=0whSovoWVbA77A89CjrUO9l8SGwrRAepZ8gnFSykNUpnJ1ka+QLrf+VaOF7WjKaLtP
         DWu3qIaPERadSW2eHsJ5Ad2z50srvQ0S3cWGlFsZWDHdKP7Nl/hU+afGDfNPhCNfeQe8
         Mmgd1e2Kl59kERGEwhVBqw+mTNYyhFk0X0MFrRZXF71zVJzkAKvoGfwWuGvXo+ZJdI0t
         UHs8+P6rr7AyKWBSK4mItOdCVFfg3k4sK27BUz7cIpVt7SrGgGjEau7F2wmf/7Z3tJMa
         p6KW2KqFzTJfGOgdoi8UDBq6JPoaUHJYZTob3X980yd57FzkcPVO/tjQfPfEFtLQpqnK
         yujw==
X-Gm-Message-State: AJIora+KrYapYVGgHePc13ZgxHi/ySZl5TCnR2Eu5/mQNRGxkzwjl4kM
        LebogtxBFKPIIUl3qAtAjC9mJJlyspzv7A==
X-Google-Smtp-Source: AGRyM1tG2M7PjSIqi4dbhDxtx2UUOUHT2lI/8aPRs4+wPizXPgf2JHK3Q0g43E1i3OBy9b5r+6gNhA==
X-Received: by 2002:a17:902:c992:b0:16b:d8b9:1c5f with SMTP id g18-20020a170902c99200b0016bd8b91c5fmr2786028plc.93.1657273820740;
        Fri, 08 Jul 2022 02:50:20 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id c18-20020a621c12000000b0051bbd79fc9csm28551035pfc.57.2022.07.08.02.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 02:50:20 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 2/2] arm64: support HAVE_IRQ_EXIT_ON_IRQ_STACK
Date:   Fri,  8 Jul 2022 17:49:50 +0800
Message-Id: <20220708094950.41944-3-zhengqi.arch@bytedance.com>
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
index be0a9f0052ee..d2cc7daecce3 100644
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
index c36ad20a52f3..003db605bc4f 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -73,14 +73,15 @@ static void init_irq_stacks(void)
 #endif
 
 #ifndef CONFIG_PREEMPT_RT
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
 #endif
 
-- 
2.20.1

