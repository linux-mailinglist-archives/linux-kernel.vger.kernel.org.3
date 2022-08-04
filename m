Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90AE5899C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238969AbiHDJOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbiHDJOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:14:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF0E61DA5
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:14:15 -0700 (PDT)
X-UUID: af6f73e6d18d4ec281e46ce8b98b6c7d-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cQcNrTUAb0l29iv67c8LIkKSVExKlz0NfcY8uCNCmDw=;
        b=Diy12RAn6pO/nX17LaZ06+2lgNNea7rSnC8AsZh6o55LW1d/Wy2w26PGElrfvhUU7naXq/8vDFf7+6JSTbHV1EHFZHBMutWLy0TiMrQeT2bVP/uZKb4+qGhQAk6opMJpLgb5pGmMbJa0qd6YbbkivQoKrJu6oCxUBKhFrAMu0oo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:07fd544b-b963-4e59-ab2a-b6ccb4250aee,OB:0,LO
        B:20,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:07fd544b-b963-4e59-ab2a-b6ccb4250aee,OB:0,LOB:
        20,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:d09847d0-a6cf-4fb6-be1b-c60094821ca2,C
        OID:3fc9c37b1292,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: af6f73e6d18d4ec281e46ce8b98b6c7d-20220804
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunxu.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1010981879; Thu, 04 Aug 2022 17:14:12 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 4 Aug 2022 17:14:10 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Aug 2022 17:14:09 +0800
From:   Chunxu Li <chunxu.li@mediatek.com>
To:     <pierre-louis.bossart@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <angelogioacchino.delregno@collabora.com>,
        <daniel.baluta@nxp.com>
CC:     <matthias.bgg@gmail.com>, <yc.hung@mediatek.com>,
        <tinghan.shen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        <sound-open-firmware@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <project_global_chrome_upstream_group@mediatek.com>,
        Chunxu Li <chunxu.li@mediatek.com>
Subject: [PATCH 2/2] ASoC: SOF: mediatek: Add .of_machine_select field for mt8186
Date:   Thu, 4 Aug 2022 17:13:59 +0800
Message-ID: <20220804091359.31449-3-chunxu.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804091359.31449-1-chunxu.li@mediatek.com>
References: <20220804091359.31449-1-chunxu.li@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the mt8186 do not use ACPI type machine, the of_machine_select
is used to distinguish different machines in sof_machine_check.

Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c
 b/sound/soc/sof/mediatek/mt8186/mt8186.c
index e006532caf2f..cb8bed383064 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -497,6 +497,8 @@ static struct snd_sof_dsp_ops sof_mt8186_ops = {
 	/* misc */
 	.get_bar_index	= mt8186_get_bar_index,
 
+	.of_machine_select = sof_of_machine_select,
+
 	/* firmware loading */
 	.load_firmware	= snd_sof_load_firmware_memcpy,
 
@@ -515,7 +517,16 @@ static struct snd_sof_dsp_ops sof_mt8186_ops = {
 			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
 };
 
+static struct snd_sof_of_mach sof_mt8186_machs[] = {
+	{
+		.board = "mediatek,mt8186",
+		.sof_tplg_filename = "sof-mt8186.tplg",
+	},
+	{}
+};
+
 static const struct sof_dev_desc sof_of_mt8186_desc = {
+	.of_machines = sof_mt8186_machs,
 	.ipc_supported_mask	= BIT(SOF_IPC),
 	.ipc_default		= SOF_IPC,
 	.default_fw_path = {
-- 
2.25.1

