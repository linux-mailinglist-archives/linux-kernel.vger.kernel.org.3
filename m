Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904285A42BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiH2F4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiH2Fz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:55:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7EBD23162
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 22:55:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E42723A;
        Sun, 28 Aug 2022 22:55:23 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB97C3F766;
        Sun, 28 Aug 2022 22:55:43 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>
Cc:     Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Date:   Mon, 29 Aug 2022 07:54:49 +0200
Message-Id: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the Android devices still prefer to run PELT with a shorter
halflife than the hardcoded value of 32ms in mainline.

The Android folks claim better response time of display pipeline tasks
(higher min and avg fps for 60, 90 or 120Hz refresh rate). Some of the
benchmarks like PCmark web-browsing show higher scores when running
with 16ms or 8ms PELT halflife. The gain in response time and
performance is considered to outweigh the increase of energy
consumption in these cases.

The original idea of introducing a PELT halflife compile time option
for 32, 16, 8ms from Patrick Bellasi in 2018
https://lkml.kernel.org/r/20180409165134.707-1-patrick.bellasi@arm.com
wasn't integrated into mainline mainly because of breaking the PELT
stability requirement (see (1) below).

We have been experimenting with a new idea from Morten Rasmussen to
instead introduce an additional clock between task and pelt clock. This
way the effect of a shorter PELT halflife of 8ms or 16ms can be
achieved by left-shifting the elapsed time. This is similar to the use
of time shifting of the pelt clock to achieve scale invariance in PELT.
The implementation is from Vincent Donnefort with some minor
modifications to align with current tip sched/core.

---

Known potential issues:

(1) PELT stability requirement

PELT halflife has to be larger than or equal to the scheduling period.

The sched_period (sysctl_sched_latency) of a typical mobile device with
8 CPUs with the default logarithmical tuning is 24ms so only the 32 ms
PELT halflife met this. Shorter halflife of 16ms or even 8ms would break
this.

It looks like that this problem might not exist anymore because of the
PELT rewrite in 2015, i.e. with commit 9d89c257dfb9
("sched/fair: Rewrite runnable load and utilization average tracking").
Since then sched entities (task & task groups) and cfs_rq's are
independently maintained rather than each entity update maintains the
cfs_rq at the same time.

This seems to mitigate the issue that the cfs_rq signal is not correct
when there are not all runnable entities able ot do a self update during
a PELT halflife window.

That said, I'm not entirely sure whether the entity-cfs_rq
synchronization is the only issue behind this PELT stability requirement.


(2) PELT utilization versus util_est (estimated utilization)

The PELT signal of a periodic task oscillates with higher peak amplitude
when using smaller halflife. For a typical periodic task of the display
pipeline with a runtime/period of 8ms/16ms the peak amplitude is at ~40
for 32ms, at ~80 for 16ms and at ~160 for 8ms. Util_est stores the
util_avg peak as util_est.enqueued per task.

With an additional exponential weighted moving average (ewma) to smooth
task utilization decreases, util_est values of the runnable tasks are
aggregated on the root cfs_rq.
CPU and task utilization for CPU frequency selection and task placement
is the max value out of util_est and util_avg. 
I.e. because of how util_est is implemented higher CPU Operating
Performance Points and more capable CPUs are already chosen when using
smaller PELT halflife.


(3) Wrong PELT history when switching PELT multiplier

The PELT history becomes stale the moment the PELT multiplier is changed
during runtime. So all decisions based on PELT are skewed for the time
interval to produce LOAD_MAX_AVG (the sum of the infinite geometric
series) which value is ~345ms for halflife=32ms (smaller for 8ms or
16ms).

Rate limiting the PELT multiplier change to this value is not solving
the issue here. So the user would have to live with possible incorrect
discussions during these PELT multiplier transition times.

---

It looks like that individual task boosting e.g. via uclamp_min,
possibly abstracted by middleware frameworks like Android Dynamic
Performance Framework (ADPF) would be the way to go here but until this
is fully available and adopted some Android folks will still prefer the
overall system boosting they achieve by running with a shorter PELT
halflife.

Vincent Donnefort (1):
  sched/pelt: Introduce PELT multiplier

 kernel/sched/core.c  |  2 +-
 kernel/sched/pelt.c  | 60 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/pelt.h  | 42 ++++++++++++++++++++++++++++---
 kernel/sched/sched.h |  1 +
 4 files changed, 100 insertions(+), 5 deletions(-)

-- 
2.25.1

