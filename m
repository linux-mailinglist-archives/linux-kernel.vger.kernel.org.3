Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7518057E9E7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 00:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiGVWkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 18:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbiGVWkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 18:40:14 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3D21A06B;
        Fri, 22 Jul 2022 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658529519; x=1690065519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=36h9uKHBZ/R8K8A3gNaxdbJpvYGm7y4WLL4L2AEqb8I=;
  b=SQvLYRGwK9LnrprUarXWZNI+nZ3xeV3Od0KMJXB/PStXKhxvcop6sm58
   R2DSp+uNi6dJKhSgUb0zW7COlSzbWWG0DEkKPcj0Sjk08qJintUEy/A2q
   03SDZjnDrQ90iM5tntTTbJGbPGpVW712DpV5xU1DKYNGZSEZDLBhIhuOv
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Jul 2022 15:37:26 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 15:37:26 -0700
Received: from hu-gurus-sd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Jul 2022 15:37:26 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: [PATCH v2 2/5] firmware: qcom: scm: Optionally remove SCM call serialization
Date:   Fri, 22 Jul 2022 15:37:15 -0700
Message-ID: <1658529438-9234-3-git-send-email-quic_gurus@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658529438-9234-1-git-send-email-quic_gurus@quicinc.com>
References: <1658529438-9234-1-git-send-email-quic_gurus@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some firmware versions support the handling of multiple SCM calls at the
same time. Add a device tree boolean property which, when specified,
allows this to happen.

Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 drivers/firmware/qcom_scm-smc.c | 8 ++++++--
 drivers/firmware/qcom_scm.c     | 6 ++++++
 drivers/firmware/qcom_scm.h     | 2 ++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom_scm-smc.c
index d111833..66193c2 100644
--- a/drivers/firmware/qcom_scm-smc.c
+++ b/drivers/firmware/qcom_scm-smc.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2015,2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/io.h>
@@ -63,11 +64,14 @@ static void __scm_smc_do(const struct arm_smccc_args *smc,
 	}
 
 	do {
-		mutex_lock(&qcom_scm_lock);
+		if (!qcom_scm_allow_multicall)
+			mutex_lock(&qcom_scm_lock);
 
 		__scm_smc_do_quirk(smc, res);
 
-		mutex_unlock(&qcom_scm_lock);
+		if (!qcom_scm_allow_multicall)
+			mutex_unlock(&qcom_scm_lock);
+
 
 		if (res->a0 == QCOM_SCM_V2_EBUSY) {
 			if (retry_count++ > QCOM_SCM_EBUSY_MAX_RETRY)
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 3163660..4046073 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2010,2015,2019 The Linux Foundation. All rights reserved.
  * Copyright (C) 2015 Linaro Ltd.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
@@ -22,6 +23,8 @@
 static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
 module_param(download_mode, bool, 0);
 
+bool qcom_scm_allow_multicall = false;
+
 #define SCM_HAS_CORE_CLK	BIT(0)
 #define SCM_HAS_IFACE_CLK	BIT(1)
 #define SCM_HAS_BUS_CLK		BIT(2)
@@ -1333,6 +1336,9 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	__scm = scm;
 	__scm->dev = &pdev->dev;
 
+	qcom_scm_allow_multicall = of_property_read_bool(__scm->dev->of_node,
+							"allow-multi-call");
+
 	__get_convention();
 
 	/*
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 0d51eef..c0a4d6b 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright (c) 2010-2015,2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef __QCOM_SCM_INT_H
 #define __QCOM_SCM_INT_H
@@ -12,6 +13,7 @@ enum qcom_scm_convention {
 };
 
 extern enum qcom_scm_convention qcom_scm_convention;
+extern bool qcom_scm_allow_multicall;
 
 #define MAX_QCOM_SCM_ARGS 10
 #define MAX_QCOM_SCM_RETS 3
-- 
2.7.4

