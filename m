Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5712747E70F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349671AbhLWRbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:31:31 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:6988 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349668AbhLWRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:31:13 -0500
X-IronPort-AV: E=Sophos;i="5.88,230,1635174000"; 
   d="scan'208";a="104503626"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Dec 2021 02:31:10 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 800B040C4DD0;
        Fri, 24 Dec 2021 02:31:07 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-media@vger.kernel.org,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 12/13] media: mtk-vpu: Drop unnecessary call to platform_get_resource()
Date:   Thu, 23 Dec 2021 17:30:13 +0000
Message-Id: <20211223173015.22251-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

