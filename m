Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE24452D299
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiESMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiESMfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:35:33 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C89A5A91;
        Thu, 19 May 2022 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652963731; x=1684499731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=9e55PrONxEYDZiDFgzGGY2kemkZdNEMcJOrzRun0Zx0=;
  b=cAk2kYhtaXtNHZH2zPe812BMdONGk6kGmitIPM2H5lc6gmgLr0pLkF7o
   pZK37sdYYfMoNysRGBKov3hrhCruhtIdYWWESJhSuoO6HeZiLWbY6Hl3F
   Z/CdL/f1h1dhtpYkvAkA848wWRdokPZO+6mtq3AaXvGJ45tfgQGZKtb49
   k=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 May 2022 05:35:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 05:35:31 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 05:35:30 -0700
Received: from hu-harshq-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 05:35:27 -0700
From:   Harsh Agarwal <quic_harshq@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, Harsh Agarwal <quic_harshq@quicinc.com>
Subject: [RFC 2/2] usb: dwc3: Refactor PHY logic to support Multiport Controller
Date:   Thu, 19 May 2022 18:04:55 +0530
Message-ID: <1652963695-10109-3-git-send-email-quic_harshq@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
References: <1652963695-10109-1-git-send-email-quic_harshq@quicinc.com>
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

Currently the USB driver supports only single port controller
which works with 2 PHYs at max ie HS and SS.

But some devices have "multiport" controller where a single
controller supports multiple ports and each port have their own
PHYs. Refactor PHY logic to support the same.

This implementation is compatible with existing glue drivers.

Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
---
 drivers/usb/dwc3/core.c   | 259 +++++++++++++++++++++++++++++++++++-----------
 drivers/usb/dwc3/core.h   |   8 +-
 drivers/usb/dwc3/drd.c    |   8 +-
 drivers/usb/dwc3/gadget.c |   4 +-
 4 files changed, 209 insertions(+), 70 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2682469..8eb6b5b6 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -189,8 +189,8 @@ static void __dwc3_set_mode(struct work_struct *work)
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
 		} else {
-			if (dwc->usb2_phy)
-				otg_set_vbus(dwc->usb2_phy->otg, true);
+			if (dwc->usb2_phy[0])
+				otg_set_vbus(dwc->usb2_phy[0]->otg, true);
 			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
 			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
 			if (dwc->dis_split_quirk) {
@@ -204,9 +204,13 @@ static void __dwc3_set_mode(struct work_struct *work)
 		dwc3_core_soft_reset(dwc);
 
 		dwc3_event_buffers_setup(dwc);
-
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
+		/*
+		 * Multiport Controller works only in host mode.
+		 * There will only be one pair of HS and SS PHY for the controller operating in
+		 * device mode.
+		 */
+		if (dwc->usb2_phy[0])
+			otg_set_vbus(dwc->usb2_phy[0]->otg, false);
 		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
 		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
 
@@ -825,15 +829,20 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
 
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
+	int i;
 	dwc3_event_buffers_cleanup(dwc);
 
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
+	for (i = 0; i < dwc->num_hsphy; i++)
+		usb_phy_shutdown(dwc->usb2_phy[i]);
+	for (i = 0; i < dwc->num_ssphy; i++)
+		usb_phy_shutdown(dwc->usb3_phy[i]);
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	for (i = 0; i < dwc->num_hsphy; i++)
+		usb_phy_set_suspend(dwc->usb2_phy[i], 1);
+	for (i = 0; i < dwc->num_ssphy; i++)
+		usb_phy_set_suspend(dwc->usb3_phy[i], 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
 	dwc3_clk_disable(dwc);
@@ -1038,7 +1047,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 {
 	unsigned int		hw_mode;
 	u32			reg;
-	int			ret;
+	int			ret, i;
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
@@ -1066,8 +1075,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->phys_ready = true;
 	}
 
-	usb_phy_init(dwc->usb2_phy);
-	usb_phy_init(dwc->usb3_phy);
+	for (i = 0; i < dwc->num_hsphy; i++)
+		usb_phy_init(dwc->usb2_phy[i]);
+	for (i = 0; i < dwc->num_ssphy; i++)
+		usb_phy_init(dwc->usb3_phy[i]);
 	ret = phy_init(dwc->usb2_generic_phy);
 	if (ret < 0)
 		goto err0a;
@@ -1112,8 +1123,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
-	usb_phy_set_suspend(dwc->usb2_phy, 0);
-	usb_phy_set_suspend(dwc->usb3_phy, 0);
+	for (i = 0; i < dwc->num_hsphy; i++)
+		usb_phy_set_suspend(dwc->usb2_phy[i], 0);
+	for (i = 0; i < dwc->num_ssphy; i++)
+		usb_phy_set_suspend(dwc->usb3_phy[i], 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
 	if (ret < 0)
 		goto err2;
@@ -1234,12 +1247,16 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	phy_power_off(dwc->usb2_generic_phy);
 
 err2:
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	for (i = 0; i < dwc->num_hsphy; i++)
+		usb_phy_set_suspend(dwc->usb2_phy[i], 1);
+	for (i = 0; i < dwc->num_ssphy; i++)
+		usb_phy_set_suspend(dwc->usb3_phy[i], 1);
 
 err1:
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
+	for (i = 0; i < dwc->num_hsphy; i++)
+		usb_phy_shutdown(dwc->usb2_phy[i]);
+	for (i = 0; i < dwc->num_ssphy; i++)
+		usb_phy_shutdown(dwc->usb3_phy[i]);
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
@@ -1250,52 +1267,166 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	return ret;
 }
 
+static struct usb_phy *dwc3_core_get_phy_by_handle_with_node(struct device *dev,
+	const char *phandle, u8 index, struct device_node *lookup_node)
+{
+	struct device_node *node;
+	struct usb_phy	*phy;
+
+	node = of_parse_phandle(lookup_node, phandle, index);
+	if (!node) {
+		dev_err(dev, "failed to get %s phandle in %pOF node\n", phandle,
+			dev->of_node);
+		return ERR_PTR(-ENODEV);
+	}
+	phy = devm_usb_get_phy_by_node(dev, node, NULL);
+	of_node_put(node);
+	return phy;
+}
+
+static int dwc3_extract_num_phys(struct dwc3 *dwc)
+{
+	struct device_node	*ports, *port;
+
+	/* Find if any "multiport" child is present inside DWC3*/
+	for_each_available_child_of_node(dwc->dev->of_node, ports) {
+		if (!strcmp(ports->name, "multiport"))
+			break;
+	}
+	if (!ports) {
+		dwc->num_hsphy = 1;
+		dwc->num_ssphy = 1;
+	} else {
+		for_each_available_child_of_node(ports, port) {
+			dwc->num_hsphy += 1;
+			dwc->num_ssphy += 1;
+		}
+	}
+	dev_info(dwc->dev, "Num of HS and SS PHY are %u %u\n", dwc->num_hsphy, dwc->num_ssphy);
+
+	dwc->usb2_phy = devm_kzalloc(dwc->dev,
+		sizeof(*dwc->usb2_phy) * dwc->num_hsphy, GFP_KERNEL);
+	if (!dwc->usb2_phy)
+		return -ENOMEM;
+
+	dwc->usb3_phy = devm_kzalloc(dwc->dev,
+		sizeof(*dwc->usb3_phy) * dwc->num_ssphy, GFP_KERNEL);
+	if (!dwc->usb3_phy)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static int dwc3_core_get_phy(struct dwc3 *dwc)
 {
 	struct device		*dev = dwc->dev;
 	struct device_node	*node = dev->of_node;
-	int ret;
+	struct device_node	*ports, *port;
 
-	if (node) {
-		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
-		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
-	} else {
-		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
-		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
-	}
+	int ret, i = 0;
 
-	if (IS_ERR(dwc->usb2_phy)) {
-		ret = PTR_ERR(dwc->usb2_phy);
-		if (ret == -ENXIO || ret == -ENODEV)
-			dwc->usb2_phy = NULL;
-		else
-			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
+	ret = dwc3_extract_num_phys(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "Unable to extract number of PHYs\n");
+		return ret;
 	}
 
-	if (IS_ERR(dwc->usb3_phy)) {
-		ret = PTR_ERR(dwc->usb3_phy);
-		if (ret == -ENXIO || ret == -ENODEV)
-			dwc->usb3_phy = NULL;
-		else
-			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
+	/* Find if any "multiport" child is present inside DWC3*/
+	for_each_available_child_of_node(node, ports) {
+		if (!strcmp(ports->name, "multiport"))
+			break;
 	}
 
-	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
-	if (IS_ERR(dwc->usb2_generic_phy)) {
-		ret = PTR_ERR(dwc->usb2_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV)
-			dwc->usb2_generic_phy = NULL;
-		else
-			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
-	}
+	if (!ports) {
+		if (node) {
+			dwc->usb2_phy[0] = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
+			dwc->usb3_phy[0] = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
+		} else {
+			dwc->usb2_phy[0] = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+			dwc->usb3_phy[0] = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
+		}
 
-	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
-	if (IS_ERR(dwc->usb3_generic_phy)) {
-		ret = PTR_ERR(dwc->usb3_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV)
-			dwc->usb3_generic_phy = NULL;
-		else
-			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
+		if (IS_ERR(dwc->usb2_phy[0])) {
+			ret = PTR_ERR(dwc->usb2_phy[0]);
+			if (ret == -ENXIO || ret == -ENODEV)
+				dwc->usb2_phy[0] = NULL;
+			else
+				return dev_err_probe(dev, ret, "no usb2 phy configured\n");
+		}
+
+		if (IS_ERR(dwc->usb3_phy[0])) {
+			ret = PTR_ERR(dwc->usb3_phy[0]);
+			if (ret == -ENXIO || ret == -ENODEV)
+				dwc->usb3_phy[0] = NULL;
+			else
+				return dev_err_probe(dev, ret, "no usb3 phy configured\n");
+		}
+
+		dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
+		if (IS_ERR(dwc->usb2_generic_phy)) {
+			ret = PTR_ERR(dwc->usb2_generic_phy);
+			if (ret == -ENOSYS || ret == -ENODEV)
+				dwc->usb2_generic_phy = NULL;
+			else
+				return dev_err_probe(dev, ret, "no usb2 phy configured\n");
+		}
+
+		dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
+		if (IS_ERR(dwc->usb3_generic_phy)) {
+			ret = PTR_ERR(dwc->usb3_generic_phy);
+			if (ret == -ENOSYS || ret == -ENODEV)
+				dwc->usb3_generic_phy = NULL;
+			else
+				return dev_err_probe(dev, ret, "no usb3 phy configured\n");
+		}
+
+	} else {
+		pr_info("Multiport node found\n");
+		/* Iterate over each port of the MultiPort */
+		for_each_available_child_of_node(ports, port) {
+			dwc->usb2_phy[i] = dwc3_core_get_phy_by_handle_with_node(dev, "usb-phy",
+											0, port);
+			dwc->usb3_phy[i] = dwc3_core_get_phy_by_handle_with_node(dev, "usb-phy",
+											1, port);
+
+			if (IS_ERR(dwc->usb2_phy[i])) {
+				ret = PTR_ERR(dwc->usb2_phy[i]);
+				pr_err("usb2_phy gone %d\n", ret);
+				if (ret == -ENXIO || ret == -ENODEV)
+					dwc->usb2_phy[i] = NULL;
+				else
+					return dev_err_probe(dev, ret, "no usb2 phy configured\n");
+			}
+
+			if (IS_ERR(dwc->usb3_phy[i])) {
+				ret = PTR_ERR(dwc->usb3_phy[i]);
+				pr_err("usb3_phy gone %d\n", ret);
+				if (ret == -ENXIO || ret == -ENODEV)
+					dwc->usb3_phy[i] = NULL;
+				else
+					return dev_err_probe(dev, ret, "no usb3 phy configured\n");
+			}
+			//TODO Write Generic PHY API
+			dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
+			if (IS_ERR(dwc->usb2_generic_phy)) {
+				ret = PTR_ERR(dwc->usb2_generic_phy);
+				if (ret == -ENOSYS || ret == -ENODEV)
+					dwc->usb2_generic_phy = NULL;
+				else
+					return dev_err_probe(dev, ret, "no usb2 phy configured\n");
+			}
+
+			//TODO Write Generic PHY API
+			dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
+			if (IS_ERR(dwc->usb3_generic_phy)) {
+				ret = PTR_ERR(dwc->usb3_generic_phy);
+				if (ret == -ENOSYS || ret == -ENODEV)
+					dwc->usb3_generic_phy = NULL;
+				else
+					return dev_err_probe(dev, ret, "no usb3 phy configured\n");
+			}
+			i++;
+		}
 	}
 
 	return 0;
@@ -1310,8 +1441,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_PERIPHERAL:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
+		if (dwc->usb2_phy[0])
+			otg_set_vbus(dwc->usb2_phy[0]->otg, false);
 		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
 		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
 
@@ -1322,8 +1453,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_HOST:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, true);
+		if (dwc->usb2_phy[0])
+			otg_set_vbus(dwc->usb2_phy[0]->otg, true);
 		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
 		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
 
@@ -1673,7 +1804,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	struct resource		*res, dwc_res;
 	struct dwc3		*dwc;
 
-	int			ret;
+	int			ret, i;
 
 	void __iomem		*regs;
 
@@ -1838,13 +1969,17 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc3_debugfs_exit(dwc);
 	dwc3_event_buffers_cleanup(dwc);
 
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
+	for (i = 0; i < dwc->num_hsphy; i++)
+		usb_phy_shutdown(dwc->usb2_phy[i]);
+	for (i = 0; i < dwc->num_ssphy; i++)
+		usb_phy_shutdown(dwc->usb3_phy[i]);
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	for (i = 0; i < dwc->num_hsphy; i++)
+		usb_phy_set_suspend(dwc->usb2_phy[i], 1);
+	for (i = 0; i < dwc->num_ssphy; i++)
+		usb_phy_set_suspend(dwc->usb3_phy[i], 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 81c486b..3175ed9 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1020,6 +1020,8 @@ struct dwc3_scratchpad_array {
  * @usb_psy: pointer to power supply interface.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
+ * @num_hsphy: Number of HS ports controlled by the core
+ * @num_dsphy: Number of SS ports controlled by the core
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
  * @phys_ready: flag to indicate that PHYs are ready
@@ -1147,8 +1149,10 @@ struct dwc3 {
 
 	struct reset_control	*reset;
 
-	struct usb_phy		*usb2_phy;
-	struct usb_phy		*usb3_phy;
+	struct usb_phy		**usb2_phy;
+	struct usb_phy		**usb3_phy;
+	u32			num_hsphy;
+	u32			num_ssphy;
 
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 039bf24..7c9eba6 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -384,8 +384,8 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
 		} else {
-			if (dwc->usb2_phy)
-				otg_set_vbus(dwc->usb2_phy->otg, true);
+			if (dwc->usb2_phy[0])
+				otg_set_vbus(dwc->usb2_phy[0]->otg, true);
 			if (dwc->usb2_generic_phy)
 				phy_set_mode(dwc->usb2_generic_phy,
 					     PHY_MODE_USB_HOST);
@@ -398,8 +398,8 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 		dwc3_event_buffers_setup(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
+		if (dwc->usb2_phy[0])
+			otg_set_vbus(dwc->usb2_phy[0]->otg, false);
 		if (dwc->usb2_generic_phy)
 			phy_set_mode(dwc->usb2_generic_phy,
 				     PHY_MODE_USB_DEVICE);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4f54f0e..c58a67c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2870,8 +2870,8 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 	union power_supply_propval	val = {0};
 	int				ret;
 
-	if (dwc->usb2_phy)
-		return usb_phy_set_power(dwc->usb2_phy, mA);
+	if (dwc->usb2_phy[0])
+		return usb_phy_set_power(dwc->usb2_phy[0], mA);
 
 	if (!dwc->usb_psy)
 		return -EOPNOTSUPP;
-- 
2.7.4

