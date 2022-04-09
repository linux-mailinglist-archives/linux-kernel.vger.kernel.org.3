Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C944FAAB5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbiDIUZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiDIUYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:24:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F67814023;
        Sat,  9 Apr 2022 13:22:35 -0700 (PDT)
Date:   Sat, 09 Apr 2022 20:22:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649535754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flmJT8g3LkPf5OFtHiIqbiCsqW93S7VEn9FZTSp2FNs=;
        b=HHrFZRwepn6Z8zLuwababzH3L73AgF95BfVXPNLtdDjC+uKWNZZelJhk8GHW7TR6ov+S8M
        WszoWZl91loxRyCLvvmXO3akJXw7q+UnOP9rzh3gny2Sa9rJO8dgE0G5Nd9oU1Q3SJwZ8j
        OXNRrlyf3g9REnkjOfRF82Mzoa5UjVaK80GA6HvA0NiA6gfTcrtGKb+sMslRWi+Ibv9guw
        wcXxQo7aHxBKRPqsmNI3s7Wz9NNm4/PGsDHQ9vYWzQ6QsvijXuhaxH+gRUrQvGlpQwgNRf
        8oCkEsavrUtC1rlEYO7rYXsFU8WnOkebmcbP+g4ndI01fUuSmaaIqGQzEQtv6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649535754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=flmJT8g3LkPf5OFtHiIqbiCsqW93S7VEn9FZTSp2FNs=;
        b=14Sz1roVOUAcxj4ffYhAjQ/EDeD3x0A4HoUyKV6Dea6cAKweVXDS3TIIV75WeIx6ijOZJ0
        jEmaSClh7QpSsFDQ==
From:   "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Fix warning condition in __run_timers()
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405191732.7438-3-anna-maria@linutronix.de>
References: <20220405191732.7438-3-anna-maria@linutronix.de>
MIME-Version: 1.0
Message-ID: <164953575293.4207.16304445982254847122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c54bc0fc84214b203f7a0ebfd1bd308ce2abe920
Gitweb:        https://git.kernel.org/tip/c54bc0fc84214b203f7a0ebfd1bd308ce2abe920
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 05 Apr 2022 21:17:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 09 Apr 2022 22:17:47 +02:00

timers: Fix warning condition in __run_timers()

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20220405191732.7438-3-anna-maria@linutronix.de

---
 kernel/time/timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 85f1021..9dd2a39 100644
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
 
