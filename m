Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E3447E705
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349662AbhLWRbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:31:08 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:56123 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349597AbhLWRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:31:01 -0500
X-IronPort-AV: E=Sophos;i="5.88,230,1635174000"; 
   d="scan'208";a="104983894"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Dec 2021 02:31:00 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A23A640C4DA9;
        Fri, 24 Dec 2021 02:30:57 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-media@vger.kernel.org,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 09/13] media: mtk-vcodec: Drop unnecessary call to platform_get_resource()
Date:   Thu, 23 Dec 2021 17:30:10 +0000
Message-Id: <20211223173015.22251-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_vcodec_probe() calls platform_get_resource(pdev, IORESOURCE_IRQ, ..)
to check if IRQ resource exists and later calls platform_get_irq(pdev, ..)
to get the actual IRQ.

This patch drops an unnecessary call to platform_get_resource() and
checks the return value of platform_get_irq(pdev, ..) to check if the
IRQ line is valid.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c    | 11 ++++-------
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c    | 10 +++-------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
index 40c39e1e596b..1509c2a4de84 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
@@ -200,7 +200,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 {
 	struct mtk_vcodec_dev *dev;
 	struct video_device *vfd_dec;
-	struct resource *res;
 	phandle rproc_phandle;
 	enum mtk_vcodec_fw_type fw_type;
 	int i, ret;
@@ -244,14 +243,12 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		mtk_v4l2_debug(2, "reg[%d] base=%p", i, dev->reg_base[i]);
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to get irq resource");
-		ret = -ENOENT;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		goto err_res;
-	}
 
-	dev->dec_irq = platform_get_irq(pdev, 0);
+	dev->dec_irq = ret;
+
 	irq_set_status_flags(dev->dec_irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, dev->dec_irq,
 			mtk_vcodec_dec_irq_handler, 0, pdev->name, dev);
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index aeaecb8d416e..86e70d826754 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -236,7 +236,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 {
 	struct mtk_vcodec_dev *dev;
 	struct video_device *vfd_enc;
-	struct resource *res;
 	phandle rproc_phandle;
 	enum mtk_vcodec_fw_type fw_type;
 	int ret;
@@ -280,14 +279,11 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		goto err_res;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "failed to get irq resource");
-		ret = -ENOENT;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		goto err_res;
-	}
 
-	dev->enc_irq = platform_get_irq(pdev, 0);
+	dev->enc_irq = ret;
 	irq_set_status_flags(dev->enc_irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, dev->enc_irq,
 			       mtk_vcodec_enc_irq_handler,
-- 
2.17.1

