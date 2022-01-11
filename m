Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEC348AECC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241036AbiAKNrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241007AbiAKNrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:47:14 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2257C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:47:13 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so1840935wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 05:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nP+CSE9iEIzwFG5+V5deqlDlAk8XkEcUa0ABGWq3KOQ=;
        b=HzW+ELs2Jece1l9cxsUSv3nMDlAa9v7FnQq4OZ6HmYhTZekh3dvBXvz09BFW0iiaLG
         F1ufmpq2GrDqZr95cKKUQy/YANyGbj9HV+6ruFgk7V7lpGiA1367GXH7miZm6yugItBn
         v6/Zx/Cv4E/NlWbB3nZw8Zf8y484+tqHY08EqlOd2An94V8elG4WQFRkLg3KfXJLVO4/
         g/cj5cE2p0oFaHdpJvyrMZom7En/ZaJfkxZxyFANl/QLyFbKcMGKye/W4DTleD4PFana
         jcrenQAXVyTxLWTfB1N/p4gkFciMc2Unf8v2sPV79GGTVXneAvHzOSF9L4ie/ttzKHm1
         pMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nP+CSE9iEIzwFG5+V5deqlDlAk8XkEcUa0ABGWq3KOQ=;
        b=Fu51/JObj/Ge5FzLS+GrDuwJgm7hUmzUsiomLsLqEd+c34aTmKYVC0GQaHJ5e6EZDx
         Mtn8AKU9HbMnSpt6zcWjPYprtOB7u99s4sYdmDHELDsC5Gtlk6ZeDNpU4XA4tZ8a9gaJ
         gv5CZw03tgggA8qT4e7oDcQttbU5Yf+vvWBZPWManl/a8A32FIflwCmS8oTKs2V7b9D9
         pquOS+FHA0qDWM5FhDTAULyiMtWNETBqY0tHz9pCdi5rhAxSNw5LytnfRKFql94I5uz6
         nNT7jJJ5exmEGO7cbp0rNkqWNWJHVH81GrgFeasbupaPLRQDv2vPXw8IxaiLx84bou9V
         LVeg==
X-Gm-Message-State: AOAM533bzQkMHVJWcpo5Tkno0ZJJcduv4G73mP2exUcJaY6ZqJWkFwR1
        GSmN0ku/3yo0s+FEl0/ycofHtQ==
X-Google-Smtp-Source: ABdhPJz3w8uSkdsGUVQx1VkTmLsEhuryoyJeypweawRS0nabC6RJPzC2SeGlFk5KddqAAdn5MFpaUw==
X-Received: by 2002:a05:600c:354c:: with SMTP id i12mr2531988wmq.90.1641908832380;
        Tue, 11 Jan 2022 05:47:12 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:44fe:4c24:d946:283b])
        by smtp.gmail.com with ESMTPSA id az1sm9618411wrb.104.2022.01.11.05.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 05:47:11 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3 1/4] sched/pelt: Relax the sync of util_sum with util_avg
Date:   Tue, 11 Jan 2022 14:46:56 +0100
Message-Id: <20220111134659.24961-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111134659.24961-1-vincent.guittot@linaro.org>
References: <20220111134659.24961-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rick reported performance regressions in bugzilla because of cpu frequency
being lower than before:
    https://bugzilla.kernel.org/show_bug.cgi?id=215045

He bisected the problem to:
commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")

This commit forces util_sum to be synced with the new util_avg after
removing the contribution of a task and before the next periodic sync. By
doing so util_sum is rounded to its lower bound and might lost up to
LOAD_AVG_MAX-1 of accumulated contribution which has not yet been
reflected in util_avg.

Instead of always setting util_sum to the low bound of util_avg, which can
significantly lower the utilization of root cfs_rq after propagating the
change down into the hierarchy, we revert the change of util_sum and
propagate the difference.

In addition, we also check that cfs's util_sum always stays above the
lower bound for a given util_avg as it has been observed that
sched_entity's util_sum is sometimes above cfs one.

Reported-by: Rick Yiu <rickyiu@google.com>
Fixes: 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa378df..ed35255fdb85 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3381,6 +3381,7 @@ void set_task_rq_fair(struct sched_entity *se,
 	se->avg.last_update_time = n_last_update_time;
 }
 
+#define MIN_DIVIDER (LOAD_AVG_MAX - 1024)
 
 /*
  * When on migration a sched_entity joins/leaves the PELT hierarchy, we need to
@@ -3449,7 +3450,6 @@ void set_task_rq_fair(struct sched_entity *se,
  * XXX: only do this for the part of runnable > running ?
  *
  */
-
 static inline void
 update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
@@ -3681,7 +3681,19 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 		r = removed_util;
 		sub_positive(&sa->util_avg, r);
-		sa->util_sum = sa->util_avg * divider;
+		sub_positive(&sa->util_sum, r * divider);
+		/*
+		 * Because of rounding, se->util_sum might ends up being +1 more than
+		 * cfs->util_sum. Although this is not a problem by itself, detaching
+		 * a lot of tasks with the rounding problem between 2 updates of
+		 * util_avg (~1ms) can make cfs->util_sum becoming null whereas
+		 * cfs_util_avg is not.
+		 * Check that util_sum is still above its lower bound for the new
+		 * util_avg. Given that period_contrib might have moved since the last
+		 * sync, we are only sure that util_sum must be above or equal to
+		 *    util_avg * minimum possible divider
+		 */
+		sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);
 
 		r = removed_runnable;
 		sub_positive(&sa->runnable_avg, r);
-- 
2.17.1

