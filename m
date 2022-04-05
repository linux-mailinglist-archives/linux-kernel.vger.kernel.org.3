Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678974F475E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350778AbiDEVJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573545AbiDETUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:20:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72D7EBBBA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:18:07 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649186285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0nMItS7qCqiegQo1A0e1KdGXtjDBwpycBrPJsybEUo4=;
        b=sqKyNsLO5ZRoqbbiCvhK4JaM38b2Mh2U8EcEaUtUTi0Vr2lMQd75f4QVZgK3KRt315reLO
        SEkBpNt9baSqJ30dqbOi0YC5FMw2QI8Buj1hMfM9WbbYgX/C1+GozpZju6eWxVUgPpE1Ek
        RDUxuE41XelLEzZ4zFefIZVcvbO+f08HaqNxyA5lJ/SmAI2XG+uFUxFIfOBTBNipyTvUgd
        iEvKZGDwzpCQoHtsfBqe+L589sP7qqklNM+EdmGOy02fOZrEPfLqiinQ8sULVQNn5W3qJw
        Jgwzkofl4e6P/UfYZxBVUZy4Z42gt3Xd/25xfm2NmgkcYAAcGVmszRn4YN79lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649186285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0nMItS7qCqiegQo1A0e1KdGXtjDBwpycBrPJsybEUo4=;
        b=UUiXZZ4R04IUae1XNwVeR9Id8vQHmedvNK6eK3BV+Q9Ex4IVQRaq+wpNTSPFdKyA74yH4w
        B8Lj7QAuE1ljh7CQ==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/2] timers: Fix warning in __run_timers()
Date:   Tue,  5 Apr 2022 21:17:32 +0200
Message-Id: <20220405191732.7438-3-anna-maria@linutronix.de>
In-Reply-To: <20220405191732.7438-1-anna-maria@linutronix.de>
References: <20220405191732.7438-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the timer base is empty, base::next_expiry is set to base::clk +
NEXT_TIMER_MAX_DELTA and base::next_expiry_recalc is false. When no timer
is queued until jiffies reaches base::next_expiry value, the warning for
not finding any expired timer and base::next_expiry_recalc is false in
__run_timers() triggers.

To prevent triggering the warning in this valid scenario
base::timers_pending needs to be added to the warning condition.

Fixes: 31cd0e119d50 ("timers: Recalculate next timer interrupt only when necessary")
Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4af98e77cd78..204d6cd83d0e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1722,11 +1722,14 @@ static inline void __run_timers(struct timer_base *base)
 	       time_after_eq(jiffies, base->next_expiry)) {
 		levels = collect_expired_timers(base, heads);
 		/*
-		 * The only possible reason for not finding any expired
-		 * timer at this clk is that all matching timers have been
-		 * dequeued.
+		 * The two possible reasons for not finding any expired
+		 * timer at this clk are that all matching timers have been
+		 * dequeued or no timer has been queued since
+		 * base::next_expiry was set to base::clk +
+		 * NEXT_TIMER_MAX_DELTA.
 		 */
-		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
+		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
+			     && base->timers_pending);
 		base->clk++;
 		base->next_expiry = __next_timer_interrupt(base);
 
-- 
2.20.1

