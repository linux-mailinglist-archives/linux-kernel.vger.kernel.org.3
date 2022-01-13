Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6753C48DD40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbiAMRyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:54:49 -0500
Received: from foss.arm.com ([217.140.110.172]:49234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237325AbiAMRyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:54:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 901E56D;
        Thu, 13 Jan 2022 09:54:45 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D0EE3F766;
        Thu, 13 Jan 2022 09:54:44 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-eng@arm.com
Cc:     james.clark@arm.com, German Gomez <german.gomez@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf: arm_spe: Enable CONTEXT packets if profiling in CPU mode
Date:   Thu, 13 Jan 2022 17:54:17 +0000
Message-Id: <20220113175417.5523-3-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220113175417.5523-1-german.gomez@arm.com>
References: <20220113175417.5523-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CONTEXT packets in SPE traces if the profiler runs in CPU mode.

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

