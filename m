Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C5A4908F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiAQMpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:45:32 -0500
Received: from foss.arm.com ([217.140.110.172]:57844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240031AbiAQMp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:45:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B918C6D;
        Mon, 17 Jan 2022 04:45:28 -0800 (PST)
Received: from e127744.arm.com (unknown [10.57.36.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 78EA63F73D;
        Mon, 17 Jan 2022 04:45:27 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, james.clark@arm.com,
        leo.yan@linaro.org
Cc:     German Gomez <german.gomez@arm.com>
Subject: [RFC PATCH 2/2] perf: arm_spe: Enable CONTEXT packets in SPE traces if the profiler runs in CPU mode.
Date:   Mon, 17 Jan 2022 12:44:32 +0000
Message-Id: <20220117124432.3119132-3-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117124432.3119132-1-german.gomez@arm.com>
References: <20220117124432.3119132-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONTEXT packets in SPE traces if the profiler runs in CPU mode.
This is no less permissive than the existing behavior for the following
reason:

If perf_event_paranoid <= 0, then non perfmon_capable() users can open
a per-CPU event. With a per-CPU event, unpriviledged users are allowed
to profile _all_ processes, even ones owned by root.

Without this change, users could see kernel addresses, root processes,
etc, but not gather the PIDs of those processes. The PID is probably the
least sensitive of all the information.

It would be more idiomatic to check the perf_event_paranoid level with
perf_allow_cpu(), but this function is not exported so cannot be used
from a module. Looking for cpu != -1 is the indirect way of checking
the same thing as it could never get to arm_spe_pmu_event_init() without
perf_event_paranoid <= 0.

Co-authored-by: James Clark <james.clark@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 8515bf85c..7d9a7fa4f 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -711,7 +711,7 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_LAT))
 		return -EOPNOTSUPP;
 
-	spe_pmu->pmscr_cx = perfmon_capable();
+	spe_pmu->pmscr_cx = perfmon_capable() || (event->cpu != -1);
 	reg = arm_spe_event_to_pmscr(event);
 	if (!perfmon_capable() &&
 	    (reg & (BIT(SYS_PMSCR_EL1_PA_SHIFT) |
-- 
2.25.1

