Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22D5A2469
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343800AbiHZJ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343772AbiHZJ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:29:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F684D7D10;
        Fri, 26 Aug 2022 02:29:15 -0700 (PDT)
X-UUID: abb1907b200543a891c6c44336e114fb-20220826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jY8phmZztrWIcfUtaeVr9kuoCdktR8X67vNWupv29y8=;
        b=vDo/JIDJi17M/BgaMWuW18qmjN3MTBl0rSduAklIdof8GYUJLSji0OARJhzQ4d2/mxrhDDlHpXfyn/FF+qGmZcVqVw1mVCtwMzIq6xDyhg2DiG8WV+ib4QAfE98xeD6hAB6BCzXmnfLtJFBbJRJiD3ejTSIKb7oGpZhjhNT9ikE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:17125e6e-1f72-4983-8f84-fa4d48a947a1,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:-25
X-CID-META: VersionHash:84eae18,CLOUDID:2359aa55-e800-47dc-8adf-0c936acf4f1b,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: abb1907b200543a891c6c44336e114fb-20220826
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1080767275; Fri, 26 Aug 2022 17:29:09 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 26 Aug 2022 17:29:07 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 26 Aug 2022 17:29:07 +0800
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
Subject: [V7,0/8] Support multi-hardware jpeg decoder for MT8195
Date:   Fri, 26 Aug 2022 17:28:56 +0800
Message-ID: <20220826092904.10283-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes compared with v6:
- some modifications for patch v6's review comments.

Changes compared with v5:
- some modifications for patch v5's review comments.
- fix yaml file check errors.

Changes compared with v4:
- some modifications for patch v4's review comments.
- fix Gstreamer test errors.

Changes compared with v3:
- some modifications for patch v3's review comments.

Changes compared with v2:
- add stop cmd function.
- some modifications for patch v1's review comments.

Changes compared with v1:
- new yaml file for mt8195 jpeg decoder.
- some modifications for patch v1's review comments.

kyrie wu (8):
  dt-bindings: mediatek: Add mediatek,mt8195-jpgdec compatible
  media: mtk-jpegdec: export jpeg decoder functions
  media: mtk-jpegdec: support jpegdec multi-hardware
  media: mtk-jpegdec: add jpegdec timeout func interface
  media: mtk-jpegdec: add jpeg decode worker interface
  media: mtk-jpegdec: add output pic reorder interface
  media: mtk-jpegdec: refactor jpegdec func interface
  mtk-jpegdec: add stop cmd interface for jpgdec

 .../media/mediatek,mt8195-jpegdec.yaml        | 169 ++++++++++
 drivers/media/platform/mediatek/jpeg/Makefile |   5 +-
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 233 ++++++++++++-
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  46 +++
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 314 ++++++++++++++++--
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |   3 +-
 .../platform/mediatek/jpeg/mtk_jpeg_dec_reg.h |   1 +
 7 files changed, 739 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegdec.yaml

-- 
2.18.0

