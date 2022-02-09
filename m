Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4CA4AF076
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiBIL7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiBIL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:57:40 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067E5E00F7FE;
        Wed,  9 Feb 2022 02:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644404270; x=1675940270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ymNRMu+gBg6OvkS+IUc6XUhPjfMnKryjA5CxUcBOeo4=;
  b=Zu4T1MolecHXeH66vnXyXAhPN0usKP7zGGfdbOhOnAuoyYk+VdYGMWyX
   xsT8FJQ/YJbytFrP/JPQcKDC9EskpbhinQQ9pAE/XRxa73rzCvJijT+qD
   V/pCx3ifOCH2JpzUXyzNx/YOrd9KFgCJhaW2FAFa+6B7e+wxORBo2ntkx
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 09 Feb 2022 02:57:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 02:57:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 02:57:48 -0800
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 02:57:45 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v3 05/10] coresight-tpdm: Add DSB dataset support
Date:   Wed, 9 Feb 2022 18:57:01 +0800
Message-ID: <20220209105706.18852-6-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209105706.18852-1-quic_jinlmao@quicinc.com>
References: <20220209105706.18852-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPDM serves as data collection component for various dataset types.
DSB(Discrete Single Bit) is one of the dataset types. DSB subunit
can be enabled for data collection by writing 1 to the first bit of
DSB_CR register. This change is to add enable/disable function for
DSB dataset by writing DSB_CR register.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 57 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h | 21 ++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 51b8b17e6a80..c6480b7389b0 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -20,7 +20,28 @@
 
 DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
 
+static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
+{
+	u32 val;
+
+	/* Set the enable bit of DSB control register to 1 */
+	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+	val = val | BIT(0);
+	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
+}
+
 /** TPDM enable operations **/
+static void _tpdm_enable(struct tpdm_drvdata *drvdata)
+{
+	CS_UNLOCK(drvdata->base);
+
+	/* Check if DSB datasets is present for TPDM. */
+	if (test_bit(TPDM_DS_DSB, drvdata->datasets))
+		tpdm_enable_dsb(drvdata);
+
+	CS_LOCK(drvdata->base);
+}
+
 static int tpdm_enable(struct coresight_device *csdev,
 		       struct perf_event *event, u32 mode)
 {
@@ -32,6 +53,7 @@ static int tpdm_enable(struct coresight_device *csdev,
 		return -EBUSY;
 	}
 
+	_tpdm_enable(drvdata);
 	drvdata->enable = true;
 	mutex_unlock(&drvdata->lock);
 
@@ -39,7 +61,29 @@ static int tpdm_enable(struct coresight_device *csdev,
 	return 0;
 }
 
+static void tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
+{
+	u32 val;
+
+	/* Set the enable bit of DSB control register to 0 */
+	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+	val = val & ~BIT(0);
+	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
+}
+
 /** TPDM disable operations **/
+static void _tpdm_disable(struct tpdm_drvdata *drvdata)
+{
+	CS_UNLOCK(drvdata->base);
+
+	/* Check if DSB datasets is present for TPDM. */
+	if (test_bit(TPDM_DS_DSB, drvdata->datasets))
+		tpdm_disable_dsb(drvdata);
+
+	CS_LOCK(drvdata->base);
+
+}
+
 static void tpdm_disable(struct coresight_device *csdev,
 			 struct perf_event *event)
 {
@@ -51,6 +95,7 @@ static void tpdm_disable(struct coresight_device *csdev,
 		return;
 	}
 
+	_tpdm_disable(drvdata);
 	drvdata->enable = false;
 	mutex_unlock(&drvdata->lock);
 
@@ -76,7 +121,19 @@ static const struct coresight_ops tpdm_cs_ops = {
 
 static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
 {
+	int i;
+	u32 pidr;
+
 	drvdata->traceid = coresight_get_system_trace_id();
+
+	CS_UNLOCK(drvdata->base);
+	/*  Get the datasets present on the TPDM. */
+	pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
+	for (i = 0; i < TPDM_DATASETS; i++) {
+		if (pidr & BIT(i))
+			__set_bit(i, drvdata->datasets);
+	}
+	CS_LOCK(drvdata->base);
 }
 
 static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 2effbabf349b..cb3ddc6c89ae 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -6,6 +6,25 @@
 #ifndef _CORESIGHT_CORESIGHT_TPDM_H
 #define _CORESIGHT_CORESIGHT_TPDM_H
 
+/* The max number of the datasets that TPDM supports */
+#define TPDM_DATASETS       7
+
+/* DSB Subunit Registers */
+#define TPDM_DSB_CR		(0x780)
+
+/**
+ * This enum is for PERIPHIDR0 register of TPDM.
+ * The fields [6:0] of PERIPHIDR0 are used to determine what
+ * interfaces and subunits are present on a given TPDM.
+ *
+ * PERIPHIDR0[0] : Fix to 1 if ImplDef subunit present, else 0
+ * PERIPHIDR0[1] : Fix to 1 if DSB subunit present, else 0
+ */
+enum tpdm_dataset {
+	TPDM_DS_IMPLDEF,
+	TPDM_DS_DSB,
+};
+
 /**
  * struct tpdm_drvdata - specifics associated to an TPDM component
  * @base:       memory mapped base address for this component.
@@ -13,6 +32,7 @@
  * @csdev:      component vitals needed by the framework.
  * @lock:       lock for the enable value.
  * @enable:     enable status of the component.
+ * @datasets:   The datasets types present of the TPDM.
  * @traceid:    value of the current ID for this component.
  */
 
@@ -22,6 +42,7 @@ struct tpdm_drvdata {
 	struct coresight_device	*csdev;
 	struct mutex		lock;
 	bool			enable;
+	DECLARE_BITMAP(datasets, TPDM_DATASETS);
 	int			traceid;
 };
 
-- 
2.17.1

