Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF3F4AF078
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiBIL7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiBIL5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:57:40 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F142E00FA7C;
        Wed,  9 Feb 2022 02:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644404273; x=1675940273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=GQGuZH7SiS8ReJf4+zubvdcuYL906X+zATeXTViK31E=;
  b=c5E1CFgD3HLwaNV1LB+j5rvq5rkuwsPxPbgLMqn1y+57HkAcyhpHi5Dn
   UK58d0r8vr9Dg2neiSySMU8KHEvdmHmD/Sb8R1yw+YIn4OG5tfKUUHK5N
   ySgJFaGqAz/+a0YtvG9esas2uC9cm5JgWwc3g/RFRCmJm9p1Cfa58Tcfu
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Feb 2022 02:57:53 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 02:57:53 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 02:57:52 -0800
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 02:57:48 -0800
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
Subject: [PATCH v3 06/10] coresight-tpdm: Add integration test support
Date:   Wed, 9 Feb 2022 18:57:02 +0800
Message-ID: <20220209105706.18852-7-quic_jinlmao@quicinc.com>
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

Integration test for tpdm can help to generate the data for
verification of the topology during TPDM software bring up.

Sample:
echo 1 > /sys/bus/coresight/devices/tmc_etf0/enable_sink
echo 1 > /sys/bus/coresight/devices/tpdm1/enable_source
echo 1 > /sys/bus/coresight/devices/tpdm1/integration_test
echo 2 > /sys/bus/coresight/devices/tpdm1/integration_test
cat /dev/tmc_etf0 > /data/etf-tpdm1.bin

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/Kconfig          |  9 ++++
 drivers/hwtracing/coresight/coresight-tpdm.c | 54 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h |  8 +++
 3 files changed, 71 insertions(+)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 5c506a1cd08f..60248fef4089 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -214,4 +214,13 @@ config CORESIGHT_TPDM
 	  To compile this driver as a module, choose M here: the module will be
 	  called coresight-tpdm.
 
+config CORESIGHT_TPDM_INTEGRATION_TEST
+	bool "Enable CoreSight Integration Test For TPDM"
+	depends on CORESIGHT_TPDM
+	help
+	  This option adds support for the CoreSight integration test on this
+	  devie. Coresight architecture provides integration control modes of
+	  operation to facilitate integration testing and software bringup
+	  and/or to instrument topology discovery. The TPDM utilizes integration
+	  mode to accomplish integration testing and software bringup.
 endif
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index c6480b7389b0..7a2b9097b470 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -136,6 +136,59 @@ static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+#ifdef CONFIG_CORESIGHT_TPDM_INTEGRATION_TEST
+static ssize_t integration_test_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf,
+					  size_t size)
+{
+	int i, ret = 0;
+	unsigned long val;
+	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val != 1 && val != 2)
+		return -EINVAL;
+
+	if (!drvdata->enable)
+		return -EINVAL;
+
+	if (val == 1)
+		val = ATBCNTRL_VAL_64;
+	else
+		val = ATBCNTRL_VAL_32;
+	CS_UNLOCK(drvdata->base);
+	writel_relaxed(0x1, drvdata->base + TPDM_ITCNTRL);
+
+	for (i = 1; i < 5; i++)
+		writel_relaxed(val, drvdata->base + TPDM_ITATBCNTRL);
+
+	writel_relaxed(0, drvdata->base + TPDM_ITCNTRL);
+	CS_LOCK(drvdata->base);
+	return size;
+}
+static DEVICE_ATTR_WO(integration_test);
+#endif /* CORESIGHT_TPDM_INTEGRATION_TEST */
+
+static struct attribute *tpdm_attrs[] = {
+#ifdef CONFIG_CORESIGHT_TPDM_INTEGRATION_TEST
+	&dev_attr_integration_test.attr,
+#endif /* CORESIGHT_TPDM_INTEGRATION_TEST */
+	NULL,
+};
+
+static struct attribute_group tpdm_attr_grp = {
+	.attrs = tpdm_attrs,
+};
+
+static const struct attribute_group *tpdm_attr_grps[] = {
+	&tpdm_attr_grp,
+	NULL,
+};
+
 static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
@@ -171,6 +224,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &tpdm_cs_ops;
 	desc.pdata = adev->dev.platform_data;
 	desc.dev = &adev->dev;
+	desc.groups = tpdm_attr_grps;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index cb3ddc6c89ae..128fcff37192 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -12,6 +12,14 @@
 /* DSB Subunit Registers */
 #define TPDM_DSB_CR		(0x780)
 
+/* TPDM integration test registers */
+#define TPDM_ITATBCNTRL		(0xEF0)
+#define TPDM_ITCNTRL		(0xF00)
+
+/* Register value for integration test */
+#define ATBCNTRL_VAL_32		0xC00F1409
+#define ATBCNTRL_VAL_64		0xC01F1409
+
 /**
  * This enum is for PERIPHIDR0 register of TPDM.
  * The fields [6:0] of PERIPHIDR0 are used to determine what
-- 
2.17.1

