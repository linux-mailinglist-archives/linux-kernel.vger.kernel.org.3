Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718A04A7551
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345697AbiBBQDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:03:15 -0500
Received: from foss.arm.com ([217.140.110.172]:39844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241077AbiBBQDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:03:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 464A611D4;
        Wed,  2 Feb 2022 08:03:10 -0800 (PST)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 369543F73B;
        Wed,  2 Feb 2022 08:03:08 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] coresight: Make ETM4x TRCVICTLR register accesses consistent with sysreg.h
Date:   Wed,  2 Feb 2022 16:02:19 +0000
Message-Id: <20220202160226.37858-10-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220202160226.37858-1-james.clark@arm.com>
References: <20220202160226.37858-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a no-op change for style and consistency and has no effect on the
binary produced by gcc-11.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 10 +++---
 .../coresight/coresight-etm4x-sysfs.c         | 32 +++++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.h | 26 +++++++--------
 3 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 19469546f733..00285e2533b5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1209,7 +1209,7 @@ static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
 /* Set ELx trace filter access in the TRCVICTLR register */
 static void etm4_set_victlr_access(struct etmv4_config *config)
 {
-	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_MASK;
+	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_MASK << TRCVICTLR_EXLEVEL_SHIFT);
 	config->vinst_ctrl |= etm4_get_victlr_access_type(config);
 }
 
@@ -1229,7 +1229,7 @@ static void etm4_set_default_config(struct etmv4_config *config)
 	config->ts_ctrl = 0x0;
 
 	/* TRCVICTLR::EVENT = 0x01, select the always on logic */
-	config->vinst_ctrl = BIT(0);
+	config->vinst_ctrl = (0x01 & TRCVICTLR_EVENT_MASK) << TRCVICTLR_EVENT_SHIFT;
 
 	/* TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering */
 	etm4_set_victlr_access(config);
@@ -1338,7 +1338,7 @@ static void etm4_set_default_filter(struct etmv4_config *config)
 	 * TRCVICTLR::SSSTATUS == 1, the start-stop logic is
 	 * in the started state
 	 */
-	config->vinst_ctrl |= BIT(9);
+	config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
 	config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
 
 	/* No start-stop filtering for ViewInst */
@@ -1442,7 +1442,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 			 * TRCVICTLR::SSSTATUS == 1, the start-stop logic is
 			 * in the started state
 			 */
-			config->vinst_ctrl |= BIT(9);
+			config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
 
 			/* No start-stop filtering for ViewInst */
 			config->vissctlr = 0x0;
@@ -1470,7 +1470,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 			 * etm4_disable_perf().
 			 */
 			if (filters->ssstatus)
-				config->vinst_ctrl |= BIT(9);
+				config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
 
 			/* No include/exclude filtering for ViewInst */
 			config->viiectlr = 0x0;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index d808eeae8b07..87e52f685f05 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -206,11 +206,11 @@ static ssize_t reset_store(struct device *dev,
 	 * started state. ARM recommends start-stop logic is set before
 	 * each trace run.
 	 */
-	config->vinst_ctrl = BIT(0);
+	config->vinst_ctrl = (0x01 & TRCVICTLR_EVENT_MASK) << TRCVICTLR_EVENT_SHIFT;
 	if (drvdata->nr_addr_cmp > 0) {
 		config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
 		/* SSSTATUS, bit[9] */
-		config->vinst_ctrl |= BIT(9);
+		config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
 	}
 
 	/* No address range filtering for ViewInst */
@@ -416,22 +416,22 @@ static ssize_t mode_store(struct device *dev,
 
 	/* bit[9] Start/stop logic control bit */
 	if (config->mode & ETM_MODE_VIEWINST_STARTSTOP)
-		config->vinst_ctrl |= BIT(9);
+		config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
 	else
-		config->vinst_ctrl &= ~BIT(9);
+		config->vinst_ctrl &= ~TRCVICTLR_SSSTATUS;
 
 	/* bit[10], Whether a trace unit must trace a Reset exception */
 	if (config->mode & ETM_MODE_TRACE_RESET)
-		config->vinst_ctrl |= BIT(10);
+		config->vinst_ctrl |= TRCVICTLR_TRCRESET;
 	else
-		config->vinst_ctrl &= ~BIT(10);
+		config->vinst_ctrl &= ~TRCVICTLR_TRCRESET;
 
 	/* bit[11], Whether a trace unit must trace a system error exception */
 	if ((config->mode & ETM_MODE_TRACE_ERR) &&
 		(drvdata->trc_error == true))
-		config->vinst_ctrl |= BIT(11);
+		config->vinst_ctrl |= TRCVICTLR_TRCERR;
 	else
-		config->vinst_ctrl &= ~BIT(11);
+		config->vinst_ctrl &= ~TRCVICTLR_TRCERR;
 
 	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
 		etm4_config_trace_mode(config);
@@ -723,7 +723,7 @@ static ssize_t event_vinst_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	val = config->vinst_ctrl & ETMv4_EVENT_MASK;
+	val = REG_VAL(config->vinst_ctrl, TRCVICTLR_EVENT);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -739,9 +739,9 @@ static ssize_t event_vinst_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	val &= ETMv4_EVENT_MASK;
-	config->vinst_ctrl &= ~ETMv4_EVENT_MASK;
-	config->vinst_ctrl |= val;
+	val &= TRCVICTLR_EVENT_MASK;
+	config->vinst_ctrl &= ~(TRCVICTLR_EVENT_MASK << TRCVICTLR_EVENT_SHIFT);
+	config->vinst_ctrl |= val << TRCVICTLR_EVENT_SHIFT;
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -755,7 +755,7 @@ static ssize_t s_exlevel_vinst_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	val = (config->vinst_ctrl & TRCVICTLR_EXLEVEL_S_MASK) >> TRCVICTLR_EXLEVEL_S_SHIFT;
+	val = REG_VAL(config->vinst_ctrl, TRCVICTLR_EXLEVEL_S);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -772,7 +772,7 @@ static ssize_t s_exlevel_vinst_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	/* clear all EXLEVEL_S bits  */
-	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_S_MASK);
+	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_S_SHIFT);
 	/* enable instruction tracing for corresponding exception level */
 	val &= drvdata->s_ex_level;
 	config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_S_SHIFT);
@@ -790,7 +790,7 @@ static ssize_t ns_exlevel_vinst_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	/* EXLEVEL_NS, bits[23:20] */
-	val = (config->vinst_ctrl & TRCVICTLR_EXLEVEL_NS_MASK) >> TRCVICTLR_EXLEVEL_NS_SHIFT;
+	val = REG_VAL(config->vinst_ctrl, TRCVICTLR_EXLEVEL_NS);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -807,7 +807,7 @@ static ssize_t ns_exlevel_vinst_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	/* clear EXLEVEL_NS bits  */
-	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_NS_MASK);
+	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_NS_SHIFT);
 	/* enable instruction tracing for corresponding exception level */
 	val &= drvdata->ns_ex_level;
 	config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_NS_SHIFT);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index e37393934e0d..02afce9dcf6b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -224,6 +224,18 @@
 #define TRCSTALLCTLR_INSTPRIORITY		BIT(10)
 #define TRCSTALLCTLR_NOOVERFLOW			BIT(13)
 
+#define TRCVICTLR_EVENT_SHIFT			0
+#define TRCVICTLR_EVENT_MASK			GENMASK(7, 0)
+#define TRCVICTLR_SSSTATUS			BIT(9)
+#define TRCVICTLR_TRCRESET			BIT(10)
+#define TRCVICTLR_TRCERR			BIT(11)
+#define TRCVICTLR_EXLEVEL_SHIFT			16
+#define TRCVICTLR_EXLEVEL_MASK			GENMASK(6, 0)
+#define TRCVICTLR_EXLEVEL_S_SHIFT		16
+#define TRCVICTLR_EXLEVEL_S_MASK		GENMASK(3, 0)
+#define TRCVICTLR_EXLEVEL_NS_SHIFT		20
+#define TRCVICTLR_EXLEVEL_NS_MASK		GENMASK(2, 0)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
@@ -724,23 +736,9 @@
 #define ETM_EXLEVEL_NS_OS		BIT(5)	/* NonSecure EL1	*/
 #define ETM_EXLEVEL_NS_HYP		BIT(6)	/* NonSecure EL2	*/
 
-#define ETM_EXLEVEL_MASK		(GENMASK(6, 0))
-#define ETM_EXLEVEL_S_MASK		(GENMASK(3, 0))
-#define ETM_EXLEVEL_NS_MASK		(GENMASK(6, 4))
-
 /* access level controls in TRCACATRn */
 #define TRCACATR_EXLEVEL_SHIFT		8
 
-/* access level control in TRCVICTLR */
-#define TRCVICTLR_EXLEVEL_SHIFT		16
-#define TRCVICTLR_EXLEVEL_S_SHIFT	16
-#define TRCVICTLR_EXLEVEL_NS_SHIFT	20
-
-/* secure / non secure masks - TRCVICTLR, IDR3 */
-#define TRCVICTLR_EXLEVEL_MASK		(ETM_EXLEVEL_MASK << TRCVICTLR_EXLEVEL_SHIFT)
-#define TRCVICTLR_EXLEVEL_S_MASK	(ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_SHIFT)
-#define TRCVICTLR_EXLEVEL_NS_MASK	(ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_SHIFT)
-
 #define ETM_TRCIDR1_ARCH_MAJOR_SHIFT	8
 #define ETM_TRCIDR1_ARCH_MAJOR_MASK	(0xfU << ETM_TRCIDR1_ARCH_MAJOR_SHIFT)
 #define ETM_TRCIDR1_ARCH_MAJOR(x)	\
-- 
2.28.0

