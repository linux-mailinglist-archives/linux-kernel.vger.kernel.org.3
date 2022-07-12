Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BA5570F86
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 03:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiGLBcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 21:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGLBcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:32:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27768D5CC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:32:40 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so6255216pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ei9yAA7QrpUbdjMc3HmjzhCQ9jQmC45mh/jU0RZTxVw=;
        b=EQ7Q7mJlyAUBbAtNhEhuBBBuTIwOKpa3/AXEhB2TDcC3Odwcrip4c6YZLLObTAg+FO
         wGI2Q0k1HSuSwooApuW4+iX17E8Ae4WZv+S/JOySwzRBusN/09skTvRlA4B+7RL9f3n0
         8qOBuu4cEy6DWoG7ukU80eJsUeDozzSlTHkITVU/oXdbWiIp7saHGOySdsFPPJnMlpkf
         jaD2TLaoe+IUlQZPRUEYTHDC+YQtgtGLppPuAxdT8oNgLebpm3/5gAcMvuq88itiV6uj
         ci+xUiWx7GKTEPTcV7B9Bp2BcETS64WnZo2dbsLHULb7N+H9EHAAwrwQfzYCGxiCIK07
         OHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ei9yAA7QrpUbdjMc3HmjzhCQ9jQmC45mh/jU0RZTxVw=;
        b=7Bhf35CUYBrFd3pRj4h2zQBcxU1Lb6LrJAXz+m9RqwzdLOPTc9nxGBHL2DWaeFTNig
         tW0IMoJan2zSlegi81sallhJM6ruYxtCL+O+DfbWZ675kSTd7DzCz90QQPqpNxFhgXDd
         Rw8oqXqfnBfK+CHLxTxDelNnXhJG5MaO1gSGNe8zfXSdt9FZmEqcFRcgGNpq+FIKLl0i
         v3jdihre1Uixg6W49cUwtCdFAD7ykIgWtvCXTNm4k/b5ChwmOUMq6H5a0K3oA9bQdBCj
         V0M/oFXZzX1soYNevmfVBSUrlVpHaDmfh2gY8CDbSF7ItCmXuPE33rxtLtT3Y4z8Yjnt
         JZYw==
X-Gm-Message-State: AJIora+aN6iXOr6YozUqm54Lwf/KjxtLqpLkaLJDyjzYMPbKlrxzK1T8
        275TtegDJvFGHS/An0EXC7E=
X-Google-Smtp-Source: AGRyM1vTzdFMrECEheI40uFb8pWRGJvh4N4194dquo7n6aYa75/J9V+lHQ3xOwjiV0+LKWGN8VLEEw==
X-Received: by 2002:a05:6a00:1a46:b0:525:82e2:a0d3 with SMTP id h6-20020a056a001a4600b0052582e2a0d3mr20837514pfv.48.1657589560437;
        Mon, 11 Jul 2022 18:32:40 -0700 (PDT)
Received: from localhost.localdomain (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id g124-20020a625282000000b00518e1251197sm5539620pfb.148.2022.07.11.18.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 18:32:40 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: [PATCH v5 2/2] sched/rt: Trying to push current task when target disable migrating
Date:   Tue, 12 Jul 2022 09:31:25 +0800
Message-Id: <20220712013125.623338-2-schspa@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220712013125.623338-1-schspa@gmail.com>
References: <20220712013125.623338-1-schspa@gmail.com>
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
 kernel/sched/core.c | 6 +++++-
 kernel/sched/rt.c   | 6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecdc..0b1fefd97d874 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2509,8 +2509,12 @@ int push_cpu_stop(void *arg)
 	if (p->sched_class->find_lock_rq)
 		lowest_rq = p->sched_class->find_lock_rq(p, rq);
 
-	if (!lowest_rq)
+	if (!lowest_rq) {
+		if (unlikely(is_migration_disabled(p)))
+			p->migration_flags |= MDF_PUSH;
+
 		goto out_unlock;
+	}
 
 	// XXX validate p is still the highest prio task
 	if (task_rq(p) == rq) {
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7c32ba51b6d85..877380e465b7a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2136,6 +2136,12 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 */
 		task = pick_next_pushable_task(rq);
 		if (task == next_task) {
+			/*
+			 * If next task has now disabled migrating, see if we
+			 * can push the current task.
+			 */
+			if (unlikely(is_migration_disabled(task)))
+				goto retry;
 			/*
 			 * The task hasn't migrated, and is still the next
 			 * eligible task, but we failed to find a run-queue
-- 
2.37.0

