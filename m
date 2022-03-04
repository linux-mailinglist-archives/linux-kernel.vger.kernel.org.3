Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826404CDA0E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241097AbiCDRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbiCDRUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:20:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 633F51B0C7D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:19:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B1561478;
        Fri,  4 Mar 2022 09:19:51 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.42.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 862A13F73D;
        Fri,  4 Mar 2022 09:19:49 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/15] coresight: etm4x: Cleanup TRCACATRn register accesses
Date:   Fri,  4 Mar 2022 17:19:08 +0000
Message-Id: <20220304171913.2292458-12-james.clark@arm.com>
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
 .../coresight/coresight-etm4x-sysfs.c         | 42 +++++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.h | 14 +++++--
 2 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index b3b1b92909cc..29188b1a4646 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -22,7 +22,7 @@ static int etm4_set_mode_exclude(struct etmv4_drvdata *drvdata, bool exclude)
 	 * TRCACATRn.TYPE bit[1:0]: type of comparison
 	 * the trace unit performs
 	 */
-	if (BMVAL(config->addr_acc[idx], 0, 1) == ETM_INSTR_ADDR) {
+	if (FIELD_GET(TRCACATRn_TYPE_MASK, config->addr_acc[idx]) == TRCACATRn_TYPE_ADDR) {
 		if (idx % 2 != 0)
 			return -EINVAL;
 
@@ -863,11 +863,11 @@ static ssize_t addr_instdatatype_show(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
-	val = BMVAL(config->addr_acc[idx], 0, 1);
+	val = FIELD_GET(TRCACATRn_TYPE_MASK, config->addr_acc[idx]);
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
+		config->addr_acc[idx] &= ~TRCACATRn_TYPE_MASK;
 
 	spin_unlock(&drvdata->spinlock);
 	return size;
@@ -1149,7 +1149,7 @@ static ssize_t addr_ctxtype_show(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	/* CONTEXTTYPE, bits[3:2] */
-	val = BMVAL(config->addr_acc[idx], 2, 3);
+	val = FIELD_GET(TRCACATRn_CONTEXTTYPE_MASK, config->addr_acc[idx]);
 	len = scnprintf(buf, PAGE_SIZE, "%s\n", val == ETM_CTX_NONE ? "none" :
 			(val == ETM_CTX_CTXID ? "ctxid" :
 			(val == ETM_CTX_VMID ? "vmid" : "all")));
@@ -1175,18 +1175,18 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 	idx = config->addr_idx;
 	if (!strcmp(str, "none"))
 		/* start by clearing context type bits */
-		config->addr_acc[idx] &= ~(BIT(2) | BIT(3));
+		config->addr_acc[idx] &= ~TRCACATRn_CONTEXTTYPE_MASK;
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
@@ -1194,9 +1194,9 @@ static ssize_t addr_ctxtype_store(struct device *dev,
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
@@ -1215,7 +1215,7 @@ static ssize_t addr_context_show(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	/* context ID comparator bits[6:4] */
-	val = BMVAL(config->addr_acc[idx], 4, 6);
+	val = FIELD_GET(TRCACATRn_CONTEXT_MASK, config->addr_acc[idx]);
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1240,8 +1240,8 @@ static ssize_t addr_context_store(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	/* clear context ID comparator bits[6:4] */
-	config->addr_acc[idx] &= ~(BIT(4) | BIT(5) | BIT(6));
-	config->addr_acc[idx] |= (val << 4);
+	config->addr_acc[idx] &= ~TRCACATRn_CONTEXT_MASK;
+	config->addr_acc[idx] |= val << __bf_shf(TRCACATRn_CONTEXT_MASK);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1258,7 +1258,7 @@ static ssize_t addr_exlevel_s_ns_show(struct device *dev,
 
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
-	val = BMVAL(config->addr_acc[idx], 8, 14);
+	val = FIELD_GET(TRCACATRn_EXLEVEL_MASK, config->addr_acc[idx]);
 	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1275,14 +1275,14 @@ static ssize_t addr_exlevel_s_ns_store(struct device *dev,
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
-	if (val & ~((GENMASK(14, 8) >> 8)))
+	if (val & ~(TRCACATRn_EXLEVEL_MASK >> __bf_shf(TRCACATRn_EXLEVEL_MASK)))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	/* clear Exlevel_ns & Exlevel_s bits[14:12, 11:8], bit[15] is res0 */
-	config->addr_acc[idx] &= ~(GENMASK(14, 8));
-	config->addr_acc[idx] |= (val << 8);
+	config->addr_acc[idx] &= ~TRCACATRn_EXLEVEL_MASK;
+	config->addr_acc[idx] |= val << __bf_shf(TRCACATRn_EXLEVEL_MASK);
 	spin_unlock(&drvdata->spinlock);
 	return size;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 9cacc38b1890..802ddbe2eecd 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -208,6 +208,12 @@
 #define TRCVICTLR_EXLEVEL_S_MASK		GENMASK(19, 16)
 #define TRCVICTLR_EXLEVEL_NS_MASK		GENMASK(22, 20)
 
+#define TRCACATRn_TYPE_MASK			GENMASK(1, 0)
+#define TRCACATRn_CONTEXTTYPE_MASK		GENMASK(3, 2)
+#define TRCACATRn_CONTEXTTYPE_CTXID		BIT(2)
+#define TRCACATRn_CONTEXTTYPE_VMID		BIT(3)
+#define TRCACATRn_CONTEXT_MASK			GENMASK(6, 4)
+#define TRCACATRn_EXLEVEL_MASK			GENMASK(14, 8)
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
@@ -1050,10 +1056,10 @@ struct etmv4_drvdata {
 
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

