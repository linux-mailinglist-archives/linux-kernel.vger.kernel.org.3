Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6BF576D1A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiGPJiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiGPJiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:38:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92382656E;
        Sat, 16 Jul 2022 02:38:18 -0700 (PDT)
X-UUID: 4b96fc6abc5344388bde83279b210e94-20220716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:af2906f3-241f-4389-ba32-dcd06c5a3478,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:bcdea6d7-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 4b96fc6abc5344388bde83279b210e94-20220716
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 212847598; Sat, 16 Jul 2022 17:38:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sat, 16 Jul 2022 17:38:11 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Sat, 16 Jul 2022 17:38:10 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
CC:     Yong Wu <yong.wu@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 0/5] support mt8188 h264 encoder
Date:   Sat, 16 Jul 2022 17:38:03 +0800
Message-ID: <20220716093808.29894-1-irui.wang@mediatek.com>
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

mt8188 encoder hardware has a change compared to the previous
chipsets, it supports 34-bit iova access. For 34-bit iova, the
encoder driver needs to write all 34 bits to hardware, otherwise
encoder will encode fail.

Patch 1 add the 34-bit iova supporting in driver.
Patch 2~3 add dt-bindings and driver compatible and private data.
Patch 4~5 fix some issues when encoding.

Irui Wang (5):
  media: mediatek: vcodec: Add encoder driver support for 34-bit iova
  dt-bindings: media: mediatek: vcodec: Add encoder dt-bindings for
    mt8188
  media: mediatek: vcodec: Add mt8188 encoder driver
  media: mediatek: vcodec: Fix bitstream crop information error
  media: mediatek: vcodec: Fix encoder multi-instance deadlock

 .../media/mediatek,vcodec-encoder.yaml        |   1 +
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |   6 +
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c |  14 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      |  22 +-
 .../mediatek/vcodec/venc/venc_h264_if.c       | 200 +++++++++++++++---
 .../platform/mediatek/vcodec/venc_ipi_msg.h   |  24 +++
 .../platform/mediatek/vcodec/venc_vpu_if.c    |  34 ++-
 7 files changed, 252 insertions(+), 49 deletions(-)

-- 
2.18.0

