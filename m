Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDC156CC4A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 04:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiGJCLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 22:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGJCLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 22:11:15 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2485511C39;
        Sat,  9 Jul 2022 19:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657419072; x=1688955072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=MxyM0o2eLOBazm2JLW2lNg1LtENWOU935EjXwlfpRIw=;
  b=KwWKY+RwDVvCdrNHP58M2p3chSx/VB1v2G7FTzjCyjMzTx0XB2IlMade
   TbgX4jyCY11HE6kZEd65RZV65T6RjKOSs27VyATPW1SgTIWfHGbZvaklh
   bsGqE+DYujIkdRhncIo/azitIRLJq/phMkBALEj3tWGbQKivUx2Wd8G4k
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Jul 2022 19:11:11 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 19:11:11 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 9 Jul 2022 19:11:11 -0700
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 9 Jul 2022 19:11:07 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
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
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v12 5/9] coresight-tpdm: Add integration test support
Date:   Sun, 10 Jul 2022 10:10:28 +0800
Message-ID: <20220710021032.27455-6-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220710021032.27455-1-quic_jinlmao@quicinc.com>
References: <20220710021032.27455-1-quic_jinlmao@quicinc.com>
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
echo 1 > /sys/bus/coresight/devices/tpdm0/enable_source
echo 1 > /sys/bus/coresight/devices/tpdm0/integration_test
echo 2 > /sys/bus/coresight/devices/tpdm0/integration_test
cat /dev/tmc_etf0 > /data/etf-tpdm0.bin

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 .../testing/sysfs-bus-coresight-devices-tpdm  | 13 +++++
 drivers/hwtracing/coresight/coresight-tpdm.c  | 54 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tpdm.h  | 14 +++++
 3 files changed, 81 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
new file mode 100644
index 000000000000..e1c2b5a59cb4
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
@@ -0,0 +1,13 @@
+What:		/sys/bus/coresight/devices/<tpdm-name>/integration_test
+Date:		June 2022
+KernelVersion	5.20
+Contact:	Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_taozha@quicinc.com>
+Description:
+		(Write) Run integration test for tpdm. Integration test
+		will generate test data for tpdm. It can help to make
+		sure that the trace path is enabled and the link configurations
+		are fine.
+
+		Accepts only one of the 2 values -  1 or 2.
+		1 : Generate 64 bits data
+		2 : Generate 32 bits data
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index f6d653a45c99..88df3e687ce2 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -121,6 +121,59 @@ static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+/*
+ * value 1: 64 bits test data
+ * value 2: 32 bits test data
+ */
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
+	for (i = 0; i < INTEGRATION_TEST_CYCLE; i++)
+		writel_relaxed(val, drvdata->base + TPDM_ITATBCNTRL);
+
+	writel_relaxed(0, drvdata->base + TPDM_ITCNTRL);
+	CS_LOCK(drvdata->base);
+	return size;
+}
+static DEVICE_ATTR_WO(integration_test);
+
+static struct attribute *tpdm_attrs[] = {
+	&dev_attr_integration_test.attr,
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
 	void __iomem *base;
@@ -157,6 +210,7 @@ static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.pdata = adev->dev.platform_data;
 	desc.dev = &adev->dev;
 	desc.access = CSDEV_ACCESS_IOMEM(base);
+	desc.groups = tpdm_attr_grps;
 	drvdata->csdev = coresight_register(&desc);
 	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h b/drivers/hwtracing/coresight/coresight-tpdm.h
index c8a101cbb4c7..d808fa1e8d4a 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.h
+++ b/drivers/hwtracing/coresight/coresight-tpdm.h
@@ -14,6 +14,20 @@
 /* Enable bit for DSB subunit */
 #define TPDM_DSB_CR_ENA		BIT(0)
 
+/* TPDM integration test registers */
+#define TPDM_ITATBCNTRL		(0xEF0)
+#define TPDM_ITCNTRL		(0xF00)
+
+/* Register value for integration test */
+#define ATBCNTRL_VAL_32		0xC00F1409
+#define ATBCNTRL_VAL_64		0xC01F1409
+
+/*
+ * Number of cycles to write value when
+ * integration test.
+ */
+#define INTEGRATION_TEST_CYCLE	10
+
 /**
  * The bits of PERIPHIDR0 register.
  * The fields [6:0] of PERIPHIDR0 are used to determine what
-- 
2.17.1

