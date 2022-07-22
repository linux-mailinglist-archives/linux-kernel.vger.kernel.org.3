Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0813657DD23
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbiGVJGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiGVJGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:06:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC43A77546;
        Fri, 22 Jul 2022 02:06:15 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D4CCD6601AC4;
        Fri, 22 Jul 2022 10:06:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658480774;
        bh=CfNQdn+7bRVPCo6r1q63+2yJ9heXyDofUvE37G3Wn3g=;
        h=From:To:Cc:Subject:Date:From;
        b=Vn4cBVxr8viaIkZ2d+cawX2RWBiO0Fg4TfunGXkNB7nTTnqsBVqmC3lzGy8ok8b0b
         4pZP5jijtwG79+rbxW4MODo9Pse6oDuEDKtyAJH7xVpd7QHMUbwfpDE/YPy1tNLbMQ
         DnnvZjQvhceXzviE+7tcfLDUpKyb0FfxDeFb2zOZX5oy721cZj/AyIeNMpE7fihz0B
         oXiEDR3+g3smefgMn8LlhrAxAThuR07ae7FgEof4gG/gA/LtSSU0fZ+7ZMVSPzsn/o
         wIllGqsaIoj60txIRCTZSyhJ+4cEoZ+OJt56Azjvj+dt8Pce/gekbCj38aBgXciV9x
         MBhPGBRsned/A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, y.oudjana@protonmail.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, ikjn@chromium.org,
        miles.chen@mediatek.com, sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
Subject: [PATCH v6 0/8] MediaTek Helio X10 MT6795 - Clock drivers
Date:   Fri, 22 Jul 2022 11:06:01 +0200
Message-Id: <20220722090609.52364-1-angelogioacchino.delregno@collabora.com>
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

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This (very big) series introduces system clock, multimedia clock drivers
(including resets) for this SoC.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

This series depends on, and can be merged on top of:
[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=640122
[2]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849

Changes in v6:
 - Added helper function to cleanly unregister ref2usb_tx clocks
 - Added missing error handling and remove function to clk-mt6795-mm

Changes in v5:
 - Renamed clock/reset header filenames to add vendor prefix
 - Removed quotes for $id, $schema in commit [4/7]

Changes in v4:
 - Removed unnecessary examples for clock controllers in commit [4/7]
 - Fixed one instance of 88 columns line wrap in commit [4/7]

Changes in v3:
 - Fixed typo in commit [4/7]

Changes in v2:
 - Fixed yaml clock bindings as per Rob's review
 - Added ability to compile all MT6795 clock drivers as modules
 - Added commits to export some symbols, required to compile as module


AngeloGioacchino Del Regno (8):
  dt-bindings: mediatek: Document MT6795 system controllers bindings
  dt-bindings: clock: Add MediaTek Helio X10 MT6795 clock bindings
  dt-bindings: reset: Add bindings for MT6795 Helio X10 reset
    controllers
  dt-bindings: clock: mediatek: Add clock driver bindings for MT6795
  clk: mediatek: clk-apmixed: Remove unneeded __init annotation
  clk: mediatek: Export required symbols to compile clk drivers as
    module
  clk: mediatek: clk-apmixed: Add helper function to unregister
    ref2usb_tx
  clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers

 .../arm/mediatek/mediatek,infracfg.yaml       |   2 +
 .../bindings/arm/mediatek/mediatek,mmsys.yaml |   1 +
 .../arm/mediatek/mediatek,pericfg.yaml        |   1 +
 .../bindings/clock/mediatek,apmixedsys.yaml   |   1 +
 .../bindings/clock/mediatek,mt6795-clock.yaml |  66 ++
 .../clock/mediatek,mt6795-sys-clock.yaml      |  54 ++
 .../bindings/clock/mediatek,topckgen.yaml     |   1 +
 drivers/clk/mediatek/Kconfig                  |  37 ++
 drivers/clk/mediatek/Makefile                 |   6 +
 drivers/clk/mediatek/clk-apmixed.c            |  12 +-
 drivers/clk/mediatek/clk-cpumux.c             |   2 +
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c  | 157 +++++
 drivers/clk/mediatek/clk-mt6795-infracfg.c    | 151 +++++
 drivers/clk/mediatek/clk-mt6795-mfg.c         |  50 ++
 drivers/clk/mediatek/clk-mt6795-mm.c          | 132 ++++
 drivers/clk/mediatek/clk-mt6795-pericfg.c     | 160 +++++
 drivers/clk/mediatek/clk-mt6795-topckgen.c    | 610 ++++++++++++++++++
 drivers/clk/mediatek/clk-mt6795-vdecsys.c     |  55 ++
 drivers/clk/mediatek/clk-mt6795-vencsys.c     |  50 ++
 drivers/clk/mediatek/clk-mtk.c                |   2 +
 drivers/clk/mediatek/clk-mtk.h                |   1 +
 drivers/clk/mediatek/reset.c                  |   1 +
 .../dt-bindings/clock/mediatek,mt6795-clk.h   | 275 ++++++++
 .../reset/mediatek,mt6795-resets.h            |  53 ++
 24 files changed, 1879 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt6795-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-vdecsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-vencsys.c
 create mode 100644 include/dt-bindings/clock/mediatek,mt6795-clk.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6795-resets.h

-- 
2.35.1

