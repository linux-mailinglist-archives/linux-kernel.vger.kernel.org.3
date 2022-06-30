Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12D2561F58
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbiF3Pdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiF3Pd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:33:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE17E5592;
        Thu, 30 Jun 2022 08:33:26 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8AAD26601966;
        Thu, 30 Jun 2022 16:33:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656603204;
        bh=EudDgFiZB1R9NaUbxHSruCGuiD0p7vpdf1apIJF86C8=;
        h=From:To:Cc:Subject:Date:From;
        b=a22QgeEDiZNL1AUeZlBoDNE8gsCktZVRPfcQ6Tj+bhXjunFSzUdo0LsPkkxsLxllR
         Zs2ZkGg9cr+WB2BGKG1tvraC5g4zJTgYefqiB/WuMFtdhXe2s0yWG2vYA+7TEA7Lo4
         sgwR7l0/LEnGywJcbG126AEI7SOT9VhxH9IlJN7zpDH+WUImRaBi/zfKEAiWjldD7A
         kERUlxwVHhnAO/bmwhZ3iD9jOwenRzvhuIln1Hf24uVb6QGprJgO24V2YDR/6YiV0j
         OzoD1r1JCC4hQ9Lr/eXm0XKXSOo10WZaxcdDCD/cehyopMG0aBgDJUXZ3nPu/W9MyP
         jMmJx6cJPlbzA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        gtk3@inbox.ru, luca@z3ntu.xyz, sam.shih@mediatek.com,
        sean.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH 00/11] MT8195 Chromebooks devicetrees - Google Tomato
Date:   Thu, 30 Jun 2022 17:33:05 +0200
Message-Id: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

This is the first part for upstreaming Google's Cherry Tomato
Chromebook (Acer Chromebook Spin 513): in this series, we introduce
the devicetrees for the four revisions of this Chromebook and enable
every controller and feature that can be added as per the current
state of the main SoC devicetrees (mt8195.dtsi) and its PMIC
devicetree (mt6359.dtsi).

More parts will come as soon as more support will be added by
MediaTek in the mt8195 devicetree.

Note: This series will introduce a dtbs_check warning about a failure
      to match compatible for 'mediatek,mt6359': that's expected, as
      this is defined in devicetree/bindings/mfd/mt6397.txt (so there
      is no schema, yet).


This series depends on the following fixes:
[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220630110453.186526-1-angelogioacchino.delregno@collabora.com/
[2]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220630122334.216903-1-angelogioacchino.delregno@collabora.com/
[3]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220630131543.225554-1-angelogioacchino.delregno@collabora.com/

AngeloGioacchino Del Regno (11):
  dt-bindings: arm: mediatek: Add MT8195 Cherry Tomato Chromebooks
  arm64: dts: mediatek: Introduce MT8195 Cherry platform's Tomato
  arm64: dts: mediatek: cherry: Assign interrupt line to MT6359 PMIC
  arm64: dts: mediatek: cherry: Add platform regulators layout and
    config
  arm64: dts: mediatek: cherry: Add support for internal eMMC storage
  arm64: dts: mediatek: cherry: Document gpios and add default pin
    config
  arm64: dts: mediatek: cherry: Enable I2C and SPI controllers
  arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers
  arm64: dts: mediatek: cherry: Enable MT6360 sub-pmic on I2C7
  arm64: dts: mediatek: cherry: Enable support for the SPI NOR flash
  arm64: dts: mediatek: cherry: Add I2C-HID touchscreen on I2C4

 .../devicetree/bindings/arm/mediatek.yaml     |  13 +
 arch/arm64/boot/dts/mediatek/Makefile         |   3 +
 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  15 +
 .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  35 +
 .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  36 +
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 715 ++++++++++++++++++
 6 files changed, 817 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi

-- 
2.35.1

