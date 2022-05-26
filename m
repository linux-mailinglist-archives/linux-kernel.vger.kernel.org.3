Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C49D534D1D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbiEZKO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346966AbiEZKOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:14:23 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C228169CFD;
        Thu, 26 May 2022 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653560061; x=1685096061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TCo+yigxX/uDiJmLwkPciec+kcXd4nurpXKGqojapgM=;
  b=IyJ+EdEe61mqyDEAZH7qsMIfukyLegK1zSfuArNxcaUPf9yqvnm3SyS3
   75LtgTA6I8DEbSkqnVKO6wpPd/8UjXPRZrqN3Shgxm4twuh4IyGiYhEQo
   qCNuv9Tz0Dh34QxZbm0yzaSxISzRbN3BmaxNw31wYyWyCSX4WcGX5J4Ht
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 26 May 2022 03:14:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 03:14:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 26 May 2022 03:14:19 -0700
Received: from hu-harshq-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 26 May 2022 03:14:14 -0700
From:   Harsh Agarwal <quic_harshq@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, Harsh Agarwal <quic_harshq@quicinc.com>
Subject: [RFC v2 2/2] usb: dwc3: Refactor PHY logic to support Multiport Controller
Date:   Thu, 26 May 2022 15:43:49 +0530
Message-ID: <1653560029-6937-3-git-send-email-quic_harshq@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653560029-6937-1-git-send-email-quic_harshq@quicinc.com>
References: <1653560029-6937-1-git-send-email-quic_harshq@quicinc.com>
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
 drivers/usb/dwc3/core.c   | 420 +++++++++++++++++++++++++++++++++-------------
 drivers/usb/dwc3/core.h   |  12 +-
 drivers/usb/dwc3/drd.c    |  16 +-
 drivers/usb/dwc3/gadget.c |   4 +-
 4 files changed, 326 insertions(+), 126 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2682469..def08ac 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -120,7 +120,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 {
 	struct dwc3 *dwc = work_to_dwc(work);
 	unsigned long flags;
-	int ret;
+	int i, ret;
 	u32 reg;
 
 	mutex_lock(&dwc->mutex);
@@ -189,10 +189,13 @@ static void __dwc3_set_mode(struct work_struct *work)
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
 		} else {
-			if (dwc->usb2_phy)
-				otg_set_vbus(dwc->usb2_phy->otg, true);
-			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+			for (i = 0; i < dwc->num_hsphy; i++) {
+				if (dwc->usb2_phy[i])
+					otg_set_vbus(dwc->usb2_phy[i]->otg, true);
+				phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
+			}
+			for (i = 0; i < dwc->num_ssphy; i++)
+				phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
 			if (dwc->dis_split_quirk) {
 				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
 				reg |= DWC3_GUCTL3_SPLITDISABLE;
@@ -205,10 +208,10 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 		dwc3_event_buffers_setup(dwc);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
+		if (dwc->usb2_phy[0])
+			otg_set_vbus(dwc->usb2_phy[0]->otg, false);
+		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
@@ -655,12 +658,18 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
  */
 static int dwc3_phy_setup(struct dwc3 *dwc)
 {
+	int i;
 	unsigned int hw_mode;
 	u32 reg;
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+	for (i = 1; i < dwc->num_ssphy; i++) {
+		if (reg != dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(i)))
+			dev_warn(dwc->dev,
+				"Reset values of pipectl registers 0 and %d are different!\n", i);
+	}
 
 	/*
 	 * Make sure UX_EXIT_PX is cleared as that causes issues with some
@@ -715,9 +724,15 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_del_phy_power_chg_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+	for (i = 0; i < dwc->num_ssphy; i++)
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i), reg);
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	for (i = 1; i < dwc->num_hsphy; i++) {
+		if (reg != dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i)))
+			dev_warn(dwc->dev,
+				"Reset values of usb2phycfg register 0 and %d are different!\n", i);
+	}
 
 	/* Select the HS PHY interface */
 	switch (DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3)) {
@@ -729,7 +744,8 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 		} else if (dwc->hsphy_interface &&
 				!strncmp(dwc->hsphy_interface, "ulpi", 4)) {
 			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			for (i = 0; i < dwc->num_hsphy; i++)
+				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
 		} else {
 			/* Relying on default value. */
 			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
@@ -786,7 +802,8 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_u2_freeclk_exists_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
 
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	for (i = 0; i < dwc->num_hsphy; i++)
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
 
 	return 0;
 }
@@ -825,17 +842,29 @@ static void dwc3_clk_disable(struct dwc3 *dwc)
 
 static void dwc3_core_exit(struct dwc3 *dwc)
 {
+	int i;
 	dwc3_event_buffers_cleanup(dwc);
 
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
+	for (i = 0; i < dwc->num_hsphy; i++) {
+		usb_phy_shutdown(dwc->usb2_phy[i]);
+		phy_exit(dwc->usb2_generic_phy[i]);
+	}
+
+	for (i = 0; i < dwc->num_ssphy; i++) {
+		usb_phy_shutdown(dwc->usb3_phy[i]);
+		phy_exit(dwc->usb3_generic_phy[i]);
+	}
+
+	for (i = 0; i < dwc->num_hsphy; i++) {
+		usb_phy_set_suspend(dwc->usb2_phy[i], 1);
+		phy_power_off(dwc->usb2_generic_phy[i]);
+	}
+
+	for (i = 0; i < dwc->num_ssphy; i++) {
+		usb_phy_set_suspend(dwc->usb3_phy[i], 1);
+		phy_power_off(dwc->usb3_generic_phy[i]);
+	}
 
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	phy_power_off(dwc->usb2_generic_phy);
-	phy_power_off(dwc->usb3_generic_phy);
 	dwc3_clk_disable(dwc);
 	reset_control_assert(dwc->reset);
 }
@@ -1038,7 +1067,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 {
 	unsigned int		hw_mode;
 	u32			reg;
-	int			ret;
+	int			ret, i;
 
 	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 
@@ -1066,16 +1095,24 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc->phys_ready = true;
 	}
 
-	usb_phy_init(dwc->usb2_phy);
-	usb_phy_init(dwc->usb3_phy);
-	ret = phy_init(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err0a;
+	for (i = 0; i < dwc->num_hsphy; i++)
+		usb_phy_init(dwc->usb2_phy[i]);
+	for (i = 0; i < dwc->num_ssphy; i++)
+		usb_phy_init(dwc->usb3_phy[i]);
 
-	ret = phy_init(dwc->usb3_generic_phy);
-	if (ret < 0) {
-		phy_exit(dwc->usb2_generic_phy);
-		goto err0a;
+	for (i = 0; i < dwc->num_hsphy; i++) {
+		ret = phy_init(dwc->usb2_generic_phy[i]);
+		if (ret < 0)
+			goto err0a;
+	}
+
+	for (i = 0; i < dwc->num_ssphy; i++) {
+		ret = phy_init(dwc->usb3_generic_phy[i]);
+		if (ret < 0) {
+			for (i = 0; i < dwc->num_hsphy; i++)
+				phy_exit(dwc->usb2_generic_phy[i]);
+			goto err0a;
+		}
 	}
 
 	ret = dwc3_core_soft_reset(dwc);
@@ -1085,15 +1122,19 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
 	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
 		if (!dwc->dis_u3_susphy_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+			for (i = 0; i < dwc->num_ssphy; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(i));
+				reg |= DWC3_GUSB3PIPECTL_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i), reg);
+			}
 		}
 
 		if (!dwc->dis_u2_susphy_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			for (i = 0; i < dwc->num_hsphy; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+				reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+			}
 		}
 	}
 
@@ -1112,15 +1153,19 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
-	usb_phy_set_suspend(dwc->usb2_phy, 0);
-	usb_phy_set_suspend(dwc->usb3_phy, 0);
-	ret = phy_power_on(dwc->usb2_generic_phy);
-	if (ret < 0)
-		goto err2;
+	for (i = 0; i < dwc->num_hsphy; i++) {
+		usb_phy_set_suspend(dwc->usb2_phy[i], 0);
+		ret = phy_power_on(dwc->usb2_generic_phy[i]);
+		if (ret < 0)
+			goto err2;
+	}
 
-	ret = phy_power_on(dwc->usb3_generic_phy);
-	if (ret < 0)
-		goto err3;
+	for (i = 0; i < dwc->num_ssphy; i++) {
+		usb_phy_set_suspend(dwc->usb3_phy[i], 0);
+		ret = phy_power_on(dwc->usb3_generic_phy[i]);
+		if (ret < 0)
+			goto err3;
+	}
 
 	ret = dwc3_event_buffers_setup(dwc);
 	if (ret) {
@@ -1228,20 +1273,29 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	return 0;
 
 err4:
-	phy_power_off(dwc->usb3_generic_phy);
+	for (i = 0; i < dwc->num_ssphy; i++)
+		phy_power_off(dwc->usb3_generic_phy[i]);
 
 err3:
-	phy_power_off(dwc->usb2_generic_phy);
+	for (i = 0; i < dwc->num_hsphy; i++)
+		phy_power_off(dwc->usb2_generic_phy[i]);
 
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
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
+	for (i = 0; i < dwc->num_hsphy; i++) {
+		usb_phy_shutdown(dwc->usb2_phy[i]);
+		phy_exit(dwc->usb2_generic_phy[i]);
+	}
+
+	for (i = 0; i < dwc->num_ssphy; i++) {
+		usb_phy_shutdown(dwc->usb3_phy[i]);
+		phy_exit(dwc->usb3_generic_phy[i]);
+	}
 
 err0a:
 	dwc3_ulpi_exit(dwc);
@@ -1250,53 +1304,173 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	return ret;
 }
 
-static int dwc3_core_get_phy(struct dwc3 *dwc)
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
+static int dwc3_count_phys(struct dwc3 *dwc, struct device_node *lookup_node)
+{
+	int count;
+
+	count = of_count_phandle_with_args(lookup_node, "phys", NULL);
+
+	if (count == -ENOENT)
+		count = of_count_phandle_with_args(lookup_node, "usb-phy", NULL);
+
+	if (count == 1) {
+		dwc->num_hsphy++;
+	} else if (count == 2) {
+		dwc->num_hsphy++;
+		dwc->num_ssphy++;
+	} else {
+		return count;
+	}
+	return 0;
+}
+
+static int dwc3_extract_num_phys(struct dwc3 *dwc)
+{
+	struct device_node	*ports, *port;
+	int			ret;
+
+	/* Find if any "multiport" child is present inside DWC3*/
+	for_each_available_child_of_node(dwc->dev->of_node, ports) {
+		if (!strcmp(ports->name, "multiports"))
+			break;
+	}
+	if (!ports) {
+		dwc->num_hsphy = 1;
+		dwc->num_ssphy = 1;
+	} else {
+		for_each_available_child_of_node(ports, port) {
+			ret  = dwc3_count_phys(dwc, port);
+			if (ret)
+				return ret;
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
+	dwc->usb2_generic_phy = devm_kzalloc(dwc->dev,
+		sizeof(*dwc->usb2_generic_phy) * dwc->num_hsphy, GFP_KERNEL);
+	if (!dwc->usb2_generic_phy)
+		return -ENOMEM;
+
+	dwc->usb3_generic_phy = devm_kzalloc(dwc->dev,
+		sizeof(*dwc->usb3_generic_phy) * dwc->num_ssphy, GFP_KERNEL);
+	if (!dwc->usb3_generic_phy)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int dwc3_core_get_phy_by_node(struct dwc3 *dwc,
+		struct device_node *lookup_node, int i)
 {
 	struct device		*dev = dwc->dev;
-	struct device_node	*node = dev->of_node;
-	int ret;
+	int			ret;
 
-	if (node) {
-		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
-		dwc->usb3_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 1);
+	if (lookup_node) {
+		dwc->usb2_phy[i] = dwc3_core_get_phy_by_handle_with_node(dev,
+								"usb-phy", 0, lookup_node);
+		dwc->usb3_phy[i] = dwc3_core_get_phy_by_handle_with_node(dev,
+								"usb-phy", 1, lookup_node);
 	} else {
-		dwc->usb2_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
-		dwc->usb3_phy = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
+		dwc->usb2_phy[i] = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
+		dwc->usb3_phy[i] = devm_usb_get_phy(dev, USB_PHY_TYPE_USB3);
 	}
 
-	if (IS_ERR(dwc->usb2_phy)) {
-		ret = PTR_ERR(dwc->usb2_phy);
+	if (IS_ERR(dwc->usb2_phy[i])) {
+		ret = PTR_ERR(dwc->usb2_phy[i]);
 		if (ret == -ENXIO || ret == -ENODEV)
-			dwc->usb2_phy = NULL;
+			dwc->usb2_phy[i] = NULL;
 		else
 			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
 	}
 
-	if (IS_ERR(dwc->usb3_phy)) {
-		ret = PTR_ERR(dwc->usb3_phy);
+	if (IS_ERR(dwc->usb3_phy[i])) {
+		ret = PTR_ERR(dwc->usb3_phy[i]);
 		if (ret == -ENXIO || ret == -ENODEV)
-			dwc->usb3_phy = NULL;
+			dwc->usb3_phy[i] = NULL;
 		else
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
 	}
 
-	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
-	if (IS_ERR(dwc->usb2_generic_phy)) {
-		ret = PTR_ERR(dwc->usb2_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV)
-			dwc->usb2_generic_phy = NULL;
+	dwc->usb2_generic_phy[i] = devm_of_phy_get(dev, lookup_node, "usb2-phy");
+	if (IS_ERR(dwc->usb2_generic_phy[i])) {
+		ret = PTR_ERR(dwc->usb2_generic_phy[i]);
+		if (ret == -ENODEV)
+			dwc->usb2_generic_phy[i] = NULL;
 		else
 			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
 	}
 
-	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
-	if (IS_ERR(dwc->usb3_generic_phy)) {
-		ret = PTR_ERR(dwc->usb3_generic_phy);
-		if (ret == -ENOSYS || ret == -ENODEV)
-			dwc->usb3_generic_phy = NULL;
+	dwc->usb3_generic_phy[i] = devm_of_phy_get(dev, lookup_node, "usb3-phy");
+	if (IS_ERR(dwc->usb3_generic_phy[i])) {
+		ret = PTR_ERR(dwc->usb3_generic_phy[i]);
+		if (ret == -ENODEV)
+			dwc->usb3_generic_phy[i] = NULL;
 		else
 			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
 	}
+	return 0;
+}
+
+static int dwc3_core_get_phy(struct dwc3 *dwc)
+{
+	struct device		*dev = dwc->dev;
+	struct device_node	*node = dev->of_node;
+	struct device_node	*ports, *port;
+
+	int ret, i = 0;
+
+	ret = dwc3_extract_num_phys(dwc);
+	if (ret) {
+		dev_err(dwc->dev, "Unable to extract number of PHYs\n");
+		return ret;
+	}
+
+	/* Find if any "multiport" child is present inside DWC3*/
+	for_each_available_child_of_node(node, ports) {
+		if (!strcmp(ports->name, "multiport"))
+			break;
+	}
+
+	if (!ports) {
+		ret = dwc3_core_get_phy_by_node(dwc, node, 0);
+		if (ret)
+			return ret;
+	} else {
+		for_each_available_child_of_node(ports, port) {
+			ret = dwc3_core_get_phy_by_node(dwc, port, i);
+			if (ret)
+				return ret;
+			i++;
+		}
+	}
+	pr_info("USB phy all good\n");
 
 	return 0;
 }
@@ -1304,16 +1478,16 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
-	int ret;
+	int i, ret;
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
+		if (dwc->usb2_phy[0])
+			otg_set_vbus(dwc->usb2_phy[0]->otg, false);
+		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
+		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
 
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
@@ -1322,10 +1496,15 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_HOST:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, true);
-		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
-		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
+		for (i = 0; i < dwc->num_ssphy; i++) {
+			if (dwc->usb2_phy[i])
+				otg_set_vbus(dwc->usb2_phy[i]->otg, true);
+			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
+		}
+
+
+		for (i = 0; i < dwc->num_ssphy; i++)
+			phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
 
 		ret = dwc3_host_init(dwc);
 		if (ret)
@@ -1673,7 +1852,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	struct resource		*res, dwc_res;
 	struct dwc3		*dwc;
 
-	int			ret;
+	int			ret, i;
 
 	void __iomem		*regs;
 
@@ -1838,15 +2017,23 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc3_debugfs_exit(dwc);
 	dwc3_event_buffers_cleanup(dwc);
 
-	usb_phy_shutdown(dwc->usb2_phy);
-	usb_phy_shutdown(dwc->usb3_phy);
-	phy_exit(dwc->usb2_generic_phy);
-	phy_exit(dwc->usb3_generic_phy);
+	for (i = 0; i < dwc->num_hsphy; i++) {
+		usb_phy_shutdown(dwc->usb2_phy[i]);
+		phy_exit(dwc->usb2_generic_phy[i]);
+	}
+	for (i = 0; i < dwc->num_ssphy; i++) {
+		usb_phy_shutdown(dwc->usb3_phy[i]);
+		phy_exit(dwc->usb3_generic_phy[i]);
+	}
 
-	usb_phy_set_suspend(dwc->usb2_phy, 1);
-	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	phy_power_off(dwc->usb2_generic_phy);
-	phy_power_off(dwc->usb3_generic_phy);
+	for (i = 0; i < dwc->num_hsphy; i++) {
+		usb_phy_set_suspend(dwc->usb2_phy[i], 1);
+		phy_power_off(dwc->usb2_generic_phy[i]);
+	}
+	for (i = 0; i < dwc->num_ssphy; i++) {
+		usb_phy_set_suspend(dwc->usb3_phy[i], 1);
+		phy_power_off(dwc->usb3_generic_phy[i]);
+	}
 
 	dwc3_ulpi_exit(dwc);
 
@@ -1928,6 +2115,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 
 static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 {
+	int i;
 	unsigned long	flags;
 	u32 reg;
 
@@ -1950,17 +2138,21 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 		/* Let controller to suspend HSPHY before PHY driver suspends */
 		if (dwc->dis_u2_susphy_quirk ||
 		    dwc->dis_enblslpm_quirk) {
-			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-			reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
-				DWC3_GUSB2PHYCFG_SUSPHY;
-			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-
-			/* Give some time for USB2 PHY to suspend */
-			usleep_range(5000, 6000);
+			for (i = 0; i < dwc->num_hsphy; i++) {
+				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+				reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
+					DWC3_GUSB2PHYCFG_SUSPHY;
+				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+
+				/* Give some time for USB2 PHY to suspend */
+				usleep_range(5000, 6000);
+			}
 		}
 
-		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
-		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
+		for (i = 0; i < dwc->num_hsphy; i++)
+			phy_pm_runtime_put_sync(dwc->usb2_generic_phy[i]);
+		for (i = 0; i < dwc->num_ssphy; i++)
+			phy_pm_runtime_put_sync(dwc->usb3_generic_phy[i]);
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* do nothing during runtime_suspend */
@@ -1988,7 +2180,7 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
 static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 {
 	unsigned long	flags;
-	int		ret;
+	int		i, ret;
 	u32		reg;
 
 	switch (dwc->current_dr_role) {
@@ -2011,17 +2203,21 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			break;
 		}
 		/* Restore GUSB2PHYCFG bits that were modified in suspend */
-		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-		if (dwc->dis_u2_susphy_quirk)
-			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+		for (i = 0; i < dwc->num_hsphy; i++) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
+			if (dwc->dis_u2_susphy_quirk)
+				reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
-		if (dwc->dis_enblslpm_quirk)
-			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
+			if (dwc->dis_enblslpm_quirk)
+				reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
 
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
+		}
 
-		phy_pm_runtime_get_sync(dwc->usb2_generic_phy);
-		phy_pm_runtime_get_sync(dwc->usb3_generic_phy);
+		for (i = 0; i < dwc->num_hsphy; i++)
+			phy_pm_runtime_get_sync(dwc->usb2_generic_phy[i]);
+		for (i = 0; i < dwc->num_ssphy; i++)
+			phy_pm_runtime_get_sync(dwc->usb3_generic_phy[i]);
 		break;
 	case DWC3_GCTL_PRTCAP_OTG:
 		/* nothing to do on runtime_resume */
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 81c486b..53b9f63c 100644
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
@@ -1147,11 +1149,13 @@ struct dwc3 {
 
 	struct reset_control	*reset;
 
-	struct usb_phy		*usb2_phy;
-	struct usb_phy		*usb3_phy;
+	struct usb_phy		**usb2_phy;
+	struct usb_phy		**usb3_phy;
+	u32			num_hsphy;
+	u32			num_ssphy;
 
-	struct phy		*usb2_generic_phy;
-	struct phy		*usb3_generic_phy;
+	struct phy		**usb2_generic_phy;
+	struct phy		**usb3_generic_phy;
 
 	bool			phys_ready;
 
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 039bf24..404643f 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -384,10 +384,10 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
 		} else {
-			if (dwc->usb2_phy)
-				otg_set_vbus(dwc->usb2_phy->otg, true);
-			if (dwc->usb2_generic_phy)
-				phy_set_mode(dwc->usb2_generic_phy,
+			if (dwc->usb2_phy[0])
+				otg_set_vbus(dwc->usb2_phy[0]->otg, true);
+			if (dwc->usb2_generic_phy[0])
+				phy_set_mode(dwc->usb2_generic_phy[0],
 					     PHY_MODE_USB_HOST);
 		}
 		break;
@@ -398,10 +398,10 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 		dwc3_event_buffers_setup(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
-		if (dwc->usb2_generic_phy)
-			phy_set_mode(dwc->usb2_generic_phy,
+		if (dwc->usb2_phy[0])
+			otg_set_vbus(dwc->usb2_phy[0]->otg, false);
+		if (dwc->usb2_generic_phy[0])
+			phy_set_mode(dwc->usb2_generic_phy[0],
 				     PHY_MODE_USB_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
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

