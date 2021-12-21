Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E8947BBED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 09:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhLUIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 03:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbhLUIeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 03:34:16 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 00:34:16 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id m1so10008803pfk.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 00:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=8bEuaCXKu7mmH+AFbJUwOkYk9y4UKVGL2CArXivgAI8=;
        b=lgn0Ry4DKRKlifOlEa5IZRu6RN/QPMmmkpsk4gmZ1XxFzZ+yb7wa9vEalOS3srUEKS
         fXgF9BdEz8kY/fegfMfPhsYfakIWM6aRC3ba2p175OYedLnotYt7nIxOVWnIil7IAMT4
         VTEwOJSOQCtHD2g4Nu7IVKcOqwKBsRoq43TKJaUoOjGYBB9L2eGUE5lJZeXilt9RezMT
         Qu6Y/32Vp89cCzQT3hZ3uNrsFSf8QwGPBF7NWkxKmg7kAWyerT2dt19HUY6L9hVLpOga
         m/O8XVJS9aZrDYR3YgufWkiT68edFKwLeObXWbxC4fegBRS56h1U8CmliJyUzdlZSgM6
         tWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=8bEuaCXKu7mmH+AFbJUwOkYk9y4UKVGL2CArXivgAI8=;
        b=W3omAtFBdjRL8Ub2Hc2T4rUP458jD4NSzq2EpON7IzQjORzVijvQA5BMiDYtfpt5CT
         p3ZmxknUlfgxltJNAo53QJCyWyP3qXpQRRb0DaiordJALBfmjajNiFGm8FIvgY1LC+pl
         2p5+9cEYjUT/JnNWsI1j5CiOC0Oc+d57LnkMGHLOt8YNXGLV0kRJq8YxUkM0qTWLSXj4
         CRNhjfMWaAwOEZA1ynrGjQOWDihts7zUH0J6Ch67jOTFwFOvKNBxSyF8yquB8PHN7970
         /f+PCSCfewLq4BHvfX+8H7jJRRAUEC+DZFJyvi2kzq4EemzCTxLnrfSQDuXcgYA6GKhx
         Kc+g==
X-Gm-Message-State: AOAM530yr/A+h7Ht9thUOXDYKVeMvFoJsjSnGJ8lRWzgsCJBFGvkXxHR
        CIuJN8F0/5QnXp8NawmboP4=
X-Google-Smtp-Source: ABdhPJxwt4vGC82RUYlckmCavwTE42kN6ucOJ/JiNA/74vROdIg/ilCXcSdJjbYshE9DunHBLXfbZw==
X-Received: by 2002:a05:6a00:b89:b0:4bb:15c:908c with SMTP id g9-20020a056a000b8900b004bb015c908cmr2209268pfj.34.1640075656070;
        Tue, 21 Dec 2021 00:34:16 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g12sm1448585pfv.136.2021.12.21.00.34.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Dec 2021 00:34:15 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] psi: fix possible trigger missing in the window
Date:   Tue, 21 Dec 2021 16:33:57 +0800
Message-Id: <1640075637-14520-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

There could be missing wake up if the rest of the window remain the
same stall states as the polling_total updates for every polling_min_period.
Introducing threshold_breach flag to record the trigger's status and update
the logic.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: modify the logic according to Suren's suggestion
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

