Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42B6586C81
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiHAOCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbiHAOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:02:18 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509ED1FCD7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:02:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id tl27so2688077ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=vvVvpZsdBf40xEdQdYY4cKcB9z//6gWP7EvRWgTvqEc=;
        b=DalDtQb4s7/Elx5TCPwLEBgV0G5jSthN8imejZLtuteRWjOeceBaLUAuEvwF0vq35j
         LqE1Uq0SZx6hIhHoNMl+b8T1xiGdNXNfMPk7mF2BNPQOg+yN+cS+DqrYBExPY7qENsri
         qNGMYoKdYAA6sEa7g0O8k4idsKHvzaRyWSY1gnWqFZt7WMasWj89G5uDhrh+fcJduMsQ
         kEn4KcgPuwWZW2hv/ztwrFLMGZsrvQbAkTaX/Ct+ES5Nc8EseFnxkx0OpzhDQL0YWQvB
         3w41iTLIF6Igh0LXrt9a0hr9HUw6K6mBbdbR1saVtBY2sX8G05ZwSQBGtq6plIEHbo+u
         fsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=vvVvpZsdBf40xEdQdYY4cKcB9z//6gWP7EvRWgTvqEc=;
        b=YbPXj2LHlxtGfu6G4vNB7QtT82bRBV7AD7n1pWZOGaaRU+More9w6SwJbTVc+Yu6op
         dH6OYwLaK9VU49CSz7zwG2YMUSJTn72624b4bS8kvUrRDlEwjmg63tcFQnvRExL2pRyn
         ADvRLSaTNMxNfn3vcZKexOY6f36MZdpIj8GIleJRdfPAEJFT/WumUg46uE1+zAJ0gQvE
         LnUv233zSEzCgoeS47p0PHv4KbB8CeCZJdEzDvxxHX4OBV8tS2hhK7y3DeTqVgmvPBob
         esBQorrZe7ossq8ST+oXKjUNoj1l/v/2jhgfzdYXuZKzEC7RRHtBlo6DIo5nLiNgJHwG
         9oig==
X-Gm-Message-State: ACgBeo0WdwFig+ySKAIFtiEXO4+KKCBajb+MnhmOAkFCeGQqwReCbBR1
        XASBUkG1FNUfQGOa+caj8yw=
X-Google-Smtp-Source: AA6agR5ocueEeozrtB76cvDlQynZ/s/VNBRi/VMZwYmDm6hDNKynPEC7K9eCJFKs42m7uch0R5VXXw==
X-Received: by 2002:a17:907:6930:b0:730:5f89:d144 with SMTP id rb48-20020a170907693000b007305f89d144mr6874716ejc.134.1659362535818;
        Mon, 01 Aug 2022 07:02:15 -0700 (PDT)
Received: from gmail.com (84-236-113-167.pool.digikabel.hu. [84.236.113.167])
        by smtp.gmail.com with ESMTPSA id i13-20020a056402054d00b0043ca6fb7e7dsm6764751edx.68.2022.08.01.07.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 07:02:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 1 Aug 2022 16:02:12 +0200
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
Subject: [GIT PULL] Scheduler updates for v6.0
Message-ID: <Yufc5Mq1aqLVV/Ov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest sched/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2022-08-01

   # HEAD: c17a6ff9321355487d7d5ccaa7d406a0ea06b6c4 rseq: Kill process when unknown flags are encountered in ABI structures

This cycle's scheduler updates for v6.0 are:

Load-balancing improvements:
============================

- Improve NUMA balancing on AMD Zen systems for affine workloads.

- Improve the handling of reduced-capacity CPUs in load-balancing.

- Energy Model improvements: fix & refine all the energy fairness metrics (PELT),
  and remove the conservative threshold requiring 6% energy savings to
  migrate a task. Doing this improves power efficiency for most workloads,
  and also increases the reliability of energy-efficiency scheduling.

- Optimize/tweak select_idle_cpu() to spend (much) less time searching
  for an idle CPU on overloaded systems. There's reports of several
  milliseconds spent there on large systems with large workloads ...

  [ Since the search logic changed, there might be behavioral side effects. ]

- Improve NUMA imbalance behavior. On certain systems
  with spare capacity, initial placement of tasks is non-deterministic,
  and such an artificial placement imbalance can persist for a long time,
  hurting (and sometimes helping) performance.

  The fix is to make fork-time task placement consistent with runtime
  NUMA balancing placement.

  Note that some performance regressions were reported against this,
  caused by workloads that are not memory bandwith limited, which benefit
  from the artificial locality of the placement bug(s). Mel Gorman's
  conclusion, with which we concur, was that consistency is better than
  random workload benefits from non-deterministic bugs:

     "Given there is no crystal ball and it's a tradeoff, I think it's
      better to be consistent and use similar logic at both fork time
      and runtime even if it doesn't have universal benefit."

- Improve core scheduling by fixing a bug in sched_core_update_cookie() that
  caused unnecessary forced idling.

- Improve wakeup-balancing by allowing same-LLC wakeup of idle CPUs for newly
  woken tasks.

- Fix a newidle balancing bug that introduced unnecessary wakeup latencies.

ABI improvements/fixes:
=======================

- Do not check capabilities and do not issue capability check denial messages
  when a scheduler syscall doesn't require privileges. (Such as increasing niceness.)

- Add forced-idle accounting to cgroups too.

- Fix/improve the RSEQ ABI to not just silently accept unknown flags.
  (No existing tooling is known to have learned to rely on the previous behavior.)

- Depreciate the (unused) RSEQ_CS_FLAG_NO_RESTART_ON_* flags.

Optimizations:
==============

- Optimize & simplify leaf_cfs_rq_list()

- Micro-optimize set_nr_{and_not,if}_polling() via try_cmpxchg().

Misc fixes & cleanups:
======================

- Fix the RSEQ self-tests on RISC-V and Glibc 2.35 systems.

- Fix a full-NOHZ bug that can in some cases result in the tick not being
  re-enabled when the last SCHED_RT task is gone from a runqueue but there's
  still SCHED_OTHER tasks around.

- Various PREEMPT_RT related fixes.

- Misc cleanups & smaller fixes.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Chen Yu (1):
      sched/fair: Introduce SIS_UTIL to search idle CPU based on sum of util_avg

Chengming Zhou (1):
      sched/fair: Optimize and simplify rq leaf_cfs_rq_list

Christian Göttsche (1):
      sched: only perform capability check on privileged operation

Cruz Zhao (1):
      sched/core: Fix the bug that task won't enqueue into core tree when update cookie

Dietmar Eggemann (3):
      sched, drivers: Remove max param from effective_cpu_util()/sched_cpu_util()
      sched/fair: Rename select_idle_mask to select_rq_mask
      sched/fair: Use the same cpumask per-PD throughout find_energy_efficient_cpu()

John Keeping (1):
      sched/core: Always flush pending blk_plug

Josh Don (2):
      sched: Allow newidle balancing to bail out of load_balance
      sched/core: add forced idle accounting for cgroups

K Prateek Nayak (1):
      sched/fair: Consider CPU affinity when allowing NUMA imbalance in find_idlest_group()

Mathieu Desnoyers (2):
      rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_* flags
      rseq: Kill process when unknown flags are encountered in ABI structures

Mel Gorman (4):
      sched/numa: Initialise numa_migrate_retry
      sched/numa: Do not swap tasks between nodes when spare capacity is available
      sched/numa: Apply imbalance limitations consistently
      sched/numa: Adjust imb_numa_nr to a better approximation of memory channels

Michael Jeanson (3):
      selftests/rseq: riscv: use rseq_get_abi() helper
      selftests/rseq: riscv: fix 'literal-suffix' warning
      selftests/rseq: check if libc rseq support is registered

Nicolas Saenz Julienne (1):
      nohz/full, sched/rt: Fix missed tick-reenabling bug in dequeue_task_rt()

Tianchen Ding (2):
      sched: Fix the check of nr_running at queue wakelist
      sched: Remove the limitation of WF_ON_CPU on wakelist if wakee cpu is idle

Uros Bizjak (1):
      sched/core: Use try_cmpxchg in set_nr_{and_not,if}_polling

Vincent Donnefort (4):
      sched/fair: Provide u64 read for 32-bits arch helper
      sched/fair: Decay task PELT values during wakeup migration
      sched/fair: Remove task_util from effective utilization in feec()
      sched/fair: Remove the energy margin in feec()

Vincent Guittot (1):
      sched/fair: fix case with reduced capacity CPU

Yajun Deng (1):
      sched/deadline: Use proc_douintvec_minmax() limit minimum value

Zhang Qiao (2):
      sched/fair: Remove redundant word " *"
      sched: Remove unused function group_first_cpu()


 drivers/powercap/dtpm_cpu.c               |  33 +-
 drivers/thermal/cpufreq_cooling.c         |   6 +-
 include/linux/cgroup-defs.h               |   4 +
 include/linux/kernel_stat.h               |   7 +
 include/linux/sched.h                     |   2 +-
 include/linux/sched/rt.h                  |   8 -
 include/linux/sched/topology.h            |   1 +
 kernel/cgroup/rstat.c                     |  44 +-
 kernel/rseq.c                             |  23 +-
 kernel/sched/core.c                       | 215 ++++----
 kernel/sched/core_sched.c                 |  15 +-
 kernel/sched/cpufreq_schedutil.c          |   5 +-
 kernel/sched/cputime.c                    |  15 +
 kernel/sched/deadline.c                   |   6 +-
 kernel/sched/fair.c                       | 818 +++++++++++++++++++-----------
 kernel/sched/features.h                   |   3 +-
 kernel/sched/pelt.h                       |  40 +-
 kernel/sched/rt.c                         |  15 +-
 kernel/sched/sched.h                      |  63 ++-
 kernel/sched/topology.c                   |  23 +-
 tools/testing/selftests/rseq/rseq-riscv.h |  50 +-
 tools/testing/selftests/rseq/rseq.c       |   3 +-
 22 files changed, 888 insertions(+), 511 deletions(-)
