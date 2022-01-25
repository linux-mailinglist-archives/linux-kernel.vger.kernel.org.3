Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B519C49AE36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354432AbiAYIiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450719AbiAYIdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:33:13 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4EEC0612AF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 22:57:18 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d1so18303976plh.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 22:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=BCtqKKKae1nbJrnhJrOTwrukfpxsmoJefws7zuhcAHw=;
        b=SSF72/QjjYdyWJdBXKYhYAc8iQHn5Y8zWNSlDi9SMHxnF4VLhtwGVXfqxwNBdantFd
         L0VliNgqgt1dRmPK7YvWx2eZf4W3iYHMDRgfxa5qYShBhSRJEj7ZcFuv/vp2MUXyygYB
         qwrvhfSB9pD/rxwAydIzj3jIymkNMMhB2vseOArds+jRlk9CahLSkA0MYJlWExOPH1+u
         px385Af+ZE3Fq4JQGkeWCpIF+1KCFSZoBYnSbugtS5WG7khPHl19/XQohFJ4oz6Xiq5Z
         j7n7sZW4x4oj/3PXfSH/EGrCWNcgg0rpnNBG9TcVlDprFqSmJFbvoUZRpY/cRSG/ebyd
         byDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=BCtqKKKae1nbJrnhJrOTwrukfpxsmoJefws7zuhcAHw=;
        b=dgjeyu7+1cJ5tMiK4rIHg7GUIAD/3LTUeR/ZskJkbakDU8DYxtKwdqjRsP36cgKN0B
         JKotLhs2I33I5qyiFkEWZGAkEk5ZNuhZh6akJm7MnmKmEPHyHMh16vbLorQOKonqKBkl
         CIQhBEmOcBt5oNE/FkrQ88v981RoWCxokW9hAidXCrh9QvBTkMT48YANgYXyB/M7JUVe
         i8fDys0gfS8lgSfFjD2FukZ3hHqolTJHE1DFaoGcsWYI2nFzE5r2e+BSN4bW71pmIuxK
         PTkoJ//IPQ3+Rv77H87VhuwuZiT8xFJuCMNAYzZr0wNdMX7sH4a7fwYLV7EsaqnN2oZE
         k38A==
X-Gm-Message-State: AOAM532Li5hLOto9WTvvsuOzxwO/Y9p3bPrx5l6D8O435457zkGZKAm5
        eUwbu+oLYOu9d6VjdEU/Y8g=
X-Google-Smtp-Source: ABdhPJx0nX+TrHs0Ymc7uNiOGdLtM+qgjTddinHZrO8cpYA+uKxfTQvhvGCPnU+OsALRyc7mEO+bxQ==
X-Received: by 2002:a17:902:e5c5:b0:14b:1bbb:9f5 with SMTP id u5-20020a170902e5c500b0014b1bbb09f5mr16983715plf.62.1643093837548;
        Mon, 24 Jan 2022 22:57:17 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o18sm18941565pfu.45.2022.01.24.22.57.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jan 2022 22:57:16 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv4] psi: fix possible trigger missing in the window
Date:   Tue, 25 Jan 2022 14:56:58 +0800
Message-Id: <1643093818-19835-1-git-send-email-huangzhaoyang@gmail.com>
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
v4: update variable name and comments
---
---
 include/linux/psi_types.h |  3 +++
 kernel/sched/psi.c        | 46 ++++++++++++++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 0a23300..e0ec129 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -132,6 +132,9 @@ struct psi_trigger {
 
 	/* Refcounting to prevent premature destruction */
 	struct kref refcount;
+
+	/* Deferred event(s) from previous ratelimit window */
+	bool pending_event;
 };
 
 struct psi_group {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1652f2b..dd80bd2 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -515,7 +515,7 @@ static void init_triggers(struct psi_group *group, u64 now)
 static u64 update_triggers(struct psi_group *group, u64 now)
 {
 	struct psi_trigger *t;
-	bool new_stall = false;
+	bool update_total = false;
 	u64 *total = group->total[PSI_POLL];
 
 	/*
@@ -524,24 +524,35 @@ static u64 update_triggers(struct psi_group *group, u64 now)
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
@@ -550,9 +561,11 @@ static u64 update_triggers(struct psi_group *group, u64 now)
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
 
@@ -1152,6 +1165,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->last_event_time = 0;
 	init_waitqueue_head(&t->event_wait);
 	kref_init(&t->refcount);
+	t->pending_event = false;
 
 	mutex_lock(&group->trigger_lock);
 
-- 
1.9.1

