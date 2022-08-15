Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7268A592DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbiHOLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbiHOLCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:02:34 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2698224095;
        Mon, 15 Aug 2022 04:02:30 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8926BFC15;
        Mon, 15 Aug 2022 13:02:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660561347; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=di9qAzMMt0Uch8kPIvSmTcNkx/O6Br+B8hRhRF4lYGs=;
        b=krvljssHeJ6ZlYsMS9O9emhoDvEBaxp0Pugx2H+g7k3oMNwALh8w3y+bwJ7C1rKPSbNl4m
        +pJOuJwF+2LJ1FGq0/Ke1iuDLy0SpYnOExZD01nfhYM0Z8wfj1BGs/9Lamt2jtWnUuJljV
        pVozdiXnlFSxcJlUQ3HpmNFXNdgP9lx37NhtZ+Sl/6IADT/9nkLa13Gl0Q4PlOgPIz4qo5
        +k89kX7ekkge0zBDegRb2rPx2dDUVfXM1XQbaeFccdWoOKNVkXkMaBpmFaZ5OQNyWEVub1
        4bRl1TvcDkYETHiou+xZ5rC5FcSsDtxdKXPyuojPNPvP3RbiGn6HSZIo9Cyduw==
From:   Frieder Schrempf <frieder@fris.de>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 0/8] arm64: dts: imx8mm-kontron: Improvements and OSM board support
Date:   Mon, 15 Aug 2022 13:01:23 +0200
Message-Id: <20220815110134.49683-1-frieder@fris.de>
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

This set contains a few improvements for the imx8mm-kontron devicetrees
(patch 3-7) and support for a new SoM (patch 8, including baseboard) that
complies to the Open Standard Module (OSM) 1.0 hardware specification, size S
(https://sget.org/standards/osm).

It also includes binding changes in patch 1 and 2.

Changes in v3:
* drop patch for 2 which was applied separately
* rebase on v6.0-rc1
* rename compatibles and file names

Changes in v2:
* move binding changes to beginning of patchset
* Allow arbitrary regulator names in PCA9450 bindings
* Use voltage rail names from schematic for PMIC regulator-names
* Add SPI NOR partition layout to devicetree
* Remove unneeded header include
* Add tags

Frieder Schrempf (8):
  dt-bindings: arm: fsl: Rename compatibles for Kontron i.MX8MM
    SoM/board
  dt-bindings: arm: fsl: Add Kontron BL i.MX8MM OSM-S board
  arm64: dts: imx8mm-kontron: Adjust compatibles, file names and model
    strings
  arm64: dts: imx8mm-kontron: Use the VSELECT signal to switch SD card
    IO voltage
  arm64: dts: imx8mm-kontron: Remove low DDRC operating point
  arm64: dts: imx8mm-kontron: Use voltage rail names from schematic for
    PMIC regulator-names
  arm64: dts: imx8mm-kontron: Add SPI NOR partition layout
  arm64: dts: Add support for Kontron SL/BL i.MX8MM OSM-S

 .../devicetree/bindings/arm/fsl.yaml          |  13 +-
 arch/arm64/boot/dts/freescale/Makefile        |   3 +-
 .../dts/freescale/imx8mm-kontron-bl-osm-s.dts | 376 ++++++++++++++++++
 ...tron-n801x-s.dts => imx8mm-kontron-bl.dts} |   7 +-
 .../dts/freescale/imx8mm-kontron-osm-s.dtsi   | 330 +++++++++++++++
 ...-n801x-som.dtsi => imx8mm-kontron-sl.dtsi} |  53 ++-
 6 files changed, 757 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
 rename arch/arm64/boot/dts/freescale/{imx8mm-kontron-n801x-s.dts => imx8mm-kontron-bl.dts} (96%)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
 rename arch/arm64/boot/dts/freescale/{imx8mm-kontron-n801x-som.dtsi => imx8mm-kontron-sl.dtsi} (87%)

-- 
2.37.1

