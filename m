Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3990C48A461
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345947AbiAKAXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:23:55 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:57594 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345968AbiAKAXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:23:52 -0500
X-IronPort-AV: E=Sophos;i="5.88,278,1635174000"; 
   d="scan'208";a="106595551"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Jan 2022 09:23:50 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A08124157D34;
        Tue, 11 Jan 2022 09:23:47 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] media: mtk-vcodec: Drop unnecessary call to platform_get_resource()
Date:   Tue, 11 Jan 2022 00:23:10 +0000
Message-Id: <20220111002314.15213-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111002314.15213-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220111002314.15213-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v1->v2
* No change.
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

