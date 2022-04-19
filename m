Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E445079F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357483AbiDSTPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiDSTOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:14:53 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E09E3E0F9;
        Tue, 19 Apr 2022 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650395530; x=1681931530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wk85P/Va31o9qzS6/lj0BoC5eFOyfop6d/XOvNpS/dI=;
  b=eFuR+FFvtelgzhr/qE8w8C/vUGFe82ZNaYnCb2DmFcsddj/BzBPXE1pv
   o6CISSXouFynpI/Y+NuRt9MQiyxyA2sDrhjvgunuBxvle/SUPaNOQtzC2
   YR/W+UBBW0rVUF1Qx2Jw8XVHg8An5wFZybG94E8yuZPQ2nFuycfYILyox
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Apr 2022 12:12:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 12:12:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 12:12:08 -0700
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 12:12:01 -0700
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_kriskura@quicinc.com>,
        <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v14 5/7] usb: dwc3: qcom: Configure wakeup interrupts during suspend
Date:   Wed, 20 Apr 2022 00:41:08 +0530
Message-ID: <1650395470-31333-6-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650395470-31333-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1650395470-31333-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Configure DP/DM interrupts to detect line state changes based on
hs_phy_mode. Enable the triggers opposite of what the current
DP, DM levels. For HS/FS mode enable DM interrupt and for LS enable DP
interrupt.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 7352124..9804a19 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -316,22 +316,36 @@ static void dwc3_qcom_disable_wakeup_irq(int irq)
 
 static void dwc3_qcom_disable_interrupts(struct dwc3_qcom *qcom)
 {
-	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
+	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
 
-	dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
+	dwc3_qcom_disable_wakeup_irq(qcom->hs_phy_irq);
 
-	dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+	if (dwc->hs_phy_mode & PHY_MODE_USB_HOST_LS) {
+		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
+	} else if (dwc->hs_phy_mode & PHY_MODE_USB_HOST_HS) {
+		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+	} else {
+		dwc3_qcom_disable_wakeup_irq(qcom->dp_hs_phy_irq);
+		dwc3_qcom_disable_wakeup_irq(qcom->dm_hs_phy_irq);
+	}
 
 	dwc3_qcom_disable_wakeup_irq(qcom->ss_phy_irq);
 }
 
 static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
 {
-	dwc3_qcom_enable_wakeup_irq(qcom->hs_phy_irq);
+	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
 
-	dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq);
+	dwc3_qcom_enable_wakeup_irq(qcom->hs_phy_irq);
 
-	dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq);
+	if (dwc->hs_phy_mode & PHY_MODE_USB_HOST_LS) {
+		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq);
+	} else if (dwc->hs_phy_mode & PHY_MODE_USB_HOST_HS) {
+		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq);
+	} else {
+		dwc3_qcom_enable_wakeup_irq(qcom->dp_hs_phy_irq);
+		dwc3_qcom_enable_wakeup_irq(qcom->dm_hs_phy_irq);
+	}
 
 	dwc3_qcom_enable_wakeup_irq(qcom->ss_phy_irq);
 }
-- 
2.7.4

