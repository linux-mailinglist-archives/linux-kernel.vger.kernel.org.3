Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139AC47CA3B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbhLVAYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhLVAYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:24:44 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:24:44 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u16so520937plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=6VcCCa/uNyu5klYi1x3xHgmWoLaBIpIlwVyG80i3crM=;
        b=ouuDwtP9G+3UVD9uHW4khTzY0tcWhe4PqAJJb5Mlss1XklMPskVdIpyGS9E/BJWTbq
         6taCXHEzKKIXGt1KvJdmGhH0+fvdGtotn57vsaRp+AbyZemRVIWSEbbyIgjUlI27PjZf
         eMc2fTu/xKkBEQNJlMwMalVPT1/7gMdSB8x+iJ/7CZdjlifOLmAmVbVdj0y4qIl+dYiV
         B96mjX61NEPsrUdkvuFSp3fdroyzL1D+27To7CIZo3yLmKjTFfGhtMxHiqDO40k2D2/W
         9laH3wHcaqOd75rGVjuiJJDkeEURG0Iwb9FnHGkPMg3S5WNts3PCYwt1KAl1kp3+k6WE
         Sw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=6VcCCa/uNyu5klYi1x3xHgmWoLaBIpIlwVyG80i3crM=;
        b=tSyAzKHejXplqOtO8uzS+vNHrznK51CEIhGssEAjhUQ2onInJupF/sotvi+LpCcNm9
         2fVWXo4LpK3gO2CM/x9X1ms5FBx6Z1OzWo62dVDyYR+MROeZBFJU2jXBBF7CbPzLTC/Y
         UjdwoT6F8D9e+35T+dXSSHLWmk/kUTu8oyL/D7TLemii++JFuENnFvWW7rYdH8jbmgav
         Lyis6ZTv51GLY0XumpTAYAq7Vnj1A8w1Hkcr1sraXVCvNwocOzHPT3LxjxChNV3E1TbH
         BV+ljH8Dclwzz/VQHQAg2luu3MA6LLTh6SZvhTklU9kAnm3O4sJB5LY2Bt9zHbU/BKcF
         JOaQ==
X-Gm-Message-State: AOAM533bWW9XVSb93Z2L3nGDt3WAQnJOjRwQ1V2lu7kmisQtDDrCw/B7
        MQaonQqqxAtevhcJuslCRCw=
X-Google-Smtp-Source: ABdhPJwNX5Epbm+IoS4Lp2LJLLSVPOkEOIERxa7U8zVMkAyf4l33ukzgulA5C0IsoCfSTRSHX0B16A==
X-Received: by 2002:a17:90a:e7cb:: with SMTP id kb11mr719921pjb.75.1640132683559;
        Tue, 21 Dec 2021 16:24:43 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s34sm225625pfg.198.2021.12.21.16.24.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Dec 2021 16:24:43 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] psi: fix possible trigger missing in the window
Date:   Wed, 22 Dec 2021 08:24:28 +0800
Message-Id: <1640132668-28249-1-git-send-email-huangzhaoyang@gmail.com>
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

