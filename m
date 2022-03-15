Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758BD4D968F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346076AbiCOIpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346089AbiCOIo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:44:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8552665
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id p9so27767404wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PT6oP8Jxq/AnQKQrGym6FIRcV/x2SroiEfI6dmW78oU=;
        b=kZTtYTq13n91G600kgSsv3nvkimRqSxLmYPmUwDwuFUzoG656P+ToP2+CdHvE0tYdL
         oHyUFRhEkm918IAdWMgwx0D7CiN+2/Kd0j0eau7VeC3D46q7I3Xjybjvo2BU7yHKu0Kb
         T39MrWvm9J05ll1Ma+T+UhyWORStQpFj18XMGXZoCm77EVn4e+Um6bTblcLriK4GUWkc
         E0hHoFUYpE7ziI/e8lgBKIYKGPjYL4xEjaq86lqRmMTVAwLrewpX0V0AszmDb3ZJEpJ1
         UI7Sc4g24kQUdbiDqCgTXp/N7K9fKxv69eovZVDKk1ekdV10UwI+bRPYqLoLsIlJcr3+
         Tauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PT6oP8Jxq/AnQKQrGym6FIRcV/x2SroiEfI6dmW78oU=;
        b=V/FP6RfbJa1kd0kWv//V6PteJmVv4jJTjguncsLRrc9C49L88qCKYo3S9NMj46yy57
         M1K+mgCjdnjoiqfpt8T5pg/FI+TevoYToTSXGOltz++NXPtXgel/a0pUgegxfU+zmBPt
         dclNIf9muZO3qH1TeqUXX+L47cHHJbjqZhKrGXOXutXPrSaza9/fEJwrnLWbrD5NsgoA
         8WWKGUXGlTafjbxjAzODVKOWGIQCJ+ZXXR8exAnQh5hzPlEcbjp2l5WXh9O9BCvVc5Kp
         faEesXoy/nte4gQwrygrb20V83t+PtKLLT130kTP71nxAzuklEPIbMtHHd/0692ShI1K
         JB8w==
X-Gm-Message-State: AOAM531ajdX/FpICSr09S+hZrqfeMd5Sl9lAeDJVwTV+FS0khOUtzZtw
        AyWj5kwmxFklTSyD/Exw6VGofxYrvZw=
X-Google-Smtp-Source: ABdhPJy69whst2eBve1qaFC7O/uiNStT6gJPWBejAclg4dgwQHBHQrv+Sis3zs6rWSg1PC/f7fCTbA==
X-Received: by 2002:a5d:6c67:0:b0:203:bf25:f311 with SMTP id r7-20020a5d6c67000000b00203bf25f311mr5452015wrz.108.1647333822098;
        Tue, 15 Mar 2022 01:43:42 -0700 (PDT)
Received: from kepler.. (0526F1FC.dsl.pool.telekom.hu. [5.38.241.252])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b0020374784350sm15078503wrt.64.2022.03.15.01.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 01:43:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 00/15] sched/headers: Optimize scheduler build time
Date:   Tue, 15 Mar 2022 09:42:32 +0100
Message-Id: <20220315084247.40783-1-mingo@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Optimize the kernel scheduler build time by organizing the code into
larger build units. This cuts CPU usage by 60%.

These patches originate from the fast-headers tree.

The numbers:

Cumulative scheduler (kernel/sched/) build time speedup on a
Linux distribution's config, which enables all scheduler features,
compared to the vanilla kernel:

      _____________________________________________________________________________
     |
     |  Vanilla kernel (v5.13-rc7):
     |_____________________________________________________________________________
     |
     |  Performance counter stats for 'make -j96 kernel/sched/' (3 runs):
     |
     |   126,975,564,374      instructions              #    1.45  insn per cycle           ( +-  0.00% )
     |    87,637,847,671      cycles                    #    3.959 GHz                      ( +-  0.30% )
     |         22,136.96 msec cpu-clock                 #    7.499 CPUs utilized            ( +-  0.29% )
     |
     |            2.9520 +- 0.0169 seconds time elapsed  ( +-  0.57% )
     |_____________________________________________________________________________
     |
     |  Patched kernel:
     |_____________________________________________________________________________
     |
     | Performance counter stats for 'make -j96 kernel/sched/' (3 runs):
     |
     |    50,420,496,914      instructions              #    1.47  insn per cycle           ( +-  0.00% )
     |    34,234,322,038      cycles                    #    3.946 GHz                      ( +-  0.31% )
     |          8,675.81 msec cpu-clock                 #    3.053 CPUs utilized            ( +-  0.45% )
     |
     |            2.8420 +- 0.0181 seconds time elapsed  ( +-  0.64% )
     |_____________________________________________________________________________

    Summary:

      - CPU time used to build the scheduler dropped by -60.9%, a reduction
        from 22.1 clock-seconds to 8.7 clock-seconds.

      - Wall-clock time to build the scheduler dropped by -3.9%, a reduction
        from 2.95 seconds to 2.84 seconds.

Ingo Molnar (15):
  sched/headers: Fix header to build standalone: <linux/sched_clock.h>
  sched/headers: Add header guard to kernel/sched/sched.h
  sched/headers: Add header guard to kernel/sched/stats.h and kernel/sched/autogroup.h
  sched/headers: sched/clock: Mark all functions 'notrace', remove CC_FLAGS_FTRACE build asymmetry
  sched/headers: Add initial new headers as identity mappings
  sched/headers: Fix comment typo in kernel/sched/cpudeadline.c
  sched/headers: Make the <linux/sched/deadline.h> header build standalone
  sched/headers: Introduce kernel/sched/build_utility.c and build multiple .c files there
  sched/headers: Introduce kernel/sched/build_policy.c and build multiple .c files there
  sched/headers: Standardize kernel/sched/sched.h header dependencies
  sched/headers: Reorganize, clean up and optimize kernel/sched/core.c dependencies
  sched/headers: Reorganize, clean up and optimize kernel/sched/fair.c dependencies
  sched/headers: Reorganize, clean up and optimize kernel/sched/build_policy.c dependencies
  sched/headers: Reorganize, clean up and optimize kernel/sched/build_utility.c dependencies
  sched/headers: Reorganize, clean up and optimize kernel/sched/sched.h dependencies

 arch/arm64/include/asm/paravirt_api_clock.h |   1 +
 arch/x86/include/asm/paravirt_api_clock.h   |   1 +
 include/linux/cgroup_api.h                  |   1 +
 include/linux/cpumask_api.h                 |   1 +
 include/linux/fs_api.h                      |   1 +
 include/linux/gfp_api.h                     |   1 +
 include/linux/hashtable_api.h               |   1 +
 include/linux/hrtimer_api.h                 |   1 +
 include/linux/kobject_api.h                 |   1 +
 include/linux/kref_api.h                    |   1 +
 include/linux/ktime_api.h                   |   1 +
 include/linux/llist_api.h                   |   1 +
 include/linux/lockdep_api.h                 |   1 +
 include/linux/mm_api.h                      |   1 +
 include/linux/mutex_api.h                   |   1 +
 include/linux/perf_event_api.h              |   1 +
 include/linux/pgtable_api.h                 |   1 +
 include/linux/ptrace_api.h                  |   1 +
 include/linux/rcuwait_api.h                 |   1 +
 include/linux/refcount_api.h                |   1 +
 include/linux/sched/affinity.h              |   1 +
 include/linux/sched/cond_resched.h          |   1 +
 include/linux/sched/deadline.h              |   2 +
 include/linux/sched/posix-timers.h          |   1 +
 include/linux/sched/rseq_api.h              |   1 +
 include/linux/sched/task_flags.h            |   1 +
 include/linux/sched/thread_info_api.h       |   1 +
 include/linux/sched_clock.h                 |   2 +
 include/linux/seqlock_api.h                 |   1 +
 include/linux/softirq.h                     |   1 +
 include/linux/spinlock_api.h                |   1 +
 include/linux/swait_api.h                   |   1 +
 include/linux/syscalls_api.h                |   1 +
 include/linux/u64_stats_sync_api.h          |   1 +
 include/linux/wait_api.h                    |   1 +
 include/linux/workqueue_api.h               |   1 +
 kernel/sched/Makefile                       |  28 +++++-------
 kernel/sched/autogroup.c                    |   3 +-
 kernel/sched/autogroup.h                    |   5 +++
 kernel/sched/build_policy.c                 |  52 ++++++++++++++++++++++
 kernel/sched/build_utility.c                | 109 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/clock.c                        |  44 +++++++++----------
 kernel/sched/completion.c                   |   2 +-
 kernel/sched/core.c                         |  81 +++++++++++++++++++++++++++++-----
 kernel/sched/core_sched.c                   |   3 --
 kernel/sched/cpuacct.c                      |   3 +-
 kernel/sched/cpudeadline.c                  |   3 +-
 kernel/sched/cpufreq.c                      |   3 --
 kernel/sched/cpufreq_schedutil.c            |   7 ---
 kernel/sched/cpupri.c                       |   1 -
 kernel/sched/cputime.c                      |   1 -
 kernel/sched/deadline.c                     |   2 -
 kernel/sched/debug.c                        |   1 -
 kernel/sched/fair.c                         |  31 +++++++++++++
 kernel/sched/idle.c                         |   3 --
 kernel/sched/isolation.c                    |   1 -
 kernel/sched/loadavg.c                      |   1 -
 kernel/sched/membarrier.c                   |   1 -
 kernel/sched/pelt.c                         |   4 --
 kernel/sched/psi.c                          |  15 -------
 kernel/sched/rt.c                           |   3 --
 kernel/sched/sched.h                        | 114 ++++++++++++++++++++++++++----------------------
 kernel/sched/stats.c                        |   1 -
 kernel/sched/stats.h                        |   4 ++
 kernel/sched/stop_task.c                    |   1 -
 kernel/sched/swait.c                        |   1 -
 kernel/sched/topology.c                     |   1 -
 kernel/sched/wait.c                         |   1 -
 kernel/sched/wait_bit.c                     |   2 +-
 69 files changed, 407 insertions(+), 163 deletions(-)
 create mode 100644 arch/arm64/include/asm/paravirt_api_clock.h
 create mode 100644 arch/x86/include/asm/paravirt_api_clock.h
 create mode 100644 include/linux/cgroup_api.h
 create mode 100644 include/linux/cpumask_api.h
 create mode 100644 include/linux/fs_api.h
 create mode 100644 include/linux/gfp_api.h
 create mode 100644 include/linux/hashtable_api.h
 create mode 100644 include/linux/hrtimer_api.h
 create mode 100644 include/linux/kobject_api.h
 create mode 100644 include/linux/kref_api.h
 create mode 100644 include/linux/ktime_api.h
 create mode 100644 include/linux/llist_api.h
 create mode 100644 include/linux/lockdep_api.h
 create mode 100644 include/linux/mm_api.h
 create mode 100644 include/linux/mutex_api.h
 create mode 100644 include/linux/perf_event_api.h
 create mode 100644 include/linux/pgtable_api.h
 create mode 100644 include/linux/ptrace_api.h
 create mode 100644 include/linux/rcuwait_api.h
 create mode 100644 include/linux/refcount_api.h
 create mode 100644 include/linux/sched/affinity.h
 create mode 100644 include/linux/sched/cond_resched.h
 create mode 100644 include/linux/sched/posix-timers.h
 create mode 100644 include/linux/sched/rseq_api.h
 create mode 100644 include/linux/sched/task_flags.h
 create mode 100644 include/linux/sched/thread_info_api.h
 create mode 100644 include/linux/seqlock_api.h
 create mode 100644 include/linux/softirq.h
 create mode 100644 include/linux/spinlock_api.h
 create mode 100644 include/linux/swait_api.h
 create mode 100644 include/linux/syscalls_api.h
 create mode 100644 include/linux/u64_stats_sync_api.h
 create mode 100644 include/linux/wait_api.h
 create mode 100644 include/linux/workqueue_api.h
 create mode 100644 kernel/sched/build_policy.c
 create mode 100644 kernel/sched/build_utility.c

-- 
2.32.0

