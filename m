Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5AB548289
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbiFMIg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239397AbiFMIgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:36:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A814D2E;
        Mon, 13 Jun 2022 01:36:15 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:36:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655109374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzlzsjP48UtF0PJNcbhxAVOSOvbMnhjXg0V4T2/iJnY=;
        b=hshIlQXBMsgh6o7LyUzvoGdHiBJg6pjb1R8ukGA2DSKtaSUNZoilLFLDB+uxuB2WBC6EZL
        O2HVFfeUToPl8Yv7njTpvxsLZVX2pbA7hcvzsT4LrxM6+uY7nWzJmd5aC8zhHFjREuNbNE
        ftz6waA0HUZzH+lEGmBzL1fe++xMk+QaF8L8a5Q8GYKgsE/QTeN5QOgM6vxxQQuZZeNQoJ
        nHPEusBmsfafcYeoiUSwoaaCD/jAlRInQkytjBc0tWbj5pxfhWz41PAI/BjmpGlbfuBxyR
        v3egmrNty9aNlxR902DGv32/TAdWUXgRupPDjEYFPxC5W8fUgjRJuCYD1u9wVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655109374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzlzsjP48UtF0PJNcbhxAVOSOvbMnhjXg0V4T2/iJnY=;
        b=Uy58VG7f+ASbnjEBvp3yH9W79QORrFNtCw2VGyuMXrA76yUkbp19CzAfbiwiy4fqs1Y3O3
        jr1eLlJygPvZquCQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/lockdep: Use sched_clock() for random numbers
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YoNn3pTkm5+QzE5k@linutronix.de>
References: <YoNn3pTkm5+QzE5k@linutronix.de>
MIME-Version: 1.0
Message-ID: <165510937305.4207.6864911562240875202.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     4051a81774d6d8e28192742c26999d6f29bc0e68
Gitweb:        https://git.kernel.org/tip/4051a81774d6d8e28192742c26999d6f29bc0e68
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 17 May 2022 11:16:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:29:57 +02:00

locking/lockdep: Use sched_clock() for random numbers

Since the rewrote of prandom_u32(), in the commit mentioned below, the
function uses sleeping locks which extracing random numbers and filling
the batch.
This breaks lockdep on PREEMPT_RT because lock_pin_lock() disables
interrupts while calling __lock_pin_lock(). This can't be moved earlier
because the main user of the function (rq_pin_lock()) invokes that
function after disabling interrupts in order to acquire the lock.

The cookie does not require random numbers as its goal is to provide a
random value in order to notice unexpected "unlock + lock" sites.

Use sched_clock() to provide random numbers.

Fixes: a0103f4d86f88 ("random32: use real rng for non-deterministic randomness")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YoNn3pTkm5+QzE5k@linutronix.de
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 81e8728..f06b91c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5432,7 +5432,7 @@ static struct pin_cookie __lock_pin_lock(struct lockdep_map *lock)
 			 * be guessable and still allows some pin nesting in
 			 * our u32 pin_count.
 			 */
-			cookie.val = 1 + (prandom_u32() >> 16);
+			cookie.val = 1 + (sched_clock() & 0xffff);
 			hlock->pin_count += cookie.val;
 			return cookie;
 		}
