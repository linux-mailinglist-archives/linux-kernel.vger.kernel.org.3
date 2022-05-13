Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667B152679F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382675AbiEMQvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382697AbiEMQvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:51:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A06527F6;
        Fri, 13 May 2022 09:50:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C50451F42289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652460656;
        bh=+xBBNGyIiNxlh6qLU8iRTsoeX33SDyUBO7XLJdSH9/M=;
        h=From:To:Cc:Subject:Date:From;
        b=Zx2VB73ycSD3mUzLcQJqWOApz3Bvr1a+l5B8r0QHnAL5qfwVcFaavfrux37fkmnyl
         7OumPCp6ZmD5caW0EBMEDKSMHkI7KijmqLHYAQfESCfDU5wsR461rBhNMljydmbhi8
         yx4ltQQ+2pB7x5KG+Rqa9fFi7GJVQnAib5mSQTqwBcCM3wwGUeP5Ts6TIsXSU2L/bt
         0N3y0UCx75DgvLF3pnJe8g+2TvHRHBP6j1yLuB6447fvkEyr2mm/pro9Gt7e7+iLGi
         WXG3tP3v92bxwGtRsCPOS8iGFtvMT8a/OUoOZAzHLA8hdglfx3RDCgaSsRJtHKZsbz
         OptOodXSQvmBA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
Subject: [PATCH 0/5] MediaTek Helio X10 MT6795 - Clock drivers
Date:   Fri, 13 May 2022 18:50:45 +0200
Message-Id: <20220513165050.500831-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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


AngeloGioacchino Del Regno (5):
  dt-bindings: mediatek: Document MT6795 system controllers bindings
  dt-bindings: clock: Add MediaTek Helio X10 MT6795 clock bindings
  dt-bindings: reset: Add bindings for MT6795 Helio X10 reset
    controllers
  dt-bindings: arm: mediatek: Add clock driver bindings for MT6795
  clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers

 .../arm/mediatek/mediatek,infracfg.yaml       |   2 +
 .../bindings/arm/mediatek/mediatek,mmsys.yaml |   1 +
 .../arm/mediatek/mediatek,mt6795-clock.yaml   |  67 ++
 .../mediatek/mediatek,mt6795-sys-clock.yaml   |  73 +++
 .../arm/mediatek/mediatek,pericfg.yaml        |   1 +
 .../bindings/clock/mediatek,apmixedsys.yaml   |   1 +
 .../bindings/clock/mediatek,topckgen.yaml     |   1 +
 drivers/clk/mediatek/Kconfig                  |  37 ++
 drivers/clk/mediatek/Makefile                 |   6 +
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c  | 154 +++++
 drivers/clk/mediatek/clk-mt6795-infracfg.c    | 145 +++++
 drivers/clk/mediatek/clk-mt6795-mfg.c         |  47 ++
 drivers/clk/mediatek/clk-mt6795-mm.c          | 103 +++
 drivers/clk/mediatek/clk-mt6795-pericfg.c     | 157 +++++
 drivers/clk/mediatek/clk-mt6795-topckgen.c    | 607 ++++++++++++++++++
 drivers/clk/mediatek/clk-mt6795-vdecsys.c     |  52 ++
 drivers/clk/mediatek/clk-mt6795-vencsys.c     |  46 ++
 include/dt-bindings/clock/mt6795-clk.h        | 275 ++++++++
 include/dt-bindings/reset/mt6795-resets.h     |  50 ++
 19 files changed, 1825 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt6795-sys-clock.yaml
 create mode 100644 drivers/clk/mediatek/clk-mt6795-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-pericfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-topckgen.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-vdecsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt6795-vencsys.c
 create mode 100644 include/dt-bindings/clock/mt6795-clk.h
 create mode 100644 include/dt-bindings/reset/mt6795-resets.h

-- 
2.35.1

