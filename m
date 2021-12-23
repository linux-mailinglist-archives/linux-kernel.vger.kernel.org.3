Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736C547E6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349584AbhLWRau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:30:50 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:57707 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349551AbhLWRap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:30:45 -0500
X-IronPort-AV: E=Sophos;i="5.88,230,1635174000"; 
   d="scan'208";a="104983867"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Dec 2021 02:30:44 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 801B940C4A56;
        Fri, 24 Dec 2021 02:30:42 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-media@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/13] media: s5p-mfc: Use platform_get_irq() to get the interrupt
Date:   Thu, 23 Dec 2021 17:30:05 +0000
Message-Id: <20211223173015.22251-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211223173015.22251-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/media/platform/s5p-mfc/s5p_mfc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index f6732f031e96..761341934925 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1268,7 +1268,6 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 {
 	struct s5p_mfc_dev *dev;
 	struct video_device *vfd;
-	struct resource *res;
 	int ret;
 
 	pr_debug("%s++\n", __func__);
@@ -1294,12 +1293,10 @@ static int s5p_mfc_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->regs_base))
 		return PTR_ERR(dev->regs_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get irq resource\n");
-		return -ENOENT;
-	}
-	dev->irq = res->start;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+	dev->irq = ret;
 	ret = devm_request_irq(&pdev->dev, dev->irq, s5p_mfc_irq,
 					0, pdev->name, dev);
 	if (ret) {
-- 
2.17.1

