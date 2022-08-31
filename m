Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779065A7870
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiHaIEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiHaIE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:04:29 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F344FC58D1;
        Wed, 31 Aug 2022 01:04:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C8770DF6D2;
        Wed, 31 Aug 2022 01:03:30 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Dp67oS9Wm6KH; Wed, 31 Aug 2022 01:03:30 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1661933010; bh=yaZZI5m921+EyANDEcdH4Vsbrq6CyoF91jveOMdpW9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4BdqsmOdXvCkyS4IHTVAWMXjhMNfB6SrDRbYIyTq3AJFB85ij6yn+c0/Nj5CkXl9
         2yXOF4/HzDUfYH0tgj0Ocz4LxdFS5osoMMd5Fd279bWllj0DR3ZNgx964PxU9TSHzn
         kR37teHWkQrckZgn9jTRQDZ87G6sN7X+MNrLfgQj7CufKXnNGsnZaeDObLdj57YVeA
         hop9g72A8OfD+XcfnBjWPm6I+9ii7TIE0DQWTlWIVWuWCpRuRXQxtq/O8SeByf1yXg
         GWzhq1PXyzzCsi+IAfCTrY8s71IIpUl3Fatqq7qdh2jZEaR8yYPszxFoxPUGafKjX9
         kBOh/2srCxJ6Q==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v1 1/5] arm64: dts: imx8mq-librem5: describe the voice coil motor for focus control
Date:   Wed, 31 Aug 2022 10:02:57 +0200
Message-Id: <20220831080301.1092737-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220831080301.1092737-1-martin.kepplinger@puri.sm>
References: <20220831080301.1092737-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the focus motor that will be used for the rear camera - even
though the rear camera sensor driver is not yet in the mainline. The
focus motor is a separate device and can be controlled already.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 9eec8a7eecfc8..0626e4194d958 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1070,6 +1070,12 @@ &i2c4 {
 	pinctrl-0 = <&pinctrl_i2c4>;
 	status = "okay";
 
+	vcm@c {
+		compatible = "dongwoon,dw9714";
+		reg = <0x0c>;
+		vcc-supply = <&reg_csi_1v8>;
+	};
+
 	bat: fuel-gauge@36 {
 		compatible = "maxim,max17055";
 		reg = <0x36>;
-- 
2.30.2

