Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FDD4B86AF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbiBPLcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:32:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiBPLb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:31:56 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5ED2982B;
        Wed, 16 Feb 2022 03:31:40 -0800 (PST)
X-UUID: 24ccf40f78b9409db20afdcc46c412ce-20220216
X-UUID: 24ccf40f78b9409db20afdcc46c412ce-20220216
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 320886192; Wed, 16 Feb 2022 19:31:37 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Feb 2022 19:31:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Feb
 2022 19:31:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 19:31:36 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Tinghan Shen" <tinghan.shen@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>
Subject: [PATCH v11 0/3] Add basic SoC support for mediatek mt8195
Date:   Wed, 16 Feb 2022 19:31:28 +0800
Message-ID: <20220216113131.13145-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic SoC support for Mediatek's SoC MT8195.

---
Changes in v11:
  - rebase on 5.17-rc4
Changes in v10:
  - clean CC list
Changes in v9:
  - remove duplicated cpus dt-bindings patch in v8
Changes in v8:
  - v7 mediatek,spi-mtk-nor.yaml patch is applied in branch for-5.17 at 
    kernel/git/broonie/spi.git
  - v7 pinctrl-mt8195.yaml patch is applied in branch for-next at 
    kernel/git/linusw/linux-pinctrl.git
  - add cortex-a78 compatible to cpus dt-bindings
  - add mediatek,drive-strength-adv property to pinctrl dt-bindings
  - fix evb dts
    - remove i2c nodes with disabled status from dts
    - fix pin properties not match pinctrl dt-bindings
    - remove unnecessary u3port*
  - fix dtsi
    - fix node format
    - reorder oscillator* nodes 
    - fix node name of cpu idle nodes
    - remove clock-frequency property in the timer node
    - reorder clock and clock names in usb nodes
Changes in v7:
  - refine title of spi-nor dt-bindings patch
  - refine commit message of pinctrl dt-bindings patch
  - update pinctrl-mt8195.yaml
    - change property pattern from 'pins' to '^pins'
    - update examples with new property in descriptions
    - add new example
  - drop '_' from node names of pinctrl subnodes in mt8195-evb.dts
Changes in v6:
  - rebase on 5.16-rc1
  - add new clock name to spi-nor dt-bindings
  - add "pins" property in pinctrl dt-bindings
  - fix fails of dtbs_checks
    - remove "arm,armv8" not matched in yaml from cpu compatile
    - fix node name of xhci
    - remvoe xhci upstreaming wakeup properties
    - remove xhci unused properties address-cells and size-cells
    - fix node name of ufs-phy 
    - fix node name of spi-nor
    - fix node name and sub-nodes of pinctrl
    - fix mmc compatible
Changes in v5:
  - enable basic nodes in mt8195-evb.dts
  - remove dedicated clock nodes
  - add mmc2 node
  - fix interrupt number of pinctrl node
  - update clock nodes to apply internal fixes
  - add dt-bindings for perficfg node

v4 thread:
https://lore.kernel.org/all/20210922093303.23720-2-seiya.wang@mediatek.com/
v3 thread:
https://lore.kernel.org/all/20210601075350.31515-2-seiya.wang@mediatek.com/
v2 thread:
https://lore.kernel.org/all/20210319023427.16711-10-seiya.wang@mediatek.com/
v1 thread:
https://lore.kernel.org/all/20210316111443.3332-11-seiya.wang@mediatek.com/
---

Tinghan Shen (3):
  dt-bindings: arm: mediatek: Add mt8195 pericfg compatible
  dt-bindings: pinctrl: mt8195: Add mediatek,drive-strength-adv property
  arm64: dts: Add mediatek SoC mt8195 and evaluation board

 .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
 .../bindings/pinctrl/pinctrl-mt8195.yaml      |   35 +
 arch/arm64/boot/dts/mediatek/Makefile         |    1 +
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts   |  161 +++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 1049 +++++++++++++++++
 5 files changed, 1247 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi

-- 
2.18.0

