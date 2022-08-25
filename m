Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDCB5A1064
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241073AbiHYM1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240538AbiHYM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:27:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B15B2874
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:27:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k9so24420779wri.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=1jOusZgKkm5WANPXGaVYE6KRJlFGGUsuCyFNE7JUooM=;
        b=CEA9syvDnBy12AASzhjTKQePZq/nDobaYDFG33wpBoHuTYHBS+aGzekCp/7KATl82q
         pneAop0fiEfoG1GSROoAovfj7ob6z6FPikrFGC/Q01FKgXeAjKKTktGrS2XHQnGbo7lv
         DOpasbdR3Ggjn3/S7XEkZyJkvycx8YgKfGsdF6S3WW8MkgZfZKvMw1jPKLrsCIdKKjYP
         TBRBNdt9MAsxZLop6/5VMDXe4jPte55IrtJz7zxExSqKXzdxLHlYgcrAwOS2OzBX7e/u
         BiQZ1ue8UVldKu93ERpMi460AcuS31+lx3z3Q0YSqRk6+FTuEnFcVlADiKl2l84E+SiK
         UXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=1jOusZgKkm5WANPXGaVYE6KRJlFGGUsuCyFNE7JUooM=;
        b=inPw6XkyHAMHvL3BPa9Ezhc58DljzBD4UYFNplB044KHAwoAH8hqnXnJ/xvsm3qDoz
         NWSWj31mjNwaaHt3Dhy6vX/ACEnMecwQ7BaS2FqbsfPEXLtgt4hGXGn9mEAifqI6P7WB
         aHRjGiuoM3axrWp7z0Cv0JUJ0Rwlzghfq9DjBBSAKmnhi6gbJYlX3XEOpJkNyg5NY5JT
         4cvXm/jojtr3R67Q9o2ZXQsLLM1YYm8iYXCSp64zkHk4eAtL61e0qjjgEXVEKJwsyMrR
         QiILZoCZt4qbD2qnt/8FBzZlE1reuDivZx/JIOaduKZIXZW5Xmzo48Wb4GjKC6pxNKU8
         BBAQ==
X-Gm-Message-State: ACgBeo33CR0gwJQ0YE/SANELfeyzNxjbhZgD7gSQ/N4Rq861xS5mxar7
        fx5uLxKJ1xneNk7T5yMPRaUvCA==
X-Google-Smtp-Source: AA6agR7TQhU8j0DY68b9wCi9Eo1yLjeb7HaOm3n9AMlTFOh/dP+I8ZeHbohu7+HoxNJ9ofbOw3FFGg==
X-Received: by 2002:a5d:47cc:0:b0:225:7827:70d4 with SMTP id o12-20020a5d47cc000000b00225782770d4mr2104040wrc.315.1661430452431;
        Thu, 25 Aug 2022 05:27:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:55dd:3519:10d3:b07b])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003a5ee64cc98sm5417809wmr.33.2022.08.25.05.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 05:27:30 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     zhangqiao22@huawei.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/4] sched/fair: make sure to try to detach at least one movable task
Date:   Thu, 25 Aug 2022 14:27:23 +0200
Message-Id: <20220825122726.20819-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220825122726.20819-1-vincent.guittot@linaro.org>
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During load balance, we try at most env->loop_max time to move a task.
But it can happen that the loop_max LRU tasks (ie tail of
the cfs_tasks list) can't be moved to dst_cpu because of affinity.
In this case, loop in the list until we found at least one.

The maximum of detached tasks remained the same as before.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da388657d5ac..02b7b808e186 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8052,8 +8052,12 @@ static int detach_tasks(struct lb_env *env)
 		p = list_last_entry(tasks, struct task_struct, se.group_node);
 
 		env->loop++;
-		/* We've more or less seen every task there is, call it quits */
-		if (env->loop > env->loop_max)
+		/*
+		 * We've more or less seen every task there is, call it quits
+		 * unless we haven't found any movable task yet.
+		 */
+		if (env->loop > env->loop_max &&
+		    !(env->flags & LBF_ALL_PINNED))
 			break;
 
 		/* take a breather every nr_migrate tasks */
@@ -10182,7 +10186,9 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 
 		if (env.flags & LBF_NEED_BREAK) {
 			env.flags &= ~LBF_NEED_BREAK;
-			goto more_balance;
+			/* Stop if we tried all running tasks */
+			if (env.loop < busiest->nr_running)
+				goto more_balance;
 		}
 
 		/*
-- 
2.17.1

