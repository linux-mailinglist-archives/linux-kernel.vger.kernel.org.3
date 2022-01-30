Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F424A3349
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 03:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353784AbiA3CcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 21:32:19 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:56378 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1346564AbiA3CcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 21:32:17 -0500
X-UUID: acce27d7611f4ec2bece075ccab458be-20220130
X-UUID: acce27d7611f4ec2bece075ccab458be-20220130
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1626602513; Sun, 30 Jan 2022 10:32:14 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 Jan 2022 10:32:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 30 Jan
 2022 10:32:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 Jan 2022 10:32:12 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>
Subject: [PATCH v10 0/3] Add basic SoC support for mediatek mt8195
Date:   Sun, 30 Jan 2022 10:32:06 +0800
Message-ID: <20220130023209.16275-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic SoC support for Mediatek's SoC MT8195.

---
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

