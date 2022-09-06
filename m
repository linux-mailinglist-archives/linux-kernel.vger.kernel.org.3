Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4CC5AE423
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiIFJ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbiIFJ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:27:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AE9EE11
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:27:43 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C3A6F6601E73;
        Tue,  6 Sep 2022 10:27:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662456461;
        bh=YDlQ+YNdqI/5kTvHBiM/B/3jPqKXRqtJVv0TyDN9v4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUe01iz99vjxX5T1OZqszuO5NuLhZ7HOJybhSE3NubRqkA7xOh107oJhxrBscabsA
         U/0eCBPs483WDAw8bfelr0xm1W6crl/U+jz4c6NYA7JiZv2y++LJPmvnfc+Shzchjy
         j5TLzLqoMHNKJpogWol7MEwV0SbiTnxlUTTwxlta6zOYWt0fjo0mVB6eY4PIMvB1gL
         s+6Fpqa2s/QpoVVZJGxXkq1VQzYQuL+IkhYQBwq/XQ7B9vPpBcAmtjjI1RPciSsDFQ
         74JhAc0TlmV//EpD6Kfxgd5Gk29MGhfj9lqnJfz2MbF7oShABq3XHf3f0eMtVkeeN6
         IFPussD/yOgTA==
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
Subject: [PATCH 4/5] ASoC: SOF: mediatek: mt8195: Add generic pcm_{open,close} callbacks
Date:   Tue,  6 Sep 2022 11:27:26 +0200
Message-Id: <20220906092727.37324-5-angelogioacchino.delregno@collabora.com>
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

Use the generic sof_stream_pcm_{open,close}() functions for the
pcm_{open,close} callbacks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 68747ee21c6f..c1590e78edd4 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -586,6 +586,10 @@ static struct snd_sof_dsp_ops sof_mt8195_ops = {
 	/* misc */
 	.get_bar_index	= mt8195_get_bar_index,
 
+	/* stream callbacks */
+	.pcm_open	= sof_stream_pcm_open,
+	.pcm_close	= sof_stream_pcm_close,
+
 	/* firmware loading */
 	.load_firmware	= snd_sof_load_firmware_memcpy,
 
-- 
2.37.2

