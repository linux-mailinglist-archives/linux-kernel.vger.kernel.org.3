Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E6053B4F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiFBIZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiFBIZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:25:19 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4616581;
        Thu,  2 Jun 2022 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654158317; x=1685694317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Uclr9TNqmmdXvvT/NbtqpYkZ+jeCIKQ2HEPc798ulwA=;
  b=kdVmN3EnlNaz9Bujc8DHYRdvf7iInL3KSuk8AILjQam1TvDe7Jty9509
   b+ITb9v1mwsoq9uCWmogX+wlZ1u0cm6WYMf+9o7ro0xJ65/SVhx3kw7Zw
   eCc2AcU3yV9qJJgTHkoKtF388XrGw/He8kch3tlMRNnFTNeXbTRskgusD
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Jun 2022 01:25:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 01:25:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 01:25:16 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 01:25:09 -0700
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
Subject: [PATCH v20 2/5] usb: dwc3: core: Host wake up support from system suspend
Date:   Thu, 2 Jun 2022 13:54:34 +0530
Message-ID: <1654158277-12921-3-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654158277-12921-1-git-send-email-quic_kriskura@quicinc.com>
References: <1654158277-12921-1-git-send-email-quic_kriskura@quicinc.com>
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

From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>

Check wakeup-source property for dwc3 core node to set the
wakeup capability. Drop the device_init_wakeup call from
runtime suspend and resume.

If the dwc3 is wakeup capable, don't power down the USB PHY(s).
The glue drivers are expected to take care of configuring the
additional wakeup settings if needed based on the dwc3 wakeup
capability status. In some SOC designs, powering off the PHY is
resulting in higher leakage, so this patch save power on such boards.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
 drivers/usb/dwc3/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index e027c04..b99d3c2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1787,6 +1787,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
+	device_init_wakeup(&pdev->dev, of_property_read_bool(dev->of_node, "wakeup-source"));
 
 	spin_lock_init(&dwc->lock);
 	mutex_init(&dwc->mutex);
@@ -1948,7 +1949,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		dwc3_core_exit(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg)) {
+		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
 			dwc3_core_exit(dwc);
 			break;
 		}
@@ -2009,7 +2010,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
-		if (!PMSG_IS_AUTO(msg)) {
+		if (!PMSG_IS_AUTO(msg) && !device_can_wakeup(dwc->dev)) {
 			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
@@ -2086,8 +2087,6 @@ static int dwc3_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	device_init_wakeup(dev, true);
-
 	return 0;
 }
 
@@ -2096,8 +2095,6 @@ static int dwc3_runtime_resume(struct device *dev)
 	struct dwc3     *dwc = dev_get_drvdata(dev);
 	int		ret;
 
-	device_init_wakeup(dev, false);
-
 	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
 	if (ret)
 		return ret;
-- 
2.7.4

