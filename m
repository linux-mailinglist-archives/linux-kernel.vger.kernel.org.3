Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FFC4784CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhLQGIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhLQGIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:08:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76039C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 22:08:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u17so973887plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 22:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=tKUR11+VJDxu6abRc3pnA0Mxj4gPKgi7U53J9cfBDfI=;
        b=kUqCuV1ZrKslAqq0lWt9KzC8x5lNvA4MryDIBzosvZTihVPlN9ag1apZ5nDd9MTx5p
         f0zWqpBWEdEoveQv8mywuScLwtIsDvB0/CYVB8qTxx975po75pIwOdoem/8A8fEsYaWZ
         +lb50jDoeeTewKuA6ER+mfRZOIqItAgFXb5Z18ykcZyj9RRX7c4qozgHhv779TEw7JG7
         5W39OBfgTsXdmTDT/vqAEm1s5HqYiOmhPErb3PSZllsMpfnoKFNxZsQ9hR/oLTQzqK7S
         /t/fYtC+DVFoyYReLa9APcarMnjqf6k6awmF/oz3tbd9yl+nrtiHx4MPPQJo7PYDjjRo
         xk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=tKUR11+VJDxu6abRc3pnA0Mxj4gPKgi7U53J9cfBDfI=;
        b=M8f4cwM+OviGWk4KGddFMxB6+l7OeTToWBA+OtqTxX/cUkGtkzqPZAIObWlbvOe14g
         nYmQKGmpI50YsLEcqQPDsL2m5oVDEiAUakwVX50MdVDSQwqDX6/eMxAd8SpauOr0M4/i
         BiElmxwqmbwOrCynqQAJuQ/d/kdd8SbNi4dOKUUQovwda0sfMsTxvf7zMUgO/p7Gf2G2
         zmEhR22TykG1yRrTFux8i13E7A9CkF3sWadBal9URitpWJEEZxOq++Kxk9re5xMcFfh9
         hn/jXa0vevG2joy7Q6XVshnHJPvg4JryhlAl2ojsaUnWJXwLXgAYl3cwMT9Uru0POM2F
         KZkw==
X-Gm-Message-State: AOAM5301SKZ3txg1KNC5XTLNwg+NlzJa0axBi8v1T2PPXLNpfQxlV1+6
        SFosuXl19/jtoCpmr0e0aYoqiFdDIFQf4w==
X-Google-Smtp-Source: ABdhPJyQrahQsPOsq74gZi8Q7kzz4sDyg/XCu6jWUXOWPNgITfm97mUYPL/Olr8NuC2oZjGJ77riQQ==
X-Received: by 2002:a17:902:d488:b0:141:f3a3:d2f4 with SMTP id c8-20020a170902d48800b00141f3a3d2f4mr1842703plg.86.1639721280927;
        Thu, 16 Dec 2021 22:08:00 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h5sm8569339pfc.113.2021.12.16.22.07.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Dec 2021 22:08:00 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] psi: fix possible trigger missing in the window
Date:   Fri, 17 Dec 2021 14:07:44 +0800
Message-Id: <1639721264-12294-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

There could be missing wake up if the rest of the window remain the
same stall states as the polling_total updates for every polling_min_period.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/psi_types.h |  2 ++
 kernel/sched/psi.c        | 30 ++++++++++++++++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 0a23300..9533d2e 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -132,6 +132,8 @@ struct psi_trigger {
 
 	/* Refcounting to prevent premature destruction */
 	struct kref refcount;
+
+	bool new_stall;
 };
 
 struct psi_group {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1652f2b..402718c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -458,9 +458,12 @@ static void psi_avgs_work(struct work_struct *work)
 static void window_reset(struct psi_window *win, u64 now, u64 value,
 			 u64 prev_growth)
 {
+	struct psi_trigger *t = container_of(win, struct psi_trigger, win);
+
 	win->start_time = now;
 	win->start_value = value;
 	win->prev_growth = prev_growth;
+	t->new_stall = false;
 }
 
 /*
@@ -515,7 +518,6 @@ static void init_triggers(struct psi_group *group, u64 now)
 static u64 update_triggers(struct psi_group *group, u64 now)
 {
 	struct psi_trigger *t;
-	bool new_stall = false;
 	u64 *total = group->total[PSI_POLL];
 
 	/*
@@ -523,19 +525,26 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 	 * watchers know when their specified thresholds are exceeded.
 	 */
 	list_for_each_entry(t, &group->triggers, node) {
-		u64 growth;
-
 		/* Check for stall activity */
 		if (group->polling_total[t->state] == total[t->state])
 			continue;
 
 		/*
-		 * Multiple triggers might be looking at the same state,
-		 * remember to update group->polling_total[] once we've
-		 * been through all of them. Also remember to extend the
-		 * polling time if we see new stall activity.
+		 * update the trigger if there is new stall which will be
+		 * reset when run out of the window
 		 */
-		new_stall = true;
+		t->new_stall = true;
+
+		memcpy(&group->polling_total[t->state], &total[t->state],
+				sizeof(group->polling_total[t->state]));
+	}
+
+	list_for_each_entry(t, &group->triggers, node) {
+		u64 growth;
+
+		/* check if new stall happened during this window*/
+		if (!t->new_stall)
+			continue;
 
 		/* Calculate growth since last update */
 		growth = window_update(&t->win, now, total[t->state]);
@@ -552,10 +561,6 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 		t->last_event_time = now;
 	}
 
-	if (new_stall)
-		memcpy(group->polling_total, total,
-				sizeof(group->polling_total));
-
 	return now + group->poll_min_period;
 }
 
@@ -1152,6 +1157,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->last_event_time = 0;
 	init_waitqueue_head(&t->event_wait);
 	kref_init(&t->refcount);
+	t->new_stall = false;
 
 	mutex_lock(&group->trigger_lock);
 
-- 
1.9.1

