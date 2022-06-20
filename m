Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5572455105F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiFTGce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiFTGc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:32:29 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6303BCE08;
        Sun, 19 Jun 2022 23:32:28 -0700 (PDT)
X-UUID: f15ce4b0f3c14da39cf878414fed6e9d-20220620
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:98b3200d-0fac-4e98-879f-41fd8f547f3a,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:90
X-CID-INFO: VERSION:1.1.6,REQID:98b3200d-0fac-4e98-879f-41fd8f547f3a,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:90
X-CID-META: VersionHash:b14ad71,CLOUDID:d3d7822d-1756-4fa3-be7f-474a6e4be921,C
        OID:ee125e104d0a,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: f15ce4b0f3c14da39cf878414fed6e9d-20220620
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 169535115; Mon, 20 Jun 2022 14:32:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 20 Jun 2022 14:32:20 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 20 Jun 2022 14:32:18 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH, v2] media: mediatek: vcodec: Initialize decoder parameters after getting dec_capability
Date:   Mon, 20 Jun 2022 14:32:17 +0800
Message-ID: <20220620063217.9867-1-yunfei.dong@mediatek.com>
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

Need to get dec_capability from scp first, then initialize decoder
supported format and other parameters according to dec_capability value.

Fixes: fd00d90330d1 ("media: mtk-vcodec: vdec: move stateful ops into their own file")
Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
compared witch v1:
- add Fixes lables
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c     | 2 --
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 1465ddff1c6b..41589470da32 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -112,8 +112,6 @@ void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_ctx *ctx)
 {
 	struct mtk_q_data *q_data;
 
-	ctx->dev->vdec_pdata->init_vdec_params(ctx);
-
 	ctx->m2m_ctx->q_lock = &ctx->dev->dev_mutex;
 	ctx->fh.m2m_ctx = ctx->m2m_ctx;
 	ctx->fh.ctrl_handler = &ctx->ctrl_hdl;
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index 4103d7c1b638..99d7b15f2b9d 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -208,6 +208,8 @@ static int fops_vcodec_open(struct file *file)
 
 		dev->dec_capability =
 			mtk_vcodec_fw_get_vdec_capa(dev->fw_handler);
+		ctx->dev->vdec_pdata->init_vdec_params(ctx);
+
 		mtk_v4l2_debug(0, "decoder capability %x", dev->dec_capability);
 	}
 
-- 
2.25.1

