Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB71448A469
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbiAKAYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:24:41 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:52994 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345992AbiAKAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:24:01 -0500
X-IronPort-AV: E=Sophos;i="5.88,278,1635174000"; 
   d="scan'208";a="106050200"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Jan 2022 09:24:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3B9F74157D12;
        Tue, 11 Jan 2022 09:23:57 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] media: mtk-vpu: Drop unnecessary call to platform_get_resource()
Date:   Tue, 11 Jan 2022 00:23:13 +0000
Message-Id: <20220111002314.15213-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111002314.15213-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220111002314.15213-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_vpu_probe() calls platform_get_resource(pdev, IORESOURCE_IRQ, ..)
to check if IRQ resource exists and later calls
platform_get_irq(pdev, ..) to get the actual IRQ.

This patch drops an unnecessary call to platform_get_resource() and
checks the return value of platform_get_irq(pdev, ..) to make sure the
IRQ line is valid.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* No change.
---
 drivers/media/platform/mtk-vpu/mtk_vpu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index 7bd715fc844d..47b684b92f81 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -810,7 +810,6 @@ static int mtk_vpu_probe(struct platform_device *pdev)
 {
 	struct mtk_vpu *vpu;
 	struct device *dev;
-	struct resource *res;
 	int ret = 0;
 
 	dev_dbg(&pdev->dev, "initialization\n");
@@ -908,13 +907,10 @@ static int mtk_vpu_probe(struct platform_device *pdev)
 	init_waitqueue_head(&vpu->run.wq);
 	init_waitqueue_head(&vpu->ack_wq);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(dev, "get IRQ resource failed.\n");
-		ret = -ENXIO;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		goto free_p_mem;
-	}
-	vpu->reg.irq = platform_get_irq(pdev, 0);
+	vpu->reg.irq = ret;
 	ret = devm_request_irq(dev, vpu->reg.irq, vpu_irq_handler, 0,
 			       pdev->name, vpu);
 	if (ret) {
-- 
2.17.1

