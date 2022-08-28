Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9805B5A3EB6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiH1RE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiH1REX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:04:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF9F32DA5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 10:04:22 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id bg22so5940790pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 10:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wmSDgJbG7Or0Iv/nU4CO8TfhIodvkwyMaOJxP40X1E8=;
        b=IN6fIg89oc+E2iYNX2r6SjtdHQYmqpAhX1HOFdCtB0syVy10dTb7uKlyJdP/+TFFYZ
         30rmyw8lm0RAD7BepVjiuFztivMg6o2J10PI5dOVgRdYHObX6miAbpJo7dRfPSBgQgDg
         gq4gkZYZ1giISZRKhS3AxwJe/JX9F0tLPiVfe5VZ4JeaCVsa5rjQQTiUGJQN3hLas3hh
         USqhOHRVSpyjjCGQFrLvFkx1XGcOWsveTeOvgfcOJx2V9daAjtRsDc2cQaDYI1sqL6Kl
         1jkLiRABuR25F1txPjHTyHloc+E5kR8UZNmsNckeek0QcNdCCcitDKiuEm3wn5/Ih7cT
         sHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wmSDgJbG7Or0Iv/nU4CO8TfhIodvkwyMaOJxP40X1E8=;
        b=Lfh5I9mnr+TkxvuX02iwsyS1WKdd/SM+u7p2/SGnUdFLBbnNM6BFoZAcS5ntJEo+Jr
         ExAf3E23Kz2ztm5oV7VjH/dTiyP2T1rQQGMX42DDNW1dfxQeX9ibuTDzhshcj8sNO6vB
         Oh76AZeGIl08aOIrp3tZYozwtuEtkjV+hXu6KFcyTt70aR/1nfzsDU72mO8LyUpTJhhy
         /dXIdORnUMyc/jPhISjihPEHwqmarU5ScgnK4S+4E3XG3U6fRqJaazNsQUmZvPT1iI4b
         rr26riX+1Iw+KfcXu+VgJdiKpPN4hbxFjRGOfZERbKeM3+jvPfwVWIpfHfcoyRw//LhY
         bVYQ==
X-Gm-Message-State: ACgBeo1WKlmUEByz35Dnu4ILb+gdTNulV00clf2DJ8Lsef9aSCw1+RRN
        ANr/Ak+tF7LiClSiqn/LyTI=
X-Google-Smtp-Source: AA6agR7zoCoWZkF/myIFMF4OXZa8aMutLSj1syZTDuBbZQ6ThvJq9rrUAmdaFCClCOtX0XGFBwPL8Q==
X-Received: by 2002:a17:902:8ec7:b0:172:ac9c:4757 with SMTP id x7-20020a1709028ec700b00172ac9c4757mr12818808plo.163.1661706261556;
        Sun, 28 Aug 2022 10:04:21 -0700 (PDT)
Received: from localhost.localdomain (ec2-18-117-95-84.us-east-2.compute.amazonaws.com. [18.117.95.84])
        by smtp.gmail.com with ESMTPSA id t6-20020aa79466000000b0053692028ec1sm5487446pfq.34.2022.08.28.10.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 10:04:20 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH v8 2/2] sched/rt: Trying to push current task when target disable migrating
Date:   Mon, 29 Aug 2022 01:03:03 +0800
Message-Id: <20220828170303.171400-2-schspa@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828170303.171400-1-schspa@gmail.com>
References: <20220828170303.171400-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the task to push disable migration, retry to push the current
running task on this CPU away, instead doing nothing for this migrate
disabled task.

CC: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Schspa Shi <schspa@gmail.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/core.c     | 13 ++++++++++++-
 kernel/sched/deadline.c |  9 +++++++++
 kernel/sched/rt.c       |  8 ++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253c9ac0c..056b336c29e70 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2503,8 +2503,19 @@ int push_cpu_stop(void *arg)
 	if (p->sched_class->find_lock_rq)
 		lowest_rq = p->sched_class->find_lock_rq(p, rq);
 
-	if (!lowest_rq)
+	if (!lowest_rq) {
+		/*
+		 * The find_lock_rq function above could have released the rq
+		 * lock and allow p to schedule and be preempted again, and
+		 * that lowest_rq could be NULL because p now has the
+		 * migrate_disable flag set and not because it could not find
+		 * the lowest rq. So we must check task migration flag again.
+		 */
+		if (unlikely(is_migration_disabled(p)))
+			p->migration_flags |= MDF_PUSH;
+
 		goto out_unlock;
+	}
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e7eea6cde5cb9..c8055b978dbc3 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2340,6 +2340,15 @@ static int push_dl_task(struct rq *rq)
 		 */
 		task = pick_next_pushable_dl_task(rq);
 		if (task == next_task) {
+			/*
+			 * If next task has now disabled migrating, see if we
+			 * can do resched_curr().
+			 */
+			if (unlikely(is_migration_disabled(task))) {
+				put_task_struct(next_task);
+				goto retry;
+			}
+
 			/*
 			 * The task is still there. We don't try
 			 * again, some other CPU will pull it when ready.
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 57e8cd5c9c267..381ec05eb2701 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2139,6 +2139,14 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 */
 		task = pick_next_pushable_task(rq);
 		if (task == next_task) {
+			/*
+			 * If next task has now disabled migrating, see if we
+			 * can push the current task.
+			 */
+			if (unlikely(is_migration_disabled(task))) {
+				put_task_struct(next_task);
+				goto retry;
+			}
 			/*
 			 * The task hasn't migrated, and is still the next
 			 * eligible task, but we failed to find a run-queue
-- 
2.37.2

