Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40F0584BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiG2G04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiG2G0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:26:41 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E815A3E0;
        Thu, 28 Jul 2022 23:26:39 -0700 (PDT)
X-UUID: 6342c6bc44514764871cbc2fe4efd0e2-20220729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:9893c6fe-de3b-48f2-967a-0c978b8e210c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:90
X-CID-INFO: VERSION:1.1.8,REQID:9893c6fe-de3b-48f2-967a-0c978b8e210c,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:90
X-CID-META: VersionHash:0f94e32,CLOUDID:55a9a9d0-841b-4e95-ad42-8f86e18f54fc,C
        OID:8c846a13a754,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6342c6bc44514764871cbc2fe4efd0e2-20220729
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 542189348; Fri, 29 Jul 2022 14:26:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 29 Jul 2022 14:26:33 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 29 Jul 2022 14:26:33 +0800
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
        <maoguang.meng@mediatek.com>
Subject: [V12,0/7] Enable two hardware jpeg encoder for MT8195
Date:   Fri, 29 Jul 2022 14:26:23 +0800
Message-ID: <20220729062630.5592-1-irui.wang@mediatek.com>
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

This series adds support for multi hardware jpeg encoding, by first
adding use of_platform_populate to manage each hardware information:
interrupt, clock, register bases and power. Secondly add encoding
work queue to deal with the encoding requestsof multi-hardware
at the same time. Lastly, add output picture reorder function
interface to eliminate the out of order images.

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

Changes compared with v11:
- some modifications for patch v11's review comments.
- fix yaml file check errors.

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
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 259 +++++++++++++++---
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  81 +++++-
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  |   1 +
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |   3 +-
 .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 258 +++++++++++++++++
 7 files changed, 711 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml

-- 
2.18.0

