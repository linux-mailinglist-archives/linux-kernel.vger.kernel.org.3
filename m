Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02FE4D65D3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350096AbiCKQPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiCKQPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:15:16 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7BD188861
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:12 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so7803149wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=InxvzxIrVkhiOTKaarbGJmjSNaK0ud+wtyJ3b1vFhkQ=;
        b=k6aXlA23/m4WAiYLkcDX6rs0eSviv8nVTkgOiZbL2hJNOv/drLLtm/HDAxthpKLk84
         GXyLkqmNUyHxK3q+89RXDAH45Vrmg7mzPrLKfddw7n4MYBguU55suK4z5DWZGFrDtGqk
         JP94AUNGhhpXz0K/s0ugbsWRANTYnG1DZZ9uK790pQtzEVljBC3bXCpmEdWWP/aACjUD
         4VrEChUKgr7mM0P/Sok0w78xVuRbtAlfxkotSethNO10PgFSBlTgwViathqkDv5rajXx
         bvZke9V2mOXQdkk5qBlo+/1/6QgvBNkVJ36+g7zu+gn/FiQh8mUHNTB4hfs2FzEvmgIz
         VrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=InxvzxIrVkhiOTKaarbGJmjSNaK0ud+wtyJ3b1vFhkQ=;
        b=2G0hI9cPeECBYpKzUcpGXFSEN8vjAO0XlUZ73FQbNYH3/lb9Z21L1okCLD3iHvhvv3
         7BLkCvv9gPAY0bt8spsNnlXAi2Mc1+zM6KEYPAZW14j3As8P9/0K/EFOvRTK6sQp9qfc
         yk51kRYhxwQU0HSGVdYO4RuHCRebscnRGLxxx3pKY9tkOX1Z+8kHvcwQnrtYeLfvidSs
         SjxvD7+XEvdRDHU7LmHOWnaEhDkATX5hCzAnqglMyEOTf7G5XW+Axo1TXBUeA5GJevSG
         cOn+uZZwl2ogsQI1CGIKZMSB7F2wF9LvY8/FiccUuDGcds2rwlxHuGpvPxpGCw4R+DL5
         bW5Q==
X-Gm-Message-State: AOAM531W0DvjAa0g393ckFo4tsk7S69zhpHbw2GoNdiCfg1dBOc1mVq7
        MbLyuOKKl8hSMuPm6cC6c5NuAQ==
X-Google-Smtp-Source: ABdhPJxPxuDJs0pQc2Mspmx5eZueSL0XStzt2V7gXNupgl4ShTVMF5mrGl+XXouJKmBDQ3bA3Tyjug==
X-Received: by 2002:a1c:e915:0:b0:37b:d847:e127 with SMTP id q21-20020a1ce915000000b0037bd847e127mr8182389wmc.180.1647015251177;
        Fri, 11 Mar 2022 08:14:11 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70d9:405c:a1e4:4d23])
        by smtp.gmail.com with ESMTPSA id 4-20020a056000154400b00203812ca383sm6464137wry.78.2022.03.11.08.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:14:10 -0800 (PST)
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
Subject: [PATCH 0/6]  Add latency_nice priority
Date:   Fri, 11 Mar 2022 17:14:00 +0100
Message-Id: <20220311161406.23497-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset restarts the work about adding a latency nice priority to
describe the latency tolerance of cfs tasks.

The patches [1-4] have been done by Parth:
https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/

I have just rebased and moved the set of latency priority outside the
priority update. I have removed the reviewed tag because the patches
are 2 years old.

The patches [5-6] use latency nice priority to decide if a cfs task can
preempt the current running task. Patch 5 gives some tests results with
cyclictests and hackbench to highlight the benefit of latency nice
priority for short interactive task or long intensive tasks.

Parth Shah (4):
  sched: Introduce latency-nice as a per-task attribute
  sched/core: Propagate parent task's latency requirements to the child
    task
  sched: Allow sched_{get,set}attr to change latency_nice of the task
  sched/core: Add permission checks for setting the latency_nice value

Vincent Guittot (2):
  sched/fair: Take into account latency nice at wakeup
  sched/fair: Add sched group latency support

 include/linux/sched.h            |  3 +
 include/uapi/linux/sched.h       |  4 +-
 include/uapi/linux/sched/types.h | 19 +++++++
 init/init_task.c                 |  1 +
 kernel/sched/core.c              | 97 ++++++++++++++++++++++++++++++++
 kernel/sched/debug.c             |  1 +
 kernel/sched/fair.c              | 92 +++++++++++++++++++++++++++++-
 kernel/sched/sched.h             | 34 +++++++++++
 tools/include/uapi/linux/sched.h |  4 +-
 9 files changed, 251 insertions(+), 4 deletions(-)

-- 
2.17.1

