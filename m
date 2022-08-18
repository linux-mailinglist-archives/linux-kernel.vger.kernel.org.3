Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD1B598368
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244752AbiHRMsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244483AbiHRMsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:48:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6126012A9A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso1939468pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SMq0cA2jEsn6WUyEAj1aw0vQrzMP34F5/Qh2zJxCnf8=;
        b=8F/j6dgpNdtCdvGjJwoeXeGFkbJpvyprWVFaTMVY0I04GiTIWWX9BlGy5aMX/FZqBc
         wSvdwLVXA8rUx0L3/j72vCOnKOE4YUATu38FDrESPwXie6DXG1hpVFhrYNJ5Ppe2yls6
         bsEjtPhuhypyi9AObjyA4yDccxYkhGf4wATPgia3GD1AIcW9/fYqIBTWGty4/kvQb3dp
         1HyHWaH9xfuoMCQbesTLLrUwyh651YyEZUX5zH80+/Oxf6Uspa2TUl5n9vi8Pyi+xib+
         UH2v7u0e51Y75IhU6ONR7RgZz9ManOiVJZUgH8q5K5heAxKcy2ANAdtGRj6S6ZE96Nm1
         x89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SMq0cA2jEsn6WUyEAj1aw0vQrzMP34F5/Qh2zJxCnf8=;
        b=Tfx4Oupp3ekPJKadbDHZ6lQZKhnH6nuHbR1UcfYgxOhyzGoIokh84myReml7nR7Hlk
         Rv9z47w2YxjZlf0mibA//JXHTzS6wyuC59py8j3TkLIN3oMhjQfJwwT3T/rmFwiZv1W4
         +RrFwBdv956nhc4aTE3qfz5SMFupkO+ZEzfV2Er2UNEvl9EQIqzq6aC+WbidOkWi475h
         tl+Wmz+t5mXIpaYq/Z/bFuZkQLt2bxN/CiKzJGk5A1fGvZ9EM47wLfNetFb+MGwkgJpc
         4Wmo1jR8kFreZxDeDB4d2DsMSUB5/v6fUI8FfmyUPYKBl9dhbbWonwNCPieVry9uRJ3S
         B9sg==
X-Gm-Message-State: ACgBeo02OmrWn5mIrtBgQ+yJaf3m2ZjFDaFrhGCQn7aHG40P0Qr6LAyu
        lcRqYISIZ/dujst6fJSAqZGYoA==
X-Google-Smtp-Source: AA6agR5tyBTcCYcVMENIvyQyB3mc6gL9geKpMkd8MDRKN1UQ8YhRNv8srMvQPh1H+evwhM4/9NPOPQ==
X-Received: by 2002:a17:90b:38cb:b0:1f5:2321:63cb with SMTP id nn11-20020a17090b38cb00b001f5232163cbmr8908237pjb.110.1660826897816;
        Thu, 18 Aug 2022 05:48:17 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id c16-20020a621c10000000b0052f3a7bc29fsm1477449pfc.202.2022.08.18.05.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:48:17 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v6 0/9] sched/fair: task load tracking optimization and cleanup
Date:   Thu, 18 Aug 2022 20:47:56 +0800
Message-Id: <20220818124805.601-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
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

Hi all,

This patch series is optimization and cleanup for task load tracking when
task migrate CPU/cgroup or switched_from/to_fair(), based on tip/sched/core.

There are three types of detach/attach_entity_load_avg (except fork and exit)
for a fair task:
1. task migrate CPU (on_rq migrate or wake_up migrate)
2. task migrate cgroup (detach and attach)
3. task switched_from/to_fair (detach later attach)

patch 1-3 cleanup the task change cgroup case by remove cpu_cgrp_subsys->fork(),
since we already do the same thing in sched_cgroup_fork().

patch 5/9 optimize the task migrate CPU case by combine detach into dequeue.

patch 6/9 fix another detach on unattached task case which has been woken up
by try_to_wake_up() but is waiting for actually being woken up by
sched_ttwu_pending().

patch 7/9 remove unnecessary limitation that we would fail when change
cgroup of forked task which hasn't been woken up by wake_up_new_task().

patch 8-9 optimize post_init_entity_util_avg() for fair task and skip
setting util_avg and runnable_avg for !fair task at the fork time.

Thanks!


Changes in v6:
 - Use TASK_NEW to check new forked task which hasn't been woken up
   by wake_up_new_task(), suggested by Peter Zijlstra. Thanks!
 - Update comments related to post_init_entity_util_avg() in patch 8/9.

Changes in v5:
 - Don't do code movements in patch 6/9, which complicate code review,
   as suggested by Vincent. Thanks!
 - Fix a build error of typo in patch 7/9.

Changes in v4:
 - Drop detach/attach_entity_cfs_rq() refactor patch in the last version.
 - Move new forked task check to task_change_group_fair().

Changes in v3:
 - One big change is this series don't freeze PELT sum/avg values to be
   used as initial values when re-entering fair any more, since these
   PELT values become much less relevant.
 - Reorder patches and collect tags from Vincent and Dietmar. Thanks!
 - Fix detach on unattached task which has been woken up by try_to_wake_up()
   but is waiting for actually being woken up by sched_ttwu_pending().
 - Delete TASK_NEW which limit forked task from changing cgroup.
 - Don't init util_avg and runnable_avg for !fair taks at fork time.

Changes in v2:
 - split task se depth maintenance into a separate patch3, suggested
   by Peter.
 - reorder patch6-7 before patch8-9, since we need update_load_avg()
   to do conditional attach/detach to avoid corner cases like twice
   attach problem.

Chengming Zhou (9):
  sched/fair: maintain task se depth in set_task_rq()
  sched/fair: remove redundant cpu_cgrp_subsys->fork()
  sched/fair: reset sched_avg last_update_time before set_task_rq()
  sched/fair: update comments in enqueue/dequeue_entity()
  sched/fair: combine detach into dequeue when migrating task
  sched/fair: fix another detach on unattached task corner case
  sched/fair: allow changing cgroup of new forked task
  sched/fair: move task sched_avg attach to enqueue_task_fair()
  sched/fair: don't init util/runnable_avg for !fair task

 kernel/sched/core.c  |  52 ++++---------------
 kernel/sched/fair.c  | 120 ++++++++++++++++++++-----------------------
 kernel/sched/sched.h |   6 +--
 3 files changed, 66 insertions(+), 112 deletions(-)

-- 
2.37.2

