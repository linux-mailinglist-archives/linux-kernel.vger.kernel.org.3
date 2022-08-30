Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDFD5A6ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiH3Ree (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiH3Rdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:33:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75B57FD3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:29:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E6E31576;
        Tue, 30 Aug 2022 10:26:55 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.15.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4B5603F7B4;
        Tue, 30 Aug 2022 10:26:47 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, german.gomez@arm.com,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 5/5] coresight: Make new csdev_access offsets unsigned
Date:   Tue, 30 Aug 2022 18:26:13 +0100
Message-Id: <20220830172614.340962-6-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220830172614.340962-1-james.clark@arm.com>
References: <20220830172614.340962-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New csdev_access functions were added as part of the previous
refactor. In order to make them more consistent with the
existing ones, change any signed offset types to be unsigned.

Now that they are unsigned, stop using hi_off = -1 to signify
a single 32bit access. Instead just call the existing 32bit
accessors. This is also applied to other parts of the codebase,
and the coresight_{read,write}_reg_pair() functions can be
deleted.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.h |  8 ++---
 drivers/hwtracing/coresight/coresight-core.c | 18 ++++++++--
 drivers/hwtracing/coresight/coresight-priv.h | 35 +++++---------------
 drivers/hwtracing/coresight/coresight-tmc.h  |  4 +--
 include/linux/coresight.h                    | 27 +++++++++------
 5 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
index 6160c2d75a56..442e034bbfba 100644
--- a/drivers/hwtracing/coresight/coresight-catu.h
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -70,24 +70,24 @@ struct catu_drvdata {
 static inline u32							\
 catu_read_##name(struct catu_drvdata *drvdata)				\
 {									\
-	return coresight_read_reg_pair(drvdata->base, offset, -1);	\
+	return csdev_access_relaxed_read32(&drvdata->csdev->access, offset); \
 }									\
 static inline void							\
 catu_write_##name(struct catu_drvdata *drvdata, u32 val)		\
 {									\
-	coresight_write_reg_pair(drvdata->base, val, offset, -1);	\
+	csdev_access_relaxed_write32(&drvdata->csdev->access, val, offset); \
 }
 
 #define CATU_REG_PAIR(name, lo_off, hi_off)				\
 static inline u64							\
 catu_read_##name(struct catu_drvdata *drvdata)				\
 {									\
-	return coresight_read_reg_pair(drvdata->base, lo_off, hi_off);	\
+	return csdev_access_relaxed_read_pair(&drvdata->csdev->access, lo_off, hi_off); \
 }									\
 static inline void							\
 catu_write_##name(struct catu_drvdata *drvdata, u64 val)		\
 {									\
-	coresight_write_reg_pair(drvdata->base, val, lo_off, hi_off);	\
+	csdev_access_relaxed_write_pair(&drvdata->csdev->access, val, lo_off, hi_off); \
 }
 
 CATU_REG32(control, CATU_CONTROL);
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index c63b2167a69f..d5dbc67bacb4 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -60,7 +60,7 @@ EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
 
 static const struct cti_assoc_op *cti_assoc_ops;
 
-ssize_t coresight_simple_show(struct device *_dev,
+ssize_t coresight_simple_show_pair(struct device *_dev,
 			      struct device_attribute *attr, char *buf)
 {
 	struct coresight_device *csdev = container_of(_dev, struct coresight_device, dev);
@@ -72,7 +72,21 @@ ssize_t coresight_simple_show(struct device *_dev,
 	pm_runtime_put_sync(_dev->parent);
 	return sysfs_emit(buf, "0x%llx\n", val);
 }
-EXPORT_SYMBOL_GPL(coresight_simple_show);
+EXPORT_SYMBOL_GPL(coresight_simple_show_pair);
+
+ssize_t coresight_simple_show32(struct device *_dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct coresight_device *csdev = container_of(_dev, struct coresight_device, dev);
+	struct cs_off_attribute *cs_attr = container_of(attr, struct cs_off_attribute, attr);
+	u64 val;
+
+	pm_runtime_get_sync(_dev->parent);
+	val = csdev_access_relaxed_read32(&csdev->access, cs_attr->off);
+	pm_runtime_put_sync(_dev->parent);
+	return sysfs_emit(buf, "0x%llx\n", val);
+}
+EXPORT_SYMBOL_GPL(coresight_simple_show32);
 
 void coresight_set_cti_ops(const struct cti_assoc_op *cti_op)
 {
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index c211979deca5..595ce5862056 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -41,8 +41,8 @@
 #define ETM_MODE_EXCL_USER	BIT(31)
 struct cs_pair_attribute {
 	struct device_attribute attr;
-	s32 lo_off;
-	s32 hi_off;
+	u32 lo_off;
+	u32 hi_off;
 };
 
 struct cs_off_attribute {
@@ -50,21 +50,23 @@ struct cs_off_attribute {
 	u32 off;
 };
 
-extern ssize_t coresight_simple_show(struct device *_dev,
+extern ssize_t coresight_simple_show32(struct device *_dev,
+				     struct device_attribute *attr, char *buf);
+extern ssize_t coresight_simple_show_pair(struct device *_dev,
 				     struct device_attribute *attr, char *buf);
 
 #define coresight_simple_reg32(name, offset)				\
-	(&((struct cs_pair_attribute[]) {				\
+	(&((struct cs_off_attribute[]) {				\
 	   {								\
-		__ATTR(name, 0444, coresight_simple_show, NULL),	\
-		offset, -1						\
+		__ATTR(name, 0444, coresight_simple_show32, NULL),	\
+		offset							\
 	   }								\
 	})[0].attr.attr)
 
 #define coresight_simple_reg64(name, lo_off, hi_off)			\
 	(&((struct cs_pair_attribute[]) {				\
 	   {								\
-		__ATTR(name, 0444, coresight_simple_show, NULL),	\
+		__ATTR(name, 0444, coresight_simple_show_pair, NULL),	\
 		lo_off, hi_off						\
 	   }								\
 	})[0].attr.attr)
@@ -130,25 +132,6 @@ static inline void CS_UNLOCK(void __iomem *addr)
 	} while (0);
 }
 
-static inline u64
-coresight_read_reg_pair(void __iomem *addr, s32 lo_offset, s32 hi_offset)
-{
-	u64 val;
-
-	val = readl_relaxed(addr + lo_offset);
-	val |= (hi_offset < 0) ? 0 :
-	       (u64)readl_relaxed(addr + hi_offset) << 32;
-	return val;
-}
-
-static inline void coresight_write_reg_pair(void __iomem *addr, u64 val,
-						 s32 lo_offset, s32 hi_offset)
-{
-	writel_relaxed((u32)val, addr + lo_offset);
-	if (hi_offset >= 0)
-		writel_relaxed((u32)(val >> 32), addr + hi_offset);
-}
-
 void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, u32 mode, void *sink_data);
 struct coresight_device *coresight_get_sink(struct list_head *path);
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 6bec20a392b3..66959557cf39 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -282,12 +282,12 @@ ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
 static inline u64							\
 tmc_read_##name(struct tmc_drvdata *drvdata)				\
 {									\
-	return coresight_read_reg_pair(drvdata->base, lo_off, hi_off);	\
+	return csdev_access_relaxed_read_pair(&drvdata->csdev->access, lo_off, hi_off); \
 }									\
 static inline void							\
 tmc_write_##name(struct tmc_drvdata *drvdata, u64 val)			\
 {									\
-	coresight_write_reg_pair(drvdata->base, val, lo_off, hi_off);	\
+	csdev_access_relaxed_write_pair(&drvdata->csdev->access, val, lo_off, hi_off); \
 }
 
 TMC_REG_PAIR(rrp, TMC_RRP, TMC_RRPHI)
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a47dd1f62216..1554021231f9 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -373,21 +373,26 @@ static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
 }
 
 static inline u64 csdev_access_relaxed_read_pair(struct csdev_access *csa,
-						 s32 lo_offset, s32 hi_offset)
+						 u32 lo_offset, u32 hi_offset)
 {
-	u64 val;
-
 	if (likely(csa->io_mem)) {
-		val = readl_relaxed(csa->base + lo_offset);
-		val |= (hi_offset < 0) ? 0 :
-		       (u64)readl_relaxed(csa->base + hi_offset) << 32;
-		return val;
+		return readl_relaxed(csa->base + lo_offset) |
+			((u64)readl_relaxed(csa->base + hi_offset) << 32);
 	}
 
-	val = csa->read(lo_offset, true, false);
-	val |= (hi_offset < 0) ? 0 :
-	       (u64)csa->read(hi_offset, true, false) << 32;
-	return val;
+	return csa->read(lo_offset, true, false) | (csa->read(hi_offset, true, false) << 32);
+}
+
+static inline void csdev_access_relaxed_write_pair(struct csdev_access *csa, u64 val,
+						   u32 lo_offset, u32 hi_offset)
+{
+	if (likely(csa->io_mem)) {
+		writel_relaxed((u32)val, csa->base + lo_offset);
+		writel_relaxed((u32)(val >> 32), csa->base + hi_offset);
+	} else {
+		csa->write((u32)val, lo_offset, true, false);
+		csa->write((u32)(val >> 32), hi_offset, true, false);
+	}
 }
 
 static inline u32 csdev_access_read32(struct csdev_access *csa, u32 offset)
-- 
2.28.0

