Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B36257B361
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiGTI57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiGTI5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:57:48 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7227A6E2C2;
        Wed, 20 Jul 2022 01:57:43 -0700 (PDT)
X-UUID: a02b16bcaa744d44a422240f2fba5b8e-20220720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:d6f54ae4-7388-46f2-be04-cb27356dab9c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:9d457933-b9e4-42b8-b28a-6364427c76bb,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: a02b16bcaa744d44a422240f2fba5b8e-20220720
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 866756739; Wed, 20 Jul 2022 16:57:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 20 Jul 2022 16:57:35 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 20 Jul 2022 16:57:34 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        "Andrew-CT Chen" <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>
CC:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        "Irui Wang" <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2, 0/6] support mt8188 h264 encoder
Date:   Wed, 20 Jul 2022 16:57:25 +0800
Message-ID: <20220720085731.11011-1-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mt8188 encoder hardware has a change compared to the previous
chipsets, it supports 34-bit iova access. For 34-bit iova, the
encoder driver needs to write all 34 bits to hardware, otherwise
encoder will encode fail.

Patch 1 add the 34-bit iova supporting in driver.
Patch 2~3 add dt-bindings and driver compatible and private data.
Patch 4~6 some modification for in driver.

---
compare with v1:
 - split vpu_enc_encode function into 32bits and 34bits.
 - some review comments modification.
---

Irui Wang (6):
  media: mediatek: vcodec: Add encoder driver support for 34-bit iova
  dt-bindings: media: mediatek: vcodec: Add encoder dt-bindings for
    mt8188
  media: mediatek: vcodec: Add mt8188 encoder driver
  media: mediatek: vcodec: Remove encoder driver get IRQ resource
  media: mediatek: vcodec: Fix bitstream crop information error
  media: mediatek: vcodec: Use ctx vb2_queue mutex instead of device
    mutex

 .../media/mediatek,vcodec-encoder.yaml        |   1 +
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |   6 +
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c |  14 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  22 +-
 .../mediatek/vcodec/venc/venc_h264_if.c       | 200 +++++++++++++++---
 .../platform/mediatek/vcodec/venc_ipi_msg.h   |  24 +++
 .../platform/mediatek/vcodec/venc_vpu_if.c    |  76 ++++++-
 7 files changed, 291 insertions(+), 52 deletions(-)

-- 
2.18.0

