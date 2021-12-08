Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A0E46D7C4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhLHQM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:12:57 -0500
Received: from foss.arm.com ([217.140.110.172]:35494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236550AbhLHQMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:12:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EB3C13A1;
        Wed,  8 Dec 2021 08:09:23 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.34.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 643413F5A1;
        Wed,  8 Dec 2021 08:09:21 -0800 (PST)
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf cs-etm: Update deduction of TRCCONFIGR register for branch broadcast
Date:   Wed,  8 Dec 2021 16:09:07 +0000
Message-Id: <20211208160907.749482-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211208160907.749482-1-james.clark@arm.com>
References: <20211208160907.749482-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that a config flag for branch broadcast has been added, take it into
account when trying to deduce what the driver would have programmed the
TRCCONFIGR register to.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/include/linux/coresight-pmu.h | 2 ++
 tools/perf/arch/arm/util/cs-etm.c   | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 4ac5c081af93..6c2fd6cc5a98 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -18,6 +18,7 @@
  * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
  * directly use below macros as config bits.
  */
+#define ETM_OPT_BRANCH_BROADCAST 8
 #define ETM_OPT_CYCACC		12
 #define ETM_OPT_CTXTID		14
 #define ETM_OPT_CTXTID2		15
@@ -25,6 +26,7 @@
 #define ETM_OPT_RETSTK		29
 
 /* ETMv4 CONFIGR programming bits for the ETM OPTs */
+#define ETM4_CFG_BIT_BB         3
 #define ETM4_CFG_BIT_CYCACC	4
 #define ETM4_CFG_BIT_CTXTID	6
 #define ETM4_CFG_BIT_VMID	7
diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 293a23bf8be3..c7ef4e9b4a3a 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -527,6 +527,9 @@ static u64 cs_etmv4_get_config(struct auxtrace_record *itr)
 	if (config_opts & BIT(ETM_OPT_CTXTID2))
 		config |= BIT(ETM4_CFG_BIT_VMID) |
 			  BIT(ETM4_CFG_BIT_VMID_OPT);
+	if (config_opts & BIT(ETM_OPT_BRANCH_BROADCAST))
+		config |= BIT(ETM4_CFG_BIT_BB);
+
 	return config;
 }
 
-- 
2.28.0

