Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D32A4CDA0A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbiCDRUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241068AbiCDRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70913158DAF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:19:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2ABD1478;
        Fri,  4 Mar 2022 09:19:45 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D3723F73D;
        Fri,  4 Mar 2022 09:19:44 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/15] coresight: etm4x: Cleanup TRCVICTLR register accesses
Date:   Fri,  4 Mar 2022 17:19:06 +0000
Message-Id: <20220304171913.2292458-10-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220304171913.2292458-1-james.clark@arm.com>
References: <20220304171913.2292458-1-james.clark@arm.com>
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

This is a no-op change for style and consistency and has no effect on
the binary output by the compiler. In sysreg.h fields are defined as
the register name followed by the field name and then _MASK. This
allows for grepping for fields by name rather than using magic numbers.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 10 +++---
 .../coresight/coresight-etm4x-sysfs.c         | 36 +++++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.h | 22 +++++-------
 3 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 445e2057d5ed..88353f8ba414 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1206,7 +1206,7 @@ static void etm4_init_arch_data(void *info)
 
 static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
 {
-	return etm4_get_access_type(config) << TRCVICTLR_EXLEVEL_SHIFT;
+	return etm4_get_access_type(config) << __bf_shf(TRCVICTLR_EXLEVEL_MASK);
 }
 
 /* Set ELx trace filter access in the TRCVICTLR register */
@@ -1232,7 +1232,7 @@ static void etm4_set_default_config(struct etmv4_config *config)
 	config->ts_ctrl = 0x0;
 
 	/* TRCVICTLR::EVENT = 0x01, select the always on logic */
-	config->vinst_ctrl = BIT(0);
+	config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
 
 	/* TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering */
 	etm4_set_victlr_access(config);
@@ -1341,7 +1341,7 @@ static void etm4_set_default_filter(struct etmv4_config *config)
 	 * TRCVICTLR::SSSTATUS == 1, the start-stop logic is
 	 * in the started state
 	 */
-	config->vinst_ctrl |= BIT(9);
+	config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
 	config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
 
 	/* No start-stop filtering for ViewInst */
@@ -1445,7 +1445,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 			 * TRCVICTLR::SSSTATUS == 1, the start-stop logic is
 			 * in the started state
 			 */
-			config->vinst_ctrl |= BIT(9);
+			config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
 
 			/* No start-stop filtering for ViewInst */
 			config->vissctlr = 0x0;
@@ -1473,7 +1473,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 			 * etm4_disable_perf().
 			 */
 			if (filters->ssstatus)
-				config->vinst_ctrl |= BIT(9);
+				config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
 
 			/* No include/exclude filtering for ViewInst */
 			config->viiectlr = 0x0;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index cd24590ea38a..b3b1b92909cc 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -206,11 +206,11 @@ static ssize_t reset_store(struct device *dev,
 	 * started state. ARM recommends start-stop logic is set before
 	 * each trace run.
 	 */
-	config->vinst_ctrl = BIT(0);
+	config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
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
+	val = FIELD_GET(TRCVICTLR_EVENT_MASK, config->vinst_ctrl);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -739,9 +739,9 @@ static ssize_t event_vinst_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	val &= ETMv4_EVENT_MASK;
-	config->vinst_ctrl &= ~ETMv4_EVENT_MASK;
-	config->vinst_ctrl |= val;
+	val &= TRCVICTLR_EVENT_MASK >> __bf_shf(TRCVICTLR_EVENT_MASK);
+	config->vinst_ctrl &= ~TRCVICTLR_EVENT_MASK;
+	config->vinst_ctrl |= FIELD_PREP(TRCVICTLR_EVENT_MASK, val);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -755,7 +755,7 @@ static ssize_t s_exlevel_vinst_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	val = (config->vinst_ctrl & TRCVICTLR_EXLEVEL_S_MASK) >> TRCVICTLR_EXLEVEL_S_SHIFT;
+	val = FIELD_GET(TRCVICTLR_EXLEVEL_S_MASK, config->vinst_ctrl);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -772,10 +772,10 @@ static ssize_t s_exlevel_vinst_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	/* clear all EXLEVEL_S bits  */
-	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_S_MASK);
+	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_S_MASK;
 	/* enable instruction tracing for corresponding exception level */
 	val &= drvdata->s_ex_level;
-	config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_S_SHIFT);
+	config->vinst_ctrl |= val << __bf_shf(TRCVICTLR_EXLEVEL_S_MASK);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -790,7 +790,7 @@ static ssize_t ns_exlevel_vinst_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	/* EXLEVEL_NS, bits[23:20] */
-	val = (config->vinst_ctrl & TRCVICTLR_EXLEVEL_NS_MASK) >> TRCVICTLR_EXLEVEL_NS_SHIFT;
+	val = FIELD_GET(TRCVICTLR_EXLEVEL_NS_MASK, config->vinst_ctrl);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -807,10 +807,10 @@ static ssize_t ns_exlevel_vinst_store(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	/* clear EXLEVEL_NS bits  */
-	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_NS_MASK);
+	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_NS_MASK;
 	/* enable instruction tracing for corresponding exception level */
 	val &= drvdata->ns_ex_level;
-	config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_NS_SHIFT);
+	config->vinst_ctrl |= val << __bf_shf(TRCVICTLR_EXLEVEL_NS_MASK);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 36934056a5dc..9cacc38b1890 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -200,6 +200,14 @@
 #define TRCSTALLCTLR_INSTPRIORITY		BIT(10)
 #define TRCSTALLCTLR_NOOVERFLOW			BIT(13)
 
+#define TRCVICTLR_EVENT_MASK			GENMASK(7, 0)
+#define TRCVICTLR_SSSTATUS			BIT(9)
+#define TRCVICTLR_TRCRESET			BIT(10)
+#define TRCVICTLR_TRCERR			BIT(11)
+#define TRCVICTLR_EXLEVEL_MASK			GENMASK(22, 16)
+#define TRCVICTLR_EXLEVEL_S_MASK		GENMASK(19, 16)
+#define TRCVICTLR_EXLEVEL_NS_MASK		GENMASK(22, 20)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
@@ -700,23 +708,9 @@
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

