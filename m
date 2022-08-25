Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3FA5A092F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiHYGyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbiHYGy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:54:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B86A1A61
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 23:54:26 -0700 (PDT)
X-UUID: a35dbd15b5e843d399e02cb2172ed511-20220825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZMxdqidHeMKTU6uO8paqRwQ9GJO1Qr/k1wi7WnYBmfk=;
        b=KOKE8dPAKny/qkebfiHgl8m9mqrJF8KFDVMrXDzP6ZrSTJ0HVnrbRSM11veVpIfqQXCadOIAV+deW7frCbBN635xTylhbewZG0JVMRtsKZYwuMNPwSo7bmLV6XQuLSQYGo6hiHEvTlDqVpJph13JVOLvCpVw3d4pOLNQM8gLnw8=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:6b808bfc-73f0-411a-9ae1-02f2287dc14b,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.10,REQID:6b808bfc-73f0-411a-9ae1-02f2287dc14b,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:100
X-CID-META: VersionHash:84eae18,CLOUDID:22c10f20-1c20-48a5-82a0-25f9c331906d,C
        OID:728947958c42,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: a35dbd15b5e843d399e02cb2172ed511-20220825
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunxu.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1212544490; Thu, 25 Aug 2022 14:54:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 25 Aug 2022 14:54:18 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 25 Aug 2022 14:54:17 +0800
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
Subject: [PATCH 3/3] ASoC: SOF: mediatek: Use generic implementation for .ipc_msg_data field
Date:   Thu, 25 Aug 2022 14:54:11 +0800
Message-ID: <20220825065411.31279-4-chunxu.li@mediatek.com>
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

Use generic sof_ipc_msg_data instead of specific implementation as
they do the same things

Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index 5fc206bb0da0..a1be5d74f40b 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -460,14 +460,6 @@ static int mt8186_get_bar_index(struct snd_sof_dev *sdev, u32 type)
 	return type;
 }
 
-static int mt8186_ipc_msg_data(struct snd_sof_dev *sdev,
-			       struct snd_pcm_substream *substream,
-			       void *p, size_t sz)
-{
-	sof_mailbox_read(sdev, sdev->dsp_box.offset, p, sz);
-	return 0;
-}
-
 static struct snd_soc_dai_driver mt8186_dai[] = {
 {
 	.name = "SOF_DL1",
@@ -526,7 +518,7 @@ static struct snd_sof_dsp_ops sof_mt8186_ops = {
 	.send_msg		= mt8186_send_msg,
 	.get_mailbox_offset	= mt8186_get_mailbox_offset,
 	.get_window_offset	= mt8186_get_window_offset,
-	.ipc_msg_data		= mt8186_ipc_msg_data,
+	.ipc_msg_data		= sof_ipc_msg_data,
 	.set_stream_data_offset = sof_set_stream_data_offset,
 
 	/* misc */
-- 
2.25.1

