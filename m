Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC9848BCA8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347970AbiALBsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347965AbiALBsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:48:15 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD2C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:48:15 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c3so1770917pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=6VcCCa/uNyu5klYi1x3xHgmWoLaBIpIlwVyG80i3crM=;
        b=b6tcahg+T5y6YlhZy6IKeQPGYgsVya1Q7MB3pxrTeKA6FtL+k6+I0MUZDBoelpg8p/
         4N0QqftZDjoNOPjaWcBIpvc/3cx5eQ6pugbR8kfzd458vkjJMW2uAZpp3kTFY7QBc7OQ
         MFBuo6oM1wCYiMmC0wRyX8WH6rEGVgUcP24q54DlDX99YkenTYutj3Oz3Py8kuo4yTsl
         rqvFvsBZJDAcFxnXQfrd9j3pX1TweqcJmXcNT0AyAvO27ZO0WMcRKYmQL02YUusWM+Hl
         Fh5O6aWWJsuPHm1h/JnE8OgnIpp8EDTL3OA6y7w0U30is7zeUAERa934Im0xY0CTVaD6
         taoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=6VcCCa/uNyu5klYi1x3xHgmWoLaBIpIlwVyG80i3crM=;
        b=uaM8zZwdyF4vKkkLx6ygP6F0mpOuBkXbmxBSd8fMW3SaPER8jPxsibUFgCSjY9c2v3
         YriTeuplb8WrCKkmfpvQnBwy03+8bxjooNIiAPw+dNVLVpSR4otNM5j2vugLyOZkMAjA
         U6Qzh+0qH2h6wZMmOiGNGTOMOZMByyDajbV8qXoPgAN/plfluy4zXjNRZyBNLdnpwvMO
         V7qtaLWvXgbWSigF3fVFGW0BF9qf6HjXR+wV+HkvpMEwUCZKIrBHL9LQJz15bFIrUA/y
         tsPRfeMxR2Z1/2ju+InlGd7ytJD2QGXLdD8MllCJlFQR8Rzp/yv41mq0q62huSHwwKue
         sQsA==
X-Gm-Message-State: AOAM530VHurijzzBVJraVfONTR4tKd65Of2/WKxl8BD0zNQycj3aSrz4
        ESLRIpYH8j2ZV7WdTDqNX1Q=
X-Google-Smtp-Source: ABdhPJwkl7mjvLoPUcMoCFkGXqaBTVoTFEXx8USTKJtId9VY0sd+VqYdnFtCLmH/j83sT7OXiXOqpQ==
X-Received: by 2002:a17:90b:4a51:: with SMTP id lb17mr6157575pjb.118.1641952095044;
        Tue, 11 Jan 2022 17:48:15 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w6sm541801pga.25.2022.01.11.17.48.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jan 2022 17:48:14 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [Resend PATCH v3] psi: fix possible trigger missing in the window
Date:   Wed, 12 Jan 2022 09:47:54 +0800
Message-Id: <1641952074-5041-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

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
---
v2: modify the logic according to Suren's suggestion
v3: update commit message
---
---
 include/linux/psi_types.h |  2 ++
 kernel/sched/psi.c        | 38 +++++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 0a23300..87b694a 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -132,6 +132,8 @@ struct psi_trigger {
 
 	/* Refcounting to prevent premature destruction */
 	struct kref refcount;
+
+	bool threshold_breach;
 };
 
 struct psi_group {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1652f2b..5c67ab9 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -524,24 +524,29 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 	 */
 	list_for_each_entry(t, &group->triggers, node) {
 		u64 growth;
+		bool trigger_stalled =
+			group->polling_total[t->state] != total[t->state];
 
-		/* Check for stall activity */
-		if (group->polling_total[t->state] == total[t->state])
-			continue;
-
-		/*
-		 * Multiple triggers might be looking at the same state,
-		 * remember to update group->polling_total[] once we've
-		 * been through all of them. Also remember to extend the
-		 * polling time if we see new stall activity.
-		 */
-		new_stall = true;
-
-		/* Calculate growth since last update */
-		growth = window_update(&t->win, now, total[t->state]);
-		if (growth < t->threshold)
+		/* Check for stall activity or a previous threshold breach */
+		if (!trigger_stalled && !t->threshold_breach)
 			continue;
 
+		if (trigger_stalled) {
+			/*
+			 * Multiple triggers might be looking at the same state,
+			 * remember to update group->polling_total[] once we've
+			 * been through all of them. Also remember to extend the
+			 * polling time if we see new stall activity.
+			 */
+			new_stall = true;
+
+			/* Calculate growth since last update */
+			growth = window_update(&t->win, now, total[t->state]);
+			if (growth < t->threshold)
+				continue;
+
+			t->threshold_breach = true;
+		}
 		/* Limit event signaling to once per window */
 		if (now < t->last_event_time + t->win.size)
 			continue;
@@ -550,6 +555,8 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 		if (cmpxchg(&t->event, 0, 1) == 0)
 			wake_up_interruptible(&t->event_wait);
 		t->last_event_time = now;
+		/* Reset threshold breach flag once event got generated */
+		t->threshold_breach = false;
 	}
 
 	if (new_stall)
@@ -1152,6 +1159,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->last_event_time = 0;
 	init_waitqueue_head(&t->event_wait);
 	kref_init(&t->refcount);
+	t->threshold_breach = false;
 
 	mutex_lock(&group->trigger_lock);
 
-- 
1.9.1

