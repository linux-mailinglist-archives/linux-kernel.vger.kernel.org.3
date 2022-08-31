Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00D65A8431
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiHaRWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaRWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:22:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ED86C769;
        Wed, 31 Aug 2022 10:22:02 -0700 (PDT)
X-UUID: 68973a83f43c440f8d48669d2f7e758d-20220901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=/1gON577MpchCSxyKYEbduzrjWst5XYqzHZ47x/O7SQ=;
        b=UKu7Vgf7ZCjB89X9vlJSM+0WBfFIE44TpLXRSvP+1hl9iYtseesZcG0ifpw797TN0MxSpX2RDVRHjPs75M3JoF55L9ye10E72D0e8e/DZJ/fKeUXUdDHG86biaFwBdE7ZJHPbaf7G5Zm8ydGW23/g+GdS5XMvPimqfB0JBrmJEY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:9cf3ef29-021c-42cb-b6e9-e2eb9057463b,OB:0,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:9cf3ef29-021c-42cb-b6e9-e2eb9057463b,OB:0,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:764936d0-20bd-4e5e-ace8-00692b7ab380,C
        OID:0bb1ec711bf6,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 68973a83f43c440f8d48669d2f7e758d-20220901
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 368902829; Thu, 01 Sep 2022 01:21:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 1 Sep 2022 01:21:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 1 Sep 2022 01:21:56 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Xiandong Wang <xiandong.wang@mediatek.com>
Subject: [PATCH v3 2/2] soc: mediatek: mutex: Add mt8186 mutex mod settings for mdp3
Date:   Thu, 1 Sep 2022 01:21:51 +0800
Message-ID: <20220831172151.10215-3-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220831172151.10215-1-allen-kh.cheng@mediatek.com>
References: <20220831172151.10215-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
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

Add mt8186 mutex mod settings for mdp3.

Co-developed-by: Xiandong Wang <xiandong.wang@mediatek.com>
Signed-off-by: Xiandong Wang <xiandong.wang@mediatek.com>
Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c       | 28 ++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-mutex.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 5ea43de4e410..f95100d4de73 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -91,6 +91,15 @@
 #define MT8183_MUTEX_MOD_MDP_AAL0		23
 #define MT8183_MUTEX_MOD_MDP_CCORR0		24
 
+#define MT8186_MUTEX_MOD_MDP_RDMA0		0
+#define MT8186_MUTEX_MOD_MDP_AAL0		2
+#define MT8186_MUTEX_MOD_MDP_HDR0		4
+#define MT8186_MUTEX_MOD_MDP_RSZ0		5
+#define MT8186_MUTEX_MOD_MDP_RSZ1		6
+#define MT8186_MUTEX_MOD_MDP_WROT0		7
+#define MT8186_MUTEX_MOD_MDP_TDSHP0		9
+#define MT8186_MUTEX_MOD_MDP_COLOR0		14
+
 #define MT8173_MUTEX_MOD_DISP_OVL0		11
 #define MT8173_MUTEX_MOD_DISP_OVL1		12
 #define MT8173_MUTEX_MOD_DISP_RDMA0		13
@@ -324,6 +333,17 @@ static const unsigned int mt8186_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_RDMA1] = MT8186_MUTEX_MOD_DISP_RDMA1,
 };
 
+static const unsigned int mt8186_mdp_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
+	[MUTEX_MOD_IDX_MDP_RDMA0] = MT8186_MUTEX_MOD_MDP_RDMA0,
+	[MUTEX_MOD_IDX_MDP_RSZ0] = MT8186_MUTEX_MOD_MDP_RSZ0,
+	[MUTEX_MOD_IDX_MDP_RSZ1] = MT8186_MUTEX_MOD_MDP_RSZ1,
+	[MUTEX_MOD_IDX_MDP_TDSHP0] = MT8186_MUTEX_MOD_MDP_TDSHP0,
+	[MUTEX_MOD_IDX_MDP_WROT0] = MT8186_MUTEX_MOD_MDP_WROT0,
+	[MUTEX_MOD_IDX_MDP_HDR0] = MT8186_MUTEX_MOD_MDP_HDR0,
+	[MUTEX_MOD_IDX_MDP_AAL0] = MT8186_MUTEX_MOD_MDP_AAL0,
+	[MUTEX_MOD_IDX_MDP_COLOR0] = MT8186_MUTEX_MOD_MDP_COLOR0,
+};
+
 static const unsigned int mt8192_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8192_MUTEX_MOD_DISP_AAL0,
 	[DDP_COMPONENT_CCORR] = MT8192_MUTEX_MOD_DISP_CCORR0,
@@ -458,6 +478,12 @@ static const struct mtk_mutex_data mt8183_mutex_driver_data = {
 	.no_clk = true,
 };
 
+static const struct mtk_mutex_data mt8186_mdp_mutex_driver_data = {
+	.mutex_mod_reg = MT8183_MUTEX0_MOD0,
+	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
+	.mutex_table_mod = mt8186_mdp_mutex_table_mod,
+};
+
 static const struct mtk_mutex_data mt8186_mutex_driver_data = {
 	.mutex_mod = mt8186_mutex_mod,
 	.mutex_sof = mt8186_mutex_sof,
@@ -810,6 +836,8 @@ static const struct of_device_id mutex_driver_dt_match[] = {
 	  .data = &mt8183_mutex_driver_data},
 	{ .compatible = "mediatek,mt8186-disp-mutex",
 	  .data = &mt8186_mutex_driver_data},
+	{ .compatible = "mediatek,mt8186-mdp3-mutex",
+	  .data = &mt8186_mdp_mutex_driver_data},
 	{ .compatible = "mediatek,mt8192-disp-mutex",
 	  .data = &mt8192_mutex_driver_data},
 	{ .compatible = "mediatek,mt8195-disp-mutex",
diff --git a/include/linux/soc/mediatek/mtk-mutex.h b/include/linux/soc/mediatek/mtk-mutex.h
index a0f4f51a3b45..b335c2837cd8 100644
--- a/include/linux/soc/mediatek/mtk-mutex.h
+++ b/include/linux/soc/mediatek/mtk-mutex.h
@@ -20,6 +20,8 @@ enum mtk_mutex_mod_index {
 	MUTEX_MOD_IDX_MDP_WDMA,
 	MUTEX_MOD_IDX_MDP_AAL0,
 	MUTEX_MOD_IDX_MDP_CCORR0,
+	MUTEX_MOD_IDX_MDP_HDR0,
+	MUTEX_MOD_IDX_MDP_COLOR0,
 
 	MUTEX_MOD_IDX_MAX		/* ALWAYS keep at the end */
 };
-- 
2.18.0

