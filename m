Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B18C46E9C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhLIOUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:20:34 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:61662 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238495AbhLIOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639059411; x=1670595411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xqJAJ9D7+IA8ZR9lL4oi9H+spKYV1MaDmW9XUuI/wcI=;
  b=zU+i/QhP63opHPDuE9hxautDSXmOcW+DPeY1mG25YbfKs2OHLuWjJp2W
   91FfBM9l3FW9QVD+eu6kZrVfpKjBU7FvHMND0qkZoW/FSfQvAb7iarN6Y
   sC9R9k7SL8iOP3eSRfll3kgUrCUzxh+duUdQ968MIBNDfxtBnJ3Wd3xO0
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Dec 2021 06:16:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:16:46 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:16:45 -0800
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:16:41 -0800
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
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 4/9] coresight-tpdm: Add DSB dataset support
Date:   Thu, 9 Dec 2021 22:15:38 +0800
Message-ID: <20211209141543.21314-5-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
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
 drivers/hwtracing/coresight/coresight-tpdm.c | 56 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h | 23 ++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index f494cef4fb24..c0dd216f70eb 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -20,6 +20,27 @@
 
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
@@ -31,6 +52,7 @@ static int tpdm_enable(struct coresight_device *csdev,
 		return -EBUSY;
 	}
 
+	_tpdm_enable(drvdata);
 	drvdata->enable = true;
 	mutex_unlock(&drvdata->lock);
 
@@ -38,6 +60,28 @@ static int tpdm_enable(struct coresight_device *csdev,
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
@@ -49,6 +93,7 @@ static void tpdm_disable(struct coresight_device *csdev,
 		return;
 	}
 
+	_tpdm_disable(drvdata);
 	drvdata->enable = false;
 	mutex_unlock(&drvdata->lock);
 
@@ -75,8 +120,19 @@ static const struct coresight_ops tpdm_cs_ops = {
 static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
 {
 	static int traceid = TPDM_TRACE_ID_START;
+	int i;
+	u32 pidr;
 
+	CS_UNLOCK(drvdata->base);
 	drvdata->traceid = traceid++;
+
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
index 980ae90ff1c8..ba99c20e12bb 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -8,6 +8,27 @@
 
 /* Default value of the traceid */
 #define TPDM_TRACE_ID_START 128
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
+ * PERIPHIDR0[0] : Fix to 1 if ImplDef subunit present, else 0.
+ *                 No TPDM supports ImplDef subunit now. But
+ *                 the first bit of PERIPHIDR0 is for ImplDef
+ *                 subunit for initial design.
+ * PERIPHIDR0[1] : Fix to 1 if DSB subunit present, else 0.
+ */
+enum tpdm_dataset {
+	TPDM_DS_IMPLDEF,
+	TPDM_DS_DSB,
+};
 
 /**
  * struct tpdm_drvdata - specifics associated to an TPDM component
@@ -16,6 +37,7 @@
  * @csdev:      component vitals needed by the framework.
  * @lock:       lock for the enable value.
  * @enable:     enable status of the component.
+ * @datasets:   The datasets types present of the TPDM.
  * @traceid:    value of the current ID for this component.
  */
 
@@ -25,6 +47,7 @@ struct tpdm_drvdata {
 	struct coresight_device	*csdev;
 	struct mutex		lock;
 	bool			enable;
+	DECLARE_BITMAP(datasets, TPDM_DATASETS);
 	int			traceid;
 };
 
-- 
2.17.1

