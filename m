Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD0757CE27
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiGUOue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiGUOub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:50:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AFD2019E;
        Thu, 21 Jul 2022 07:50:30 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1FD1E6601AAA;
        Thu, 21 Jul 2022 15:50:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658415028;
        bh=wGbwT5jBrPv2vLl+3BSZalWhnDZWaPGXrP0f6gHkLT8=;
        h=From:To:Cc:Subject:Date:From;
        b=ImqwbHwSMz6hDczFLt/n1zmq30miovI+4MkYwIX5Ixa4vo/ZYATMe5GACXaV1WmxE
         ZBBZOQYRtWJjjUn9JnREj/TiXUw56G77KfV6Dy8AHLss1E08QoBQ8wUt+BKbxt0dDH
         f1zw4SQvIhFGdbkJw0dTQnSep2Tgx9hIVRyiXXimmpxkMVvmvqulnnus5Ds9LYbWcH
         C9D/Karn04H7A6T0j1DHveSABt0pErytC36nUMkS/L5rEJ2aZz0AYmQ5N0nDCUw0D/
         tH/F4MCp0h7ORhPJD8bE/JG+giIDe9l06e8mSBQZtxg3HA6KPHuJmMAJx5pRq035RS
         toz57VEHXnMew==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/8] MT8195 Acer Tomato - devicetrees Part 2
Date:   Thu, 21 Jul 2022 16:50:09 +0200
Message-Id: <20220721145017.918102-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables more functionality on the MT8195 Tomato Chromebooks,
bringing it to an almost usable state.

With this series, the device is able to boot from the MicroSD card
and is able to communicate with the EC for various functions,
including the enablement of the Chromebook's keyboard, battery
charging, fuel gauge and other standard ChromeOS EC functionality.

This also enables the Audio DSP, codec and sound card and adds support
for the regulators found on the SPMI bus.

What's missing (coming in the next part)?

* Format:    feature  (location)
*
* MediaTek vcodec enc/dec (mt8195.dtsi only)
* PCI-Express WiFi card (mt8195 and mt8195-cherry)
* VDOSYS1 (mt8195.dtsi and mediatek-drm/mmsys drivers)
* DP/eDP outputs for external/internal display (mt8195 and mt8195-cherry)
* LVTS Thermal Sensors (mt8195.dtsi, driver is missing)
* GPU support (comes later, clocks implementation is in the works)


### NOTE: ###

This series depends on MediaTek's MT8195 new device nodes [1] series

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?submitter=196333


Changes in v2:
 - Fixed *huge* mistake on patch [8/8] (truly sorry!!!)

AngeloGioacchino Del Regno (8):
  arm64: dts: mediatek: cherry: Enable the System Companion Processor
  arm64: dts: mediatek: cherry: Wire up the ChromeOS EC and GSC
  arm64: dts: mediatek: cherry: Add keyboard mapping for the top row
  arm64: dts: mediatek: cherry: Enable secondary SD/MMC controller
  arm64: dts: mediatek: cherry: Enable Elantech eKTH3000 i2c trackpad
  arm64: dts: mediatek: cherry: Enable DSP, audio codec and sound card
  arm64: dts: mediatek: cherry: Enable keyboard PWM backlight
  arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus

 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  10 +
 .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  10 +
 .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  10 +
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 403 ++++++++++++++++++
 4 files changed, 433 insertions(+)

-- 
2.35.1

