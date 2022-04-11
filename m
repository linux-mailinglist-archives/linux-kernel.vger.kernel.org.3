Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259414FB1AD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 04:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243647AbiDKCaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 22:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiDKCaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 22:30:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959063878D;
        Sun, 10 Apr 2022 19:28:04 -0700 (PDT)
X-UUID: f309404746e246b4a03a226ae0e23382-20220411
X-UUID: f309404746e246b4a03a226ae0e23382-20220411
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 63912116; Mon, 11 Apr 2022 10:27:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 11 Apr 2022 10:27:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 10:27:55 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <ryder.lee@kernel.org>, <wenst@chromium.org>,
        <chunfeng.yun@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH v14 0/2] Add basic SoC support for mediatek mt8195
Date:   Mon, 11 Apr 2022 10:27:22 +0800
Message-ID: <20220411022724.11005-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic SoC support for Mediatek's SoC MT8195.

---
Changes in v14:
  - update pwrap dt-bindings 
    this patch is picked from 20220411014121.15015-2-zhiyong.tao@mediatek.com 
  - enable u3phy2 and u3phy3 in evb dts 
Changes in v13:
  - add more description of reg items in mtk-sd.yaml
Changes in v12:
  - update mtk-sd.yaml to extend reg property and fix yamllint error
  - add xhci nodes and move xhci3 property (usb2-lpm-disable) to evb.dts
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

Tinghan Shen (1):
  arm64: dts: Add mediatek SoC mt8195 and evaluation board

Zhiyong.Tao (1):
  dt-bindings: pwrap: mediatek: fix pwrap document for mt8195

 .../bindings/soc/mediatek/pwrap.txt           |   10 +-
 arch/arm64/boot/dts/mediatek/Makefile         |    1 +
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts   |  181 +++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 1045 +++++++++++++++++
 4 files changed, 1232 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi

-- 
2.18.0

