Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FC7586BBA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiHANQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiHANQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:16:22 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085992FFC5;
        Mon,  1 Aug 2022 06:16:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6800CC01CB;
        Mon,  1 Aug 2022 15:16:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1659359773; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=oa9sycEErUOj2Oq3kpiFHxM6XsttM4oiFCIw5P8CBXE=;
        b=Nu9+dDEj0erdR9PyNkcR7Lyrp/6Pc4rqngUdwrFEL3CH0dBOZfzCyaDdtLEy7K928YqPs5
        JAia4T5t+89crAwuVkgzhVPZCDOTczaSFFOiJZIh7hvc3DDMbY5Tmk9WJ8/NiN4sgDL45C
        ykyW5cYngwVo14OGrnK7saVn46TIiiH0Red+4WxZW0Ke38m41NiU7zsAM5IloBDkXnARLZ
        WaSaSW0dlu4juoRK2j1u21SPzYoIJBlS0IhWO9UQmnj80ZznkFeWrYoQ9R89MDutXa1Ic0
        M5kITVGYwfLvOk1SK66mT9nhwRHMEYJIDF+Tgp4jHaIDpzAAhgn7ilHh2OZHjQ==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v2 7/8] arm64: dts: imx8mm-kontron: Add SPI NOR partition layout
Date:   Mon,  1 Aug 2022 15:15:51 +0200
Message-Id: <20220801131554.116795-8-frieder@fris.de>
In-Reply-To: <20220801131554.116795-1-frieder@fris.de>
References: <20220801131554.116795-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

This is the layout used by the bootloader. Add it to the kernel
devicetree to make the same layout available in Linux and have
the devicetrees synced.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
* new patch
---
 .../freescale/imx8mm-kontron-n801x-som.dtsi   | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index c995592981c2..bb87e8b166bf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -66,6 +66,27 @@ flash@0 {
 		compatible = "mxicy,mx25r1635f", "jedec,spi-nor";
 		spi-max-frequency = <80000000>;
 		reg = <0>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "u-boot";
+				reg = <0x0 0x1E0000>;
+			};
+
+			partition@1 {
+				label = "env";
+				reg = <0x1E0000 0x10000>;
+			};
+
+			partition@2 {
+				label = "env_redundant";
+				reg = <0x1F0000 0x10000>;
+			};
+		};
 	};
 };
 
-- 
2.37.1

