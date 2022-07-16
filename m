Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE38576CF3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiGPJfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiGPJe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:34:56 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5EB2C101;
        Sat, 16 Jul 2022 02:34:46 -0700 (PDT)
X-UUID: c421bfcf135044b8b7a94ce4f955a4e0-20220716
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:978a759f-b0e0-4006-a319-46fb7d29246d,OB:0,LO
        B:20,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.8,REQID:978a759f-b0e0-4006-a319-46fb7d29246d,OB:0,LOB:
        20,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:95
X-CID-META: VersionHash:0f94e32,CLOUDID:0a5a2433-b9e4-42b8-b28a-6364427c76bb,C
        OID:106539e306eb,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: c421bfcf135044b8b7a94ce4f955a4e0-20220716
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1554928513; Sat, 16 Jul 2022 17:34:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 16 Jul 2022 17:34:37 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Sat, 16 Jul 2022 17:34:36 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, <wenst@chromium.org>,
        kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>, <srv_heupstream@mediatek.com>
Subject: [V11,0/7] Enable two hardware jpeg encoder for MT8195
Date:   Sat, 16 Jul 2022 17:34:28 +0800
Message-ID: <20220716093435.29796-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

This series has been tested with MT8195 Gstreamer.
Encoding worked for this chip.

Patches 1 Adds jpeg encoder dt-bindings for mt8195

Patches 2 jpeg encoder builds two module for using Multi-HW,
export some functions to make them visible by other modules.

Patches 3 use devm_of_platform_populate to manage multi-hardware.

Patch 4 add jpeg encoding timeout function to judge hardware timeout.

Patch 5 add encoding work queue to deal with multi-hardware encoding
at the same time.

Patch 6 add output picture reorder function to order images.

Patch 7 add stop cmd function to deal with EOS operation.
---
This series patches dependent on:
media_stage tree:
[1]
https://git.linuxtv.org/media_stage.git/commit/?id=b3627647f9ea7473d10fb08a95fd7c4133a17ca4

patch1 new jpegenc dt-bindings included files
[2] MM IOMMU binding:
https://patchwork.kernel.org/project/linux-mediatek/patch/20220217113453.13658-2-yong.wu@mediatek.com/

[3] MT8195 power domain:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=580579

Changes compared with v10:
- some modifications for patch v10's review comments.
- fix Gstreamer test errors.

Changes compared with v9:
- some modifications for patch v9's review comments.

Changes compared with v8:
- some modifications for patch v8's review comments.
- add stop cmd function.

Changes compared with v7:
- some modifications for patch v6's review comments.

Changes compared with v6:
- new yaml file for mt8195 jpeg encoder.
- some modifications for patch v5's review comments.

Changes compared with v5:
- use of_platform_populate to replace component framework to
  manage multi-hardware in patch 2.

Changes compared with v4:
- No change compaered with v4

Changes compared with v3:
- Structure patches for consistency, non-backward
  compatible and do not break any existing functionality

Changes compared with v2:
- Split the last two patches into several patches
  to enhance readability
- Correct some syntax errors
- Explain why the component framework is used

Changes compared with v1:
- Add jpeg encoder dt-bindings for MT8195
- Use component framework to manage jpegenc HW
- Add jpegenc output pic reorder function interface

kyrie wu (7):
  dt-bindings: mediatek: Add mediatek, mt8195-jpgenc compatible
  mtk-jpegenc: export jpeg encoder functions
  mtk-jpegenc: manage jpegenc multi-hardware
  mtk-jpegenc: add jpegenc timeout func interface
  mtk-jpegenc: add jpeg encode worker interface
  mtk-jpegenc: add output pic reorder interface
  mtk-jpegenc: add stop cmd interface for jpgenc

 .../media/mediatek,mt8195-jpegenc.yaml        | 139 ++++++++++
 drivers/media/platform/mediatek/jpeg/Makefile |  11 +-
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 257 ++++++++++++++---
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  81 +++++-
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  |   1 +
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |   3 +-
 .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 259 ++++++++++++++++++
 7 files changed, 710 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml

-- 
2.18.0

