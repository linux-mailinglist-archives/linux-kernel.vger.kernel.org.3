Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DF647A8E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhLTLnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:43:42 -0500
Received: from foss.arm.com ([217.140.110.172]:52892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhLTLnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:43:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32A6511FB;
        Mon, 20 Dec 2021 03:43:41 -0800 (PST)
Received: from localhost.localdomain (unknown [10.57.37.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D69E33F718;
        Mon, 20 Dec 2021 03:43:39 -0800 (PST)
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 1/3] sched/fair: Make cpu_overutilized() EAS dependent
Date:   Mon, 20 Dec 2021 12:43:21 +0100
Message-Id: <20211220114323.22811-2-vincent.donnefort@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211220114323.22811-1-vincent.donnefort@arm.com>
References: <20211220114323.22811-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a system with Energy Aware Scheduling (EAS), tasks are placed according
to their energy consumption estimation and load balancing is disabled to
not break that energy biased placement. If the system becomes
overutilized, i.e. one of the CPU has too much utilization, energy
placement would then be disabled, in favor of Capacity-Aware Scheduling
(CAS), including load balancing. This is the sole usage for
rd->overutilized. Hence, there is no need to raise it for !EAS systems.

Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point indicator")
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 095b0aa378df..e2f6fa14e5e7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5511,7 +5511,8 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
-	return !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
+	return sched_energy_enabled() &&
+	       !fits_capacity(cpu_util_cfs(cpu), capacity_of(cpu));
 }
 
 static inline void update_overutilized_status(struct rq *rq)
-- 
2.25.1

