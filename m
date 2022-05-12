Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC575254C5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357675AbiELSYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357651AbiELSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:24:05 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7C45F8C2;
        Thu, 12 May 2022 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652379842; x=1683915842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wbPSwTWKs4eXkxIn4y3Us29ei2iTX+Mu5DDySjzbpls=;
  b=oH/cFMe5OGG6F3xRhGRE9Wjzhlj1blo46sZSTWTMJH0KJxqtFsYlpY/l
   RcBj2cGmK3Zr1m9wCft08OujVpcBa7bAAFeBm80k15YF+O8Q3kn6cdeJX
   oEwKjTqpTcbXgsiKC8+aR5klJsrxPcsMAqNortchHl6tIZ3c5iuV91SB9
   E=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 12 May 2022 11:24:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:24:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 11:24:00 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 11:23:54 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [v16 4/5] usb: dwc3: qcom: Configure wakeup interrupts during suspend
Date:   Thu, 12 May 2022 23:53:21 +0530
Message-ID: <1652379802-8318-5-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652379802-8318-1-git-send-email-quic_kriskura@quicinc.com>
References: <1652379802-8318-1-git-send-email-quic_kriskura@quicinc.com>
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

From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>

Configure DP/DM interrupts to detect line state changes based on
hs_phy_mode. Enable the triggers opposite of what the current
DP, DM levels. For HS/FS mode enable DM interrupt and for LS enable DP
interrupt.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
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

