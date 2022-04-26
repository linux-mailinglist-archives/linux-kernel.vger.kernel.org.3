Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864EF50F305
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344300AbiDZHxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344303AbiDZHxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:53:04 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A21AE1CFCB;
        Tue, 26 Apr 2022 00:49:57 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,290,1643641200"; 
   d="scan'208";a="118016699"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Apr 2022 16:49:57 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 82EAF4248B19;
        Tue, 26 Apr 2022 16:49:53 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/3] ASoC: sh: rz-ssi: Propagate error codes returned from platform_get_irq_byname()
Date:   Tue, 26 Apr 2022 08:49:21 +0100
Message-Id: <20220426074922.13319-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220426074922.13319-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220426074922.13319-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate error codes returned from platform_get_irq_byname() instead of
returning -ENODEV. platform_get_irq_byname() may return -EPROBE_DEFER, to
handle such cases propagate the error codes.

While at it drop the dev_err_probe() messages as platform_get_irq_byname()
already does this for us in case of error.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* No change
---
 sound/soc/sh/rz-ssi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index cec458b8c507..d9a684e71ec3 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -977,8 +977,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	/* Error Interrupt */
 	ssi->irq_int = platform_get_irq_byname(pdev, "int_req");
 	if (ssi->irq_int < 0)
-		return dev_err_probe(&pdev->dev, -ENODEV,
-				     "Unable to get SSI int_req IRQ\n");
+		return ssi->irq_int;
 
 	ret = devm_request_irq(&pdev->dev, ssi->irq_int, &rz_ssi_interrupt,
 			       0, dev_name(&pdev->dev), ssi);
@@ -990,8 +989,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 		/* Tx and Rx interrupts (pio only) */
 		ssi->irq_tx = platform_get_irq_byname(pdev, "dma_tx");
 		if (ssi->irq_tx < 0)
-			return dev_err_probe(&pdev->dev, -ENODEV,
-					     "Unable to get SSI dma_tx IRQ\n");
+			return ssi->irq_tx;
 
 		ret = devm_request_irq(&pdev->dev, ssi->irq_tx,
 				       &rz_ssi_interrupt, 0,
@@ -1002,8 +1000,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
 		ssi->irq_rx = platform_get_irq_byname(pdev, "dma_rx");
 		if (ssi->irq_rx < 0)
-			return dev_err_probe(&pdev->dev, -ENODEV,
-					     "Unable to get SSI dma_rx IRQ\n");
+			return ssi->irq_rx;
 
 		ret = devm_request_irq(&pdev->dev, ssi->irq_rx,
 				       &rz_ssi_interrupt, 0,
-- 
2.25.1

