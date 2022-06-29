Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE78A560AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiF2Tr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiF2Trz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:47:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CAD33A1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:47:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C7241480;
        Wed, 29 Jun 2022 12:47:54 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.197.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C830F3F792;
        Wed, 29 Jun 2022 12:47:52 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 0/7] Fix relationship between uclamp and fits_capacity()
Date:   Wed, 29 Jun 2022 20:46:25 +0100
Message-Id: <20220629194632.1117723-1-qais.yousef@arm.com>
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

Qais Yousef (7):
  sched/uclamp: Fix relationship between uclamp and migration margin
  sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
  sched/uclamp: Fix fits_capacity() check in feec()
  sched/uclamp: Make select_idle_capacity() use util_fits_cpu()
  sched/uclamp: Make asym_fits_capacity() use util_fits_cpu()
  sched/uclamp: Make cpu_overutilized() use util_fits_cpu()
  sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early
    exit condition

 kernel/sched/core.c     |  10 +-
 kernel/sched/fair.c     | 256 +++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h    |  53 ++++++++-
 kernel/sched/topology.c |  18 +--
 4 files changed, 275 insertions(+), 62 deletions(-)


base-commit: 70fb5ccf2ebb09a0c8ebba775041567812d45f86
-- 
2.25.1

