Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BB648A46A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbiAKAYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:24:43 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:21170 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345934AbiAKAYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:24:04 -0500
X-IronPort-AV: E=Sophos;i="5.88,278,1635174000"; 
   d="scan'208";a="106050208"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Jan 2022 09:24:03 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 07C1F4157D34;
        Tue, 11 Jan 2022 09:24:00 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] media: coda: Use platform_get_irq() to get the interrupt
Date:   Tue, 11 Jan 2022 00:23:14 +0000
Message-Id: <20220111002314.15213-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111002314.15213-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220111002314.15213-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
* No change.
---
 drivers/media/platform/coda/imx-vdoa.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/coda/imx-vdoa.c b/drivers/media/platform/coda/imx-vdoa.c
index 00643f37b3e6..c70871bae193 100644
--- a/drivers/media/platform/coda/imx-vdoa.c
+++ b/drivers/media/platform/coda/imx-vdoa.c
@@ -284,7 +284,6 @@ EXPORT_SYMBOL(vdoa_context_configure);
 static int vdoa_probe(struct platform_device *pdev)
 {
 	struct vdoa_data *vdoa;
-	struct resource *res;
 	int ret;
 
 	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
@@ -309,10 +308,10 @@ static int vdoa_probe(struct platform_device *pdev)
 	if (IS_ERR(vdoa->regs))
 		return PTR_ERR(vdoa->regs);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res)
-		return -EINVAL;
-	ret = devm_request_threaded_irq(&pdev->dev, res->start, NULL,
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+	ret = devm_request_threaded_irq(&pdev->dev, ret, NULL,
 					vdoa_irq_handler, IRQF_ONESHOT,
 					"vdoa", vdoa);
 	if (ret < 0) {
-- 
2.17.1

