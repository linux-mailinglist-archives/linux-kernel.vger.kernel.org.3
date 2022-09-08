Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBA75B1782
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiIHIqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiIHIqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:46:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8B1112B22;
        Thu,  8 Sep 2022 01:46:07 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28888C0b024758;
        Thu, 8 Sep 2022 08:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=jGGEtSWHjFnFX2ew1wLffltI1EMqhikMgXENfn87cRA=;
 b=QgdNtxahZGaPKZJUuWtaBnfZiObP4xrCEL8Fg2+DumKxkF7f9iSazTN0BK0/j2AUUwcp
 QzmxsxTbDgzXqbBZLO9LTTDoXoiJgvrmKnfwR9Yt+90aayI9HHPJ/0+YTl3NBkkJyzW+
 IzfaDbcwqlxraBHEQ1ugKkNsV2cKGPjp0eUIxVIe+ESaY8OGahCQ84hHf3miB36a5PN4
 kHXUjhf6R6mI6Oa974l+XXS43EZwTXnqnVUcjl+bYxnd5sFl6yINOQ3p5Di2d4NgBL6z
 l+koZIelnYbclxe2vqlcdD7w34Yjy6VXZBHRxbX8D39j4+PewO7qUiq4HrFgHh052Yxh mw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jer1x40g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 08:45:53 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2888jq3S011839
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 08:45:52 GMT
Received: from taozha-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 8 Sep 2022 01:45:48 -0700
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
Subject: [PATCH 6/9] coresight-tpdm: Add node to set dsb programming mode
Date:   Thu, 8 Sep 2022 16:45:02 +0800
Message-ID: <1662626705-13097-7-git-send-email-quic_taozha@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ZnnHmkl4EfPCRXwMLJ8CLvaDcxChnw0w
X-Proofpoint-GUID: ZnnHmkl4EfPCRXwMLJ8CLvaDcxChnw0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080031
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node to set and show programming mode for TPDM DSB subunit.
Once the DSB programming mode is set, it will be written to the
register DSB_CR. Bit[10:9] of the DSB_CR register is used to set
the DSB test mode.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 49 +++++++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h | 10 ++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index fae9963..7265793 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -22,7 +22,7 @@ DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
 
 static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 {
-	u32 val;
+	u32 val, mode;
 
 	val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
 	/* Set trigger timestamp */
@@ -42,6 +42,19 @@ static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
 
 	/* Set the enable bit of DSB control register to 1 */
 	val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
+	/* Set the cycle accurate mode */
+	mode = TPDM_DSB_MODE_CYCACC(drvdata->dsb->mode);
+	val = val & ~(0x7 << 9);
+	val = val | (mode << 9);
+	/* Set the byte lane for high-performance mode */
+	mode = TPDM_DSB_MODE_HPBYTESEL(drvdata->dsb->mode);
+	val = val & ~(0x1F << 2);
+	val = val | (mode << 2);
+	/* Set the performance mode */
+	if (drvdata->dsb->mode & TPDM_DSB_MODE_PERF)
+		val |= TPDM_DSB_MODE;
+	else
+		val &= ~TPDM_DSB_MODE;
 	val |= TPDM_DSB_CR_ENA;
 	writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
 }
@@ -232,6 +245,39 @@ static struct attribute_group tpdm_attr_grp = {
 	.attrs = tpdm_attrs,
 };
 
+static ssize_t dsb_mode_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
+		return -EPERM;
+
+	return scnprintf(buf, PAGE_SIZE, "%lx\n",
+			 (unsigned long)drvdata->dsb->mode);
+}
+
+static ssize_t dsb_mode_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t size)
+{
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	unsigned long val;
+
+	if ((kstrtoul(buf, 16, &val)) || val < 0 || val > 3)
+		return -EINVAL;
+	if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
+		return -EPERM;
+
+	spin_lock(&drvdata->spinlock);
+	drvdata->dsb->mode = val & TPDM_MODE_ALL;
+	spin_unlock(&drvdata->spinlock);
+	return size;
+}
+static DEVICE_ATTR_RW(dsb_mode);
+
 static ssize_t dsb_trig_type_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
@@ -312,6 +358,7 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(dsb_trig_ts);
 static struct attribute *tpdm_dsb_attrs[] = {
+	&dev_attr_dsb_mode.attr,
 	&dev_attr_dsb_trig_ts.attr,
 	&dev_attr_dsb_trig_type.attr,
 	NULL,
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index dd4a013..4d57488 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -19,6 +19,14 @@
 #define TPDM_DSB_XTRIG_TSENAB		BIT(1)
 /* Enable bit for DSB subunit trigger type */
 #define TPDM_DSB_TRIG_TYPE		BIT(12)
+/* Enable bit for DSB subunit perfmance mode */
+#define TPDM_DSB_MODE		BIT(1)
+
+/* DSB programming modes */
+#define TPDM_DSB_MODE_CYCACC(val)	BMVAL(val, 0, 2)
+#define TPDM_DSB_MODE_PERF		BIT(3)
+#define TPDM_DSB_MODE_HPBYTESEL(val)	BMVAL(val, 4, 8)
+#define TPDM_MODE_ALL			(0xFFFFFFF)
 
 /* TPDM integration test registers */
 #define TPDM_ITATBCNTRL		(0xEF0)
@@ -48,10 +56,12 @@
 
 /**
  * struct dsb_dataset - specifics associated to dsb dataset
+ * @mode:             DSB programming mode
  * @trig_ts:          Enable/Disable trigger timestamp.
  * @trig_type:        Enable/Disable trigger type.
  */
 struct dsb_dataset {
+	u32				mode;
 	bool			trig_ts;
 	bool			trig_type;
 };
-- 
2.7.4

