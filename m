Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CE3592DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbiHOLEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHOLD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:03:29 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CB924F20;
        Mon, 15 Aug 2022 04:03:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54CF3BFBD8;
        Mon, 15 Aug 2022 13:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660561381; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=iWm6cbXgNgOMu08msuouo2YkcT7OoKQnsuMv8gfoWnY=;
        b=VYnzA7HVWf1QfsDxky/vmF1o/eSVd2gyG2zJC9uZiXZIWh7O3vGULwOtR3DUuX/RwbSRUZ
        iyskd+ASS+JsnMdV6D7XofoEhstC0FU1T4Vh74SUW86ViUItbrrwYZQcId3Kgzd0TSUj6g
        52lrlGc77F4weEo191T5NwovS6XkqeRFzkQq1WheqnYn0ULFEcXW8Nm1kJYDTeG0nmi4Ee
        EhYyD6/SMJRHR6S5yRKplZRujMSXCRRXEfE6nun35kuXM3UahypulupsQKPTt4K/p4Vrgb
        dXY2z99nELxqcTghr/lV2TnFfKSx1kuauPLow6ktutrJ3ITVShddIcATcuQJkg==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 7/8] arm64: dts: imx8mm-kontron: Add SPI NOR partition layout
Date:   Mon, 15 Aug 2022 13:01:30 +0200
Message-Id: <20220815110134.49683-8-frieder@fris.de>
In-Reply-To: <20220815110134.49683-1-frieder@fris.de>
References: <20220815110134.49683-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v3:
* rebase on v6.0-rc1

Changes in v2:
* new patch
---
 .../boot/dts/freescale/imx8mm-kontron-sl.dtsi | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
index ce9c27619e26..c227ca813d9e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi
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

