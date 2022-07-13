Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1403C5737D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbiGMNs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiGMNsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:48:46 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC102BCE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:48:43 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id q13so3433366qkc.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YybWUhAbc7wfz4yEZptFD477MqhkoIQMKRvhP8fTu+0=;
        b=KQnFd7WlnAiwY4PXk3R58GkmQ2GVlGK44Wlk9RQaEN2hmemIXnshpqqS2V0OmnJWcy
         RC3fXeNUhPIkYirFUI/n8Qe+SV5SnhFdQBnTqtJPLgXtOXomU9k/NBZJ5DOiIxfFa86P
         uK9oBXPusz9gr5XzZC14pK71m5X2CECIVt1B5bdJnhk3tzgDmZHRpSPrem3dKAt3tuyI
         skmHLaKhOvjuVLPt7hIHWdWgDtYsR2z7nq7tqcD2RIasA1c8PGiEZD27+89/XG39coiN
         KjyIwru+HT9vEz1NsLw2NWgqvwgk/D3fnHop7E06f7Nb7ugH39Llp2Wh0TqJj9w/Appx
         Akbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YybWUhAbc7wfz4yEZptFD477MqhkoIQMKRvhP8fTu+0=;
        b=PW0VrOjpA9WrrDSGQvrU8oz/OnWwNXwB1I+cQgTWVFg95461eJ9Horf3VPdYOdp+aL
         0Vt9zQsNmgJb0GebNXPKlfYvuwQ6z3m1YFBNaLjCnPU2OjinM3FBYgVlMKbxODthh4fK
         jeL5nRQlbg85rbUktWA68BqcL7y/5dNuyS5e7aYMu1w8Mfp9yhLwpZdLyBfhHIcVyXwI
         Xa0Gi51e3O7geHKE+/gGZvieczwvYaikJUc69V4vgYykCwPpdOCTcAQzjebS5tYxe3d1
         6C9XUs3F2JWPAK9TbOxwY9MjFhEYozJZ2Io+ERhgQnnG7FlbbeM9hYZQ2teDAnSxKR2J
         qy3Q==
X-Gm-Message-State: AJIora9khIW5saqSbzAT2QbPJ2U6ISZJPkXBZn+Orh4Q/bOUbDYYQsSi
        PYrR5ERNhS8G7ORHuRnLPlo=
X-Google-Smtp-Source: AGRyM1uTfKC+edi+nJuqExVkbmVZEPF+RLyUCWOWcFVZwhwKptn6wso1l2MOtOYqTDr4oQWlo/x5NQ==
X-Received: by 2002:a05:620a:22e3:b0:6b5:a2ab:b9bb with SMTP id p3-20020a05620a22e300b006b5a2abb9bbmr2444424qki.151.1657720122914;
        Wed, 13 Jul 2022 06:48:42 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id bl22-20020a05620a1a9600b006af45243e15sm1458083qkb.114.2022.07.13.06.48.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2022 06:48:42 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH v7 2/2] sched/rt: Trying to push current task when target disable migrating
Date:   Wed, 13 Jul 2022 21:48:23 +0800
Message-Id: <20220713134823.95141-2-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220713134823.95141-1-schspa@gmail.com>
References: <20220713134823.95141-1-schspa@gmail.com>
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

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 kernel/sched/core.c     | 13 ++++++++++++-
 kernel/sched/deadline.c |  9 +++++++++
 kernel/sched/rt.c       |  8 ++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecd..af90cc558b8e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2509,8 +2509,19 @@ int push_cpu_stop(void *arg)
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
index cb3b886a081c..21af20445e7f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2335,6 +2335,15 @@ static int push_dl_task(struct rq *rq)
 		 */
 		task = pick_next_pushable_dl_task(rq);
 		if (task == next_task) {
+			/*
+			 * If next task has now disabled migrating, see if we
+			 * can push the current task.
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
index 7bd3e6ecbe45..316088e2fee2 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2136,6 +2136,14 @@ static int push_rt_task(struct rq *rq, bool pull)
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
2.29.0

