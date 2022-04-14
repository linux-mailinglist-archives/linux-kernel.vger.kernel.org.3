Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21C7500DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbiDNMeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243391AbiDNMdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:33:45 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55953A5F5;
        Thu, 14 Apr 2022 05:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649939480; x=1681475480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=pGNj8x1GHklDyI4swlhpAUG9iXU3iTL3hkyneH0G0r4=;
  b=VPlDkzvgEjS0ufLuNEeFWNQXNKBoAAWS9wMyGZM3gFo9LDWdoP7srL8i
   7ZZTaBWgHivRGpeNYcFG7j1Nb+XsPs3qdTDGJwyaNyhMcAvwbjqVeUAEN
   bqdcWGxBeS7T0OqR1B4PBepXqSNwZcyzGA1Tf1OkptdaX8pxyJt0fmJXO
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 14 Apr 2022 05:31:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 05:31:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 05:31:19 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 05:31:14 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V10 6/9] mfd: pm8008: Add mfd_cell struct to register LDOs
Date:   Thu, 14 Apr 2022 18:00:15 +0530
Message-ID: <1649939418-19861-7-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1649939418-19861-1-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mfd_cell struct to probe LDO regulators using
devm_mfd_add_devices() API.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V8:
 - Split the probe for infra and regulator devices
 - Add the reset-gpio toggling in the infra driver probe

Changes in V9:
 - Fixed nits.

Changes in V10:
 - Removed the extra probe added for regulators as is is not needed now.

 drivers/mfd/qcom-pm8008.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index ca5240d..ab4ba55 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/mfd/core.h>
 #include <linux/mfd/qcom_pm8008.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -29,6 +30,10 @@
 #define INT_EN_CLR_OFFSET		0x16
 #define INT_LATCHED_STS_OFFSET		0x18
 
+static const struct mfd_cell pm8008_regulator_devs[] = {
+	MFD_CELL_NAME("qcom-pm8008-regulator"),
+};
+
 enum {
 	PM8008_MISC,
 	PM8008_TEMP_ALARM,
@@ -282,6 +287,14 @@ static int pm8008_probe(struct i2c_client *client)
 	}
 	gpiod_set_value(chip->reset_gpio, 1);
 
+	rc = devm_mfd_add_devices(&chip->clients[PM8008_REGULATORS_SID]->dev,
+			0, pm8008_regulator_devs, ARRAY_SIZE(pm8008_regulator_devs),
+			NULL, 0, NULL);
+	if (rc) {
+		dev_err(chip->dev, "Failed to add regulators: %d\n", rc);
+		return rc;
+	}
+
 	return devm_of_platform_populate(chip->dev);
 }
 
-- 
2.7.4

