Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9FA572F83
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiGMHro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiGMHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:47:41 -0400
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 00:47:39 PDT
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD8FE5DD5;
        Wed, 13 Jul 2022 00:47:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 781C1C0142;
        Wed, 13 Jul 2022 09:41:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1657698098; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=JDQJvV5fPEycK4HRG4YFHEdBvu0jCgAbXPDA61SwOkA=;
        b=Gsux09wlTqVjJYIPS2ZlponisZumHxcZCKDzQhHF0fIsWMxp6i7qxr6KaAJSvAQzLliXiC
        UcJoTIqSpc9QlG8D9DCdwFJ+bJCIwI3yL3sQzlwsSiPegUMtfDDNUNizOCnxLEdGStkKRd
        z0ZIf3Obvm643900QHTq+uw4Crlg2kXTjfLrmcRgPmCnCcPEEI+aqViK5Lj5xArlOuJc+y
        JpVoygulB5nw4cCMamRy0nRF7RNdb8QJUaV9edr3buwt9aTR3z8GPtxuYHZy2b170SHb6H
        b7coOk0Dnw70xa/9BlWo33zj8Hzro0A52opu73QOnH7FiKpnArzwsqVxqVL4gg==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/6] arm64: dts: imx8mm-kontron: Improvements and OSM board support
Date:   Wed, 13 Jul 2022 09:41:11 +0200
Message-Id: <20220713074118.14733-1-frieder@fris.de>
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

This set contains a few small improvements for the imx8mm-kontron devicetrees
(patch 1 to 4) and support for a new SoM (patch 5-6, including baseboard) that
complies to the Open Standard Module (OSM) 1.0 hardware specification, size S
(https://sget.org/standards/osm).

Frieder Schrempf (6):
  arm64: dts: imx8mm-kontron: Adjust board and SoM model strings
  arm64: dts: imx8mm-kontron: Use the VSELECT signal to switch SD card
    IO voltage
  arm64: dts: imx8mm-kontron: Remove low DDRC operating point
  arm64: dts: imx8mm-kontron: Use upper case PMIC regulator names
  arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S
  dt-bindings: arm: fsl: Add Kontron BL i.MX8MM OSM-S board

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-kontron-n801x-s.dts  |   5 +-
 .../freescale/imx8mm-kontron-n801x-som.dtsi   |  30 +-
 .../dts/freescale/imx8mm-kontron-n802x-s.dts  | 377 ++++++++++++++++++
 .../freescale/imx8mm-kontron-n802x-som.dtsi   | 309 ++++++++++++++
 6 files changed, 709 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n802x-s.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n802x-som.dtsi

-- 
2.37.0
