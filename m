Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A772E4756E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbhLOKuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbhLOKuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:50:16 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5EAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:50:16 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id a23so15248713pgm.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 02:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=ZzQS3th7hwfmksndYKtDaBuS9CE4JtvSUqsyMZ9SvIk=;
        b=GYXQPk+Q8aWzdFNuOVKQ0A2as5WNDhTB6X/2j+tdaLuVXu0/zB34dOKm3K4xhqnc7l
         ZaOL8b83bJ5SfVhDPmwSkvC7BDainnTfeF5DX56g1ekizcCEByEQsUliZmILOOMYGUuI
         HB7oA84dOUtidKOZeFUEcl1uqKNsyBrOQw0efD5LXiGAdwsAJ+KJQNGdO84L0ip2+8qD
         3lie3K6dxSSYylqxSpu2P9qRzcWD6h4uyl9cFqMk6dY9IZ0+3VFKA6B/xwwZ7EW7qIjq
         Qagpvv3Vx9FuT9cFs2SEAJpO5JKxhy5OX/A+19gj5/dDJIgPoM95ZgMAm3EA+Qj2UkR+
         4tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ZzQS3th7hwfmksndYKtDaBuS9CE4JtvSUqsyMZ9SvIk=;
        b=n915eK3eOzvAZJOmKNr0itjbCDYx9TGh9+t3rSsXWBnqTcSGraIgAsVgfUaG31GxQ/
         hhUJhUe0fZzMEbsyxHr+4K2PhKJweKCNvNVNQE5daTUf98GgMyxolEhEayCaaCwxn9CO
         bI+2KM0HaFykcbyRGKRrlSuxm7oZ75AU/efPIRoAFc+uYv9436xD5K6vgvydejvCfRO+
         Dsg9jG0TdI0HDsgtJIkeivVyzcTvPlX2GVcbOEs+HeYnJGg574MSzQJCvfmiVtnoWcFU
         RGjweCD/Qtcx8t7BHwDPbXcydPCyDUDDSxREGxxfFEiJXGQ3hRBY13b8ebekx4WXmoAa
         q+GQ==
X-Gm-Message-State: AOAM531eUbvstjs3QBlE559Fn+/FU9pAXF2ueuKDCOki1fnpHcTOsUVl
        m/TinB/j8gIGXO4o0T/PlWDd1sg8zsYUgQ==
X-Google-Smtp-Source: ABdhPJz9CexpSzxo/fA2khIF/BuWyvBAWCGk8K/PrskteNMpuJWJNNHK8UU+CE5emAKMly2dZUbxVA==
X-Received: by 2002:a63:cd49:: with SMTP id a9mr7430769pgj.607.1639565416237;
        Wed, 15 Dec 2021 02:50:16 -0800 (PST)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y25sm2345050pfa.12.2021.12.15.02.50.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Dec 2021 02:50:15 -0800 (PST)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] psi: introduce rt property for trigger
Date:   Wed, 15 Dec 2021 18:49:59 +0800
Message-Id: <1639565399-15629-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

There are several pratical reasons to introduce such a rt flag to let the
trigger wake up within the window,

1. WINDOW_MIN_US=500ms is too big for some scenarios where the trigger is
expected to launch some behavious on the resource under pressure.

2. Window size works as both of average factor and wakeup timing value.
However, user could expect seperate value on this two roles. eg, we expect
to watch the pressure as 'SOME 100/1000ms' and got triggered whenever it
reached.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/psi_types.h |  3 +++
 kernel/sched/psi.c        | 21 +++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 0a23300..6c83c75 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -124,6 +124,9 @@ struct psi_trigger {
 	/* Tracking window */
 	struct psi_window win;
 
+	/*real time trigger flag*/
+	u32 rt;
+
 	/*
 	 * Time last event was generated. Used for rate-limiting
 	 * events to one per window
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1652f2b..e1f08aa 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -145,6 +145,7 @@
 #include <linux/psi.h>
 #include "sched.h"
 
+extern unsigned int sysctl_sched_latency;
 static int psi_bug __read_mostly;
 
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
@@ -458,9 +459,12 @@ static void psi_avgs_work(struct work_struct *work)
 static void window_reset(struct psi_window *win, u64 now, u64 value,
 			 u64 prev_growth)
 {
+	struct psi_trigger *t = container_of(win, struct psi_trigger, win);
+
 	win->start_time = now;
 	win->start_value = value;
 	win->prev_growth = prev_growth;
+	t->rt = t->rt ? 5 : 0;
 }
 
 /*
@@ -542,6 +546,17 @@ static u64 update_triggers(struct psi_group *group, u64 now)
 		if (growth < t->threshold)
 			continue;
 
+		/* wakeup if trigger has rt and at least 5 sched_latency surpassed*/
+		if (t->rt && growth >= t->threshold) {
+			u64 rt_trigger_time = min(t->last_event_time + t->win.size,
+				sysctl_sched_latency * t->rt + t->last_event_time);
+			if (now < rt_trigger_time)
+				continue;
+			if (cmpxchg(&t->event, 0, 1) == 0)
+				wake_up_interruptible(&t->event_wait);
+			t->rt += 5;
+		}
+
 		/* Limit event signaling to once per window */
 		if (now < t->last_event_time + t->win.size)
 			continue;
@@ -1116,13 +1131,14 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	enum psi_states state;
 	u32 threshold_us;
 	u32 window_us;
+	u32 rt = 0;
 
 	if (static_branch_likely(&psi_disabled))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	if (sscanf(buf, "some %u %u", &threshold_us, &window_us) == 2)
+	if (sscanf(buf, "some %u %u %u", &threshold_us, &window_us, &rt) >= 2)
 		state = PSI_IO_SOME + res * 2;
-	else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) == 2)
+	else if (sscanf(buf, "full %u %u %u", &threshold_us, &window_us, &rt) >= 2)
 		state = PSI_IO_FULL + res * 2;
 	else
 		return ERR_PTR(-EINVAL);
@@ -1152,6 +1168,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	t->last_event_time = 0;
 	init_waitqueue_head(&t->event_wait);
 	kref_init(&t->refcount);
+	t->rt = rt ? 5 : 0;
 
 	mutex_lock(&group->trigger_lock);
 
-- 
1.9.1

