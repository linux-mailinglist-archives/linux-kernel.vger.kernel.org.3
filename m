Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC1947163D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 21:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhLKUkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 15:40:32 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:34768 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231292AbhLKUk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 15:40:26 -0500
X-UUID: cfad6ca73e2d44ddbc05cfe0c5cc520b-20211212
X-UUID: cfad6ca73e2d44ddbc05cfe0c5cc520b-20211212
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1254169002; Sun, 12 Dec 2021 04:40:18 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 12 Dec 2021 04:40:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 12 Dec
 2021 04:40:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 12 Dec 2021 04:40:17 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <matthias.bgg@gmail.com>, <broonie@kernel.org>
CC:     <bgolaszewski@baylibre.com>, <sean.wang@mediatek.com>,
        <bayi.cheng@mediatek.com>, <gch981213@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v6 0/4] Add basic SoC support for mediatek mt8195
Date:   Sun, 12 Dec 2021 04:40:10 +0800
Message-ID: <20211211204014.8014-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic SoC support for Mediatek's SoC MT8195.

---
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

Tinghan Shen (4):
  dt-bindings: arm: mediatek: add mt8195 pericfg compatible
  dt-bindings: spi: add new clock name 'axi' for spi nor
  dt-bindings: pinctrl: mt8195: add 'pins' wrapping node
  arm64: dts: Add mediatek SoC mt8195 and evaluation board

 .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
 .../bindings/pinctrl/pinctrl-mt8195.yaml      |  307 ++---
 .../bindings/spi/mediatek,spi-mtk-nor.yaml    |    6 +-
 arch/arm64/boot/dts/mediatek/Makefile         |    1 +
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts   |  209 ++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 1034 +++++++++++++++++
 6 files changed, 1410 insertions(+), 148 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi

-- 
2.18.0

