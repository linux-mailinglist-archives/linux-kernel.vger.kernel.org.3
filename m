Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECE4597C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbiHRDpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbiHRDpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:45:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491A494135
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:45:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bh13so330930pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=PQOI5B5Wt5r/rxb9bDxD+BIMmAwOC6jUY51cH5dbBys=;
        b=6ROSN/hGMMs7AnBvDBrn5pOv0+dj9KAmLblY5ozr0/ERIAU6EjdKPQEjEn3g941fbF
         hJOKNDGKTZDYwb1iqqAXgzE4tiS3frYPIJ3TaS7Iu+TVgbCKRZctbd6oxphDvNnB49gS
         YEANIoRIGvJcOQVziQ5srWN4G7r6Se+KpJAyueDQUHZNHZHgdQz6W/KinSu6sIU7vCM3
         xFwSBk+lyCxYkDXk4dSCQwACAzNnd817R4xEfBEbKMGjkpOEfZYkVF7seIlPgE38U57b
         TOQpo8fOQ2pmnx/Lc4M/lc8yTn8XIO0GuiS3n92bgV2VAlCHXj7aMn+QHxUCNpWvIduI
         icNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=PQOI5B5Wt5r/rxb9bDxD+BIMmAwOC6jUY51cH5dbBys=;
        b=qyW9V1tajFgBwKEYmyHFE9rkm1iwiC4oeMTu6AUrsr2nELkfLwrNse3h5BpWHUB6iv
         bxoVhoMBf15ON/JURgVV0E+Ig+rRShEWbrRSqHPM7JRKGJ/FR+PZGSJBF82KyjXxWhbJ
         AYcsXp//RmxCE9a1OpwOZIyuPIygkJtY5ttq4Tb/XuyxComrcJQBq0mwBEU+9RITpWzm
         N1+NbInQhCuBpYE5QndbZNa9hf39dq50o+sGUD8kiectaWOaIIzrroJ077o8hfblUYAw
         7nhKrpTKG4a/bs+cWX8eXgfp9pbiQB4fXUjfc1XeqyCwC4Z8V5d5WCC1bsmmqlPjihGr
         oN7Q==
X-Gm-Message-State: ACgBeo3pIVmokxPw9Bj7kY9E9N2NWlN0wW1RntIBDJP3WAa2EEv1IlY5
        9K+6y670HDCSgTPz4qFVtpa7Zu3JXBmaoQ==
X-Google-Smtp-Source: AA6agR4xDSwYz52KfcOYGhexY4KgGxIiB1SeUO8QbtliX+QJa0AWSZHERKOC6YR9HqpDWkOtEakqHA==
X-Received: by 2002:a05:6a00:855:b0:52e:f01d:723a with SMTP id q21-20020a056a00085500b0052ef01d723amr1140625pfk.31.1660794339730;
        Wed, 17 Aug 2022 20:45:39 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id m11-20020a65564b000000b00419acadde52sm268700pgs.46.2022.08.17.20.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:45:39 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 0/9] sched/fair: task load tracking optimization and cleanup
Date:   Thu, 18 Aug 2022 11:43:34 +0800
Message-Id: <20220818034343.87625-1-zhouchengming@bytedance.com>
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
  sched/fair: defer task sched_avg attach to enqueue_entity()
  sched/fair: don't init util/runnable_avg for !fair task

 include/linux/sched.h |   5 +-
 kernel/sched/core.c   |  57 ++++-----------------
 kernel/sched/fair.c   | 113 +++++++++++++++++++-----------------------
 kernel/sched/sched.h  |   6 +--
 4 files changed, 67 insertions(+), 114 deletions(-)

-- 
2.37.2

