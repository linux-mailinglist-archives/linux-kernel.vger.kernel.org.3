Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6185088E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378828AbiDTNJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378825AbiDTNIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:08:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393D5427C6;
        Wed, 20 Apr 2022 06:05:46 -0700 (PDT)
X-UUID: 3298ae1a53ba463f86b53de5287776db-20220420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:3f841e76-cc46-4fb9-9cf0-f7cf03432d10,OB:-327
        68,LOB:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:-32768,FILE:0,RULE:Rele
        ase_Ham,ACTION:release,TS:-20
X-CID-INFO: VERSION:1.1.4,REQID:3f841e76-cc46-4fb9-9cf0-f7cf03432d10,OB:-32768
        ,LOB:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:-32768,FILE:0,RULE:Releas
        e_Ham,ACTION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:6ee286ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:nil,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 3298ae1a53ba463f86b53de5287776db-20220420
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1099772556; Wed, 20 Apr 2022 21:05:30 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 20 Apr 2022 21:05:29 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Apr
 2022 21:05:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Apr 2022 21:05:28 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <allen-kh.cheng@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH V2 00/12] Cleanup MediaTek clk reset drivers and support MT8192/MT8195
Date:   Wed, 20 Apr 2022 21:05:15 +0800
Message-ID: <20220420130527.23200-1-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this series, we cleanup MediaTek clock reset drivers in clk/mediatek
folder. MediaTek clock reset driver is used to provide reset control
of modules controlled in clk, like infra_ao.

Changes for V2:
1. Modify drivers for reviewers' comments.
2. Use simple reset to replace v1.
3. Recover v2 to set_clr.
4. Separate error handling to another patch.
5. Add support for input offset and bit from DT.
6. Add support for MT8192 and MT8195.

Rex-BC Chen (12):
  clk: mediatek: reset: Fix written reset bit offset
  clk: mediatek: reset: Use simple reset operations
  clk: mediatek: reset: Refine functions of set_clr
  clk: mediatek: reset: Merge and revise reset register function
  clk: mediatek: reset: Add reset.h
  clk: mediatek: reset: Revise structure to control reset register
  clk: mediatek: reset: Add return for clock reset register function
  clk: mediatek: reset: Add new register reset function with device
  clk: mediatek: reset: Add support for input offset and bit from DT
  clk: mediatek: reset: Add reset support for simple probe
  clk: mediatek: reset: Add infra_ao reset support for MT8192
  clk: mediatek: reset: Add infra_ao reset support for MT8195

 drivers/clk/mediatek/Kconfig               |   1 +
 drivers/clk/mediatek/clk-mt2701-eth.c      |   8 +-
 drivers/clk/mediatek/clk-mt2701-g3d.c      |   8 +-
 drivers/clk/mediatek/clk-mt2701-hif.c      |   8 +-
 drivers/clk/mediatek/clk-mt2701.c          |  19 ++-
 drivers/clk/mediatek/clk-mt2712.c          |  19 ++-
 drivers/clk/mediatek/clk-mt7622-eth.c      |   8 +-
 drivers/clk/mediatek/clk-mt7622-hif.c      |  10 +-
 drivers/clk/mediatek/clk-mt7622.c          |  19 ++-
 drivers/clk/mediatek/clk-mt7629-eth.c      |   8 +-
 drivers/clk/mediatek/clk-mt7629-hif.c      |  10 +-
 drivers/clk/mediatek/clk-mt8135.c          |  19 ++-
 drivers/clk/mediatek/clk-mt8173.c          |  19 ++-
 drivers/clk/mediatek/clk-mt8183.c          |   8 +-
 drivers/clk/mediatek/clk-mt8192.c          |  11 ++
 drivers/clk/mediatek/clk-mt8195-infra_ao.c |   8 +
 drivers/clk/mediatek/clk-mtk.c             |   7 +
 drivers/clk/mediatek/clk-mtk.h             |   9 +-
 drivers/clk/mediatek/reset.c               | 175 +++++++++++++--------
 drivers/clk/mediatek/reset.h               |  36 +++++
 include/dt-bindings/reset/mt8192-resets.h  |  11 ++
 include/dt-bindings/reset/mt8195-resets.h  |   7 +
 22 files changed, 333 insertions(+), 95 deletions(-)
 create mode 100644 drivers/clk/mediatek/reset.h

-- 
2.18.0

