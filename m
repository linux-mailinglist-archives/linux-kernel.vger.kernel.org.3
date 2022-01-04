Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1C64844C4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiADPgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:36:38 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:32370 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234864AbiADPgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:36:37 -0500
X-IronPort-AV: E=Sophos;i="5.88,261,1635174000"; 
   d="scan'208";a="105487996"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jan 2022 00:36:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 17E414009F7D;
        Wed,  5 Jan 2022 00:36:33 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: rcar: Propagate errors from devm_request_irq()
Date:   Tue,  4 Jan 2022 15:36:15 +0000
Message-Id: <20220104153615.13393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver overrides the error code returned by devm_request_irq() to
-ENOENT. Switch to propagating the error code upstream.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
This patch depends on [1].

[1] https://lkml.org/lkml/2021/12/22/633
---
 drivers/gpio/gpio-rcar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 437baecc434e..bd2e16d6e21c 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -552,10 +552,10 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	if (devm_request_irq(dev, p->irq_parent, gpio_rcar_irq_handler,
-			     IRQF_SHARED, name, p)) {
+	ret = devm_request_irq(dev, p->irq_parent, gpio_rcar_irq_handler,
+			       IRQF_SHARED, name, p);
+	if (ret) {
 		dev_err(dev, "failed to request IRQ\n");
-		ret = -ENOENT;
 		goto err1;
 	}
 
-- 
2.17.1

