Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083FF4A7557
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiBBQD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:03:26 -0500
Received: from foss.arm.com ([217.140.110.172]:39876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238533AbiBBQDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:03:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59EEE11FB;
        Wed,  2 Feb 2022 08:03:17 -0800 (PST)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4662C3F73B;
        Wed,  2 Feb 2022 08:03:15 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     mathieu.poirier@linaro.org, coresight@lists.linaro.org
Cc:     suzuki.poulose@arm.com, leo.yan@linaro.com, mike.leach@linaro.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] coresight: Make ETM4x TRCACATRn register accesses consistent with sysreg.h
Date:   Wed,  2 Feb 2022 16:02:21 +0000
Message-Id: <20220202160226.37858-12-james.clark@arm.com>
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
 .../coresight/coresight-etm4x-sysfs.c         | 43 ++++++++++---------
 drivers/hwtracing/coresight/coresight-etm4x.h | 18 ++++++--
 2 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 87e52f685f05..51f6e13e3b29 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -22,7 +22,7 @@ static int etm4_set_mode_exclude(struct etmv4_drvdata *drvdata, bool exclude)
 	 * TRCACATRn.TYPE bit[1:0]: type of comparison
 	 * the trace unit performs
 	 */
-	if (BMVAL(config->addr_acc[idx], 0, 1) == ETM_INSTR_ADDR) {
+	if (REG_VAL(config->addr_acc[idx], TRCACATRn_TYPE) == TRCACATRn_TYPE_ADDR) {
 		if (idx % 2 != 0)
 			return -EINVAL;
 
@@ -863,11 +863,11 @@ static ssize_t addr_instdatatype_show(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
-	val = BMVAL(config->addr_acc[idx], 0, 1);
+	val = REG_VAL(config->addr_acc[idx], TRCACATRn_TYPE);
 	len = scnprintf(buf, PAGE_SIZE, "%s\n",
-			val == ETM_INSTR_ADDR ? "instr" :
-			(val == ETM_DATA_LOAD_ADDR ? "data_load" :
-			(val == ETM_DATA_STORE_ADDR ? "data_store" :
+			val == TRCACATRn_TYPE_ADDR ? "instr" :
+			(val == TRCACATRn_TYPE_DATA_LOAD_ADDR ? "data_load" :
+			(val == TRCACATRn_TYPE_DATA_STORE_ADDR ? "data_store" :
 			"data_load_store")));
 	spin_unlock(&drvdata->spinlock);
 	return len;
@@ -891,7 +891,7 @@ static ssize_t addr_instdatatype_store(struct device *dev,
 	idx = config->addr_idx;
 	if (!strcmp(str, "instr"))
 		/* TYPE, bits[1:0] */
-		config->addr_acc[idx] &= ~(BIT(0) | BIT(1));
+		config->addr_acc[idx] &= ~(TRCACATRn_TYPE_MASK << TRCACATRn_TYPE_SHIFT);
 
 	spin_unlock(&drvdata->spinlock);
 	return size;
@@ -1149,7 +1149,7 @@ static ssize_t addr_ctxtype_show(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	/* CONTEXTTYPE, bits[3:2] */
-	val = BMVAL(config->addr_acc[idx], 2, 3);
+	val = REG_VAL(config->addr_acc[idx], TRCACATRn_CONTEXTTYPE);
 	len = scnprintf(buf, PAGE_SIZE, "%s\n", val == ETM_CTX_NONE ? "none" :
 			(val == ETM_CTX_CTXID ? "ctxid" :
 			(val == ETM_CTX_VMID ? "vmid" : "all")));
@@ -1175,18 +1175,19 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 	idx = config->addr_idx;
 	if (!strcmp(str, "none"))
 		/* start by clearing context type bits */
-		config->addr_acc[idx] &= ~(BIT(2) | BIT(3));
+		config->addr_acc[idx] &= ~(TRCACATRn_CONTEXTTYPE_MASK <<
+					   TRCACATRn_CONTEXTTYPE_SHIFT);
 	else if (!strcmp(str, "ctxid")) {
 		/* 0b01 The trace unit performs a Context ID */
 		if (drvdata->numcidc) {
-			config->addr_acc[idx] |= BIT(2);
-			config->addr_acc[idx] &= ~BIT(3);
+			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_CTXID;
+			config->addr_acc[idx] &= ~TRCACATRn_CONTEXTTYPE_VMID;
 		}
 	} else if (!strcmp(str, "vmid")) {
 		/* 0b10 The trace unit performs a VMID */
 		if (drvdata->numvmidc) {
-			config->addr_acc[idx] &= ~BIT(2);
-			config->addr_acc[idx] |= BIT(3);
+			config->addr_acc[idx] &= ~TRCACATRn_CONTEXTTYPE_CTXID;
+			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_VMID;
 		}
 	} else if (!strcmp(str, "all")) {
 		/*
@@ -1194,9 +1195,9 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 		 * comparison and a VMID
 		 */
 		if (drvdata->numcidc)
-			config->addr_acc[idx] |= BIT(2);
+			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_CTXID;
 		if (drvdata->numvmidc)
-			config->addr_acc[idx] |= BIT(3);
+			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_VMID;
 	}
 	spin_unlock(&drvdata->spinlock);
 	return size;
@@ -1215,7 +1216,7 @@ static ssize_t addr_context_show(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	/* context ID comparator bits[6:4] */
-	val = BMVAL(config->addr_acc[idx], 4, 6);
+	val = REG_VAL(config->addr_acc[idx], TRCACATRn_CONTEXT);
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1240,8 +1241,8 @@ static ssize_t addr_context_store(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	/* clear context ID comparator bits[6:4] */
-	config->addr_acc[idx] &= ~(BIT(4) | BIT(5) | BIT(6));
-	config->addr_acc[idx] |= (val << 4);
+	config->addr_acc[idx] &= ~(TRCACATRn_CONTEXT_MASK << TRCACATRn_CONTEXT_SHIFT);
+	config->addr_acc[idx] |= (val << TRCACATRn_CONTEXT_SHIFT);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1258,7 +1259,7 @@ static ssize_t addr_exlevel_s_ns_show(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
-	val = BMVAL(config->addr_acc[idx], 8, 14);
+	val = REG_VAL(config->addr_acc[idx], TRCACATRn_EXLEVEL);
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1275,14 +1276,14 @@ static ssize_t addr_exlevel_s_ns_store(struct device *dev,
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
-	if (val & ~((GENMASK(14, 8) >> 8)))
+	if (val & ~TRCACATRn_EXLEVEL_MASK)
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	/* clear Exlevel_ns & Exlevel_s bits[14:12, 11:8], bit[15] is res0 */
-	config->addr_acc[idx] &= ~(GENMASK(14, 8));
-	config->addr_acc[idx] |= (val << 8);
+	config->addr_acc[idx] &= ~(TRCACATRn_EXLEVEL_MASK << TRCACATRn_EXLEVEL_SHIFT);
+	config->addr_acc[idx] |= (val << TRCACATRn_EXLEVEL_SHIFT);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 02afce9dcf6b..5701d970d81a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -236,6 +236,16 @@
 #define TRCVICTLR_EXLEVEL_NS_SHIFT		20
 #define TRCVICTLR_EXLEVEL_NS_MASK		GENMASK(2, 0)
 
+#define TRCACATRn_TYPE_SHIFT			0
+#define TRCACATRn_TYPE_MASK			GENMASK(1, 0)
+#define TRCACATRn_CONTEXTTYPE_SHIFT		2
+#define TRCACATRn_CONTEXTTYPE_MASK		GENMASK(1, 0)
+#define TRCACATRn_CONTEXTTYPE_CTXID		BIT(2)
+#define TRCACATRn_CONTEXTTYPE_VMID		BIT(3)
+#define TRCACATRn_CONTEXT_SHIFT			4
+#define TRCACATRn_CONTEXT_MASK			GENMASK(2, 0)
+#define TRCACATRn_EXLEVEL_SHIFT			8
+#define TRCACATRn_EXLEVEL_MASK			GENMASK(6, 0)
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
@@ -1078,10 +1088,10 @@ struct etmv4_drvdata {
 
 /* Address comparator access types */
 enum etm_addr_acctype {
-	ETM_INSTR_ADDR,
-	ETM_DATA_LOAD_ADDR,
-	ETM_DATA_STORE_ADDR,
-	ETM_DATA_LOAD_STORE_ADDR,
+	TRCACATRn_TYPE_ADDR,
+	TRCACATRn_TYPE_DATA_LOAD_ADDR,
+	TRCACATRn_TYPE_DATA_STORE_ADDR,
+	TRCACATRn_TYPE_DATA_LOAD_STORE_ADDR,
 };
 
 /* Address comparator context types */
-- 
2.28.0

