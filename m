Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD8746D7C2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbhLHQMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:12:51 -0500
Received: from foss.arm.com ([217.140.110.172]:35456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhLHQMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:12:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1886101E;
        Wed,  8 Dec 2021 08:09:17 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.34.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 96E4D3F5A1;
        Wed,  8 Dec 2021 08:09:15 -0800 (PST)
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
Subject: [PATCH 1/3] coresight: Add config flag to enable branch broadcast
Date:   Wed,  8 Dec 2021 16:09:05 +0000
Message-Id: <20211208160907.749482-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When enabled, all taken branch addresses are output, even if the branch
was because of a direct branch instruction. This enables reconstruction
of the program flow without having access to the memory image of the
code being executed.

Use bit 8 for the config option which would be the correct bit for
programming ETMv3. Although branch broadcast can't be enabled on ETMv3
because it's not in the define ETM3X_SUPPORTED_OPTIONS, using the
correct bit might help prevent future collisions or allow it to be
enabled if needed.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c   | 2 ++
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 9 +++++++++
 include/linux/coresight-pmu.h                      | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index c039b6ae206f..43bbd5dc3d3b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -52,6 +52,7 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
  * The PMU formats were orignally for ETMv3.5/PTM's ETMCR 'config';
  * now take them as general formats and apply on all ETMs.
  */
+PMU_FORMAT_ATTR(branch_broadcast, "config:"__stringify(ETM_OPT_BRANCH_BROADCAST));
 PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
 /* contextid1 enables tracing CONTEXTIDR_EL1 for ETMv4 */
 PMU_FORMAT_ATTR(contextid1,	"config:" __stringify(ETM_OPT_CTXTID));
@@ -97,6 +98,7 @@ static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_sinkid.attr,
 	&format_attr_preset.attr,
 	&format_attr_configid.attr,
+	&format_attr_branch_broadcast.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index bf18128cf5de..d2bafb50c66a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -692,6 +692,15 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 		ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
 	}
 
+	/* branch broadcast - enable if selected and supported */
+	if (attr->config & BIT(ETM_OPT_BRANCH_BROADCAST)) {
+		if (!drvdata->trcbb) {
+			ret = -EINVAL;
+			goto out;
+		} else
+			config->cfg |= BIT(ETM4_CFG_BIT_BB);
+	}
+
 out:
 	return ret;
 }
diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
index 4ac5c081af93..6c2fd6cc5a98 100644
--- a/include/linux/coresight-pmu.h
+++ b/include/linux/coresight-pmu.h
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
-- 
2.28.0

