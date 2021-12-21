Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7150647C46F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240172AbhLURBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:01:22 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:1977 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240103AbhLURBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:01:14 -0500
X-IronPort-AV: E=Sophos;i="5.88,224,1635174000"; 
   d="scan'208";a="104253507"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 02:01:14 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id AA4B540083DD;
        Wed, 22 Dec 2021 02:01:11 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Michal Simek <michal.simek@xilinx.com>,
        alsa-devel@alsa-project.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/2] ASoC: bcm: Use platform_get_irq() to get the interrupt
Date:   Tue, 21 Dec 2021 17:01:00 +0000
Message-Id: <20211221170100.27423-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221170100.27423-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211221170100.27423-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
v1->v2
* Included RB tag from Florian
* Included irq.h to fix builds for x86
---
 sound/soc/bcm/bcm63xx-i2s.h          |  1 -
 sound/soc/bcm/bcm63xx-pcm-whistler.c | 13 ++++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

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
index b5096f64c576..2c600b017524 100644
--- a/sound/soc/bcm/bcm63xx-pcm-whistler.c
+++ b/sound/soc/bcm/bcm63xx-pcm-whistler.c
@@ -6,6 +6,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <sound/pcm_params.h>
 #include <linux/regmap.h>
@@ -387,14 +388,12 @@ int bcm63xx_soc_platform_probe(struct platform_device *pdev,
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

