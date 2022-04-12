Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC0E4FE2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356097AbiDLNoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355549AbiDLNot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:44:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6CEE4ECD7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:42:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A661F150C;
        Tue, 12 Apr 2022 06:42:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.94.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D3453F70D;
        Tue, 12 Apr 2022 06:42:30 -0700 (PDT)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH v3 0/7] feec() energy margin removal
Date:   Tue, 12 Apr 2022 14:42:13 +0100
Message-Id: <20220412134220.1588482-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_energy_efficient() (feec()) will migrate a task to save energy only
if it saves at least 6% of the total energy consumed by the system. This
conservative approach is a problem on a system where a lot of small tasks
create a huge load on the overall: very few of them will be allowed to migrate
to a smaller CPU, wasting a lot of energy. Instead of trying to determine yet
another margin, let's try to remove it.

The first elements of this patch-set are various fixes and improvement that
stabilizes task_util and ensures energy comparison fairness across all CPUs of
the topology. Only once those fixed, we can completely remove the margin and
let feec() aggressively place task and save energy.

This has been validated by two different ways:

First using LISA's eas_behaviour test suite. This is composed of a set of
scenario and verify if the task placement is optimum. No failure have been
observed and it also improved some tests such as Ramp-Down (as the placement
is now more energy oriented) and *ThreeSmall (as no bouncing between clusters
happen anymore).

  * Hikey960: 100% PASSED
  * DB-845C:  100% PASSED
  * RB5:      100% PASSED

Second, using an Android benchmark: PCMark2 on a Pixel4, with a lot of
backports to have a scheduler as close as we can from mainline. 

  +------------+-----------------+-----------------+
  |    Test    |      Perf       |    Energy [1]   |
  +------------+-----------------+-----------------+
  | Web2       | -0.3% pval 0.03 | -1.8% pval 0.00 |
  | Video2     | -0.3% pval 0.13 | -5.6% pval 0.00 |
  | Photo2 [2] | -3.8% pval 0.00 | -1%   pval 0.00 |
  | Writing2   |  0%   pval 0.13 | -1%   pval 0.00 |
  | Data2      |  0%   pval 0.8  | -0.43 pval 0.00 |
  +------------+-----------------+-----------------+ 

The margin removal let the kernel make the best use of the Energy Model,
tasks are more likely to be placed where they fit and this saves a 
substantial amount of energy, while having a limited impact on performances.

[1] This is an energy estimation based on the CPU activity and the Energy Model
for this device. "All models are wrong but some are useful"; yes, this is an
imperfect estimation that doesn't take into account some idle states and shared
power rails. Nonetheless this is based on the information the kernel has during
runtime and it proves the scheduler can take better decisions based solely on
those data.

[2] This is the only performance impact observed. The debugging of this test
showed no issue with task placement. The better score was solely due to some
critical threads held on better performing CPUs. If a thread needs a higher
capacity CPU, the placement must result from a user input (with e.g. uclamp
min) instead of being artificially held on less efficient CPUs by feec().
Notice also, the experiment didn't use the Android only latency_sensitive
feature which would hide this problem on a real-life device.

v3 -> v4:
  - Minor cosmetic changes (Dietmar)

v2 -> v3:
  - feec(): introduce energy_env struct (Dietmar)
  - PELT migration decay: Only apply when src CPU is idle (Vincent G.)
  - PELT migration decay: Do not apply when cfs_rq is throttled
  - PELT migration decay: Snapshot the lag at cfs_rq's level

v1 -> v2:
  - Fix PELT migration last_update_time (previously root cfs_rq's).
  - Add Dietmar's patches to refactor feec()'s CPU loop.
  - feec(): renaming busy time functions get_{pd,tsk}_busy_time()
  - feec(): pd_cap computation in the first for_each_cpu loop.
  - feec(): create get_pd_max_util() function (previously within compute_energy())
  - feec(): rename base_energy_pd to base_energy.

Dietmar Eggemann (3):
  sched, drivers: Remove max param from
    effective_cpu_util()/sched_cpu_util()
  sched/fair: Rename select_idle_mask to select_rq_mask
  sched/fair: Use the same cpumask per-PD throughout
    find_energy_efficient_cpu()

Vincent Donnefort (4):
  sched/fair: Provide u64 read for 32-bits arch helper
  sched/fair: Decay task PELT values during wakeup migration
  sched/fair: Remove task_util from effective utilization in feec()
  sched/fair: Remove the energy margin in feec()

 drivers/powercap/dtpm_cpu.c       |  33 +--
 drivers/thermal/cpufreq_cooling.c |   6 +-
 include/linux/sched.h             |   2 +-
 kernel/sched/core.c               |  15 +-
 kernel/sched/cpufreq_schedutil.c  |   5 +-
 kernel/sched/fair.c               | 385 ++++++++++++++++++------------
 kernel/sched/sched.h              |  49 +++-
 7 files changed, 298 insertions(+), 197 deletions(-)

-- 
2.25.1

