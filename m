Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB8518135
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiECJmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiECJmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:42:37 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5907832052;
        Tue,  3 May 2022 02:39:05 -0700 (PDT)
X-UUID: 73bde449d5bb49b78b8d6c6aba1f035e-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:b6f99d21-0f3b-4246-92cf-f3dfee816cba,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:20e4872f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 73bde449d5bb49b78b8d6c6aba1f035e-20220503
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 942032099; Tue, 03 May 2022 17:38:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 3 May 2022 17:38:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 3 May 2022 17:38:58 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v6 00/16] Cleanup MediaTek clk reset drivers and support MT8192/MT8195
Date:   Tue, 3 May 2022 17:38:40 +0800
Message-ID: <20220503093856.22250-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

In this series, we cleanup MediaTek clock reset drivers in clk/mediatek
folder. MediaTek clock reset driver is used to provide reset control
of modules controlled in clk, like infra_ao.

Changes for v6:
1. Add a new patch to support inuput argument index mode.
2. Revise definition in reset.h to index.

Changes for V5:
1. Add all infra reset bits for MT8192 and MT8195.
2. Fix reviewers' comments.

Changes for V4:
1. Abandon the implementation of reset-cell = 2, and use reset index to
   determine which reset bit is used.
2. Add documentation for enum/structure/function in reset.h.
3. Combine binding/drvier support patch for MT8192 and MT8195.
4. The MT8195 DTS is accepted by Matthias, and I add new DTS patch to
   support infracfg_ao reset for MT8195. The DTS of MT8195 is still
   not merged into mainline. Please refer to [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=for-next&id=37f2582883be7218dc69f9af135959a8e93de223

Changes for V3:
1. Modify drivers for reviewers' comments.
2. Add dt-binding patch for MT8192/MT8195 infra.
3. Add reset property of infra node for MT8192.
4. Use original function for simple operation.

Changes for V2:
1. Modify drivers for reviewers' comments.
2. Use simple reset to replace v1.
3. Recover v2 to set_clr.
4. Separate error handling to another patch.
5. Add support for input offset and bit from DT.
6. Add support for MT8192 and MT8195.

Rex-BC Chen (16):
  clk: mediatek: reset: Add reset.h
  clk: mediatek: reset: Fix written reset bit offset
  clk: mediatek: reset: Refine and reorder functions in reset.c
  clk: mediatek: reset: Extract common drivers to update function
  clk: mediatek: reset: Merge and revise reset register function
  clk: mediatek: reset: Revise structure to control reset register
  clk: mediatek: reset: Support nonsequence base offsets of reset
    registers
  clk: mediatek: reset: Support inuput argument index mode
  clk: mediatek: reset: Change return type for clock reset register
    function
  clk: mediatek: reset: Add new register reset function with device
  clk: mediatek: reset: Add reset support for simple probe
  dt-bindings: arm: mediatek: Add #reset-cells property for
    MT8192/MT8195
  dt-bindings: reset: mediatek: Add infra_ao reset index for
    MT8192/MT8195
  clk: mediatek: reset: Add infra_ao reset support for MT8192/MT8195
  arm64: dts: mediatek: Add infra #reset-cells property for MT8192
  arm64: dts: mediatek: Add infra #reset-cells property for MT8195

 .../mediatek/mediatek,mt8192-sys-clock.yaml   |   3 +
 .../mediatek/mediatek,mt8195-sys-clock.yaml   |   3 +
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |   1 +
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  13 +-
 drivers/clk/mediatek/clk-mt2701-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701-hif.c         |  10 +-
 drivers/clk/mediatek/clk-mt2701.c             |  22 +-
 drivers/clk/mediatek/clk-mt2712.c             |  22 +-
 drivers/clk/mediatek/clk-mt7622-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt7622-hif.c         |  12 +-
 drivers/clk/mediatek/clk-mt7622.c             |  22 +-
 drivers/clk/mediatek/clk-mt7629-eth.c         |  10 +-
 drivers/clk/mediatek/clk-mt7629-hif.c         |  12 +-
 drivers/clk/mediatek/clk-mt8135.c             |  22 +-
 drivers/clk/mediatek/clk-mt8173.c             |  22 +-
 drivers/clk/mediatek/clk-mt8183.c             |  18 +-
 drivers/clk/mediatek/clk-mt8192.c             |  29 +++
 drivers/clk/mediatek/clk-mt8195-infra_ao.c    |  24 +++
 drivers/clk/mediatek/clk-mtk.c                |   7 +
 drivers/clk/mediatek/clk-mtk.h                |   9 +-
 drivers/clk/mediatek/reset.c                  | 198 +++++++++++++-----
 drivers/clk/mediatek/reset.h                  |  82 ++++++++
 include/dt-bindings/reset/mt8192-resets.h     |   8 +
 include/dt-bindings/reset/mt8195-resets.h     |   6 +
 25 files changed, 491 insertions(+), 94 deletions(-)
 create mode 100644 drivers/clk/mediatek/reset.h

-- 
2.18.0

