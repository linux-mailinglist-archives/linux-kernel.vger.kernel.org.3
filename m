Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B81358637F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiHAE2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbiHAE2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:28:04 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EFCDFB6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v18so9375507plo.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tjbq8DBRMRqIoTBEKM5fLvJIx/eVueL9+v2xlH75foA=;
        b=M/UfrOr4yop/Enj3QfL9bTr9QaoJJcDJsgKGazE1rA6RoKN5EYgIJX71ruyUMUXWmk
         5WuGLGuLLyZlukw9iF5mbXe1OtX00/oVLM62fuKD9LTL5qjnwJo/qTip7VUCJFub/nCG
         UKbOZBqEAXgJO+YrhpIWsMGTYxzIfByUbPUnz9n6t6UkAGak+qxfRUniHiIzUJ7UGwPu
         kpkbW2EC/GwzDSymc5gQirfD0Z/oJhoBtJKnuoLo16aSzHbWGBXzjC4j/s5InLDSAGb7
         b4nqyzHJlYoTYzDL1EdAEbmEdFt/1L3S2FnognPH29WHJtRt33OliFE4UP+SF67yeBiJ
         2KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tjbq8DBRMRqIoTBEKM5fLvJIx/eVueL9+v2xlH75foA=;
        b=IC3ttOFLVBdy1LIGneIwcTf+dF0yNGPiM9ht8mqOVFxYJJGWgNa5FYKz7OdU8qmRUP
         ZK9g5U3Tj5qxXyAh3zCwKd6Bsaicui8Pw5dabiOGp6m0WYJSBWGGHEA/NoTObIRjhE9+
         Bs7W8E8FzNSXkr7D+Ye8mLu0voGGJ/i073Z32EEZtDIlTzveQE5f22/tMvTmmh+y6bd7
         W3iUOj0JZU9+sPOh7TNXRH/LqmqmB5MWzYdYb6BIgbWAMJ5ZxVQ7kyupxNEkwvg8gy6+
         vz+lxLc99QE4y2AyhiaCRsdvCHcxUSPh564+C9kiqZY8O8wdEjrAFMZ7cotjrfcZurm+
         dgEA==
X-Gm-Message-State: ACgBeo3a/+eWEaCzrvBieE8DpMd9X1VgY5FIAYdDm/JvlK0HE5dsMtdK
        qJU30jTBLuXaYR26WgIuNMydgg==
X-Google-Smtp-Source: AA6agR6Gqtf0b040QrgYLhi2rcs8Fe96pRRsPZ+HbZ9M21t3KY30umRv2TUcmzqga5LNDZ3wa7Vg5A==
X-Received: by 2002:a17:903:41c4:b0:16d:cb15:290f with SMTP id u4-20020a17090341c400b0016dcb15290fmr14422523ple.47.1659328081520;
        Sun, 31 Jul 2022 21:28:01 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id ot10-20020a17090b3b4a00b001f326ead012sm7012202pjb.37.2022.07.31.21.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 21:28:01 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v3 00/10] sched/fair: task load tracking optimization and cleanup
Date:   Mon,  1 Aug 2022 12:27:35 +0800
Message-Id: <20220801042745.7794-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series is optimization and cleanup for task load tracking
when task migrate CPU/cgroup or switched_from/to_fair().

There are three types of detach/attach_entity_load_avg (except fork and
exit case) for a fair task:
1. task migrate CPU (on_rq migrate or wake_up migrate)
2. task migrate cgroup (detach and attach)
3. task switched_from/to_fair (detach later attach)

patch 01-03 cleanup the task change cgroup case by remove cpu_cgrp_subsys->fork(),
since we already do the same thing in sched_cgroup_fork().

patch 05 optimize the task migrate CPU case by combine detach into dequeue.

patch 06 fix another detach on unattached task case which has been woken up
by try_to_wake_up() but is waiting for actually being woken up by
sched_ttwu_pending().

patch 07 remove unnecessary limitation that we would fail when change
cgroup of forked task which hasn't been woken up by wake_up_new_task().

patch 08 refactor detach/attach_entity_cfs_rq by using update_load_avg()
DO_DETACH and DO_ATTACH flags.

patch 09-10 optimize post_init_entity_util_avg() for fair task and skip
setting util_avg and runnable_avg for !fair task.

Thanks!

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

Chengming Zhou (10):
  sched/fair: maintain task se depth in set_task_rq()
  sched/fair: remove redundant cpu_cgrp_subsys->fork()
  sched/fair: reset sched_avg last_update_time before set_task_rq()
  sched/fair: update comments in enqueue/dequeue_entity()
  sched/fair: combine detach into dequeue when migrating task
  sched/fair: fix another detach on unattached task corner case
  sched/fair: allow changing cgroup of new forked task
  sched/fair: refactor detach/attach_entity_cfs_rq using
    update_load_avg()
  sched/fair: defer task sched_avg attach to enqueue_entity()
  sched/fair: don't init util/runnable_avg for !fair task

 include/linux/sched.h |   5 +-
 kernel/sched/core.c   |  57 ++--------
 kernel/sched/fair.c   | 242 ++++++++++++++++++------------------------
 kernel/sched/sched.h  |   6 +-
 4 files changed, 119 insertions(+), 191 deletions(-)

-- 
2.36.1

