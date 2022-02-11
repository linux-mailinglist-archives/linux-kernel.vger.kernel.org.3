Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB714B2932
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbiBKPjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:39:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiBKPi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:38:59 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0EC13A;
        Fri, 11 Feb 2022 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date
        :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=1n07FGJBspLGZL5CXbur46zxCB6JOx/ZWd3JGbPczPE=; b=V
        OrGM09Bk1nDxlN3lE8TOoakvExcTCFoI852CVxjr98QDbEccBfX4FDH6avcE0TkZ+k4O8tVuxTPfg
        yiV13szUbthBnziQEodYmU70KVP7mJOJB630sOpHMgtEQid7obooR+1rP3ecRYK4U7NzTjn2rrj1G
        t3ATznZQ5Kt/fLpI=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:55258 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1nIY0Z-0003z0-8D; Fri, 11 Feb 2022 10:38:52 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Feb 2022 10:38:43 -0500
Message-Id: <20220211153843.3721618-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] arm64: dts: imx8mp-evk: add support for I2C5
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add support for i2c5, which is used to access the
external I2C bus on connector J22 of the imx8mp-evk.

Limit the speed to 100kHz since this is an external I2C bus.

Disabled by default, since it is shared with the CAN1 bus.

To enable i2c5, you need to disable the CAN1 function, enable the i2c5
function and also configure the CAN1/I2C5_SEL GPIO to HIGH to
select i2c5 instead of CAN1. This can be done by defining a gpio-hog
inside the pca6416 node, in your board device tree, like in this example:

&flexcan1 {
	status = "disabled";
};

&i2c5 {
	status = "okay";
};

&pca6416 {
	can1-i2c5-sel-hog {
		gpio-hog;
		gpios = <2 GPIO_ACTIVE_HIGH>;
		output-high;
		line-name = "can1-i2c5-sel";
	};
};

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index a82c31dbdbf3..4c3ac4214a2c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -319,6 +319,21 @@ pca6416: gpio@20 {
 	};
 };
 
+/* I2C on expansion connector J22. */
+&i2c5 {
+	clock-frequency = <100000>; /* Lower clock speed for external bus. */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c5>;
+	status = "disabled"; /* can1 pins conflict with i2c5 */
+
+	/* GPIO 2 of PCA6416 is used to switch between CAN1 and I2C5 functions:
+	 *     LOW:  CAN1 (default, pull-down)
+	 *     HIGH: I2C5
+	 * You need to set it to high to enable I2C5 (for example, add gpio-hog
+	 * in pca6416 node).
+	 */
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -464,6 +479,13 @@ MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c5: i2c5grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SPDIF_RX__I2C5_SDA         0x400001c3
+			MX8MP_IOMUXC_SPDIF_TX__I2C5_SCL         0x400001c3
+		>;
+	};
+
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03	0x000001c0
-- 
2.30.2

