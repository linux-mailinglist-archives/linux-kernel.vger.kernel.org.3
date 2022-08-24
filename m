Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6DC59F0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiHXBNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiHXBNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:13:40 -0400
Received: from mail-m11885.qiye.163.com (mail-m11885.qiye.163.com [115.236.118.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1826CD30;
        Tue, 23 Aug 2022 18:13:38 -0700 (PDT)
Received: from localhost (unknown [103.29.142.67])
        by mail-m11885.qiye.163.com (Hmail) with ESMTPA id 3242A4C03C0;
        Wed, 24 Aug 2022 09:13:32 +0800 (CST)
From:   Jeffy Chen <jeffy.chen@rock-chips.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Jianqun Xu <jay.xu@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] gpio/rockchip: Convert to generic_handle_domain_irq()
Date:   Wed, 24 Aug 2022 09:06:05 +0800
Message-Id: <20220824010605.14256-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE1NVkodGkNPHR1PTUIfQ1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OC46CCo5AT0wSg8iLxMjATgJ
        LQkKCU5VSlVKTU1KSEtITUpMSktCVTMWGhIXVREeHR0CVRgTHhU7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlDS043Bg++
X-HM-Tid: 0a82cd69633c2eb9kusn3242a4c03c0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow commit dbd1c54fc820 ("gpio: Bulk conversion to
generic_handle_domain_irq()").

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2:
Use for_each_set_bit().

 drivers/gpio/gpio-rockchip.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index e342a6dc4c6c..03b05a56a66f 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -324,26 +324,15 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct rockchip_pin_bank *bank = irq_desc_get_handler_data(desc);
-	u32 pend;
+	unsigned long pending;
+	unsigned int irq;
 
 	dev_dbg(bank->dev, "got irq for bank %s\n", bank->name);
 
 	chained_irq_enter(chip, desc);
 
-	pend = readl_relaxed(bank->reg_base + bank->gpio_regs->int_status);
-
-	while (pend) {
-		unsigned int irq, virq;
-
-		irq = __ffs(pend);
-		pend &= ~BIT(irq);
-		virq = irq_find_mapping(bank->domain, irq);
-
-		if (!virq) {
-			dev_err(bank->dev, "unmapped irq %d\n", irq);
-			continue;
-		}
-
+	pending = readl_relaxed(bank->reg_base + bank->gpio_regs->int_status);
+	for_each_set_bit(irq, &pending, 32) {
 		dev_dbg(bank->dev, "handling irq %d\n", irq);
 
 		/*
@@ -377,7 +366,7 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 			} while ((data & BIT(irq)) != (data_old & BIT(irq)));
 		}
 
-		generic_handle_irq(virq);
+		generic_handle_domain_irq(bank->domain, irq);
 	}
 
 	chained_irq_exit(chip, desc);
-- 
2.20.1

