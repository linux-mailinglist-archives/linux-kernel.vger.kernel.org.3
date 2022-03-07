Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F74CF1FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 07:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbiCGGjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 01:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiCGGjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 01:39:08 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8B5205FA;
        Sun,  6 Mar 2022 22:38:14 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4CF4F201416;
        Mon,  7 Mar 2022 07:38:13 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 026E82020DF;
        Mon,  7 Mar 2022 07:38:13 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 38390183AD0B;
        Mon,  7 Mar 2022 14:38:11 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v1 0/7] Add the iMX8MP PCIe support
Date:   Mon,  7 Mar 2022 14:29:09 +0800
Message-Id: <1646634556-23779-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the i.MX8MP GPC and blk-ctrl patch-set [1] issued by Lucas.
This series patches add the i.MX8MP PCIe support.
- i.MX8MP PCIe PHY has two resets refer to the i.MX8MM PCIe PHY.
  Add one more PHY reset for i.MX8MP PCIe PHY accordingly.
- Add the i.MX8MP PCIe PHY support in the i.MX8M PCIe PHY driver.
  And share as much as possible codes with i.MX8MM PCIe PHY.
- Add the i.MX8MP PCIe support in binding document, DTS files, and PCIe
  driver.
Clean up some debug codes, re-send the v1 patch-set.

[1]:https://patchwork.kernel.org/project/linux-arm-kernel/cover/20220228201731.3330192-1-l.stach@pengutronix.de/

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   1 +
Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |   4 +-
arch/arm64/boot/dts/freescale/imx8mp-evk.dts                 |  55 ++++++++++++++++++
arch/arm64/boot/dts/freescale/imx8mp.dtsi                    |  46 +++++++++++++++-
drivers/pci/controller/dwc/pci-imx6.c                        |  19 ++++++-
drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   | 248 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
drivers/reset/reset-imx7.c                                   |   1 +
7 files changed, 327 insertions(+), 47 deletions(-)

[PATCH v1 1/7] reset: imx7: Add the iMX8MP PCIe PHY PERST support
[PATCH v1 2/7] dt-binding: phy: Add iMX8MP PCIe PHY binding
[PATCH v1 3/7] phy: freescale: imx8m-pcie: Add iMX8MP PCIe PHY
[PATCH v1 4/7] dt-bindings: imx6q-pcie: Add iMX8MP PCIe compatible
[PATCH v1 5/7] arm64: dts: imx8mp: add the iMX8MP PCIe support
[PATCH v1 6/7] arm64: dts: imx8mp-evk: Add PCIe support
[PATCH v1 7/7] PCI: imx6: Add the iMX8MP PCIe support

