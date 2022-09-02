Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387265AA99A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 10:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiIBIMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 04:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiIBIMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:12:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE74BCCEC;
        Fri,  2 Sep 2022 01:12:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F0A486601F01;
        Fri,  2 Sep 2022 09:12:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662106329;
        bh=a52Rb9lUaNEcUSv5/G8YM3EWPJZbdtrNJh0NmApFglg=;
        h=From:To:Cc:Subject:Date:From;
        b=LRCKklRrVvk+ft9d4GHtu/caqoAyvmhZFbdxlYs0Lb+cxFUHW4KHZ0Uulr0atjfKG
         RjF5j8la741+bFpIABO1r6rpKjtS2442yG6ca2EnjuYlxsyxUhKz9slaoLlpiQTzRh
         B9U5nezGGxrnYTCus2YnpNVzONWASEHqZl1oT0cqGfKV7olTe3msohpN6w7T/I8y/L
         XjRYLOUwbH6Jkr2zQM6AKVvlkEnyrcm35pBEulbuCvExwlBOGPy+VRD1Nmocvab2d1
         AOhLACBwsKh8ImVhjpNHo3PVhNG5hKdv/ofcQRbDvg22fbEO7zx7Nb4LhcWRzwUVdU
         Z6h/c1RbL0Ynw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 0/7] MT8195 Acer Tomato - devicetrees Part 2
Date:   Fri,  2 Sep 2022 10:11:49 +0200
Message-Id: <20220902081156.38526-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
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
* Audio/ADSP support (waiting on SOF OF commits)

Changes in v3:
 - Commonized pin definitions for secondary SD/MMC controller
 - Added firmware-name for SCP
 - Changed keyboard backlight to google,cros-kbd-led-backlight

AngeloGioacchino Del Regno (7):
  arm64: dts: mediatek: cherry: Enable the System Companion Processor
  arm64: dts: mediatek: cherry: Wire up the ChromeOS Embedded Controller
  arm64: dts: mediatek: cherry: Add Google Security Chip (GSC) TPM
  arm64: dts: mediatek: cherry: Add keyboard mapping for the top row
  arm64: dts: mediatek: cherry: Enable secondary SD/MMC controller
  arm64: dts: mediatek: cherry: Enable Elantech eKTH3000 i2c trackpad
  arm64: dts: mediatek: cherry: Enable MT6315 regulators on SPMI bus

 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 256 ++++++++++++++++++
 1 file changed, 256 insertions(+)

-- 
2.37.2

