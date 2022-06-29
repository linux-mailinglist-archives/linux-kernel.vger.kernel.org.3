Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB72255FFC5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiF2MVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiF2MVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:21:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE87830F53
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:21:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF6B7152B;
        Wed, 29 Jun 2022 05:21:20 -0700 (PDT)
Received: from e125579.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E94AB3F66F;
        Wed, 29 Jun 2022 05:21:18 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] DL capacity-aware fixes 
Date:   Wed, 29 Jun 2022 14:20:50 +0200
Message-Id: <20220629122053.287165-1-dietmar.eggemann@arm.com>
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

While testing cpusets on asymmetric CPU capacity systems I realized that
the admission control, which kicks in when the cpumask of a cpuset is
about to be changed, is not capacity-aware. [PATCH 2/3] addresses this
issue.

Overview:

[PATCH 1/3] - Not part of the DL related changes but here for
              convenience : Inline helper function around
              static_branch_unlikely(&sched_asym_cpucapacity)

[PATCH 2/3] - Make dl_cpuset_cpumask_can_shrink() capacity-aware.

[PATCH 3/3] - Save a multiplication in dl_task_fits_capacity() by using
	      already maintained dl_density.

Dietmar Eggemann (3):
  sched: Introduce sched_asym_cpucap_active()
  sched/deadline: Make dl_cpuset_cpumask_can_shrink() capacity-aware
  sched/deadline: Use sched_dl_entity's dl_density in
    dl_task_fits_capacity()

 kernel/sched/cpudeadline.c |  2 +-
 kernel/sched/deadline.c    | 28 +++++++++++++---------------
 kernel/sched/fair.c        |  8 ++++----
 kernel/sched/rt.c          |  4 ++--
 kernel/sched/sched.h       | 13 +++++++++----
 5 files changed, 29 insertions(+), 26 deletions(-)

-- 
2.25.1

