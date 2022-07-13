Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12701572C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 06:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiGMEEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 00:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGMEEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:04:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF0970E6B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:04:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y9so9159336pff.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgjcEjE3qyjBt01uSVEDKZhUeCo8bM3RPgetRXn0YyE=;
        b=OKhjTFM1loP2I8iyw4sA8L2IkS1HN0JVoQM4Yu9JR06IswXbgy6ixCVN38kDHb3crK
         nVNsH6pjB/muL9gkxt0cb1h+RJciy5tsSy0yKXOhIqRM2fdsz+neGHIKEyHVNzh/7/3X
         EMP6seOQvFfWZ46zzjpl7MGCgzMok+1dmUH8gW412Y++33B6mxDC9oTQCB4i+Ubf2xNG
         Zm47BzrPmOgwE0Q0uQN9n/01k1FeiUrpDZO1nNIcF5ZsyaP/yo9/PgK8f0B9iarqUYaW
         AC3wxnFeekZpVrfPyomV3xTK7VfYX/riZQk3x1ewjd0UBtR8y+uZxO5pAKZKB8SF8Ij0
         kYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgjcEjE3qyjBt01uSVEDKZhUeCo8bM3RPgetRXn0YyE=;
        b=eQQL/3DhWURcU+3FCiaG2YIKx5rcVrc3Ox6JmIqULDXUpWuHtJnJjpT122G04xN8PP
         UzjUGcjjE8ZLfBx4RrwX7Q+SXvndj1pn6xAKUPFhVGzCTz/hZJhJDofk59vYfEs5/HjP
         by1mcAdWszaxp+mzD81KtFnFPPybC15c6lvNFuWvb6kC/oLfAr2mRRoLE7Z0fBsAQkBz
         +VEUmlr0Vxhe3NfaTJnRjnQ1vxI9OEIpS7t2CMDIrmXHPXKqNlH1vfk6wHzMBItLDsQA
         huBOVd2a/7sBseG97ummiNxxD59nPh2Zl1HHC+44Gxu6zzxDGtP4ix/AV/XOnG9DF6eN
         6FYQ==
X-Gm-Message-State: AJIora81TfMKiVFJaHfGmdd8T9bQiEGiPZxHzAbz94t4Yel9JL15qNeX
        1+KkToLkA+WUiL1Z3Nq4TrJnGA==
X-Google-Smtp-Source: AGRyM1sPaNzffXj2pdycEM+phJAboBg/I1p0SGFzYS8l3dwTHHXtxaZvHsPYFo1MvflmricRzWU5Mw==
X-Received: by 2002:a63:65c2:0:b0:419:8146:b1a7 with SMTP id z185-20020a6365c2000000b004198146b1a7mr1360642pgb.210.1657685087090;
        Tue, 12 Jul 2022 21:04:47 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0016bd16f8acbsm6858942plg.114.2022.07.12.21.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:04:46 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 00/10] sched: task load tracking optimization and cleanup
Date:   Wed, 13 Jul 2022 12:04:20 +0800
Message-Id: <20220713040430.25778-1-zhouchengming@bytedance.com>
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

This patch series is optimization and cleanup for task load tracking
when task migrate CPU/cgroup or switched_from/to_fair().

There are three types of detach/attach_entity_load_avg (except fork and
exit case) for a fair task:
1. task migrate CPU (on_rq migrate or wake_up migrate)
2. task migrate cgroup (detach then attach)
3. task switched_from/to_fair (detach later attach)

patch1 optimize the on_rq migrate CPU case by combine detach into dequeue,
so we don't need to do detach_entity_cfs_rq() in migrate_task_rq_fair()
any more.

patch3-4 cleanup the migrate cgroup case by remove cpu_cgrp_subsys->fork(),
since we already do the same thing in sched_cgroup_fork().

patch1-4 have been reviewed earlier, but conflicts with the current tip
tree, so include them here as a patchset. Sorry for the inconvenience.

patch6-7 use update_load_avg() to do attach/detach after check sched_avg
last_update_time, is preparation patch for the following patches.

patch8-9 fix load tracking for new forked !fair task and when task
switched_from_fair().

After these changes, the task sched_avg last_update_time is reset to 0
when migrate from CPU/cgroup or switched_from_fair(), to save updated
sched_avg for next attach.

Thanks.

Changes in v2:
 - split task se depth maintainence into a separate patch3, suggested
   by Peter.
 - reorder patch6-7 before patch8-9, since we need update_load_avg()
   to do conditional attach/detach to avoid corner cases like twice
   attach problem.

Chengming Zhou (10):
  sched/fair: combine detach into dequeue when migrating task
  sched/fair: update comments in enqueue/dequeue_entity()
  sched/fair: maintain task se depth in set_task_rq()
  sched/fair: remove redundant cpu_cgrp_subsys->fork()
  sched/fair: reset sched_avg last_update_time before set_task_rq()
  sched/fair: delete superfluous SKIP_AGE_LOAD
  sched/fair: use update_load_avg() to attach/detach entity load_avg
  sched/fair: fix load tracking for new forked !fair task
  sched/fair: stop load tracking when task switched_from_fair()
  sched/fair: delete superfluous set_task_rq_fair()

 kernel/sched/core.c     |  27 ++------
 kernel/sched/fair.c     | 144 ++++++++++------------------------------
 kernel/sched/features.h |   1 -
 kernel/sched/sched.h    |  14 +---
 4 files changed, 41 insertions(+), 145 deletions(-)

-- 
2.36.1

