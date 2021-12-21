Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D160F47C46D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbhLURBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:01:18 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:55547 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240118AbhLURBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:01:11 -0500
X-IronPort-AV: E=Sophos;i="5.88,224,1635174000"; 
   d="scan'208";a="104253504"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Dec 2021 02:01:11 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E143F4004BAE;
        Wed, 22 Dec 2021 02:01:08 +0900 (JST)
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
Subject: [PATCH v2 1/2] ASoC: xlnx: Use platform_get_irq() to get the interrupt
Date:   Tue, 21 Dec 2021 17:00:59 +0000
Message-Id: <20211221170100.27423-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* No change
---
 sound/soc/xilinx/xlnx_spdif.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/xilinx/xlnx_spdif.c b/sound/soc/xilinx/xlnx_spdif.c
index e2ca087adee6..cba0e868a7d7 100644
--- a/sound/soc/xilinx/xlnx_spdif.c
+++ b/sound/soc/xilinx/xlnx_spdif.c
@@ -237,7 +237,6 @@ MODULE_DEVICE_TABLE(of, xlnx_spdif_of_match);
 static int xlnx_spdif_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct resource *res;
 	struct snd_soc_dai_driver *dai_drv;
 	struct spdif_dev_data *ctx;
 
@@ -273,13 +272,10 @@ static int xlnx_spdif_probe(struct platform_device *pdev)
 	if (ctx->mode) {
 		dai_drv = &xlnx_spdif_tx_dai;
 	} else {
-		res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-		if (!res) {
-			dev_err(dev, "No IRQ resource found\n");
-			ret = -ENODEV;
+		ret = platform_get_irq(pdev, 0);
+		if (ret < 0)
 			goto clk_err;
-		}
-		ret = devm_request_irq(dev, res->start,
+		ret = devm_request_irq(dev, ret,
 				       xlnx_spdifrx_irq_handler,
 				       0, "XLNX_SPDIF_RX", ctx);
 		if (ret) {
-- 
2.17.1

