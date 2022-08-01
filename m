Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A159F586BAF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiHANQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiHANQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:16:07 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0462B264;
        Mon,  1 Aug 2022 06:16:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7E48BFBC6;
        Mon,  1 Aug 2022 15:15:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1659359760; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=n20eecw78N24KCT8Ahm3HDfln/rPRfajiP3bL2FlrGs=;
        b=pdgNgswtZrsx51v7nh4v33IU0NLiXWy45kzDW5tKzkBgys/a/O7gKeMV04CYiCO4vfUxn+
        SPRSZjts64T1zt/uW1ruzr+HFJjlKUUkaS8Xy2Uq3zmjynUHoMxXvk6fgxSl+c+hjdCjrj
        bwKw0YNutHT7iP0Zk2jyFAhFXDbQ2mQ3nQCS07Cc/KDIo3ZyV93FCMX/w3vp/UoMumhm2E
        mPQtt3X6CctdMi9yNYoliTynu/THuUuWJTs8oftSQGZZopPQFLRhLZd+xn6gpVK66hChKF
        wK7lruNaIe+VeAKKzdGaLkddAAuKTiTwE2u9LIZ35CbDgydVrg++w17VHkI3dw==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 0/8] arm64: dts: imx8mm-kontron: Improvements and OSM board support
Date:   Mon,  1 Aug 2022 15:15:44 +0200
Message-Id: <20220801131554.116795-1-frieder@fris.de>
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

This set contains a few small improvements for the imx8mm-kontron devicetrees
(patch 3-7) and support for a new SoM (patch 8, including baseboard) that
complies to the Open Standard Module (OSM) 1.0 hardware specification, size S
(https://sget.org/standards/osm).

It also includes binding changes for the new board (patch 1) and a binding
change for the PCA9450 PMIC regulators (patch2).

Changes in v2:
* move binding changes to beginning of patchset
* Allow arbitrary regulator names in PCA9450 bindings
* Use voltage rail names from schematic for PMIC regulator-names
* Add SPI NOR partition layout to devicetree
* Remove unneeded header include
* Add tags

Frieder Schrempf (8):
  dt-bindings: arm: fsl: Add Kontron BL i.MX8MM OSM-S board
  dt-bindings: regulator: pca9450: Allow arbitrary regulator names
  arm64: dts: imx8mm-kontron: Adjust board and SoM model strings
  arm64: dts: imx8mm-kontron: Use the VSELECT signal to switch SD card
    IO voltage
  arm64: dts: imx8mm-kontron: Remove low DDRC operating point
  arm64: dts: imx8mm-kontron: Use voltage rail names from schematic for
    PMIC regulator-names
  arm64: dts: imx8mm-kontron: Add SPI NOR partition layout
  arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../regulator/nxp,pca9450-regulator.yaml      |   8 +-
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-kontron-n801x-s.dts  |   5 +-
 .../freescale/imx8mm-kontron-n801x-som.dtsi   |  51 ++-
 .../dts/freescale/imx8mm-kontron-n802x-s.dts  | 376 ++++++++++++++++++
 .../freescale/imx8mm-kontron-n802x-som.dtsi   | 330 +++++++++++++++
 7 files changed, 754 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n802x-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n802x-som.dtsi

-- 
2.37.1

