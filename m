Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5DB56CA45
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiGIPPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:15:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860A27B2C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:15:14 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 145so1258295pga.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A0TAGRKo4T+s5Kl5lGU9qMvp0EMsuqUfm88CEfVz3Es=;
        b=y6Gkfp1BzutBkJmNW5lJvqr/Ag0O+cRcVQu4ryPLTUeFWliJiBgwK9DK6pmb9InaY/
         2kN25Q1jFc6IsaXdOEkGtG9b3joXCST3KuQLEWO24ECGBuaKEFh+Vc38gw9Rs64IltVT
         Yo0pmil1MvPWZYQG6fT0I0zz2IF5oUuHk06CnqBz88O7w20WovuZ8DvtWN+xCzPvbXc6
         hYuOmo0L3iZzKmyr9uPTsJ4bFB/6ObDJXneKWXSkjitpjAfqRE3/tRJ0LPrDycOPFLh7
         Y1CCn07FN8JDuCdnY+OyV/tlR83KrpXmIvfI9prsysTaadEhGE2ETvB+uVboQm0V4kA7
         +x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A0TAGRKo4T+s5Kl5lGU9qMvp0EMsuqUfm88CEfVz3Es=;
        b=S0Avm9mISPm6EE0TDqAOAQSBbO0EqRPs38ruerJLwsGhVTp9vWkJYZUyr2gxkTNhZj
         4ixKC1e4MphoYxi0TVoSYkvY5wiuvOP0+L7SGcnr4oFu30fgJVHiLemeg+nrG6sUezO1
         RqLgEtxOmuxB1bDe0WuKa/RyyLhslEVJq5IMTTj4J5NAdDOCaSgnA2OdpOdIBjnBymJ8
         kBXNte7zFzG0h7QkF7xib7uNXAjE9QL/UVRPxKns/6p5TW9TAsSIhk04otntpjncUaq2
         bjZgMQxFT3ILmjzTWuQjX88DerMfa7k9ow2pq80G8ipWbFBX6yDCrRJft15T5SzN21vw
         LFwA==
X-Gm-Message-State: AJIora/mygtMTgw+a3YUy9ruhqZGDX2VSq/g1x2HtfDM3VIGPEHxMHR6
        bLQyRxpZEbxnlu/b+CxjD5MbKA==
X-Google-Smtp-Source: AGRyM1uwdpplh06qX+beNbc1c45hTpTz6XnKSnHYQQQBsY/Zl2ECFgplZKv2Hg7HC6OOjExs36HI1g==
X-Received: by 2002:a05:6a00:22cb:b0:525:ba83:559a with SMTP id f11-20020a056a0022cb00b00525ba83559amr9562336pfj.54.1657379714374;
        Sat, 09 Jul 2022 08:15:14 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:e730:5493:aabd:e56d:65e6])
        by smtp.gmail.com with ESMTPSA id bo20-20020a17090b091400b001ef8d2f72fesm1295709pjb.45.2022.07.09.08.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 08:15:13 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 0/8] sched: task load tracking optimization and cleanup
Date:   Sat,  9 Jul 2022 23:13:45 +0800
Message-Id: <20220709151353.32883-1-zhouchengming@bytedance.com>
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

patch3 cleanup the migrate cgroup case by remove cpu_cgrp_subsys->fork(),
since we already do the same thing in sched_cgroup_fork().

patch1-3 have been reviewed earlier, but conflicts with the current tip
tree, so include them here as a patchset. Sorry for the inconvenience.

patch5-6 fix load tracking for new forked !fair task and when task
switched_from_fair().

After these changes, the task sched_avg last_update_time is reset to 0
when migrate from CPU/cgroup or switched_from_fair(), to save updated
sched_avg for next attach.

patch7-8 delete superfluous set_task_rq_fair() and SKIP_AGE_LOAD.

Chengming Zhou (8):
  sched/fair: combine detach into dequeue when migrating task
  sched/fair: update comments in enqueue/dequeue_entity()
  sched/fair: remove redundant cpu_cgrp_subsys->fork()
  sched/fair: reset sched_avg last_update_time before set_task_rq()
  sched/fair: fix load tracking for new forked !fair task
  sched/fair: stop load tracking when task switched_from_fair()
  sched/fair: delete superfluous set_task_rq_fair()
  sched/fair: delete superfluous SKIP_AGE_LOAD

 kernel/sched/core.c     |  27 ++------
 kernel/sched/fair.c     | 139 ++++++++++------------------------------
 kernel/sched/features.h |   1 -
 kernel/sched/sched.h    |  14 +---
 4 files changed, 41 insertions(+), 140 deletions(-)

-- 
2.36.1

