Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5146E9C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhLIOU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:20:26 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:5079 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238488AbhLIOUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639059411; x=1670595411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=JFDQNbUNGiv4D/mPwv92UusMXXIWIjon/rOD7iJlQsY=;
  b=MPJE9ewf9iLi+vbqI48caOOZykP6HjfI/To+870Yxt3SxbMaP62QDH1W
   J6rTEbwCPsUOmmW5MZGNEKBsQV/o7WHo9OcTTzfOkNTwatCvUueRXiEZD
   tRcBy8+BCF06sls0dI1BJYUnxlFOzl9c+veWhKPXdkfvPtt/S5/VkSSJ1
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Dec 2021 06:16:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:16:50 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:16:50 -0800
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:16:46 -0800
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
Subject: [PATCH v2 5/9] coresight-tpdm: Add integration test support
Date:   Thu, 9 Dec 2021 22:15:39 +0800
Message-ID: <20211209141543.21314-6-quic_jinlmao@quicinc.com>
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
index c0dd216f70eb..891c3efaf30d 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -135,6 +135,59 @@ static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
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
@@ -167,6 +220,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.ops = &tpdm_cs_ops;
 	desc.pdata = adev->dev.platform_data;
 	desc.dev = &adev->dev;
+	desc.groups = tpdm_attr_grps;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index ba99c20e12bb..9929a26f0f0b 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -14,6 +14,14 @@
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

