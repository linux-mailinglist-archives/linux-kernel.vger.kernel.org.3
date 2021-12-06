Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D40469D9D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387463AbhLFPbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:31:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42988 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357928AbhLFPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:19:20 -0500
Date:   Mon, 06 Dec 2021 15:15:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638803749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ThdUljxXIA7BAF+Uc3PyH3RzP3VEVIqiwe0bN7bsWE=;
        b=2f3fuPLtPMxvL/QaJpbEkJ//sHgYP3IFfNYr9g/NIhQKsQG91H+tcXYKp/LdFWOqWujjuM
        05rfw0jYgU+3jDrDQ5LaiEBHo5KfLvTnrFI++rh4E/9zRpCAS7haBRpzEwhC5o1V8Llisb
        8lgO+PIPMJiY6gZNCob1PrTVOXf8iLT15ZyebqxjD7cAmWY++1itZgipI09LyPnnQtvAJh
        KIXRABu0x2Bq8/+TkujlDxSwqYsROOxH6XdC/26B8JajXP2234/1J6JG2KLS3Hb7YCdoz9
        9KDEAHIXFVLhdS8XTevV3wIkJ4SaKst7hqPRXIKQbjYEFU5ExS/mBbFJyUmy1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638803749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ThdUljxXIA7BAF+Uc3PyH3RzP3VEVIqiwe0bN7bsWE=;
        b=0CORFqXCVuObQBl2V+cRRbGQ+rcs/yCbcy5ShTijuxF/oXMIxJFppcNgcFbuOc4iKN9BDz
        gZ3AlGGqw5kdIwBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Squash self-deadlock check for
 ww_rt_mutex.
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211129174654.668506-4-bigeasy@linutronix.de>
References: <20211129174654.668506-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163880374854.11128.16404759465745609173.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     02ea9fc96fe976e7f7e067f38b12202f126e3f2f
Gitweb:        https://git.kernel.org/tip/02ea9fc96fe976e7f7e067f38b12202f126e3f2f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 29 Nov 2021 18:46:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 04 Dec 2021 10:56:23 +01:00

locking/rtmutex: Squash self-deadlock check for ww_rt_mutex.

Similar to the issues in commits:

  6467822b8cc9 ("locking/rtmutex: Prevent spurious EDEADLK return caused by ww_mutexes")
  a055fcc132d4 ("locking/rtmutex: Return success on deadlock for ww_mutex waiters")

ww_rt_mutex_lock() should not return EDEADLK without first going through
the __ww_mutex logic to set the required state. In fact, the chain-walk
can deal with the spurious cycles (per the above commits) this check
warns about and is trying to avoid.

Therefore ignore this test for ww_rt_mutex and simply let things fall
in place.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211129174654.668506-4-bigeasy@linutronix.de
---
 kernel/locking/rtmutex.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 0c6a48d..f896208 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1103,8 +1103,11 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	 * the other will detect the deadlock and return -EDEADLOCK,
 	 * which is wrong, as the other waiter is not in a deadlock
 	 * situation.
+	 *
+	 * Except for ww_mutex, in that case the chain walk must already deal
+	 * with spurious cycles, see the comments at [3] and [6].
 	 */
-	if (owner == task)
+	if (owner == task && !(build_ww_mutex() && ww_ctx))
 		return -EDEADLK;
 
 	raw_spin_lock(&task->pi_lock);
