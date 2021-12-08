Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C1846D2C0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhLHL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:58:37 -0500
Received: from foss.arm.com ([217.140.110.172]:57990 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231862AbhLHL6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:58:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FBF61042;
        Wed,  8 Dec 2021 03:55:02 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.34.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 316613F73B;
        Wed,  8 Dec 2021 03:55:00 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf cs-etm: Remove duplicate and incorrect aux size checks
Date:   Wed,  8 Dec 2021 11:54:35 +0000
Message-Id: <20211208115435.610101-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two checks, one is for size when running without admin, but
this one is covered by the driver and reported on in more detail here
(builtin-record.c):

  pr_err("Permission error mapping pages.\n"
         "Consider increasing "
         "/proc/sys/kernel/perf_event_mlock_kb,\n"
         "or try again with a smaller value of -m/--mmap_pages.\n"
         "(current value: %u,%u)\n",

This had the effect of artificially limiting the aux buffer size to a
value smaller than what was allowed because perf_event_mlock_kb wasn't
taken into account.

The second is to check for a power of two, but this is covered here
(evlist.c):

  pr_info("rounding mmap pages size to %s (%lu pages)\n",
          buf, pages);

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 293a23bf8be3..8a3d54a86c9c 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -407,25 +407,6 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 
 	}
 
-	/* Validate auxtrace_mmap_pages provided by user */
-	if (opts->auxtrace_mmap_pages) {
-		unsigned int max_page = (KiB(128) / page_size);
-		size_t sz = opts->auxtrace_mmap_pages * (size_t)page_size;
-
-		if (!privileged &&
-		    opts->auxtrace_mmap_pages > max_page) {
-			opts->auxtrace_mmap_pages = max_page;
-			pr_err("auxtrace too big, truncating to %d\n",
-			       max_page);
-		}
-
-		if (!is_power_of_2(sz)) {
-			pr_err("Invalid mmap size for %s: must be a power of 2\n",
-			       CORESIGHT_ETM_PMU_NAME);
-			return -EINVAL;
-		}
-	}
-
 	if (opts->auxtrace_snapshot_mode)
 		pr_debug2("%s snapshot size: %zu\n", CORESIGHT_ETM_PMU_NAME,
 			  opts->auxtrace_snapshot_size);
-- 
2.28.0

