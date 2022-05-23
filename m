Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7287531999
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiEWRCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 13:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiEWRCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:02:25 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A771EBE7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:02:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id gi33so21649971ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9UEgxsvEX4LgbyJluZ4cSdgODAR2G6hLpVCtPD+a+Mg=;
        b=Ja5IoLTANaCtYJ89SAMBLetcRliBrdI1pvKcOt2FdUJj9XW4sFw6/vMcS3B3l4u6WB
         +3eS0YJtLEKcQG5RHaMNNXA+/zQARnpY4TExXozY+BLbrgALvY1Qb1P6Iw/sUDhvZKzn
         gHUctBdxRXU280p1IZToWgDQpXEu9YFW3pYHE6DZkFxOPb5G+f/IA3Qb9JBwgYeqvLA8
         BbBgRyKyOPhJPiK3zGHSGGYyBcaxN2eGceAbYL92CWAj/xeRRSMSvcayKiEORrtX3e4/
         vM6HeV5/uIADm3sg0X01DJ+xYTTrfQUG8eE4J4DJbNx6H039zEzbcnTSf0zQ+ga2rTRJ
         pCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=9UEgxsvEX4LgbyJluZ4cSdgODAR2G6hLpVCtPD+a+Mg=;
        b=k/OkJkurQm1w0Eyd3wR4SeoN+MeVddL42mty1fgVirgDadQQC2MZTQD++vxUOpKBX+
         VejNYv+Pd9INU1WS812Nxxct92BG0PPRq9WVW52iuTQqHVPLp7T9Q77TVi9UlW3cURNv
         BroSrSYchLekEu9KAsaTZBRtO2f6rC50c1TYOszhMmi1YaU3kZQkp3W/6eJAHorjBNZP
         WS2CPA4NdW3tRYdxC/EUJZQDqCI2eUzduTgF4dlWCU1NDrdhUPEIH7KKoQB4utjjSi5A
         Ifs40ETij0e6fbSWKRZz0TU+NkHG8YwPGH+2iEHvQCBgdCZne8Ju+s1y5VRJoXhymKSl
         kpuw==
X-Gm-Message-State: AOAM531L3DAuHpqe6FR3m0RkwOkICBUW+mly1InRpNEKFnYNh+kImQ9J
        pJ3kIqPW5CN+Yo7elnPx5bE=
X-Google-Smtp-Source: ABdhPJynO3q4MDuWXt1tGkG8ecgL0W8CXxcSUdslpr6UtP+LBDyya5goujZqjouxKbrvlJeuLLzR/Q==
X-Received: by 2002:a17:907:2d23:b0:6fe:8aef:b533 with SMTP id gs35-20020a1709072d2300b006fe8aefb533mr21331073ejc.650.1653325342234;
        Mon, 23 May 2022 10:02:22 -0700 (PDT)
Received: from gmail.com (84-236-113-78.pool.digikabel.hu. [84.236.113.78])
        by smtp.gmail.com with ESMTPSA id gz20-20020a170907a05400b006fea2b678basm4228963ejc.89.2022.05.23.10.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 10:02:21 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 23 May 2022 19:02:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] scheduler updates for v5.19
Message-ID: <You+G0njuvLvLll3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-05-23

   # HEAD: 991d8d8142cad94f9c5c05db25e67fa83d6f772a topology: Remove unused cpu_cluster_mask()

Scheduler changes in this cycle were:

 - Updates to scheduler metrics:

    - PELT fixes & enhancements
    - PSI fixes & enhancements
    - Refactor cpu_util_without()

 - Updates to instrumentation/debugging:

    - Remove sched_trace_*() helper functions - can be done via debug info
    - Fix double update_rq_clock() warnings

 - Introduce & use "preemption model accessors" to simplify some of
   the Kconfig complexity.

 - Make softirq handling RT-safe.

 - Misc smaller fixes & cleanups.

 Thanks,

	Ingo

------------------>
Chengming Zhou (3):
      sched/fair: Fix cfs_rq_clock_pelt() for throttled cfs_rq
      sched/fair: Delete useless condition in tg_unthrottle_up()
      sched/psi: report zeroes for CPU full at the system level

Dietmar Eggemann (4):
      sched/fair: Refactor cpu_util_without()
      sched/fair: Remove sched_trace_*() helper functions
      sched/fair: Remove cfs_rq_tg_path()
      topology: Remove unused cpu_cluster_mask()

Hailong Liu (1):
      psi: Fix trigger being fired unexpectedly at initial

Hao Jia (2):
      sched/core: Avoid obvious double update_rq_clock warning
      sched/deadline: Remove superfluous rq clock update in push_dl_task()

Peter Zijlstra (1):
      sched: Reverse sched_class layout

Sebastian Andrzej Siewior (1):
      smp: Make softirq handling RT safe in flush_smp_call_function_queue()

Tao Zhou (1):
      sched/fair: Revise comment about lb decision matrix

Thomas Gleixner (2):
      sched: Fix missing prototype warnings
      smp: Rename flush_smp_call_function_from_idle()

Valentin Schneider (5):
      preempt/dynamic: Introduce preemption model accessors
      kcsan: Use preemption model accessors
      ftrace: Use preemption model accessors for trace header printout
      MAINTAINERS: Add myself as scheduler topology reviewer
      mailmap: Update my email address to @redhat.com

zgpeng (1):
      sched/fair: Move calculate of avg_load to a better location


 .mailmap                          |   1 +
 Documentation/accounting/psi.rst  |   9 +-
 MAINTAINERS                       |   1 +
 include/asm-generic/vmlinux.lds.h |  12 +-
 include/linux/interrupt.h         |   9 ++
 include/linux/sched.h             |  57 ++++++--
 include/linux/topology.h          |   7 -
 kernel/kcsan/kcsan_test.c         |   5 +-
 kernel/sched/build_policy.c       |   2 +
 kernel/sched/build_utility.c      |   1 +
 kernel/sched/core.c               |  35 +++--
 kernel/sched/deadline.c           |  15 +-
 kernel/sched/fair.c               | 292 +++++++++-----------------------------
 kernel/sched/idle.c               |   2 +-
 kernel/sched/pelt.h               |   4 +-
 kernel/sched/psi.c                |  18 ++-
 kernel/sched/rt.c                 |   5 +-
 kernel/sched/sched.h              |  55 ++++---
 kernel/sched/smp.h                |   6 +
 kernel/smp.c                      |  32 +++--
 kernel/softirq.c                  |  13 ++
 kernel/stop_machine.c             |   2 -
 kernel/trace/trace.c              |  14 +-
 23 files changed, 266 insertions(+), 331 deletions(-)
