Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CAD52360C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbiEKOq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244990AbiEKOqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:46:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D52D62AFB;
        Wed, 11 May 2022 07:46:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A56431042;
        Wed, 11 May 2022 07:46:09 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.2.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC4933F66F;
        Wed, 11 May 2022 07:46:07 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, mike.leach@linaro.org
Cc:     leo.yan@linaro.com, James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] coresight: Add config flag to enable branch broadcast
Date:   Wed, 11 May 2022 15:45:58 +0100
Message-Id: <20220511144601.2257870-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220511144601.2257870-1-james.clark@arm.com>
References: <20220511144601.2257870-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 ++
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 14 ++++++++++++++
 include/linux/coresight-pmu.h                      |  2 ++
 3 files changed, 18 insertions(+)

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
index 87299e99dabb..cf249ecad5a5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -696,6 +696,20 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 		ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
 	}
 
+	/* branch broadcast - enable if selected and supported */
+	if (attr->config & BIT(ETM_OPT_BRANCH_BROADCAST)) {
+		if (!drvdata->trcbb) {
+			/*
+			 * Missing BB support could cause silent decode errors
+			 * so fail to open if it's not supported.
+			 */
+			ret = -EINVAL;
+			goto out;
+		} else {
+			config->cfg |= BIT(ETM4_CFG_BIT_BB);
+		}
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

