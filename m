Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45FD589D92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbiHDOgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbiHDOge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:36:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F88831903
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:36:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB20211FB;
        Thu,  4 Aug 2022 07:36:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.10.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A5983F73B;
        Thu,  4 Aug 2022 07:36:31 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 0/9] Fix relationship between uclamp and fits_capacity()
Date:   Thu,  4 Aug 2022 15:36:00 +0100
Message-Id: <20220804143609.515789-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relationship between uclamp and fits_capacity() is currently broken. Mostly due
to how uclamp should interact with migration margin and capacity pressure. But
also due not all users were converted to consider uclamp before calling
fits_capacity(). Namely cpu_overutilized().

The meat of the series is patch 1 where we introduce a new function,
util_fits_cpu(), that takes uclamp into account. The new function should
replace all call sits to fits_capacity(), which what subsequent patches do.
Except for patch 7 where we fix handling of early exit condition in
find_energy_efficient_cpu(AKA feec()) that must be uclamp aware too.

util_fits_cpu() will revert back to a simple call to fits_capacity() if uclamp
is not being used on the system.

Last two patches still need testing and verification, but they address the
various thermal handling issues raised in v1. We can re-order the patches, but
added at the end to facilitate review at this stage. Hope the approach and the
logic make sense.

I'll be on holidays, so if I don't respond to review comments fast enough,
apologies in advance.

Changes in v2:

	* use uclamp_rq_is_idle() in uclamp_rq_util_with() (Xuewen)

	* Simplify logic in update_sg_wakeup_stats() when converting
	  task_fits_cpu() (Vincent)

	* Better handling of thermal pressure (Vincent)

	  - We consider thermal pressure for uclamp_min in patch 1
	  - 2 new patches to handle capacity inversion which improves handling
	    when:

		+ There're multiple big cpus on separate perf domains.
		+ A task is boosted by uclamp_min and inspite of thermal
		  pressure, the big cpu is still the best placement.

		  e.g: p0->util_avg = 300, p0->uclamp_min = 1024

		  This task should stay on big CPU until thermal pressure is in
		  capacity inversion.

	v1 discussion: https://lore.kernel.org/lkml/20220629194632.1117723-1-qais.yousef@arm.com/

	Thanks for all reviewers on v1!


Qais Yousef (9):
  sched/uclamp: Fix relationship between uclamp and migration margin
  sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
  sched/uclamp: Fix fits_capacity() check in feec()
  sched/uclamp: Make select_idle_capacity() use util_fits_cpu()
  sched/uclamp: Make asym_fits_capacity() use util_fits_cpu()
  sched/uclamp: Make cpu_overutilized() use util_fits_cpu()
  sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early
    exit condition
  sched/fair: Detect capacity inversion
  sched/fair: Consider capacity inversion in util_fits_cpu()

 kernel/sched/core.c  |  10 +-
 kernel/sched/fair.c  | 290 ++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h |  70 ++++++++++-
 3 files changed, 329 insertions(+), 41 deletions(-)

-- 
2.25.1

