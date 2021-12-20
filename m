Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0754A47A342
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 02:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhLTBPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 20:15:35 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:2659 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230394AbhLTBPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 20:15:34 -0500
X-IronPort-AV: E=Sophos;i="5.88,219,1635174000"; 
   d="scan'208";a="104487792"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Dec 2021 10:15:33 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 65034416D029;
        Mon, 20 Dec 2021 10:15:31 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] rtc: ftrtc010: Use platform_get_irq() to get the interrupt
Date:   Mon, 20 Dec 2021 01:15:24 +0000
Message-Id: <20211220011524.17206-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
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
Hi,

Dropping usage of platform_get_resource() was agreed based on
the discussion [0].

[0] https://patchwork.kernel.org/project/linux-renesas-soc/
patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
---
 drivers/rtc/rtc-ftrtc010.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index ad3add5db4c8..53bb08fe1cd4 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -141,11 +141,9 @@ static int ftrtc010_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res)
-		return -ENODEV;
-
-	rtc->rtc_irq = res->start;
+	rtc->rtc_irq = platform_get_irq(pdev, 0);
+	if (rtc->rtc_irq < 0)
+		return rtc->rtc_irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
-- 
2.17.1

