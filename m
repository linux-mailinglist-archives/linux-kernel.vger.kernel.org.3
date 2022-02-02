Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E344A7BD9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 00:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348112AbiBBXqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 18:46:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49814 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbiBBXqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 18:46:15 -0500
Date:   Wed, 02 Feb 2022 23:46:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643845573;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/7J6Whu3CFL+jNQDCUdQnraWwAMc9erfGD8AhWuac0=;
        b=JNHfVYUGxRYCtfC+5e/fCpneet8smBAH0H7uOaZtWWgAsz0FN0bxS9WTjJvr7i9c4V0nrW
        HF7yfisTQokEa1tuT9Dd1s0PbSDIWdirlIJ1tEjaKafTCEtSikErNjdx7oSSA+cDYhRm+K
        RBdStHmiX45ywHlOt/PKciqOqblDJHU721wihsPU5EHJgLXqzA2vdf81Fqgh8oTmt+aks9
        f2OTKrHs0ant7vkC4rBv1rtLmTcMcvjRC3avOrMpZy/iehvVIttYa8Ly1UkKeP6bDM5B7w
        +xZMqWetmw0RjVNJM+zTz4zZXCuC5uvOPi9imnaWAZdSwvFxibCJwyHmj1LiQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643845573;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/7J6Whu3CFL+jNQDCUdQnraWwAMc9erfGD8AhWuac0=;
        b=JpKPT4uR3gAtwzCBy3p9kd3Z1uWGQVtgAu03sBkXcXaANeVtl6nJSKa4fONqEgf+wZRbDi
        ZqBiOD2/pWXdOLCg==
From:   "tip-bot2 for Changbin Du" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq, softirq: Use in_hardirq() instead of in_irq()
Cc:     Changbin Du <changbin.du@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220128110727.5110-1-changbin.du@gmail.com>
References: <20220128110727.5110-1-changbin.du@gmail.com>
MIME-Version: 1.0
Message-ID: <164384557168.16921.14390759669030795809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fe13889c390e14205e064d7e159e61eb5da4b1c3
Gitweb:        https://git.kernel.org/tip/fe13889c390e14205e064d7e159e61eb5da4b1c3
Author:        Changbin Du <changbin.du@gmail.com>
AuthorDate:    Fri, 28 Jan 2022 19:07:27 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Feb 2022 21:34:19 +01:00

genirq, softirq: Use in_hardirq() instead of in_irq()

Replace the obsolete and ambiguos macro in_irq() with the new macro
in_hardirq().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220128110727.5110-1-changbin.du@gmail.com

---
 kernel/irq/irqdesc.c |  4 ++--
 kernel/softirq.c     | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 2267e65..6167d32 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -640,7 +640,7 @@ int handle_irq_desc(struct irq_desc *desc)
 		return -EINVAL;
 
 	data = irq_desc_get_irq_data(desc);
-	if (WARN_ON_ONCE(!in_irq() && handle_enforce_irqctx(data)))
+	if (WARN_ON_ONCE(!in_hardirq() && handle_enforce_irqctx(data)))
 		return -EPERM;
 
 	generic_handle_irq_desc(desc);
@@ -676,7 +676,7 @@ EXPORT_SYMBOL_GPL(generic_handle_irq);
  */
 int generic_handle_domain_irq(struct irq_domain *domain, unsigned int hwirq)
 {
-	WARN_ON_ONCE(!in_irq());
+	WARN_ON_ONCE(!in_hardirq());
 	return handle_irq_desc(irq_resolve_mapping(domain, hwirq));
 }
 EXPORT_SYMBOL_GPL(generic_handle_domain_irq);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 41f4709..fac8018 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -222,7 +222,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	u32 pending;
 	int curcnt;
 
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 
 	local_irq_save(flags);
@@ -305,7 +305,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
 
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 
 	raw_local_irq_save(flags);
 	/*
@@ -352,14 +352,14 @@ static void __local_bh_enable(unsigned int cnt)
  */
 void _local_bh_enable(void)
 {
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 	__local_bh_enable(SOFTIRQ_DISABLE_OFFSET);
 }
 EXPORT_SYMBOL(_local_bh_enable);
 
 void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 {
-	WARN_ON_ONCE(in_irq());
+	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_disable();
@@ -618,7 +618,7 @@ static inline void tick_irq_exit(void)
 
 	/* Make sure that timer wheel updates are propagated */
 	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
-		if (!in_irq())
+		if (!in_hardirq())
 			tick_nohz_irq_exit();
 	}
 #endif
