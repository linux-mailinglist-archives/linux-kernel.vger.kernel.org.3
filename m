Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8658A59AD22
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 12:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345024AbiHTKHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 06:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344978AbiHTKHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 06:07:07 -0400
Received: from mail-m11885.qiye.163.com (mail-m11885.qiye.163.com [115.236.118.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E74D61B11
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 03:07:03 -0700 (PDT)
Received: from localhost (unknown [103.29.142.67])
        by mail-m11885.qiye.163.com (Hmail) with ESMTPA id 6B7974C0286;
        Sat, 20 Aug 2022 18:07:01 +0800 (CST)
From:   Jeffy Chen <jeffy.chen@rock-chips.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>
Cc:     Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] gpio/rockchip: Convert to generic_handle_domain_irq()
Date:   Sat, 20 Aug 2022 17:59:32 +0800
Message-Id: <20220820095933.20234-1-jeffy.chen@rock-chips.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUxLVkhIGU0ZSUIeSUtIGlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpLSFVJQlVKT0lVTUxZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nk06Tzo*Vj03ShUeNVZPHBgZ
        TjAwCThVSlVKTU1LQkJLS0lKQ0xNVTMWGhIXVREeHR0CVRgTHhU7CRQYEFYYExILCFUYFBZFWVdZ
        EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlITEs3Bg++
X-HM-Tid: 0a82bab85f4a2eb9kusn6b7974c0286
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

 drivers/gpio/gpio-rockchip.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index e342a6dc4c6c..a98351cd6821 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -333,16 +333,10 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 	pend = readl_relaxed(bank->reg_base + bank->gpio_regs->int_status);
 
 	while (pend) {
-		unsigned int irq, virq;
+		unsigned int irq;
 
 		irq = __ffs(pend);
 		pend &= ~BIT(irq);
-		virq = irq_find_mapping(bank->domain, irq);
-
-		if (!virq) {
-			dev_err(bank->dev, "unmapped irq %d\n", irq);
-			continue;
-		}
 
 		dev_dbg(bank->dev, "handling irq %d\n", irq);
 
@@ -377,7 +371,7 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 			} while ((data & BIT(irq)) != (data_old & BIT(irq)));
 		}
 
-		generic_handle_irq(virq);
+		generic_handle_domain_irq(bank->domain, irq);
 	}
 
 	chained_irq_exit(chip, desc);
-- 
2.20.1

