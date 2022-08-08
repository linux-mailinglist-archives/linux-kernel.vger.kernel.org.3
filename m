Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD458C8D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiHHM6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiHHM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:58:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F9E38B8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:58:00 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso3610851pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lGPU+wctzKbLuWapUDBug/SpNMZRxyCn/TpZiuTYAJE=;
        b=OfrmKEYnuwzM6XZirbZkKp9HH8tDVALUXBoIE6QbOOFK6UZVyZnUNfX2PSnRBtwsf6
         ZMvX7xm1lKMkEBI/qQy0UGasVfDoo9SHqRqsUJD10xUmRxp+S3CfEzZ962vuSAX7d4rK
         rYUnged7NUKeJFv9QSWcAtEdIMhEV25lNwcjB3Ku4iWYE3/BbVo6ded1L8lFZDCw4aBI
         MAO53BSF8j6VP5Vv3NhOhIvI7FyEaenN1zartttlnfeRsiFP93W5+tloRd8OzBf10pHT
         Hwj5ZeS34yb+7L1Yu3B89bzhZGN6ZQBC14OGShWAiu4N8QXxaM64tM7degzJ58hBF0He
         5W4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lGPU+wctzKbLuWapUDBug/SpNMZRxyCn/TpZiuTYAJE=;
        b=la+1HNSn3EOaXhBtMex7T5UiIZQbUQ/o087ufgFbwaY4QUF4lhfigFYoPN426yumUI
         BQqGiDmWmX/aqqNGxow6zlNAfjkbs+p13dUCtQHjo4ZEOKDZ0GYF8Ou0iB95zQrrJ6P5
         935HZqqknQx6ZNv5zSnaW7ryBKEoiWVK6BdVTRi2I8twlUbZyAkwPxDdWHb96eVC/QN5
         HAmOa2Z/57F5JkkeIB5usgv0EfC0ValrJxSSMLedTIrDzxBTkxL9Ni/BOAMFy70u+5IO
         ADAHT7SIvyge/KULruhInbL4JU03sTi0qYGb1tlHnJnmFwYqLbFUE/aC7aaxqyAyUFbT
         JZKA==
X-Gm-Message-State: ACgBeo0VvDtD8Gap94cVJbe6J1NC9d7k+rnOqBlo9l9XSVTLaEZZzPPF
        4K79fJ+T+HNnvS0h/lINfQ6TpQ==
X-Google-Smtp-Source: AA6agR47YHThcz+J3aSAEh05Fn9E8cu9+8GCiQp2FG5lg029OVW7ePocDc1cmTyK7qAfWBqDQ5Ke9w==
X-Received: by 2002:a17:902:b207:b0:16f:2349:6116 with SMTP id t7-20020a170902b20700b0016f23496116mr18491428plr.80.1659963479613;
        Mon, 08 Aug 2022 05:57:59 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id d14-20020a17090ae28e00b001f4ebd47ae7sm8057722pjz.54.2022.08.08.05.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 05:57:59 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 0/9] sched/fair: task load tracking optimization and cleanup
Date:   Mon,  8 Aug 2022 20:57:36 +0800
Message-Id: <20220808125745.22566-1-zhouchengming@bytedance.com>
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
 kernel/sched/core.c   |  57 ++--------
 kernel/sched/fair.c   | 234 ++++++++++++++++++++----------------------
 kernel/sched/sched.h  |   6 +-
 4 files changed, 124 insertions(+), 178 deletions(-)

-- 
2.36.1

