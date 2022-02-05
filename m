Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E804AA4FF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378754AbiBEAVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:21:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44282 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378744AbiBEAVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:21:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82EA461D2D;
        Sat,  5 Feb 2022 00:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EBEC340EF;
        Sat,  5 Feb 2022 00:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644020508;
        bh=WXblkqT6O0JAXTslrDVXvWINN/201DrtAA/EuNg83dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lx9zRbO1WXr8DIlBd7A/tPHQz0l+3TkjSJ3n+XsQzsKZURGG5u+n0FdPt42Yvu+0L
         rJLRqr0i8Zpsol1E5xpi5uza/ZsweJZAtjeq5ERG3d0Gm+el9EFa3w03jtteqWkxCb
         LDZvILEc0pmU65Yx3B0xaIqa+VZF8w6T9BUPzfsNxEMoMHTqVRysdEDTA5DqUc5zvC
         Yx9Bz9NOSzp5I6WXd1+03W8dLCIB9A/flxe4mFa/Nn0BwLuUPv4UOWpDUzIVuozeYQ
         xKsMqIGs9wWgSVY8TlzuKzd5lPG7zYNEpICz91STTz5NBLW0Ecv8+6gt3Dqk4x8Fwf
         Pf42gNhDLLAQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B43275C0829; Fri,  4 Feb 2022 16:21:48 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 2/2] rcu-tasks: Set ->percpu_enqueue_shift to zero upon contention
Date:   Fri,  4 Feb 2022 16:21:47 -0800
Message-Id: <20220205002147.4828-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220205002113.GA4693@paulmck-ThinkPad-P17-Gen-1>
References: <20220205002113.GA4693@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, call_rcu_tasks_generic() sets ->percpu_enqueue_shift to
order_base_2(nr_cpu_ids) upon encountering sufficient contention.
This does not shift to use of non-CPU-0 callback queues as intended, but
rather continues using only CPU 0's queue.  Although this does provide
some decrease in contention due to spreading work over multiple locks,
it is not the dramatic decrease that was intended.

This commit therefore makes call_rcu_tasks_generic() set
->percpu_enqueue_shift to 0.

Reported-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index c0fc3641ef13a..d73e32d803438 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -302,7 +302,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	if (unlikely(needadjust)) {
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim != nr_cpu_ids) {
-			WRITE_ONCE(rtp->percpu_enqueue_shift, order_base_2(nr_cpu_ids));
+			WRITE_ONCE(rtp->percpu_enqueue_shift, 0);
 			WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
 			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
 			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
-- 
2.31.1.189.g2e36527f23

