Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2266F506070
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236648AbiDSADa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiDSAC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:02:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31DC13D54;
        Mon, 18 Apr 2022 17:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F686B81136;
        Tue, 19 Apr 2022 00:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1D6C385AB;
        Tue, 19 Apr 2022 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326416;
        bh=nsc9VJDf4f5ASTnU9OeOCzg1hO7iWgQlVPIuzBYroJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BZmWSSGFrRg4/kZ/0YNd1hYx4XjeAnFMLHBAdEknFyG/ehMZuMvfSThB4Mpdce4k4
         8RU424Da2WIzitATEkKdisC3WVsi5cnuGHwLbRnshBsavj+ZojxfnqRawnrOKLD2X7
         yiPuXXwC4nydQ60sXFDMTVYYymKUMwEYtJ9XBeA4GTGtu/zKV/WGP2VMh1BxzmkzZX
         rP0UCgMVjCv6i7GiKE5c7yTWJZP6cfZYI5LbfYq2cC1snGSSqS+NL+Aw5ht0QlVZta
         hMN9HPOnMZK0nIQNvEf1T09V/YrohPMqZV/I5GFT7+4+4+rsLVdqqFL6Tc9ABkdUiY
         6p/jYwVz9MTlw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DF4045C0A23; Mon, 18 Apr 2022 17:00:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/9] rcu-tasks: Use schedule_hrtimeout_range() to wait for grace periods
Date:   Mon, 18 Apr 2022 17:00:10 -0700
Message-Id: <20220419000014.3948512-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000007.GA3945818@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The synchronous RCU-tasks grace-period-wait primitives invoke
schedule_timeout_idle() to give readers a chance to exit their
read-side critical sections.  Unfortunately, this fails during early
boot on PREEMPT_RT because PREEMPT_RT relies solely on ksoftirqd to run
timer handlers.  Because ksoftirqd cannot operate until its kthreads
are spawned, there is a brief period of time following scheduler
initialization where PREEMPT_RT cannot run the timer handlers that
schedule_timeout_idle() relies on, resulting in a hang.

To avoid this boot-time hang, this commit replaces schedule_timeout_idle()
with schedule_hrtimeout(), so that the timer expires in hardirq context.
This is ensures that the timer fires even on PREEMPT_RT throughout the
irqs-enabled portions of boot as well as during runtime.

The timer is set to expire between fract and fract + HZ / 2 jiffies in
order to align with any other timers that might expire during that time,
thus reducing the number of wakeups.

Note that RCU-tasks grace periods are infrequent, so the use of hrtimer
should be fine.  In contrast, in common-case code, user of hrtimer
could result in performance issues.

Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4b91cb214ca7..71fe340ab82a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -647,13 +647,16 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	fract = rtp->init_fract;
 
 	while (!list_empty(&holdouts)) {
+		ktime_t exp;
 		bool firstreport;
 		bool needreport;
 		int rtst;
 
 		// Slowly back off waiting for holdouts
 		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
-		schedule_timeout_idle(fract);
+		exp = jiffies_to_nsecs(fract);
+		__set_current_state(TASK_IDLE);
+		schedule_hrtimeout_range(&exp, jiffies_to_nsecs(HZ / 2), HRTIMER_MODE_REL_HARD);
 
 		if (fract < HZ)
 			fract++;
-- 
2.31.1.189.g2e36527f23

