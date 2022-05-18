Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5526B52B884
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiERLRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiERLRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:17:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D16D4E8;
        Wed, 18 May 2022 04:17:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6CFD71F44F12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652872620;
        bh=apn6ShGZEG3D6yLEFdVVyWQiT/UfA8DY+IFGQiBvVVc=;
        h=From:To:Cc:Subject:Date:From;
        b=kvD+UbyNikRWKEkhsNaUzIDlDfiMwgZgBJ3rEGieDNllPkYWc4+aDpPWs6IazHxsx
         hr4c8PWOcKuezXW/1mFy464M2JA0rprnyZNf7ALVRfFyPn6D+LsvOxu4uw8duDHEWl
         0oGWCcl2AVrbAcxhOb9EEpiLS3w8PAn033E+Yf7OMhgjyC0uHevkaavZMqk9u3ZeF3
         jG7EpDEE/4BChvUank65XMFjJ48pSHq2gXWeF6F3EZq+sKRd93jILnbA9fqcKsKI+P
         NThRwoxm+1O8mTwxIJRoORtyW4d9iVS7+A/4NUrAJ7buTkOVTyTSsuAxrjxdWP3Jwk
         0TQg4lEB5DBBg==
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
Subject: [PATCH v2 0/7] MediaTek Helio X10 MT6795 - Clock drivers
Date:   Wed, 18 May 2022 13:16:45 +0200
Message-Id: <20220518111652.223727-1-angelogioacchino.delregno@collabora.com>
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

This series depends on, and can be merged on top of:
[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=640122
[2]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849

Changes in v2:
 - Fixed yaml clock bindings as per Rob's review
 - Added ability to compile all MT6795 clock drivers as modules
 - Added commits to export some symbols, required to compile as module

AngeloGioacchino Del Regno (7):
  dt-bindings: mediatek: Document MT6795 system controllers bindings
  dt-bindings: clock: Add MediaTek Helio X10 MT6795 clock bindings
  dt-bindings: reset: Add bindings for MT6795 Helio X10 reset
    controllers
  dt-bindings: clock: mediatek: Add clock driver bindings for MT6795
  clk: mediatek: clk-apmixed: Remove unneeded __init annotation
  clk: mediatek: Export required symbols to compile clk drivers as
    module
  clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers

 .../arm/mediatek/mediatek,infracfg.yaml       |   2 +
 .../bindings/arm/mediatek/mediatek,mmsys.yaml |   1 +
 .../arm/mediatek/mediatek,pericfg.yaml        |   1 +
 .../bindings/clock/mediatek,apmixedsys.yaml   |   1 +
 .../bindings/clock/mediatek,mt6795-clock.yaml |  66 ++
 .../clock/mediatek,mt6795-sys-clock.yaml      |  74 +++
 .../bindings/clock/mediatek,topckgen.yaml     |   1 +
 drivers/clk/mediatek/Kconfig                  |  37 ++
 drivers/clk/mediatek/Makefile                 |   6 +
 drivers/clk/mediatek/clk-apmixed.c            |   3 +-
 drivers/clk/mediatek/clk-cpumux.c             |   2 +
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c  | 157 +++++
 drivers/clk/mediatek/clk-mt6795-infracfg.c    | 148 +++++
 drivers/clk/mediatek/clk-mt6795-mfg.c         |  50 ++
 drivers/clk/mediatek/clk-mt6795-mm.c          | 106 +++
 drivers/clk/mediatek/clk-mt6795-pericfg.c     | 160 +++++
 drivers/clk/mediatek/clk-mt6795-topckgen.c    | 611 ++++++++++++++++++
 drivers/clk/mediatek/clk-mt6795-vdecsys.c     |  55 ++
 drivers/clk/mediatek/clk-mt6795-vencsys.c     |  50 ++
 drivers/clk/mediatek/clk-mtk.c                |   2 +
 drivers/clk/mediatek/reset.c                  |   1 +
 include/dt-bindings/clock/mt6795-clk.h        | 275 ++++++++
 include/dt-bindings/reset/mt6795-resets.h     |  50 ++
 23 files changed, 1858 insertions(+), 1 deletion(-)
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
 create mode 100644 include/dt-bindings/clock/mt6795-clk.h
 create mode 100644 include/dt-bindings/reset/mt6795-resets.h

-- 
2.35.1

