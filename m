Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A7A51BC09
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353585AbiEEJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353358AbiEEJai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:30:38 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE1E4E3A3;
        Thu,  5 May 2022 02:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651742815; x=1683278815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=1avKMT5v2Dea6h8kovhPl7uIrb6vpMam0UarYxyyFN0=;
  b=eWlqEf9nwQ+OypodqJNtQiswfAsiduS5qWYM+fisj/DR/Dny9yynfjzc
   XJ6g4Igq5anR9gc4k5x0FiOYfXDXLX1I+fVeFm+4THOQxqPlUG00LXseY
   QI7Axj1bF1t91ArfC8AAsPgtf6ft+iDBRF2nMp/eTHii1R0+b/F5FK9sE
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 05 May 2022 02:26:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 02:26:54 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 02:26:53 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 02:26:49 -0700
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
Subject: [PATCH V11 4/9] mfd: pm8008: Add reset-gpios
Date:   Thu, 5 May 2022 14:55:34 +0530
Message-ID: <1651742739-12338-5-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651742739-12338-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1651742739-12338-1-git-send-email-quic_c_skakit@quicinc.com>
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

Add the reset-gpio toggling in the pm8008_probe() to bring
pm8008 chip out of reset instead of doing it in DT node using
"output-high" property.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V11:
 - Use local variable for reset_gpios as it is not used outside of probe.
 - Use GPIOD_OUT_LOW flag to initialize the gpio and remove below line
   as it is not required "gpiod_set_value(chip->reset_gpio, 1);".

Changes in V10:
 - This has been split from [V9,3/6] as per comments here [1]
  [1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1649166633-25872-4-git-send-email-quic_c_skakit@quicinc.com/#24803409

 drivers/mfd/qcom-pm8008.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index c472d7f..e7c3b32 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -221,6 +222,7 @@ static int pm8008_probe(struct i2c_client *client)
 {
 	int rc;
 	struct pm8008_data *chip;
+	struct gpio_desc *reset_gpio;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -239,6 +241,10 @@ static int pm8008_probe(struct i2c_client *client)
 			dev_err(chip->dev, "Failed to probe irq periphs: %d\n", rc);
 	}
 
+	reset_gpio = devm_gpiod_get(chip->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio))
+		return PTR_ERR(reset_gpio);
+
 	return devm_of_platform_populate(chip->dev);
 }
 
-- 
2.7.4

