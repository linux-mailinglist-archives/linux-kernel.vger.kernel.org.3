Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64AC467311
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379111AbhLCIIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:08:07 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:46184 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351084AbhLCIIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:08:07 -0500
Received: from localhost.localdomain (unknown [124.16.138.128])
        by APP-01 (Coremail) with SMTP id qwCowAAH3aWFz6lh8P8dAQ--.53042S2;
        Fri, 03 Dec 2021 16:04:22 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com, vz@mleia.com
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v2] gpio: lpc32xx: Handle devm_gpiochip_add_data error codes
Date:   Fri,  3 Dec 2021 16:04:20 +0800
Message-Id: <20211203080420.1560039-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAH3aWFz6lh8P8dAQ--.53042S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw48AF4fKryDCrWUKr4Uurg_yoW8JFWUpw
        10g3yIyryUAF17J34jkF18Aa4Uua10yFWjqFZ2k392q3W5JFy8tF4fXFWkXF4FyFy8Gr4U
        ZFs7tFW8Zr48Zw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8
        ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
        0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOnmRUUUUU
X-Originating-IP: [124.16.138.128]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of devm_gpiochip_add_data() is not always 0.
To catch the exception in case of the failure.

Fixes: 69c0a0a52cde ("gpio: lpc32xx: Use devm_gpiochip_add_data() for gpio registration")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog
 
v1 -> v2
 
* Change 1. Correct mixed declarations and code.
---
 drivers/gpio/gpio-lpc32xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-lpc32xx.c b/drivers/gpio/gpio-lpc32xx.c
index 4e626c4235c2..e3b734302b76 100644
--- a/drivers/gpio/gpio-lpc32xx.c
+++ b/drivers/gpio/gpio-lpc32xx.c
@@ -505,6 +505,7 @@ static int lpc32xx_of_xlate(struct gpio_chip *gc,
 static int lpc32xx_gpio_probe(struct platform_device *pdev)
 {
 	int i;
+	int err;
 	void __iomem *reg_base;
 
 	reg_base = devm_platform_ioremap_resource(pdev, 0);
@@ -518,8 +519,10 @@ static int lpc32xx_gpio_probe(struct platform_device *pdev)
 			lpc32xx_gpiochip[i].chip.of_node = pdev->dev.of_node;
 			lpc32xx_gpiochip[i].reg_base = reg_base;
 		}
-		devm_gpiochip_add_data(&pdev->dev, &lpc32xx_gpiochip[i].chip,
+		err = devm_gpiochip_add_data(&pdev->dev, &lpc32xx_gpiochip[i].chip,
 				  &lpc32xx_gpiochip[i]);
+		if (err)
+			return err;
 	}
 
 	return 0;
-- 
2.25.1

