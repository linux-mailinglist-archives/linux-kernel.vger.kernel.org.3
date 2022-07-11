Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D010A5708D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiGKRYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiGKRYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:24:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB06545EB;
        Mon, 11 Jul 2022 10:23:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w185so5333845pfb.4;
        Mon, 11 Jul 2022 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rvxfrVG0Mm4wXtw9yt0JSCd2txuXR8C99E8tNu8cTUs=;
        b=Ti9ZT6CQLlREHmFG/2KWscgIQsZgijKmybLk3UtvTdC26CNgTRjIi23V7FmyzGTJsu
         9K2/D98BioiJfscK/rOKF59aSVRlH7nJKJGFSrgdDHTc9yXnuzlF0ECV43fNY57Ze/IS
         uhf8ZJoc9aWAPJ2n6ApM8utzCmMPGPyZBgfJx8csIv+7fPBPTbsoUsS7Z4+fPBeKS4b/
         H6XCKY6D/AbfVTHvZrHRv2LCC3N9XKrpwDLMk3MLSDjVAv02L+6Tkbc9Rss6vE7mOu7o
         gvtNnAFLaJDegXQco34fmHlkL+Z7k6kNkyLqdWRLuUZP+cvgZ0azLXZn+vaxCOyKQ7np
         R0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rvxfrVG0Mm4wXtw9yt0JSCd2txuXR8C99E8tNu8cTUs=;
        b=AJGci/m62ouDaR13ueVx27sk/7ccqf+YkpPEeXFULLRQ3grEcA3vWr7VXkuJozIWv+
         BshOhma/icdP1Gs/FbcpxhCqi8WQvaSTy2X9pcP44YpCYMAHk5VQYGQZ8RoO+dPBnkzO
         uwkeIWTSVT3YSkrA5rpU4pqfDw17XUqESxJen296nqBhLHns3C3nxYRyaPNjrtBlF8j+
         IT4XAmhKWhzum//m0qKiSQnEnMtZujbVQD/JHhZR4LEHUqzt1LjagCIJwDHGgZTC080S
         lD/x7aqypg3IrsvoK3TzwFYFZyeUVafEu20V+6mj4OEbXrtEOQXgdwPA/CBHA77TGmSy
         fw7Q==
X-Gm-Message-State: AJIora/9LeOng4y8WQQRNWuTelfJ7QT+ZR+Iz683MinA8l3v7apnaIPi
        pgtbic8f2H47tfOiI8V3NvU=
X-Google-Smtp-Source: AGRyM1s3+/QpShVw7Ek4MerBvg8nNobEica4T7ApoftzFsj4uX/q6S6QeERcJojdtCLaoQTXHv2Mdg==
X-Received: by 2002:a63:4b60:0:b0:418:78e:93d8 with SMTP id k32-20020a634b60000000b00418078e93d8mr440758pgl.74.1657560238551;
        Mon, 11 Jul 2022 10:23:58 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id d124-20020a623682000000b00528d4f647f2sm5183369pfa.91.2022.07.11.10.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:23:57 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     bigeasy@linutronix.de, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Schspa Shi <schspa@gmail.com>
Subject: [RFC PATCH] irq_work: wakeup irq_workd when queued first rt_lazy work
Date:   Tue, 12 Jul 2022 01:23:15 +0800
Message-Id: <20220711172314.603717-1-schspa@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b4c6f86ec2f64
("irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT")
treat all irq_work without IRQ_WORK_HARD_IRQ flags to the lazy_list
in PREEMPT_RT. But this kind of irq_work still has some difference
with IRQ work set IRQ_WORK_LAZY. The difference as fellowing:

- With IRQ_WORK_LAZY: (type1)
  This kind of work will be executed after the next time tick by wakeup
  irq_workd, there will be more scheduling delays.

  Let's mark this as type1

- Without IRQ_WORK_LAZY and IRQ_WORK_HARD_IRQ: (type2)
  This kind of irq_work will have a faster response speed by wakeup
  irq_workd from IPI interrupt.

  Let's mark it as type2

I want to know if this difference is by design.

If this is by design, we have a problem that the irq_work of type2
will not execute as quickly as expected, it may be delayed by the
irq_work of type1.

Please consider the following scenarios:

If the CPU queued a type1 irq_work A, and then a type2 irq_work B.
But we won't make B executed quickly, because we won't issue the IPI
interrupt to wakeup irq_workd (the llist_add call will return false).

This PATCH will issue the IPI_IRQ_WORK to make B execute quickly.

One thing that needs to be optimized is that we now have
lazy_list.node.llist and lazy_work_raised which need to be granted
to be atomicity, disabled the local CPU IRQ to make this atomic.
There should be a better way to make these two variants to be atomically
and I can go in deep if this little problem is not by design, and need
to be fixed.

If these two types of irq_work should be the same with the priority.
maybe we should change.

if (!lazy_work || tick_nohz_tick_stopped()) {
	arch_irq_work_raise();
}

to

if (!(lazy_work || rt_lazy_work) || tick_nohz_tick_stopped()) {
	arch_irq_work_raise();
}

I'm uploading this patch just to explain the problem, hopefully
don't pay too much attention to the ugly changes below.

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 kernel/irq_work.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc43..d5d0b720fac15 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -25,6 +25,7 @@
 static DEFINE_PER_CPU(struct llist_head, raised_list);
 static DEFINE_PER_CPU(struct llist_head, lazy_list);
 static DEFINE_PER_CPU(struct task_struct *, irq_workd);
+static DEFINE_PER_CPU(bool, lazy_work_raised);
 
 static void wake_irq_workd(void)
 {
@@ -81,6 +82,7 @@ static void __irq_work_queue_local(struct irq_work *work)
 	bool rt_lazy_work = false;
 	bool lazy_work = false;
 	int work_flags;
+	unsigned long flags;
 
 	work_flags = atomic_read(&work->node.a_flags);
 	if (work_flags & IRQ_WORK_LAZY)
@@ -94,12 +96,35 @@ static void __irq_work_queue_local(struct irq_work *work)
 	else
 		list = this_cpu_ptr(&raised_list);
 
-	if (!llist_add(&work->node.llist, list))
+	local_irq_save(flags);
+	if (!llist_add(&work->node.llist, list)) {
+		bool irq_raised;
+		/*
+		 * In PREEMPT_RT, if we add a lazy work added to the list
+		 * before, the work maybe not raised. We need a extra check
+		 * for PREEMPT_RT.
+		 */
+		irq_raised = !xchg(this_cpu_ptr(&lazy_work_raised), true);
+		local_irq_restore(flags);
+		if (unlikely(!irq_raised))
+			arch_irq_work_raise();
+
 		return;
+	}
 
 	/* If the work is "lazy", handle it from next tick if any */
-	if (!lazy_work || tick_nohz_tick_stopped())
+	if (!lazy_work || tick_nohz_tick_stopped()) {
+		(void) xchg(this_cpu_ptr(&lazy_work_raised), true);
+		local_irq_restore(flags);
 		arch_irq_work_raise();
+	} else if (lazy_work || rt_lazy_work) {
+		/*
+		 * The first added irq work not raise a irq work, we need to
+		 * raise one for the next added irq work.
+		 */
+		(void) xchg(this_cpu_ptr(&lazy_work_raised), false);
+		local_irq_restore(flags);
+	}
 }
 
 /* Enqueue the irq work @work on the current CPU */
@@ -151,9 +176,18 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
 		 */
 		if (IS_ENABLED(CONFIG_PREEMPT_RT) &&
 		    !(atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ)) {
+			unsigned long flags;
+
+			local_irq_save(flags);
+			if (!llist_add(&work->node.llist, &per_cpu(lazy_list, cpu))) {
+				if (!xchg(this_cpu_ptr(&lazy_work_raised), true))
+					arch_irq_work_raise();
 
-			if (!llist_add(&work->node.llist, &per_cpu(lazy_list, cpu)))
+				local_irq_restore(flags);
 				goto out;
+			}
+			(void) xchg(this_cpu_ptr(&lazy_work_raised), true);
+			local_irq_restore(flags);
 
 			work = &per_cpu(irq_work_wakeup, cpu);
 			if (!irq_work_claim(work))
-- 
2.37.0

