Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFC25A6AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiH3RcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiH3Rbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:31:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CC4E15A205
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:28:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AC9B1570;
        Tue, 30 Aug 2022 10:26:52 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.15.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB1563F7B4;
        Tue, 30 Aug 2022 10:26:43 -0700 (PDT)
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
Subject: [PATCH v2 4/5] coresight: cti-sysfs: Re-use same functions for similar sysfs register accessors
Date:   Tue, 30 Aug 2022 18:26:12 +0100
Message-Id: <20220830172614.340962-5-james.clark@arm.com>
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

Currently each accessor macro creates an identical function which wastes
space in the text area and pollutes the ftrace function name list.
Change it so that the same function is used, but the register to access
is passed in as parameter rather than baked into each function.

Note that only the single accessor is used here and not
csdev_access_relaxed_read_pair() like in the previous commit, so
so a single unsigned offset value is stored instead.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../hwtracing/coresight/coresight-cti-sysfs.c | 213 +++++++-----------
 drivers/hwtracing/coresight/coresight-priv.h  |   5 +
 2 files changed, 91 insertions(+), 127 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index 7ff7e7780bbf..478b8d38b744 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -163,48 +163,82 @@ static struct attribute *coresight_cti_attrs[] = {
 
 /* register based attributes */
 
-/* macro to access RO registers with power check only (no enable check). */
-#define coresight_cti_reg(name, offset)			\
-static ssize_t name##_show(struct device *dev,				\
-			   struct device_attribute *attr, char *buf)	\
-{									\
-	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);	\
-	u32 val = 0;							\
-	pm_runtime_get_sync(dev->parent);				\
-	spin_lock(&drvdata->spinlock);					\
-	if (drvdata->config.hw_powered)					\
-		val = readl_relaxed(drvdata->base + offset);		\
-	spin_unlock(&drvdata->spinlock);				\
-	pm_runtime_put_sync(dev->parent);				\
-	return sprintf(buf, "0x%x\n", val);				\
-}									\
-static DEVICE_ATTR_RO(name)
+/* Read registers with power check only (no enable check). */
+static ssize_t coresight_cti_reg_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct cs_off_attribute *cti_attr = container_of(attr, struct cs_off_attribute, attr);
+	u32 val = 0;
 
-/* coresight management registers */
-coresight_cti_reg(devaff0, CTIDEVAFF0);
-coresight_cti_reg(devaff1, CTIDEVAFF1);
-coresight_cti_reg(authstatus, CORESIGHT_AUTHSTATUS);
-coresight_cti_reg(devarch, CORESIGHT_DEVARCH);
-coresight_cti_reg(devid, CORESIGHT_DEVID);
-coresight_cti_reg(devtype, CORESIGHT_DEVTYPE);
-coresight_cti_reg(pidr0, CORESIGHT_PERIPHIDR0);
-coresight_cti_reg(pidr1, CORESIGHT_PERIPHIDR1);
-coresight_cti_reg(pidr2, CORESIGHT_PERIPHIDR2);
-coresight_cti_reg(pidr3, CORESIGHT_PERIPHIDR3);
-coresight_cti_reg(pidr4, CORESIGHT_PERIPHIDR4);
+	pm_runtime_get_sync(dev->parent);
+	spin_lock(&drvdata->spinlock);
+	if (drvdata->config.hw_powered)
+		val = readl_relaxed(drvdata->base + cti_attr->off);
+	spin_unlock(&drvdata->spinlock);
+	pm_runtime_put_sync(dev->parent);
+	return sysfs_emit(buf, "0x%x\n", val);
+}
+
+/* Write registers with power check only (no enable check). */
+static ssize_t coresight_cti_reg_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t size)
+{
+	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct cs_off_attribute *cti_attr = container_of(attr, struct cs_off_attribute, attr);
+	unsigned long val = 0;
+
+	if (kstrtoul(buf, 0, &val))
+		return -EINVAL;
 
+	pm_runtime_get_sync(dev->parent);
+	spin_lock(&drvdata->spinlock);
+	if (drvdata->config.hw_powered)
+		cti_write_single_reg(drvdata, cti_attr->off, val);
+	spin_unlock(&drvdata->spinlock);
+	pm_runtime_put_sync(dev->parent);
+	return size;
+}
+
+#define coresight_cti_reg(name, offset)					\
+	(&((struct cs_off_attribute[]) {				\
+	   {								\
+		__ATTR(name, 0444, coresight_cti_reg_show, NULL),	\
+		offset							\
+	   }								\
+	})[0].attr.attr)
+
+#define coresight_cti_reg_rw(name, offset)				\
+	(&((struct cs_off_attribute[]) {				\
+	   {								\
+		__ATTR(name, 0644, coresight_cti_reg_show,		\
+		       coresight_cti_reg_store),			\
+		offset							\
+	   }								\
+	})[0].attr.attr)
+
+#define coresight_cti_reg_wo(name, offset)				\
+	(&((struct cs_off_attribute[]) {				\
+	   {								\
+		__ATTR(name, 0200, NULL, coresight_cti_reg_store),	\
+		offset							\
+	   }								\
+	})[0].attr.attr)
+
+/* coresight management registers */
 static struct attribute *coresight_cti_mgmt_attrs[] = {
-	&dev_attr_devaff0.attr,
-	&dev_attr_devaff1.attr,
-	&dev_attr_authstatus.attr,
-	&dev_attr_devarch.attr,
-	&dev_attr_devid.attr,
-	&dev_attr_devtype.attr,
-	&dev_attr_pidr0.attr,
-	&dev_attr_pidr1.attr,
-	&dev_attr_pidr2.attr,
-	&dev_attr_pidr3.attr,
-	&dev_attr_pidr4.attr,
+	coresight_cti_reg(devaff0, CTIDEVAFF0),
+	coresight_cti_reg(devaff1, CTIDEVAFF1),
+	coresight_cti_reg(authstatus, CORESIGHT_AUTHSTATUS),
+	coresight_cti_reg(devarch, CORESIGHT_DEVARCH),
+	coresight_cti_reg(devid, CORESIGHT_DEVID),
+	coresight_cti_reg(devtype, CORESIGHT_DEVTYPE),
+	coresight_cti_reg(pidr0, CORESIGHT_PERIPHIDR0),
+	coresight_cti_reg(pidr1, CORESIGHT_PERIPHIDR1),
+	coresight_cti_reg(pidr2, CORESIGHT_PERIPHIDR2),
+	coresight_cti_reg(pidr3, CORESIGHT_PERIPHIDR3),
+	coresight_cti_reg(pidr4, CORESIGHT_PERIPHIDR4),
 	NULL,
 };
 
@@ -454,86 +488,11 @@ static ssize_t apppulse_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(apppulse);
 
-coresight_cti_reg(triginstatus, CTITRIGINSTATUS);
-coresight_cti_reg(trigoutstatus, CTITRIGOUTSTATUS);
-coresight_cti_reg(chinstatus, CTICHINSTATUS);
-coresight_cti_reg(choutstatus, CTICHOUTSTATUS);
-
 /*
  * Define CONFIG_CORESIGHT_CTI_INTEGRATION_REGS to enable the access to the
  * integration control registers. Normally only used to investigate connection
  * data.
  */
-#ifdef CONFIG_CORESIGHT_CTI_INTEGRATION_REGS
-
-/* macro to access RW registers with power check only (no enable check). */
-#define coresight_cti_reg_rw(name, offset)				\
-static ssize_t name##_show(struct device *dev,				\
-			   struct device_attribute *attr, char *buf)	\
-{									\
-	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);	\
-	u32 val = 0;							\
-	pm_runtime_get_sync(dev->parent);				\
-	spin_lock(&drvdata->spinlock);					\
-	if (drvdata->config.hw_powered)					\
-		val = readl_relaxed(drvdata->base + offset);		\
-	spin_unlock(&drvdata->spinlock);				\
-	pm_runtime_put_sync(dev->parent);				\
-	return sprintf(buf, "0x%x\n", val);				\
-}									\
-									\
-static ssize_t name##_store(struct device *dev,				\
-			    struct device_attribute *attr,		\
-			    const char *buf, size_t size)		\
-{									\
-	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);	\
-	unsigned long val = 0;						\
-	if (kstrtoul(buf, 0, &val))					\
-		return -EINVAL;						\
-									\
-	pm_runtime_get_sync(dev->parent);				\
-	spin_lock(&drvdata->spinlock);					\
-	if (drvdata->config.hw_powered)					\
-		cti_write_single_reg(drvdata, offset, val);		\
-	spin_unlock(&drvdata->spinlock);				\
-	pm_runtime_put_sync(dev->parent);				\
-	return size;							\
-}									\
-static DEVICE_ATTR_RW(name)
-
-/* macro to access WO registers with power check only (no enable check). */
-#define coresight_cti_reg_wo(name, offset)				\
-static ssize_t name##_store(struct device *dev,				\
-			    struct device_attribute *attr,		\
-			    const char *buf, size_t size)		\
-{									\
-	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);	\
-	unsigned long val = 0;						\
-	if (kstrtoul(buf, 0, &val))					\
-		return -EINVAL;						\
-									\
-	pm_runtime_get_sync(dev->parent);				\
-	spin_lock(&drvdata->spinlock);					\
-	if (drvdata->config.hw_powered)					\
-		cti_write_single_reg(drvdata, offset, val);		\
-	spin_unlock(&drvdata->spinlock);				\
-	pm_runtime_put_sync(dev->parent);				\
-	return size;							\
-}									\
-static DEVICE_ATTR_WO(name)
-
-coresight_cti_reg_rw(itchout, ITCHOUT);
-coresight_cti_reg_rw(ittrigout, ITTRIGOUT);
-coresight_cti_reg_rw(itctrl, CORESIGHT_ITCTRL);
-coresight_cti_reg_wo(itchinack, ITCHINACK);
-coresight_cti_reg_wo(ittriginack, ITTRIGINACK);
-coresight_cti_reg(ittrigin, ITTRIGIN);
-coresight_cti_reg(itchin, ITCHIN);
-coresight_cti_reg(itchoutack, ITCHOUTACK);
-coresight_cti_reg(ittrigoutack, ITTRIGOUTACK);
-
-#endif /* CORESIGHT_CTI_INTEGRATION_REGS */
-
 static struct attribute *coresight_cti_regs_attrs[] = {
 	&dev_attr_inout_sel.attr,
 	&dev_attr_inen.attr,
@@ -544,20 +503,20 @@ static struct attribute *coresight_cti_regs_attrs[] = {
 	&dev_attr_appset.attr,
 	&dev_attr_appclear.attr,
 	&dev_attr_apppulse.attr,
-	&dev_attr_triginstatus.attr,
-	&dev_attr_trigoutstatus.attr,
-	&dev_attr_chinstatus.attr,
-	&dev_attr_choutstatus.attr,
+	coresight_cti_reg(triginstatus, CTITRIGINSTATUS),
+	coresight_cti_reg(trigoutstatus, CTITRIGOUTSTATUS),
+	coresight_cti_reg(chinstatus, CTICHINSTATUS),
+	coresight_cti_reg(choutstatus, CTICHOUTSTATUS),
 #ifdef CONFIG_CORESIGHT_CTI_INTEGRATION_REGS
-	&dev_attr_itctrl.attr,
-	&dev_attr_ittrigin.attr,
-	&dev_attr_itchin.attr,
-	&dev_attr_ittrigout.attr,
-	&dev_attr_itchout.attr,
-	&dev_attr_itchoutack.attr,
-	&dev_attr_ittrigoutack.attr,
-	&dev_attr_ittriginack.attr,
-	&dev_attr_itchinack.attr,
+	coresight_cti_reg_rw(itctrl, CORESIGHT_ITCTRL),
+	coresight_cti_reg(ittrigin, ITTRIGIN),
+	coresight_cti_reg(itchin, ITCHIN),
+	coresight_cti_reg_rw(ittrigout, ITTRIGOUT),
+	coresight_cti_reg_rw(itchout, ITCHOUT),
+	coresight_cti_reg(itchoutack, ITCHOUTACK),
+	coresight_cti_reg(ittrigoutack, ITTRIGOUTACK),
+	coresight_cti_reg_wo(ittriginack, ITTRIGINACK),
+	coresight_cti_reg_wo(itchinack, ITCHINACK),
 #endif
 	NULL,
 };
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 07b392bfdbcd..c211979deca5 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -45,6 +45,11 @@ struct cs_pair_attribute {
 	s32 hi_off;
 };
 
+struct cs_off_attribute {
+	struct device_attribute attr;
+	u32 off;
+};
+
 extern ssize_t coresight_simple_show(struct device *_dev,
 				     struct device_attribute *attr, char *buf);
 
-- 
2.28.0

