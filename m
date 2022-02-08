Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968A84ADE16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382926AbiBHQQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382881AbiBHQQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:16:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678AC061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:16:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DC75616AD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 16:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B65C340EF;
        Tue,  8 Feb 2022 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644337006;
        bh=RqIk4EnOdjCYrxJGCZyCg+wmvIsqy3TKXzcC2Wpnv+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rLOx/H7YJ24xl8oOEqYH0a0xEAGRe469GYLbMo1UGHz8Vkqa5QhUkXk/Y321AOVmm
         OkoTr8rBESWWnjjicWK0As70+z6d66hPsIMgFG5uO5lxEzJDpntZgVsGia7sLSeYfP
         QY59mNjPG1uFO/0rmkg63cErj1u3ZHYqgjkF3jKyurRAObaFprzTA5+6dfY0aIwTLm
         gbukNz1jzR6Qxmp1BpPkZWPJaONKVQYgS7Qvf/6khVdm14RpbZBi22ftmPQqCwM/b4
         hRZLkSBIuUamZgeGXfIoE1mfVPBNA8q/pVlmilDh5isaHD71x+l0+GftJSPT8BLfGF
         +Lvu989ljuGHA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 3/3] lib/irq_poll: Declare IRQ_POLL softirq vector as ksoftirqd-parking safe
Date:   Tue,  8 Feb 2022 17:16:35 +0100
Message-Id: <20220208161635.544701-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208161635.544701-1-frederic@kernel.org>
References: <20220208161635.544701-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning may appear while setting a CPU down:

	NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #20!!!

The IRQ_POLL_SOFTIRQ vector can be raised during the hotplug cpu_down()
path after ksoftirqd is parked and before the CPU actually dies. However
this is handled afterward at the CPUHP_IRQ_POLL_DEAD stage where the
queue gets migrated.

Hence this warning can be considered spurious and the vector can join
the "hotplug-safe" list.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>
---
 include/linux/interrupt.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 9613326d2f8a..f40754caaefa 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -580,12 +580,15 @@ enum
 };
 
 /*
- * Ignoring the RCU vector after ksoftirqd is parked is fine
- * because:
- * 	1) rcutree_migrate_callbacks() takes care of the queue.
+ * The following vectors can be safely ignored after ksoftirqd is parked:
+ *
+ * _ RCU:
+ * 	1) rcutree_migrate_callbacks() migrates the queue.
  * 	2) rcu_report_dead() reports the final quiescent states.
+ *
+ * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
  */
-#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ))
+#define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ))
 
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
-- 
2.25.1

