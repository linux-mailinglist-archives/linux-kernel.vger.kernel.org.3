Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4CE5AE426
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbiIFJ2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiIFJ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:27:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552FEB7E7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:27:44 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A36D6601F39;
        Tue,  6 Sep 2022 10:27:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662456463;
        bh=q/pjRlc+P1EXAov84vHYYZkyXsNxDJtdjpHTIHnbw+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7j7JJNoV/4qGA8hHzxbjp29Roe1pEwLywRePOz7quQpuSF3ELkhNFcFELz4usSLR
         ma9qGN9glh2aoynYH44mhPSEr5MX4SB38P5Dzu2KhkvV3PP1Sled5nHEjvl3+4dkAN
         S9d7FBvig4OAydOT3pxG5AipzTqt471gt8hspnXlkaKtFjh3mjSZIpKfU8/Q1XMiLJ
         BNs79djZuVQXHT1FJUSqlU6zKaC9YGJqfwc3pQzc68D7EMRIpjOsLPm+zp3vXLg2LE
         ZublxmPgPhgumD9twr6pXezF0Albz7sAyU/WPAmyuNYyuck3VVOfxwZ7L/O3c5gJ52
         SU+2RwqRrJA7w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, wenst@chromium.org,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, trevor.wu@mediatek.com, tzungbi@google.com,
        angelogioacchino.delregno@collabora.com, yc.hung@mediatek.com,
        Allen-KH.Cheng@mediatek.com, geert@linux-m68k.org,
        chunxu.li@mediatek.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: [PATCH 5/5] ASoC: SOF: mediatek: mt8195: Add devicetree support to select topologies
Date:   Tue,  6 Sep 2022 11:27:27 +0200
Message-Id: <20220906092727.37324-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220906092727.37324-1-angelogioacchino.delregno@collabora.com>
References: <20220906092727.37324-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support devicetree by adding a snd_soc_of_mach array, specifying SOF
topologies for a generic MT8195 machine and for Google Tomato
Chromebooks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index c1590e78edd4..8e359c296308 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -615,7 +615,20 @@ static struct snd_sof_dsp_ops sof_mt8195_ops = {
 			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
 };
 
+static struct snd_sof_of_mach sof_mt8195_machs[] = {
+	{
+		.compatible = "google,tomato",
+		.sof_tplg_filename = "sof-mt8195-mt6359-rt1019-rt5682-dts.tplg"
+	}, {
+		.compatible = "mediatek,mt8195",
+		.sof_tplg_filename = "sof-mt8195.tplg"
+	}, {
+		/* sentinel */
+	}
+};
+
 static const struct sof_dev_desc sof_of_mt8195_desc = {
+	.of_machines = sof_mt8195_machs,
 	.ipc_supported_mask	= BIT(SOF_IPC),
 	.ipc_default		= SOF_IPC,
 	.default_fw_path = {
-- 
2.37.2

