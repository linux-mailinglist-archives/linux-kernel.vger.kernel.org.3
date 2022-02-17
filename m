Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533D34BA8F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244792AbiBQS51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:57:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiBQS5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:57:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1B05D668;
        Thu, 17 Feb 2022 10:56:54 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124212;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBMvQsiG2NvPPtzi/hVREDQBmKieIMZ8/hnkIeo5qAI=;
        b=m5aicU8ilSs0PYwuPDPEWtL4fVvhC63oaoBwSdgHwLAIxYj9kQ7d8HwFCEsS6sLdqrQWps
        zyIuo8AI/EcNVe8NpFwX2xc7Gs7j8Yc2gFMZBBVO8j7aGgOUn1MQm6Tag5zDmRmwfwe6RJ
        8gQl73OXVhyWZxWsoFDyys8kn3XqdkZZvmOZTktAXTRG3GvUmDGvC0drEC60G0L4U5dvvE
        fmhTGKWkxgdrhnKKGtp2N09lkPlBUJCypiNHo+R/JW8BEO4ik17X8gwMTBlWCOwt7JLKz/
        5J8igOdGszXViTzaynSjUAxRFd4C+HUYrWx3Ngj2KkrmBenoVbb8WAkIgJZCoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124212;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBMvQsiG2NvPPtzi/hVREDQBmKieIMZ8/hnkIeo5qAI=;
        b=GlTioHL4Z0gYLex3RV2RAxab5XgKvWZ9gRg0MbTtMIf7MOC20Pa3+jg7ZlyLY55GA0JPhP
        tBK8n4URjEZpo+Dg==
From:   "tip-bot2 for Zhaoyang Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: fix possible trigger missing in the window
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1643093818-19835-1-git-send-email-huangzhaoyang@gmail.com>
References: <1643093818-19835-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Message-ID: <164512421171.16921.5147262447831853726.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e6df4ead85d9da1b07dd40bd4c6d2182f3e210c4
Gitweb:        https://git.kernel.org/tip/e6df4ead85d9da1b07dd40bd4c6d2182f3e210c4
Author:        Zhaoyang Huang <zhaoyang.huang@unisoc.com>
AuthorDate:    Tue, 25 Jan 2022 14:56:58 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:54 +01:00

psi: fix possible trigger missing in the window

When a new threshold breaching stall happens after a psi event was
generated and within the window duration, the new event is not
generated because the events are rate-limited to one per window. If
after that no new stall is recorded then the event will not be
generated even after rate-limiting duration has passed. This is
happening because with no new stall, window_update will not be called
even though threshold was previously breached. To fix this, record
threshold breaching occurrence and generate the event once window
duration is passed.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Link: https://lore.kernel.org/r/1643093818-19835-1-git-send-email-huangzhaoyang@gmail.com
---
 include/linux/psi_types.h |  3 ++-
 kernel/sched/psi.c        | 46 ++++++++++++++++++++++++--------------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 516c0fe..dc3ec5e 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -144,6 +144,9 @@ struct psi_trigger {
 
 	/* Refcounting to prevent premature destruction */
 	struct kref refcount;
+
+	/* Deferred event(s) from previous ratelimit window */
+	bool pending_event;
 };
 
 struct psi_group {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cfe76f7..e9d623c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -523,7 +523,7 @@ static void init_triggers(struct psi_group *group, u64 now)
 static u64 update_triggers(struct psi_group *group, u64 now)
 {
 	struct psi_trigger *t;
-	bool new_stall = false;
+	bool update_total = false;
 	u64 *total = group->total[PSI_POLL];
 
 	/*
@@ -532,24 +532,35 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 	 */
 	list_for_each_entry(t, &group->triggers, node) {
 		u64 growth;
+		bool new_stall;
 
-		/* Check for stall activity */
-		if (group->polling_total[t->state] == total[t->state])
-			continue;
+		new_stall = group->polling_total[t->state] != total[t->state];
 
+		/* Check for stall activity or a previous threshold breach */
+		if (!new_stall && !t->pending_event)
+			continue;
 		/*
-		 * Multiple triggers might be looking at the same state,
-		 * remember to update group->polling_total[] once we've
-		 * been through all of them. Also remember to extend the
-		 * polling time if we see new stall activity.
+		 * Check for new stall activity, as well as deferred
+		 * events that occurred in the last window after the
+		 * trigger had already fired (we want to ratelimit
+		 * events without dropping any).
 		 */
-		new_stall = true;
-
-		/* Calculate growth since last update */
-		growth = window_update(&t->win, now, total[t->state]);
-		if (growth < t->threshold)
-			continue;
-
+		if (new_stall) {
+			/*
+			 * Multiple triggers might be looking at the same state,
+			 * remember to update group->polling_total[] once we've
+			 * been through all of them. Also remember to extend the
+			 * polling time if we see new stall activity.
+			 */
+			update_total = true;
+
+			/* Calculate growth since last update */
+			growth = window_update(&t->win, now, total[t->state]);
+			if (growth < t->threshold)
+				continue;
+
+			t->pending_event = true;
+		}
 		/* Limit event signaling to once per window */
 		if (now < t->last_event_time + t->win.size)
 			continue;
@@ -558,9 +569,11 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 		if (cmpxchg(&t->event, 0, 1) == 0)
 			wake_up_interruptible(&t->event_wait);
 		t->last_event_time = now;
+		/* Reset threshold breach flag once event got generated */
+		t->pending_event = false;
 	}
 
-	if (new_stall)
+	if (update_total)
 		memcpy(group->polling_total, total,
 				sizeof(group->polling_total));
 
@@ -1125,6 +1138,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->last_event_time = 0;
 	init_waitqueue_head(&t->event_wait);
 	kref_init(&t->refcount);
+	t->pending_event = false;
 
 	mutex_lock(&group->trigger_lock);
 
