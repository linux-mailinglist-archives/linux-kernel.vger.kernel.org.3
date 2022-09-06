Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6EC5AE421
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiIFJ1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiIFJ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:27:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D01CB7E7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:27:39 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 68B55660037F;
        Tue,  6 Sep 2022 10:27:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662456458;
        bh=vXQl6sWYH3s9nZcdEQtm9bzb3mf6vHvob18mX522u5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gaP7CzHIWz3oofHqZpF1nJ/2SBzJ0tEF/o0JbZuWbZzz0jtYTgk1OjQ9MhHoPbYte
         +InfDwR1jByO1iziZY8SbfOS2imRGasoF9EQVvm5lxVaaVdciPurOQ9vV7njksGjgZ
         Ms628sECmg3Lk39rxRRyEMz98uT8B/xAtkNukUqWKmCOhFn6HaqVmmlfIfOr6zmUBa
         y9BZ6HipY9RZyh1ADzEmgq5bFBl0Q/ZD1EwwkufgDQV0JtHsAGDu3OfBVC1/0PkChw
         VjXWrMQauz4mC7iw6B+VCQUvq9nSWNNrJz5SGheCGz0if30q5Fj6NrbRTWIf28rLmK
         Jhcg30Re66o5g==
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
Subject: [PATCH 1/5] ASoC: mediatek: mt8195-mt6359: Properly register sound card for SOF
Date:   Tue,  6 Sep 2022 11:27:23 +0200
Message-Id: <20220906092727.37324-2-angelogioacchino.delregno@collabora.com>
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

Adding a probe callback on this snd_soc_card is required when
Sound Open Firmware support is desired, as we need to appropriately
populate the stream_name for SOF to be able to bind widgets.
Failing to do so will produce errors when applying the SOF topology
leading to card registration failure (so, no sound).
While at it, also make sure to fill the topology_shortname as required.

Fixes: 0caf1120c583 ("ASoC: mediatek: mt8195: extract SOF common code")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/mt8195/mt8195-mt6359.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index c530e3fc27e4..961e769602d6 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -1383,7 +1383,13 @@ static int mt8195_mt6359_dev_probe(struct platform_device *pdev)
 		sof_priv->num_streams = ARRAY_SIZE(g_sof_conn_streams);
 		sof_priv->sof_dai_link_fixup = mt8195_dai_link_fixup;
 		soc_card_data->sof_priv = sof_priv;
+		card->probe = mtk_sof_card_probe;
 		card->late_probe = mtk_sof_card_late_probe;
+		if (!card->topology_shortname_created) {
+			snprintf(card->topology_shortname, 32, "sof-%s", card->name);
+			card->topology_shortname_created = true;
+		}
+		card->name = card->topology_shortname;
 		sof_on = 1;
 	}
 
-- 
2.37.2

