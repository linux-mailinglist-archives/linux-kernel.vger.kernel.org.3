Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72DA47A1B4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 19:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhLSSK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 13:10:59 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:21001 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236280AbhLSSK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 13:10:57 -0500
X-IronPort-AV: E=Sophos;i="5.88,218,1635174000"; 
   d="scan'208";a="104455502"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Dec 2021 03:10:56 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 477DB40CB08A;
        Mon, 20 Dec 2021 03:10:54 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Michal Simek <michal.simek@xilinx.com>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] ASoC: bcm: Use platform_get_irq() to get the interrupt
Date:   Sun, 19 Dec 2021 18:10:39 +0000
Message-Id: <20211219181039.24812-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211219181039.24812-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211219181039.24812-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

While at it also drop "r_irq" member from struct bcm_i2s_priv as there
are no users of it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 sound/soc/bcm/bcm63xx-i2s.h          |  1 -
 sound/soc/bcm/bcm63xx-pcm-whistler.c | 12 +++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/bcm/bcm63xx-i2s.h b/sound/soc/bcm/bcm63xx-i2s.h
index edc328ba53d3..f30556bec89e 100644
--- a/sound/soc/bcm/bcm63xx-i2s.h
+++ b/sound/soc/bcm/bcm63xx-i2s.h
@@ -74,7 +74,6 @@
 
 struct bcm_i2s_priv {
 	struct device *dev;
-	struct resource *r_irq;
 	struct regmap *regmap_i2s;
 	struct clk *i2s_clk;
 	struct snd_pcm_substream	*play_substream;
diff --git a/sound/soc/bcm/bcm63xx-pcm-whistler.c b/sound/soc/bcm/bcm63xx-pcm-whistler.c
index b5096f64c576..41f80d564020 100644
--- a/sound/soc/bcm/bcm63xx-pcm-whistler.c
+++ b/sound/soc/bcm/bcm63xx-pcm-whistler.c
@@ -387,14 +387,12 @@ int bcm63xx_soc_platform_probe(struct platform_device *pdev,
 {
 	int ret;
 
-	i2s_priv->r_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!i2s_priv->r_irq) {
-		dev_err(&pdev->dev, "Unable to get register irq resource.\n");
-		return -ENODEV;
-	}
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
 
-	ret = devm_request_irq(&pdev->dev, i2s_priv->r_irq->start, i2s_dma_isr,
-			i2s_priv->r_irq->flags, "i2s_dma", (void *)i2s_priv);
+	ret = devm_request_irq(&pdev->dev, ret, i2s_dma_isr,
+			       irq_get_trigger_type(ret), "i2s_dma", (void *)i2s_priv);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"i2s_init: failed to request interrupt.ret=%d\n", ret);
-- 
2.17.1

