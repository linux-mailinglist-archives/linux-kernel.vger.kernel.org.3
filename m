Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257524E630F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346313AbiCXMUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350011AbiCXMT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:19:57 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF0E3527F;
        Thu, 24 Mar 2022 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648124305; x=1679660305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=bRE+Ab5YMWO80f3DaqTD7qsKRNbNmc8wrd2moP+yiZY=;
  b=n7APnF9K+h70xkdGVFXd1dIcXMFcOTgDvbYdFsuVQadBLtgA789XdTAw
   TCKrARFfmCGFBKEPq7ElG85dSsMYa2XBT/bgueBVnk8UKffsSI4iXG8OV
   VL+n3IQNMUBJS+ifi2srhJKwMBxvjxnzLF5RO2HzkjI9CQU8BDvyv7Dkn
   E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 Mar 2022 05:18:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 05:18:24 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 05:18:23 -0700
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 24 Mar 2022 05:18:19 -0700
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
Subject: [PATCH v4 05/10] coresight-tpdm: Add integration test support
Date:   Thu, 24 Mar 2022 20:17:29 +0800
Message-ID: <20220324121734.21531-6-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
References: <20220324121734.21531-1-quic_jinlmao@quicinc.com>
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
 drivers/hwtracing/coresight/coresight-tpdm.c | 56 +++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tpdm.h |  8 +++
 3 files changed, 72 insertions(+), 1 deletion(-)

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
index a8d257a591f3..cddd398be0cd 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -124,7 +124,60 @@ static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
 			__set_bit(i, drvdata->datasets);
 	}
 	CS_LOCK(drvdata->base);
- }
+}
+
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
 
 static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 {
@@ -160,6 +213,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &tpdm_cs_ops;
 	desc.pdata = adev->dev.platform_data;
 	desc.dev = &adev->dev;
+	desc.groups = tpdm_attr_grps;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index 0a410795dce9..e4adcbbb10b5 100644
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

