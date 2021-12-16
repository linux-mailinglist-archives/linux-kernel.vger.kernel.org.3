Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219EE47802E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 23:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhLPWxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 17:53:41 -0500
Received: from foss.arm.com ([217.140.110.172]:49486 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhLPWxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:53:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CB3612FC;
        Thu, 16 Dec 2021 14:53:40 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01B9A3F73B;
        Thu, 16 Dec 2021 14:53:38 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Beata Michalska <Beata.Michalska@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 0/2] uclamp_max vs schedutil fixes
Date:   Thu, 16 Dec 2021 22:53:18 +0000
Message-Id: <20211216225320.2957053-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems that use sugov_update_single_{freq, perf}(), uclamp_max was
ineffective because of 'busy' filter which ignores requests to change frequency
if there's no idle time. A condition that is not true if uclamp is being used
on this system.

Similarly, io heavy tasks that are capped by uclamp_max can still obtain higher
frequencies because sugov_iowait_apply() doesn't clamp the boost with
uclamp_rq_util_with().

Patches 1 and 2 address these 2 problems.

Thanks!

--
Qais Yousef

Qais Yousef (2):
  sched/sugov: Ignore 'busy' filter when uclamp_is_used()
  sched/uclamp: Fix iowait boost escaping uclamp restriction

 kernel/sched/cpufreq_schedutil.c |  11 ++-
 kernel/sched/sched.h             | 139 +++++++++++++++++--------------
 2 files changed, 87 insertions(+), 63 deletions(-)

-- 
2.25.1

