Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24D148A452
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345898AbiAKAXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:23:35 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:55393 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1345892AbiAKAXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:23:33 -0500
X-IronPort-AV: E=Sophos;i="5.88,278,1635174000"; 
   d="scan'208";a="106050139"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Jan 2022 09:23:31 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2E2044157D34;
        Tue, 11 Jan 2022 09:23:30 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] media: bdisp: Use platform_get_irq() to get the interrupt
Date:   Tue, 11 Jan 2022 00:23:04 +0000
Message-Id: <20220111002314.15213-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

