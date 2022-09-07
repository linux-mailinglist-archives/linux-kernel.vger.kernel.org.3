Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668325B076B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiIGOq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiIGOqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:46:39 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2466C816A1;
        Wed,  7 Sep 2022 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662561998; x=1694097998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nyTN5S1v23pl4QdaIwaYRFWiOie50KxUbC25YQEF+qE=;
  b=Dd0r10oWAaSjIQPsDbWRvnMe/aPeDOavQN0uD26PnVljwWT/fwPYPWZh
   /x7BSsciL9n3grlPviDDWfbIKXgNGyD0hrrxT+nLrfgiLR4UczgQlQkZb
   QYglTewG6NlZ2kxMXhasEbQFGbwJqeS6V5oTQMx/V/91sODRsp0QbT0mu
   BzZlj3Ds3genUkOHPttlvRT+A2/b8LTK8cUe2vNAaM3OXJgzkFe42Vv6j
   6rgdtzGe5QtgsHJTudRpXkhOasmiCllXAb4Fz+4LOVhug1oVE9nVXWJ6P
   RjkJxGerrewkBZ3tCTSJlw4kA3PDBJMxnMR0AI/X1C5MV/jBK0nyYz0lb
   w==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654552800"; 
   d="scan'208";a="26047490"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Sep 2022 16:46:31 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 07 Sep 2022 16:46:31 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 07 Sep 2022 16:46:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662561991; x=1694097991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nyTN5S1v23pl4QdaIwaYRFWiOie50KxUbC25YQEF+qE=;
  b=H/+ss8aiTVjn6nEFkYtz8MJ555sVCCVi3URoeZtWObVZIva0so/g0ax/
   xs71b9Zahss8j0Z8Yf0FzpIJ8fhrTiCW/RsTriQJn/sO13oNSVwQKB3NH
   iKmIvxUv2PU1nQFwDXjE2ljIjoaPotDJCq5G4iOLtG8SNVnmdAlYE/tSJ
   mxypT+/P/C3rBA7pLvMJcOB4ITd8Z5BYfPV4+NThIkxdafQz6OEGgZZDf
   IjvLyH7aKHb4d4kpDV0Ktv+tPtkyqV4U6ju9Hr8YyFsQDEMQLICOi60Ma
   VbNASU7e5AtLbzSH3Wn96nURc6rzSKhaMrcJk1xFfXvX4PEdaqa4YGse7
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654552800"; 
   d="scan'208";a="26047489"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Sep 2022 16:46:31 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 33601280056;
        Wed,  7 Sep 2022 16:46:31 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Li Jun <jun.li@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: tqma8mpql: add support for 2nd USB (host) interface
Date:   Wed,  7 Sep 2022 16:46:24 +0200
Message-Id: <20220907144624.2810117-5-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The on-board USB hub has a single reset line which needs to be enabled.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx8mp-tqma8mpql-mba8mpxl.dts   | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
index 0091430f6154..09c80ffae4b6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mpxl.dts
@@ -459,11 +459,23 @@ &usb3_0 {
 	status = "okay";
 };
 
+&usb3_1 {
+	fsl,disable-port-power-control;
+	fsl,permanently-attached;
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb3_phy0 {
 	vbus-supply = <&reg_vcc_5v0>;
 	status = "okay";
 };
 
+&usb3_phy1 {
+	vbus-supply = <&reg_vcc_5v0>;
+	status = "okay";
+};
+
 &usb_dwc3_0 {
 	/* dual role is implemented, but not a full featured OTG */
 	hnp-disable;
@@ -484,6 +496,32 @@ connector {
 	};
 };
 
+&usb_dwc3_1 {
+	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbhub>;
+	snps,dis_u3_susphy_quirk;
+	status = "okay";
+
+	hub_2_0: hub@1 {
+		compatible = "usb451,8142";
+		reg = <1>;
+		peer-hub = <&hub_3_0>;
+		reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&reg_vcc_3v3>;
+	};
+
+	hub_3_0: hub@2 {
+		compatible = "usb451,8140";
+		reg = <2>;
+		peer-hub = <&hub_2_0>;
+		reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&reg_vcc_3v3>;
+	};
+};
+
 &usdhc2 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
@@ -714,6 +752,10 @@ pinctrl_usbcon0: usb0congrp {
 		fsl,pins = <MX8MP_IOMUXC_GPIO1_IO10__GPIO1_IO10		0x1c0>;
 	};
 
+	pinctrl_usbhub: usbhubgrp {
+		fsl,pins = <MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11		0x10>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK		0x192>,
 			   <MX8MP_IOMUXC_SD2_CMD__USDHC2_CMD		0x1d2>,
-- 
2.25.1

