Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98277587164
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiHAT2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiHAT2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:28:16 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB74B71
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:28:13 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Ib5Fo6JKAGWJJIb5FoUmw3; Mon, 01 Aug 2022 21:28:11 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 01 Aug 2022 21:28:11 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mips@vger.kernel.org
Subject: [PATCH] irqchip/loongson-liointc: Fix an error handling path in liointc_init()
Date:   Mon,  1 Aug 2022 21:28:07 +0200
Message-Id: <1a6d74ab70712279023aa7bdbd31bd3aec103bc0.1659382063.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All errors lead to the error handling path, except this one.
Fix it and release some resources before returning if this test fails.

Fixes: 0858ed035a85 ("irqchip/loongson-liointc: Add ACPI init support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/irqchip/irq-loongson-liointc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index c4f3c886ad61..8ab59b658913 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -207,7 +207,7 @@ static int liointc_init(phys_addr_t addr, unsigned long size, int revision,
 					"reg-names", core_reg_names[i]);
 
 			if (index < 0)
-				return -EINVAL;
+				goto out_iounmap;
 
 			priv->core_isr[i] = of_iomap(node, index);
 		}
-- 
2.34.1

