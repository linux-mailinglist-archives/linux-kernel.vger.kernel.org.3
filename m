Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D89C58FE10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiHKOIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiHKOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:08:09 -0400
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F256A8D3D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:08:06 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M3TD421tWzMqd6N;
        Thu, 11 Aug 2022 16:08:04 +0200 (CEST)
Received: from philippe-pc.toradex.int (unknown [31.10.206.125])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4M3TD33qzwzlnSCp;
        Thu, 11 Aug 2022 16:08:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1660226884;
        bh=4P5wFVHP/eifLMBuIeuCofL/rr2vQY8FapKBSxxQcyg=;
        h=From:To:Cc:Subject:Date:From;
        b=XYaPGguxH+lQL1/6W4Ph0J7UjMEKkgfqsM9TjrbrUCxamCHTrmtUTdXbFRsgMCqTX
         efm06gZ3YdCrMnKGI3D7y/FQk+cOBYDGpCFBuEFSzbHQcWtKDk+WACqldIsQ1ssjIS
         YnGSskjl/3mDE36/Ti9Ki4dgKzhLtDUHeWL3FqNw=
From:   Philippe Schenker <dev@pschenker.ch>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Peter Chen <peter.chen@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: verdin-imx8mm: add otg2 pd to usbphy
Date:   Thu, 11 Aug 2022 16:07:38 +0200
Message-Id: <20220811140738.96348-1-dev@pschenker.ch>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

The Verdin iMX8M Mini System on Module does not have USB-ID signal
connected on Verdin USB_2 (usbotg2). On Verdin Development board this is
no problem, as we have connected a USB-Hub that is always connected.

However, if Verdin USB_2 is desired to be used as a single USB-Host port
the chipidea driver does not detect if a USB device is plugged into this
port, due to runtime pm shutting down the PHY.

Add the power-domain &pgc_otg2 to &usbphynop2 in order to detect
plugging events and enumerate the usb device.

Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v2:
- Changed word VBUS to USB-ID, as from mailinglist discussions I
  obviously mixed that up before.

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index d1b4582f44c4..34808aa36c2b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -745,6 +745,7 @@ &usbphynop1 {
 };
 
 &usbphynop2 {
+	power-domains = <&pgc_otg2>;
 	vcc-supply = <&reg_vdd_3v3>;
 };
 
-- 
2.37.1

