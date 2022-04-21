Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFA950AA1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392443AbiDUUjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392420AbiDUUj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:39:26 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 993AF4DF69;
        Thu, 21 Apr 2022 13:36:35 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,279,1643641200"; 
   d="scan'208";a="118731532"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Apr 2022 05:36:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id B74A0401998F;
        Fri, 22 Apr 2022 05:36:31 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 3/3] ASoC: sh: rz-ssi: Add a devres action to release the DMA channels
Date:   Thu, 21 Apr 2022 21:35:55 +0100
Message-Id: <20220421203555.29011-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA channels requested by rz_ssi_dma_request() in rz_ssi_probe() were
never released in the error path apart from one place. This patch fixes
this issue by adding a devres action to release the DMA channels and
dropping the single rz_ssi_release_dma_channels() call which was placed
in the error path in case devm_snd_soc_register_component() failed.

Fixes: 26ac471c5354 ("ASoC: sh: rz-ssi: Add SSI DMAC support")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index d9a684e71ec3..f04da1bf5680 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -912,6 +912,11 @@ static const struct snd_soc_component_driver rz_ssi_soc_component = {
 	.pcm_construct	= rz_ssi_pcm_new,
 };
 
+static void rz_ssi_release_dma_channels_action(void *data)
+{
+	rz_ssi_release_dma_channels(data);
+}
+
 static int rz_ssi_probe(struct platform_device *pdev)
 {
 	struct rz_ssi_priv *ssi;
@@ -966,6 +971,11 @@ static int rz_ssi_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "DMA enabled");
 		ssi->playback.transfer = rz_ssi_dma_transfer;
 		ssi->capture.transfer = rz_ssi_dma_transfer;
+
+		ret = devm_add_action_or_reset(&pdev->dev,
+					       rz_ssi_release_dma_channels_action, ssi);
+		if (ret)
+			return ret;
 	}
 
 	ssi->playback.priv = ssi;
@@ -1027,8 +1037,6 @@ static int rz_ssi_probe(struct platform_device *pdev)
 					      rz_ssi_soc_dai,
 					      ARRAY_SIZE(rz_ssi_soc_dai));
 	if (ret < 0) {
-		rz_ssi_release_dma_channels(ssi);
-
 		pm_runtime_put(ssi->dev);
 		pm_runtime_disable(ssi->dev);
 		reset_control_assert(ssi->rstc);
-- 
2.17.1

