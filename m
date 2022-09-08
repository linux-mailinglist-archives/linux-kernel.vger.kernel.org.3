Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ACF5B1781
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiIHIqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiIHIqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:46:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61A7CCE25;
        Thu,  8 Sep 2022 01:46:01 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2888DbXR022907;
        Thu, 8 Sep 2022 08:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=73EjnsCZ78Zdk6uVtIKUnlajdlFC2YgWuoFYXwb4o4g=;
 b=LJ0VjbgvtOv0GP6IPLBznaC0Bvk/NP7LTRSxL6StXDp6Zr962rux/HEKyJTpwmfJsJmi
 4SgiJ/rIAh1lIBqiksd45a4bKYjOSwNaz8JnopMLkA+ifDnK+MeTIb7pX2M/mIFZa2re
 K5suVU310EAl1dHUV4DjhaK2Fj1yXp1kYpZXovbTOFYO20rEljiYl/t1FjumGAURSXjO
 uVhl6rzLk4ax4SDskF2lqKfnAehPefrOWIdVbrXsQnludKRIrruON5i1wNnalBhD8bZW
 ah8P1i9VAtyqH0EM5UlBrf7UCul8nF+2ug6k+2R5xBxuHAt3HHBjLbeSQ+zftH82JfjY qQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfcpbr1tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 08:45:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2888jdCu015210
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 08:45:39 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 8 Sep 2022 01:45:35 -0700
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Tao Zhang <quic_taozha@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>
Subject: [PATCH 3/9] coresight-tpdm: Initialize DSB subunit configuration
Date:   Thu, 8 Sep 2022 16:44:59 +0800
Message-ID: <1662626705-13097-4-git-send-email-quic_taozha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662626705-13097-1-git-send-email-quic_taozha@quicinc.com>
References: <1662626705-13097-1-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fTq9OLnM6kLT8mNaukLs5SO_fYudxoZC
X-Proofpoint-GUID: fTq9OLnM6kLT8mNaukLs5SO_fYudxoZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080031
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSB subunit need to be configured in enablement and disablement.
A struct that specifics associated to dsb dataset is needed. It
saves the configuration and parameters of the dsb datasets. This
change is to add this struct and initialize the configuration of
DSB subunit.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 44 ++++++++++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tpdm.h | 17 +++++++++++
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 88df3e6..69ea453 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -24,6 +24,22 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
 	u32 val;
 
+	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
+	/* Set trigger timestamp */
+	if (drvdata->dsb->trig_ts)
+		val |= TPDM_DSB_XTRIG_TSENAB;
+	else
+		val &= ~TPDM_DSB_XTRIG_TSENAB;
+	writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
+
+	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+	/* Set trigger type */
+	if (drvdata->dsb->trig_type)
+		val |= TPDM_DSB_TRIG_TYPE;
+	else
+		val &= ~TPDM_DSB_TRIG_TYPE;
+	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
+
 	/* Set the enable bit of DSB control register to 1 */
 	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
 	val |= TPDM_DSB_CR_ENA;
@@ -110,15 +126,30 @@ static const struct coresight_ops tpdm_cs_ops = {
 	.source_ops	= &tpdm_source_ops,
 };
 
-static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
+static int tpdm_datasets_alloc(struct tpdm_drvdata *drvdata)
 {
 	u32 pidr;
 
-	CS_UNLOCK(drvdata->base);
 	/*  Get the datasets present on the TPDM. */
 	pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
 	drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
-	CS_LOCK(drvdata->base);
+
+	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
+		drvdata->dsb = devm_kzalloc(drvdata->dev, sizeof(*drvdata->dsb),
+					    GFP_KERNEL);
+		if (!drvdata->dsb)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
+{
+	if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
+		drvdata->dsb->trig_ts = true;
+		drvdata->dsb->trig_type = false;
+	}
 }
 
 /*
@@ -181,6 +212,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct coresight_platform_data *pdata;
 	struct tpdm_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
+	int ret;
 
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
@@ -216,7 +248,13 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(drvdata->csdev);
 
 	spin_lock_init(&drvdata->spinlock);
+	ret = tpdm_datasets_alloc(drvdata);
+	if (ret) {
+		coresight_unregister(drvdata->csdev);
+		return ret;
+	}
 	tpdm_init_default_data(drvdata);
+
 	/* Decrease pm refcount when probe is done.*/
 	pm_runtime_put(&adev->dev);
 
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index d808fa1..dd4a013 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -11,8 +11,14 @@
 
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
+#define TPDM_DSB_TIER		(0x784)
+
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
+/* Enable bit for DSB subunit trigger timestamp */
+#define TPDM_DSB_XTRIG_TSENAB		BIT(1)
+/* Enable bit for DSB subunit trigger type */
+#define TPDM_DSB_TRIG_TYPE		BIT(12)
 
 /* TPDM integration test registers */
 #define TPDM_ITATBCNTRL		(0xEF0)
@@ -41,6 +47,16 @@
 #define TPDM_PIDR0_DS_DSB	BIT(1)
 
 /**
+ * struct dsb_dataset - specifics associated to dsb dataset
+ * @trig_ts:          Enable/Disable trigger timestamp.
+ * @trig_type:        Enable/Disable trigger type.
+ */
+struct dsb_dataset {
+	bool			trig_ts;
+	bool			trig_type;
+};
+
+/**
  * struct tpdm_drvdata - specifics associated to an TPDM component
  * @base:       memory mapped base address for this component.
  * @dev:        The device entity associated to this component.
@@ -57,6 +73,7 @@ struct tpdm_drvdata {
 	spinlock_t		spinlock;
 	bool			enable;
 	unsigned long		datasets;
+	struct dsb_dataset	*dsb;
 };
 
 #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
-- 
2.7.4

