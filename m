Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81973494629
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 04:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358372AbiATDcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 22:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiATDcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 22:32:14 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35F7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 19:32:13 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y27so26561pfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 19:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=6VcCCa/uNyu5klYi1x3xHgmWoLaBIpIlwVyG80i3crM=;
        b=ULO3DXzfltvoF1pPRTDLBeRyPli2sY9LcwnVN7wBK9Jt7yVlWDQNnb7gYkJNYAxTIu
         x4NHVSMFt6GAv4NTEBv4gUcyDxZj+iJcP5rp8S69Zp8ABkhsZl/OSJ7pF+5fDappiqZX
         XBHaDFEQ+tr1diJixNZFQuuELVy0MbHIwpHA+QpA+QVRUHHDcBXeSm7s1NnXD6gdGYju
         WXQvmIuah5g6h30xHnSUFk7okFOgXJcjjgq9jwvHjXuIpA8pezl0Z0Mg1kuOa7zM+VlJ
         3UPLXl7bYtU6BlWj2mqWMityaizZgsvCG8jETXUTQgGU/zM2B0gfaTjicKDjj2tVkxrm
         g6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=6VcCCa/uNyu5klYi1x3xHgmWoLaBIpIlwVyG80i3crM=;
        b=YurO39wVaeNfDvPuRtyEsB0SESkWdrlTF0QCa0xv5SQthh3ey8c6/Xr28MZwOhIyCl
         lqHPmfC7U0yHQ6bgROLp54q+DVogwQaNdQEmCKiwXtCwJ4zdhkPjJ9d2sXhSsGgMRaD5
         4etHbsuqmwOMp+9jb3gDV8mU3WtzNkIHiiUA0bDMJnXja851vOae0EBeRGrg8Lbs3HJi
         uytiYefLjOqg1jobdKXlF7uRfD+0MP53sqBh5nZaZc6SX0C9EOVnpI6YUP/48g36m2xs
         2wlh6BH8eGO9j8gCqvN7QIp8RAe/eUpBaW9PmeA0SSxaBJno9lA8ySmVneKTRIenop8d
         YIow==
X-Gm-Message-State: AOAM532LMHamm4M4N15IaAYaMKYTkaBDOCCcXPp/fX+Z9D8oXw6DZzCH
        6YMGSU++I1o0Ru+w5HTInlKYnXVijLvKDw==
X-Google-Smtp-Source: ABdhPJyU2wvXBwrRe/LnxztvOS2PjL2olL8B7hpWapZ/PFjhalgfpmkk/8PC41fbNLGwhYQatAoi+g==
X-Received: by 2002:a05:6a00:803:b0:4c3:37b9:74d8 with SMTP id m3-20020a056a00080300b004c337b974d8mr23024575pfk.60.1642649533338;
        Wed, 19 Jan 2022 19:32:13 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h10sm1035996pfh.49.2022.01.19.19.32.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jan 2022 19:32:12 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [Resend PATCH v3] psi: fix possible trigger missing in the window
Date:   Thu, 20 Jan 2022 11:31:56 +0800
Message-Id: <1642649516-15076-1-git-send-email-huangzhaoyang@gmail.com>
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

