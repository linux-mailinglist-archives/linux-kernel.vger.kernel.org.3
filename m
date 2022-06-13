Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23F6547E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbiFMDW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiFMDWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:22:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B41211831;
        Sun, 12 Jun 2022 20:22:42 -0700 (PDT)
X-UUID: ee8f70b3131e4e7f8eccaec46012e92c-20220613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:5eecc0be-77fb-4bb1-a2d3-ed0422383d64,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:a2517837-84c0-4f9a-9fbd-acd4a0e9ad0f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: ee8f70b3131e4e7f8eccaec46012e92c-20220613
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 832653327; Mon, 13 Jun 2022 11:22:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 13 Jun 2022 11:22:35 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jun 2022 11:22:34 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, <wenst@chromium.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>, kyrie wu <kyrie.wu@mediatek.com>,
        <srv_heupstream@mediatek.com>
Subject: [V3,0/8] Support multi-hardware jpeg decoder for MT8195
Date:   Mon, 13 Jun 2022 11:22:24 +0800
Message-ID: <20220613032232.23187-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

This series adds support for multi hardware jpeg decoding,
by first adding use of_platform_populate to manage each hardware
information: interrupt, clock, register bases and power.
Secondly add decoding work queue to deal with the decoding requests
of multi-hardware at the same time. Lastly, add output picture
reorder function interface to eliminate the out of order images.

This series has been tested with both MT8195.
Decoding worked for this chip.

Patch 1 Adds jpeg decoder dt-bindings for mt8195

Patches 2 jpeg decoder builds three module for using Multi-HW,
export some functions to make them visible by other modules.

Patch 3 use of_platform_populate to manage multi-hardware.

Patch 4 add jpeg decoding timeout function to judge hardware timeout.

Patch 5 add decoding work queue to deal with multi-hardware decoding
at the same time.

Patch 6 add output picture reorder function to order images.

Patch 7 refactor jpegdec func interface for HW working.

Patch 8 add stop cmd function to deal with EOS operation.

---
This series patches dependent on:
media_stage tree:
[1]
https://git.linuxtv.org/media_stage.git/commit/?id=b3627647f9ea7473d10fb08a95fd7c4133a17ca4

patch1 new jpegdec dt-bindings included files
[2] MM IOMMU binding:
https://patchwork.kernel.org/project/linux-mediatek/patch/20220217113453.13658-2-yong.wu@mediatek.com/

[3] MT8195 power domain:
https://patchwork.kernel.org/project/linux-mediatek/list/?series=580579

Changes compared with v2:
- add stop cmd function.
- some modifications for patch v1's review comments.

Changes compared with v1:
- new yaml file for mt8195 jpeg decoder.
- some modifications for patch v1's review comments.

kyrie wu (8):
  dt-bindings: mediatek: Add mediatek,mt8195-jpgdec compatible
  media: mtk-jpegdec: export jpeg decoder functions
  media: mtk-jpegdec: manage jpegdec multi-hardware
  media: mtk-jpegdec: add jpegdec timeout func interface
  media: mtk-jpegdec: add jpeg decode worker interface
  media: mtk-jpegdec: add output pic reorder interface
  media: mtk-jpegdec: refactor jpegdec func interface
  mtk-jpegdec: add stop cmd interface for jpgdec

 .../media/mediatek,mt8195-jpegdec.yaml        | 177 ++++++++++
 drivers/media/platform/mediatek/jpeg/Makefile |   5 +-
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 244 +++++++++++++-
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  46 +++
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 309 ++++++++++++++++--
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |   3 +-
 .../platform/mediatek/jpeg/mtk_jpeg_dec_reg.h |   1 +
 7 files changed, 753 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml

-- 
2.18.0

