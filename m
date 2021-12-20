Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99EE047A95C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhLTMSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:18:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56954 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232433AbhLTMSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:18:44 -0500
X-UUID: a54850af568f49b685d2af8303344ea1-20211220
X-UUID: a54850af568f49b685d2af8303344ea1-20211220
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 985129714; Mon, 20 Dec 2021 20:18:38 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 20 Dec 2021 20:18:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 20 Dec
 2021 20:18:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 20 Dec 2021 20:18:37 +0800
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
Subject: [PATCH v7 0/4] Add basic SoC support for mediatek mt8195
Date:   Mon, 20 Dec 2021 20:18:21 +0800
Message-ID: <20211220121825.6446-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic SoC support for Mediatek's SoC MT8195.

---
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

Tinghan Shen (4):
  dt-bindings: arm: mediatek: add mt8195 pericfg compatible
  dt-bindings: spi: spi-mtk-nor: add new clock name 'axi' for spi nor
  dt-bindings: pinctrl: mt8195: add wrapping node of pin configurations
  arm64: dts: Add mediatek SoC mt8195 and evaluation board

 .../arm/mediatek/mediatek,pericfg.yaml        |    1 +
 .../bindings/pinctrl/pinctrl-mt8195.yaml      |  336 +++---
 .../bindings/spi/mediatek,spi-mtk-nor.yaml    |    6 +-
 arch/arm64/boot/dts/mediatek/Makefile         |    1 +
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts   |  209 ++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 1034 +++++++++++++++++
 6 files changed, 1437 insertions(+), 150 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi

-- 
2.18.0

