Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F12539028
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344031AbiEaL64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344022AbiEaL6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:58:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47C360D92
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:58:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3454F6113C
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 11:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF684C385A9;
        Tue, 31 May 2022 11:58:50 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 2/2] irqchip/loongson-liointc: Fix build error for LoongArch
Date:   Tue, 31 May 2022 19:59:42 +0800
Message-Id: <20220531115942.1686812-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220531115942.1686812-1-chenhuacai@loongson.cn>
References: <20220531115942.1686812-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

liointc driver is shared by MIPS and LoongArch, this patch adjust the
code to fix build error for LoongArch.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/irqchip/irq-loongson-liointc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 649c58391618..aed88857d90f 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -16,7 +16,11 @@
 #include <linux/smp.h>
 #include <linux/irqchip/chained_irq.h>
 
+#ifdef CONFIG_MIPS
 #include <loongson.h>
+#else
+#include <asm/loongson.h>
+#endif
 
 #define LIOINTC_CHIP_IRQ	32
 #define LIOINTC_NUM_PARENT 4
@@ -53,7 +57,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
 	struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_chip_generic *gc = handler->priv->gc;
-	int core = get_ebase_cpunum() % LIOINTC_NUM_CORES;
+	int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
 	u32 pending;
 
 	chained_irq_enter(chip, desc);
-- 
2.27.0

