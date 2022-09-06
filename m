Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70E05AE420
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiIFJ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiIFJ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:27:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43FBCD9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:27:41 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 821FE660038D;
        Tue,  6 Sep 2022 10:27:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662456460;
        bh=yV6nCsjeOdwaKJwa/v3ztHbWo4/fPObpHuPkgeFvzgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kCCCdAdPwuWWeMFa2+5PwAQeF3I4MKfZVzXHZNN8nHmFiSVVBsmDlgUxsLjsyP9xR
         IG7ng+Ts5OLLA0ENa5tu0bVSpEDNDDO+9dYz6DJGGuQvT3ETw3fg5Ex9W+VROmO1wC
         Jvgq8XmCrR4QLTvQLvGbaGoG4f3hZiBpJB0fAJoM/sNqiN+0ygNgmwexBb0oy+SUWj
         7idoqXQjmJ1znaMpkR+dak5n9t2yN2r1o/7PTgUmR1UwvD4yzSSGWEgoEPjIqLPgiB
         gVKCwTylk+bgKHgvg0MabafFdICAlHcMgT9VXmoGU7SHBVrcyoymzJBiVG1ksEeaRv
         ij7DtFUjRljcA==
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
Subject: [PATCH 3/5] ASoC: SOF: mediatek: mt8195: Add mailbox generic callbacks for IPC
Date:   Tue,  6 Sep 2022 11:27:25 +0200
Message-Id: <20220906092727.37324-4-angelogioacchino.delregno@collabora.com>
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

Add the .mailbox_{read,write} generic callbacks for SOF IPC and, while
at it, also change the ipc_msg_data callback to use the SOF API
sof_ipc_msg_data() instead of the custom function mt8195_ipc_msg_data().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/sof/mediatek/mt8195/mt8195.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index ff575de7e46a..68747ee21c6f 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -496,14 +496,6 @@ static int mt8195_get_bar_index(struct snd_sof_dev *sdev, u32 type)
 	return type;
 }
 
-static int mt8195_ipc_msg_data(struct snd_sof_dev *sdev,
-			       struct snd_pcm_substream *substream,
-			       void *p, size_t sz)
-{
-	sof_mailbox_read(sdev, sdev->dsp_box.offset, p, sz);
-	return 0;
-}
-
 static void mt8195_adsp_dump(struct snd_sof_dev *sdev, u32 flags)
 {
 	u32 dbg_pc, dbg_data, dbg_bus0, dbg_bus1, dbg_inst;
@@ -574,6 +566,10 @@ static struct snd_sof_dsp_ops sof_mt8195_ops = {
 	.block_read	= sof_block_read,
 	.block_write	= sof_block_write,
 
+	/* Mailbox IO */
+	.mailbox_read	= sof_mailbox_read,
+	.mailbox_write	= sof_mailbox_write,
+
 	/* Register IO */
 	.write		= sof_io_write,
 	.read		= sof_io_read,
@@ -584,7 +580,7 @@ static struct snd_sof_dsp_ops sof_mt8195_ops = {
 	.send_msg		= mt8195_send_msg,
 	.get_mailbox_offset	= mt8195_get_mailbox_offset,
 	.get_window_offset	= mt8195_get_window_offset,
-	.ipc_msg_data		= mt8195_ipc_msg_data,
+	.ipc_msg_data		= sof_ipc_msg_data,
 	.set_stream_data_offset = sof_set_stream_data_offset,
 
 	/* misc */
-- 
2.37.2

