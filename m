Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8749321C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350568AbiASBEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:04:40 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47082 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238548AbiASBEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:04:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2E8.mY_1642554274;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V2E8.mY_1642554274)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Jan 2022 09:04:34 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     linus.walleij@linaro.org
Cc:     brgl@bgdev.pl, linmq006@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/2] gpio: idt3243x: Fix an ignored error return from platform_get_irq()
Date:   Wed, 19 Jan 2022 09:04:31 +0800
Message-Id: <20220119010432.65493-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return from the call to platform_get_irq() is int, it can be
a negative error code, however this is being assigned to an unsigned
int variable 'parent_irq', so making 'parent_irq' an int.

Eliminate the following coccicheck warning:
./drivers/gpio/gpio-idt3243x.c:167:6-16: WARNING: Unsigned expression
compared with zero: parent_irq < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 30fee1d7462a ("gpio: idt3243x: Fix IRQ check in idt_gpio_probe")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpio/gpio-idt3243x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-idt3243x.c b/drivers/gpio/gpio-idt3243x.c
index 08493b05be2d..52b8b72ded77 100644
--- a/drivers/gpio/gpio-idt3243x.c
+++ b/drivers/gpio/gpio-idt3243x.c
@@ -132,7 +132,7 @@ static int idt_gpio_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct gpio_irq_chip *girq;
 	struct idt_gpio_ctrl *ctrl;
-	unsigned int parent_irq;
+	int parent_irq;
 	int ngpios;
 	int ret;
 
-- 
2.20.1.7.g153144c

