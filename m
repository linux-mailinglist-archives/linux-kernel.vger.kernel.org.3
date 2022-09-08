Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6645B177A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiIHIqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiIHIqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:46:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC5C112B1C;
        Thu,  8 Sep 2022 01:46:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28886TSd012827;
        Thu, 8 Sep 2022 08:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=idF65nlx3Gl7kiuuXMd0orvXjxoUFl/cl9yyLKSHMFQ=;
 b=gQ5D/1Ls5W/v/ajXne75F/+XKnnocEQVMdN319YzZ4Ci10Q3d8HA1NgQs3fa3WjHyllL
 +d+QsNRf6EGe8xu/8OLZ2VUKlswtWWAfV/SCIw3m4+UHnSDmSyf9E5+qIepHznIjiszr
 Dqs+lcvIVfXcaa/dVfY2+3aCrFCygvlOrQal09Sy2IeG4NLenlgQH3SHUsLFv/TgNwwH
 3Fm8sBgFHsGwTF5fF6RJldxsXD5Ihqt6SYu8Ikul5DHvv2NBzJJ6yLi0XcsYWRV6TRmA
 V3z4EYGpTrE3qywLiiB+NycThFQwoK4w4cx16pwjd2ObX6tPEKTaqwm4ZE4DFnci91m2 vQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfbarr9x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 08:45:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2888jv8p005826
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 08:45:57 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 8 Sep 2022 01:45:52 -0700
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
Subject: [PATCH 7/9] coresight-tpdm: Add nodes for dsb element creation
Date:   Thu, 8 Sep 2022 16:45:03 +0800
Message-ID: <1662626705-13097-8-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-GUID: HtnhOAnkvAYyRB6zO8ET6QjmfoO0kMlC
X-Proofpoint-ORIG-GUID: HtnhOAnkvAYyRB6zO8ET6QjmfoO0kMlC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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

Add the nodes to set value for DSB edge control and DSB edge
control mask. Each DSB subunit TPDM has n(n<16) EDCR resgisters
to configure edge control. And each DSB subunit TPDM has m(m<8)
ECDMR registers to configure edge control mask.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 130 ++++++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h |  11 +++
 2 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index 7265793..14bcf2b 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -22,7 +22,14 @@ DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
 
 static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
-	u32 val, mode;
+	u32 val, mode, i;
+
+	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
+		writel_relaxed(drvdata->dsb->edge_ctrl[i],
+			   drvdata->base + TPDM_DSB_EDCR(i));
+	for (i = 0; i < TPDM_DSB_MAX_EDCR / 2; i++)
+		writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
+			   drvdata->base + TPDM_DSB_EDCMR(i));
 
 	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
 	/* Set trigger timestamp */
@@ -278,6 +285,125 @@ static ssize_t dsb_mode_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_mode);
 
+static ssize_t dsb_edge_ctrl_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i;
+
+	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index:0x%x Val:0x%x\n", i,
+				  drvdata->dsb->edge_ctrl[i]);
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+
+/*
+ * value 1: Start EDCR register number
+ * value 2: End EDCR register number
+ * value 3: The value need to be written
+ */
+static ssize_t dsb_edge_ctrl_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long start, end, edge_ctrl;
+	uint32_t val;
+	int i, bit, reg;
+
+	if (sscanf(buf, "%lx %lx %lx", &start, &end, &edge_ctrl) != 3)
+		return -EINVAL;
+	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB) ||
+	    (start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES) ||
+	    edge_ctrl > 0x2)
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = start; i <= end; i++) {
+		reg = i / (NUM_OF_BITS / 2);
+		bit = i % (NUM_OF_BITS / 2);
+		bit = bit * 2;
+
+		val = drvdata->dsb->edge_ctrl[reg];
+		val = val & ~GENMASK((bit + 1), bit);
+		val = val | (edge_ctrl << bit);
+		drvdata->dsb->edge_ctrl[reg] = val;
+	}
+	spin_unlock(&drvdata->spinlock);
+
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_edge_ctrl);
+
+static ssize_t dsb_edge_ctrl_mask_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	ssize_t size = 0;
+	int i;
+
+	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = 0; i < TPDM_DSB_MAX_EDCR / 2; i++) {
+		size += scnprintf(buf + size, PAGE_SIZE - size,
+				  "Index:0x%x Val:0x%x\n", i,
+				  drvdata->dsb->edge_ctrl_mask[i]);
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+
+/*
+ * value 1: Start EDCMR register number
+ * value 2: End EDCMR register number
+ * value 3: The value need to be written
+ */
+static ssize_t dsb_edge_ctrl_mask_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf,
+					     size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long start, end, val;
+	u32 set;
+	int i, bit, reg;
+
+	if (sscanf(buf, "%lx %lx %lx", &start, &end, &val) != 3)
+		return -EINVAL;
+	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB) ||
+	    (start >= TPDM_DSB_MAX_LINES) || (end >= TPDM_DSB_MAX_LINES))
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	for (i = start; i <= end; i++) {
+		reg = i / NUM_OF_BITS;
+		bit = (i % NUM_OF_BITS);
+
+		set = drvdata->dsb->edge_ctrl_mask[reg];
+		if (val)
+			set = set | BIT(bit);
+		else
+			set = set & ~BIT(bit);
+		drvdata->dsb->edge_ctrl_mask[reg] = set;
+	}
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_edge_ctrl_mask);
+
 static ssize_t dsb_trig_type_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -359,6 +485,8 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
 static DEVICE_ATTR_RW(dsb_trig_ts);
 static struct attribute *tpdm_dsb_attrs[] = {
 	&dev_attr_dsb_mode.attr,
+	&dev_attr_dsb_edge_ctrl.attr,
+	&dev_attr_dsb_edge_ctrl_mask.attr,
 	&dev_attr_dsb_trig_ts.attr,
 	&dev_attr_dsb_trig_type.attr,
 	NULL,
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 4d57488..ed03c68 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -12,6 +12,8 @@
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 #define TPDM_DSB_TIER		(0x784)
+#define TPDM_DSB_EDCR(n)	(0x808 + (n * 4))
+#define TPDM_DSB_EDCMR(n)	(0x848 + (n * 4))
 
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
@@ -28,6 +30,8 @@
 #define TPDM_DSB_MODE_HPBYTESEL(val)	BMVAL(val, 4, 8)
 #define TPDM_MODE_ALL			(0xFFFFFFF)
 
+#define NUM_OF_BITS		32
+
 /* TPDM integration test registers */
 #define TPDM_ITATBCNTRL		(0xEF0)
 #define TPDM_ITCNTRL		(0xF00)
@@ -54,14 +58,21 @@
 #define TPDM_PIDR0_DS_IMPDEF	BIT(0)
 #define TPDM_PIDR0_DS_DSB	BIT(1)
 
+#define TPDM_DSB_MAX_EDCR	16
+#define TPDM_DSB_MAX_LINES	256
+
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
  * @mode:             DSB programming mode
+ * @edge_ctrl:        Save value for edge control
+ * @edge_ctrl_mask:   Save value for edge control mask
  * @trig_ts:          Enable/Disable trigger timestamp.
  * @trig_type:        Enable/Disable trigger type.
  */
 struct dsb_dataset {
 	u32				mode;
+	u32				edge_ctrl[TPDM_DSB_MAX_EDCR];
+	u32				edge_ctrl_mask[TPDM_DSB_MAX_EDCR / 2];
 	bool			trig_ts;
 	bool			trig_type;
 };
-- 
2.7.4

