Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AB85992B8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 03:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243848AbiHSBr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 21:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238919AbiHSBr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 21:47:26 -0400
X-Greylist: delayed 354 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 18:47:23 PDT
Received: from mail-m11873.qiye.163.com (mail-m11873.qiye.163.com [115.236.118.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C186D5EB6;
        Thu, 18 Aug 2022 18:47:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11873.qiye.163.com (Hmail) with ESMTPA id E22AD900383;
        Fri, 19 Aug 2022 09:41:27 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     heiko@sntech.de
Cc:     linus.walleij@linaro.org, jeffy.chen@rock-chips.com,
        linux-gpio@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH] gpio/rockchip: handle irq before toggle trigger for edge type irq
Date:   Fri, 19 Aug 2022 09:41:26 +0800
Message-Id: <20220819014126.1235390-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSxhLVk4aQ0geGUpCHklCQ1UTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ojo6Thw*Fj0yGRdMMTkoM1YY
        OitPCShVSlVKTU1LQ0xISUNDT01PVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUlMSkw3Bg++
X-HM-Tid: 0a82b3c329b82eafkusne22ad900383
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq demux for rockchip gpio interrupts do real irq handle after loop
over the bits from int status register. Some oldder SoCs such as RK3308
has no both edge trigger type support, replaced by a soft both type
which switch trigger type once a level type triggered.

For example, a irq is set to a IRQ_TYPE_EDGE_BOTH trigger type, but the
SoC not support really both edge trigger type, use a
IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING instead.

        --------
    ____|      |______

        ^      ^
	|      |
	|      [0] the falling edge come before irq ack set by driver !
	|
        rockchip_irq_demux set to EDGE_FALLING type
	rockchip_irq_demux call generic_handle_irq
	                          -> handle_edge_irq
				    -> irq_gc_ack_set_bit

The [0] irq will lost by software on board test.

With this patch, the generic_handle_irq has been move ahead before
trigger toggle to fix the [0] lost issue.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 drivers/gpio/gpio-rockchip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index f91e876fd969..952d628a6f7e 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -346,6 +346,7 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 		}
 
 		dev_dbg(bank->dev, "handling irq %d\n", irq);
+		generic_handle_irq(virq);
 
 		/*
 		 * Triggering IRQ on both rising and falling edge
@@ -377,8 +378,6 @@ static void rockchip_irq_demux(struct irq_desc *desc)
 						     bank->gpio_regs->ext_port);
 			} while ((data & BIT(irq)) != (data_old & BIT(irq)));
 		}
-
-		generic_handle_irq(virq);
 	}
 
 	chained_irq_exit(chip, desc);
-- 
2.25.1

