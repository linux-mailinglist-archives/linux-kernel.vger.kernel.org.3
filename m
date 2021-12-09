Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED78946ECDB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhLIQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:16:06 -0500
Received: from foss.arm.com ([217.140.110.172]:58688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhLIQQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:16:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CFB7ED1;
        Thu,  9 Dec 2021 08:12:29 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.83.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B147E3F5A1;
        Thu,  9 Dec 2021 08:12:27 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, lukasz.luba@arm.com,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 0/4] feec() energy margin removal
Date:   Thu,  9 Dec 2021 16:11:55 +0000
Message-Id: <20211209161159.1596018-1-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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


Vincent Donnefort (4):
  sched/fair: Provide u64 read for 32-bits arch helper
  sched/fair: Decay task PELT values during migration
  sched/fair: Remove task_util from effective utilization in feec()
  sched/fair: Remove the energy margin in feec()

 kernel/sched/core.c  |   7 ++
 kernel/sched/fair.c  | 263 ++++++++++++++++++++++---------------------
 kernel/sched/sched.h |  46 +++++++-
 3 files changed, 189 insertions(+), 127 deletions(-)

-- 
2.25.1
 
