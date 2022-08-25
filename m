Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401D25A0930
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiHYGyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbiHYGy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:54:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D02A1A6D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:54:26 -0700 (PDT)
X-UUID: 5f74ec2be8b441a9951aae829c3a0599-20220825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=J7hetefnG4im2lve6kba7kczHC23lp5y+Zw1ri01n2o=;
        b=pEqo/Wh0on7rEb+MuZSk5G5n6sl7DIpB3tE5pm1W6+NS9zhFRMSHjJO/yu5MEzXNX9YfXfl8PPSnqLVetk4Ogp3D9eDR6IpOyFrAfxZfv7fa0xI0TqrcaGaHMAW1+QlapWOWV1EEDW7R3ejvApm6K0lDIu8rboXQDPtjfsk+4IU=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:7bcef57e-be12-49fc-9e25-fcb06e339b26,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Relea
        se_Ham,ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.10,REQID:7bcef57e-be12-49fc-9e25-fcb06e339b26,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS
        981B3D,ACTION:quarantine,TS:95
X-CID-META: VersionHash:84eae18,CLOUDID:93ac90cf-20bd-4e5e-ace8-00692b7ab380,C
        OID:25347b5d99d3,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5f74ec2be8b441a9951aae829c3a0599-20220825
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunxu.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 682199100; Thu, 25 Aug 2022 14:54:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 25 Aug 2022 14:54:16 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 25 Aug 2022 14:54:15 +0800
From:   Chunxu Li <chunxu.li@mediatek.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>, <lgirdwood@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <daniel.baluta@nxp.com>
CC:     <matthias.bgg@gmail.com>, <yc.hung@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <sound-open-firmware@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <project_global_chrome_upstream_group@mediatek.com>,
        Chunxu Li <chunxu.li@mediatek.com>
Subject: [PATCH 1/3] ASoC: SOF: mediatek: Add dai driver for mt8186
Date:   Thu, 25 Aug 2022 14:54:09 +0800
Message-ID: <20220825065411.31279-2-chunxu.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825065411.31279-1-chunxu.li@mediatek.com>
References: <20220825065411.31279-1-chunxu.li@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dsp ops callback to register AFE DL1/DL2/UL1/UL2 SOF dai's with ALSA

Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 35 ++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index 014afe33b3d9..b47bb7a6ba70 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -468,6 +468,37 @@ static int mt8186_ipc_msg_data(struct snd_sof_dev *sdev,
 	return 0;
 }
 
+static struct snd_soc_dai_driver mt8186_dai[] = {
+{
+	.name = "SOF_DL1",
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+	},
+},
+{
+	.name = "SOF_DL2",
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+	},
+},
+{
+	.name = "SOF_UL1",
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+	},
+},
+{
+	.name = "SOF_UL2",
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+	},
+},
+};
+
 /* mt8186 ops */
 static struct snd_sof_dsp_ops sof_mt8186_ops = {
 	/* probe and remove */
@@ -503,6 +534,10 @@ static struct snd_sof_dsp_ops sof_mt8186_ops = {
 	/* Firmware ops */
 	.dsp_arch_ops = &sof_xtensa_arch_ops,
 
+	/* DAI drivers */
+	.drv		= mt8186_dai,
+	.num_drv	= ARRAY_SIZE(mt8186_dai),
+
 	/* PM */
 	.suspend	= mt8186_dsp_suspend,
 	.resume		= mt8186_dsp_resume,
-- 
2.25.1

