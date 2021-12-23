Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7801047E6F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349525AbhLWRaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:30:46 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:57707 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349534AbhLWRam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:30:42 -0500
X-IronPort-AV: E=Sophos;i="5.88,230,1635174000"; 
   d="scan'208";a="104983860"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Dec 2021 02:30:41 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C5E6540C4A40;
        Fri, 24 Dec 2021 02:30:39 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-media@vger.kernel.org,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 03/13] media: bdisp: Use platform_get_irq() to get the interrupt
Date:   Thu, 23 Dec 2021 17:30:04 +0000
Message-Id: <20211223173015.22251-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/media/platform/sti/bdisp/bdisp-v4l2.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
index 01ce7b711774..5aa79d9277c8 100644
--- a/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
+++ b/drivers/media/platform/sti/bdisp/bdisp-v4l2.c
@@ -1284,7 +1284,6 @@ static int bdisp_remove(struct platform_device *pdev)
 static int bdisp_probe(struct platform_device *pdev)
 {
 	struct bdisp_dev *bdisp;
-	struct resource *res;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -1335,14 +1334,11 @@ static int bdisp_probe(struct platform_device *pdev)
 		goto err_wq;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(dev, "failed to get IRQ resource\n");
-		ret = -EINVAL;
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		goto err_clk;
-	}
 
-	ret = devm_request_threaded_irq(dev, res->start, bdisp_irq_handler,
+	ret = devm_request_threaded_irq(dev, ret, bdisp_irq_handler,
 					bdisp_irq_thread, IRQF_ONESHOT,
 					pdev->name, bdisp);
 	if (ret) {
-- 
2.17.1

