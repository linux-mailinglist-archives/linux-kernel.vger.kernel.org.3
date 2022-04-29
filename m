Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7C0514828
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358490AbiD2LeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358477AbiD2Ld5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:33:57 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2B149F14;
        Fri, 29 Apr 2022 04:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651231840; x=1682767840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4CK1W0a9kn9jaFNkX6JJAfWkAorqu+bWucmc9AijetY=;
  b=n9/AfdO0OH/EVJX0yVrhMn6C/cLnkHxQ00xA+MdTig10Uizdtu3Nzn8J
   6ZCvXugi2QjuC5mOiOqGxLRG+JDyd+Cg38QyII9ODB1xHr8Rf3T4ufa8Y
   iV9IeT7Mg2sVKy4e9czVAElGqO4II5aHlhcji4pEqDgIlqY+/J2wFuotB
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Apr 2022 04:30:37 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 04:30:37 -0700
Received: from bgodavar-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 04:30:33 -0700
From:   Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
To:     <agross@kernel.org>, <robh+dt@kernel.org>,
        <bjorn.andersson@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <mka@chromium.org>, <linux-bluetooth@vger.kernel.org>,
        <quic_hemantg@quicinc.com>, <quic_saluvala@quicinc.com>,
        <quic_rjliao@quicinc.com>, <mcchou@chromium.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
Subject: [PATCH v1 3/3] Bluetooth: hci_qca: WAR to handle WCN6750 HW issue
Date:   Fri, 29 Apr 2022 15:57:53 +0530
Message-ID: <1651228073-1999-4-git-send-email-quic_bgodavar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
References: <1651228073-1999-1-git-send-email-quic_bgodavar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is workaround for hardware issue on WCN6750.
On WCN6750 sometimes observed AON power source takes 100ms
time to fully discharge voltage during OFF. As WCN6750 is
combo chip for WLAN and BT. If any of the tech area ON is
triggered during discharge phase, it fails to turn ON.
To overcome this hardware issue, During BT ON, driver check
for WLAN_EN pin status. If it high, it will pull BT_EN to high
immediately else it will wait for 100ms assuming WLAN was just
powered OFF and then BT_EN will be pulled to high.

Fixes: d8f97da1b92d2 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6750")
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
Signed-off-by: Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
---
 drivers/bluetooth/hci_qca.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index eab34e2..c3862d1 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -219,6 +219,7 @@ struct qca_serdev {
 	struct hci_uart	 serdev_hu;
 	struct gpio_desc *bt_en;
 	struct gpio_desc *sw_ctrl;
+	struct gpio_desc *wlan_en;
 	struct clk	 *susclk;
 	enum qca_btsoc_type btsoc_type;
 	struct qca_power *bt_power;
@@ -1627,12 +1628,25 @@ static int qca_regulator_init(struct hci_uart *hu)
 	if (qcadev->bt_en) {
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 		msleep(50);
+	}
+
+	if (!qcadev->wlan_en || (qcadev->wlan_en && gpiod_get_value_cansleep(qcadev->wlan_en)))
+		gpiod_set_value_cansleep(qcadev->bt_en, 1);
+
+	if (qcadev->wlan_en && !gpiod_get_value_cansleep(qcadev->wlan_en)) {
+		gpiod_set_value_cansleep(qcadev->bt_en, 0);
+		msleep(100);
 		gpiod_set_value_cansleep(qcadev->bt_en, 1);
-		msleep(50);
-		if (qcadev->sw_ctrl) {
-			sw_ctrl_state = gpiod_get_value_cansleep(qcadev->sw_ctrl);
-			bt_dev_dbg(hu->hdev, "SW_CTRL is %d", sw_ctrl_state);
-		}
+	}
+
+	if (!gpiod_get_value_cansleep(qcadev->bt_en))
+		gpiod_set_value_cansleep(qcadev->bt_en, 1);
+
+	msleep(50);
+
+	if (qcadev->sw_ctrl) {
+		sw_ctrl_state = gpiod_get_value_cansleep(qcadev->sw_ctrl);
+		bt_dev_dbg(hu->hdev, "SW_CTRL is %d", sw_ctrl_state);
 	}
 
 	qca_set_speed(hu, QCA_INIT_SPEED);
@@ -1906,8 +1920,8 @@ static void qca_power_shutdown(struct hci_uart *hu)
 		qca_regulator_disable(qcadev);
 	} else if (soc_type == QCA_WCN6750) {
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
-		msleep(100);
 		qca_regulator_disable(qcadev);
+		msleep(100);
 		if (qcadev->sw_ctrl) {
 			sw_ctrl_state = gpiod_get_value_cansleep(qcadev->sw_ctrl);
 			bt_dev_dbg(hu->hdev, "SW_CTRL is %d", sw_ctrl_state);
@@ -2057,6 +2071,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_power->vregs_on = false;
 
+		qcadev->wlan_en = devm_gpiod_get_optional(&serdev->dev, "wlan", GPIOD_ASIS);
+		if (!qcadev->wlan_en && data->soc_type == QCA_WCN6750)
+			dev_err(&serdev->dev, "failed to acquire WL_EN gpio");
+
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
 		if (IS_ERR_OR_NULL(qcadev->bt_en) && data->soc_type == QCA_WCN6750) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

