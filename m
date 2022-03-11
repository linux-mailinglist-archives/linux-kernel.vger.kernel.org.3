Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7790C4D65D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350180AbiCKQP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350152AbiCKQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:15:20 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5926E191439
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:16 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r10so13694826wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9NTMzRLoGwhdmZLI0ObjR+XF+Hbh3xQ8VsF4xT8xykA=;
        b=LsnZVgmhh5uS1QHpj2P4oaLfREx9Of1I8baPHD79rDOuDC9Pk4zK2cnXFgW+qJ+yqU
         aTcnryb/9nK684ESqGZxRLI3VQqImxz4vcM5e6jN2M7D1lbgci5PAdRMYfxoxzqhJRvw
         rjNrLUYwfNHjF1gudsP1xtqJ021ftJKnMRagij/zVzxJyCD8QTfGFQ65ZhyQNj6gjAVi
         V1a7Q5KPvl+RSE/Z25b98ilQQTjIjCGotvQx1Y5V3CPYmmxC0uSdyeRlmyc9ReO3qMVU
         L6JzgxIwDiQFDWyL1AKc3/Nv/eGQI2f/iplUT8tkE8o9MhchCb0yCl5A6xIi+QmS+SbO
         XyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9NTMzRLoGwhdmZLI0ObjR+XF+Hbh3xQ8VsF4xT8xykA=;
        b=qL1OcvkzLZOK9RBI3edJkLdyUWLoL+XGyCT2SlIuFk5/PUblRB6SmcJxTz+9w8Hbh3
         WTSKQEcZjuF8JW8VL2TT+Yq7w6CpPhirxtrRhCK2sTfqFL1xVU3NIu7lMn4kDahPtstm
         wGWLDwj5onoRblmI6bH+ACprMbQ3WWHgUPquMvQw6C5Jv42+phb2MasLoXZveUuXX/X9
         DyZMv76fUfAAGHJ2ZnlAnmfKuxNobbWieH0m6dqTX1DF0sukRJEPhQwl34yY23XRDkMB
         GD3Zm8evNf5R8gqligrvo2yb14h+tpmEpZI2VRxR/5zHlKBnCw1SVaIU9zUHb1MvZsyf
         /TMQ==
X-Gm-Message-State: AOAM533T0I0Jif6a5iVFQuBgFkz9BTbk6xOjo+lVmrZvwN9uEd5OtHY0
        VzBih8OKFgwltDiL+F5yfIWxTw==
X-Google-Smtp-Source: ABdhPJxcbEF6e5XH+u6g5S39oS3QJ3F6/VpKABVcAM0aJiAwE5m8TIVhVRUDsVEZwJ8ONP/PAfSicA==
X-Received: by 2002:a5d:678f:0:b0:1f0:2471:5a93 with SMTP id v15-20020a5d678f000000b001f024715a93mr8031486wru.164.1647015254891;
        Fri, 11 Mar 2022 08:14:14 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70d9:405c:a1e4:4d23])
        by smtp.gmail.com with ESMTPSA id 4-20020a056000154400b00203812ca383sm6464137wry.78.2022.03.11.08.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:14:14 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com
Cc:     qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/6] sched/core: Propagate parent task's latency requirements to the child task
Date:   Fri, 11 Mar 2022 17:14:02 +0100
Message-Id: <20220311161406.23497-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220311161406.23497-1-vincent.guittot@linaro.org>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Parth Shah <parth@linux.ibm.com>

Clone parent task's latency_nice attribute to the forked child task.

Reset the latency_nice value to default value when the child task is
set to sched_reset_on_fork.

Also, initialize init_task.latency_nice value with DEFAULT_LATENCY_NICE
value

Signed-off-by: Parth Shah <parth@linux.ibm.com>
[rebase]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 init/init_task.c    | 1 +
 kernel/sched/core.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/init/init_task.c b/init/init_task.c
index 73cc8f03511a..2afa249c253b 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -78,6 +78,7 @@ struct task_struct init_task
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
+	.latency_nice	= 0,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1d863d7f6ad7..157eef880d1d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4393,6 +4393,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 */
 	p->prio = current->normal_prio;
 
+	/* Propagate the parent's latency requirements to the child as well */
+	p->latency_nice = current->latency_nice;
+
 	uclamp_fork(p);
 
 	/*
@@ -4409,6 +4412,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
+		p->latency_nice = DEFAULT_LATENCY_NICE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.17.1

