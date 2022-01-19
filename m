Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D1849321E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350593AbiASBEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:04:48 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:52095 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350559AbiASBEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:04:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2EErm._1642554277;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V2EErm._1642554277)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Jan 2022 09:04:37 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     linus.walleij@linaro.org
Cc:     brgl@bgdev.pl, linmq006@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] gpio: mpc8xxx: Fix an ignored error return from platform_get_irq()
Date:   Wed, 19 Jan 2022 09:04:32 +0800
Message-Id: <20220119010432.65493-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220119010432.65493-1-yang.lee@linux.alibaba.com>
References: <20220119010432.65493-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return from the call to platform_get_irq() is int, it can be
a negative error code, however this is being assigned to an unsigned
int variable 'irqn', so making 'irqn' an int.

Eliminate the following coccicheck warning:
./drivers/gpio/gpio-mpc8xxx.c:391:5-21: WARNING: Unsigned expression
compared with zero: mpc8xxx_gc -> irqn < 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 0b39536cc699 ("gpio: mpc8xxx: Fix IRQ check in mpc8xxx_probe")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpio/gpio-mpc8xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 01634c8d27b3..a964e25ea620 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -47,7 +47,7 @@ struct mpc8xxx_gpio_chip {
 				unsigned offset, int value);
 
 	struct irq_domain *irq;
-	unsigned int irqn;
+	int irqn;
 };
 
 /*
-- 
2.20.1.7.g153144c

