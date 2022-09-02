Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E935AAA59
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiIBInV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiIBInE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:43:04 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D79B95A8;
        Fri,  2 Sep 2022 01:43:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 6B7D7DFD92;
        Fri,  2 Sep 2022 01:42:30 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8YpgOypMxvnP; Fri,  2 Sep 2022 01:42:29 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1662108149; bh=yaZZI5m921+EyANDEcdH4Vsbrq6CyoF91jveOMdpW9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=plykktG6ighlbWkyyri5fPSEEEt1SrU6ShxPOz6ODAJmKs5BPe3W40eRHBQEh0wRS
         T+tNCGI32JWdV2uwOuJsmN8i353rJqTVyTFM/StkDteSCSbi7ibyQd3d5BTpiAxoUf
         XQGj4sG4Qa7ufMbmWg/+J3mFdAutENPWjOa3PySQvh5w5N9MXOtJbRmHETyyDyWEyV
         OY2UJFN/RvG7djNNDjykhC9p797mN39h3IyYVS814AVDfC/5C0pkoU3w+aeyNId4og
         rcg0OaZ8deLf/6+e+nP9wjwRoqH5lnW+r1AT2OoUxaJrPOfmoJ5nDZhCf8X+qgmBtG
         2MT4ZdcxB28AQ==
To:     festevam@gmail.com, shawnguo@kernel.org
Cc:     martin.kepplinger@puri.sm, devicetree@vger.kernel.org,
        kernel@pengutronix.de, kernel@puri.sm, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v2 1/6] arm64: dts: imx8mq-librem5: describe the voice coil motor for focus control
Date:   Fri,  2 Sep 2022 10:42:11 +0200
Message-Id: <20220902084216.1259202-2-martin.kepplinger@puri.sm>
In-Reply-To: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
References: <20220902084216.1259202-1-martin.kepplinger@puri.sm>
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

