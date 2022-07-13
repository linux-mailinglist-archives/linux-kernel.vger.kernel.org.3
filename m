Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5CE572C24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiGMEF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbiGMEFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:05:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99847DA0DE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:14 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a15so10316097pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i5Gc9IV85m7Fejt5IzYZGHmh3j/vway/Y227kMZ6Tts=;
        b=AlZ4vOFhaCQTJILmtfJOtZR/WwLGLONxL8aAbseajsd1QY7wSelUDi6cgfQ6sQWKSM
         2ZT53xGZkEhFUbT/03JoRRs5m1g+uErBTXhbnXk2YlJzvCk6dS8as7nPiHA1bWNMhdsJ
         NGaK9kJhRIOZnqEYeGdOMwuNwLFZNsddNrt8wkJKoze3qe5qoo4wVih09gFuQSkqcPD5
         FQC3IOiWK1LYCkJJMGWRMVtl1ebQTQM0xLZ/Dmiwf6sXA01gFX7vUQjaVZMii1yOP64J
         E0yNxj5NfxK6/ac6iWI4HKTD7+Oa0z1AahRHyqInTX3mRIs2JZzqh66AggLXy5fGUmmK
         nszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i5Gc9IV85m7Fejt5IzYZGHmh3j/vway/Y227kMZ6Tts=;
        b=kJCDvIuqa+wNn/tBwklsyuUwCs7qTCan6brVRAX4G7PV3jGQCbSoMjBkftY7cj5e20
         OEo35FZMKhUJCD1c3MEJdHd7eUG1XuYdCy3rxUeh3qIPt9HYwiaW6nrLiBUvbJpv1y0A
         qpP80VFprU5ZGa3i6e2wUvsstDL3BUWBq8+qy9YyLpxEdcsejGq6mUxN+BWvo0Coqnw8
         pUBa/ZnCPyfEWEVK1/no3MPAXwwHaqVfWwgBhAcmZtcL0wiqscU3oaPKSDexAKwYtZr8
         tsHj8fVVO2gpc7uI2LrrNLUpqZSZrfP+ZXhnFtgw8xF8tZK3OIiKk3UNcLzd9irle5Hm
         8mew==
X-Gm-Message-State: AJIora+Ivqoq/9zEdV3PB2fVKsCeO5dazZSPpB+JZPCsmFasfdiXJamu
        9aYtfEiPB4oTmMHstqt37HSLrQ==
X-Google-Smtp-Source: AGRyM1unErkqwqvb3n7DC2AUiQnbQSXT3tIyIZm852yhqK7lAn6gWaF3mUCy8eRvcPCtXcQv+Rd8nQ==
X-Received: by 2002:a17:902:ecc3:b0:16c:461d:802b with SMTP id a3-20020a170902ecc300b0016c461d802bmr1257885plh.167.1657685113921;
        Tue, 12 Jul 2022 21:05:13 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm6858942plg.114.2022.07.12.21.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:05:13 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 07/10] sched/fair: use update_load_avg() to attach/detach entity load_avg
Date:   Wed, 13 Jul 2022 12:04:27 +0800
Message-Id: <20220713040430.25778-8-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713040430.25778-1-zhouchengming@bytedance.com>
References: <20220713040430.25778-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since update_load_avg() support DO_ATTACH and DO_DETACH now, we can
use update_load_avg() to implement attach/detach entity load_avg.

Another advantage of using update_load_avg() is that it will check
last_update_time before attach or detach, instead of unconditional
attach/detach in the current code.

This way can avoid some corner problematic cases of load tracking,
like twice attach problem, detach unattached NEW task problem.

1. switch to fair class (twice attach problem)

p->sched_class = fair_class;  --> p.se->avg.last_update_time = 0
if (queued)
  enqueue_task(p);
    ...
      enqueue_entity()
        update_load_avg(UPDATE_TG | DO_ATTACH)
          if (!se->avg.last_update_time && (flags & DO_ATTACH))  --> true
            attach_entity_load_avg()  --> attached, will set last_update_time
check_class_changed()
  switched_from() (!fair)
  switched_to()   (fair)
    switched_to_fair()
      attach_entity_load_avg()  --> unconditional attach again!

2. change cgroup of NEW task (detach unattached task problem)

sched_move_group(p)
  if (queued)
    dequeue_task()
  task_move_group_fair()
    detach_task_cfs_rq()
      detach_entity_load_avg()  --> detach unattached NEW task
    set_task_rq()
    attach_task_cfs_rq()
      attach_entity_load_avg()
  if (queued)
    enqueue_task()

These problems have been fixed in commit 7dc603c9028e
("sched/fair: Fix PELT integrity for new tasks"), which also
bring its own problems.

First, it add a new task state TASK_NEW and an unnessary limitation
that we would fail when change the cgroup of TASK_NEW tasks.

Second, it attach entity load_avg in post_init_entity_util_avg(),
in which we only set sched_avg last_update_time for !fair tasks,
will cause PELT integrity problem when switched_to_fair().

This patch make update_load_avg() the only location of attach/detach,
and can handle these corner cases like change cgroup of NEW tasks,
by checking last_update_time before attach/detach.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/fair.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 29811869c1fe..51fc20c161a3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4307,11 +4307,6 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
 
-static inline void
-attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
-static inline void
-detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
-
 static inline int newidle_balance(struct rq *rq, struct rq_flags *rf)
 {
 	return 0;
@@ -11527,9 +11522,7 @@ static void detach_entity_cfs_rq(struct sched_entity *se)
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 	/* Catch up with the cfs_rq and remove our load when we leave */
-	update_load_avg(cfs_rq, se, 0);
-	detach_entity_load_avg(cfs_rq, se);
-	update_tg_load_avg(cfs_rq);
+	update_load_avg(cfs_rq, se, UPDATE_TG | DO_DETACH);
 	propagate_entity_cfs_rq(se);
 }
 
@@ -11537,10 +11530,8 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	/* Synchronize entity with its cfs_rq */
-	update_load_avg(cfs_rq, se, 0);
-	attach_entity_load_avg(cfs_rq, se);
-	update_tg_load_avg(cfs_rq);
+	/* Synchronize entity with its cfs_rq and attach our load */
+	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
 	propagate_entity_cfs_rq(se);
 }
 
-- 
2.36.1

