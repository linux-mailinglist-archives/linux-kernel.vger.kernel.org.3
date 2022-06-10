Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA68545985
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbiFJBUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFJBUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:20:36 -0400
Received: from mail-m17635.qiye.163.com (mail-m17635.qiye.163.com [59.111.176.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A3931DE9;
        Thu,  9 Jun 2022 18:20:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:36a:1490:f100:350f:5deb:826:39a1])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 3ED5D4001F7;
        Fri, 10 Jun 2022 09:20:00 +0800 (CST)
From:   Yupeng Li <liyupeng@zbhlos.com>
To:     chenhuacai@kernel.org, jiaxun.yang@flygoat.com, tglx@linutronix.de,
        maz@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        caizp2008@163.com, Yupeng Li <liyupeng@zbhlos.com>
Subject: [PATCH 1/1]   irqchip/loongson-liointc: Guard uses of cpu_logical_map
Date:   Fri, 10 Jun 2022 09:19:58 +0800
Message-Id: <20220610011958.3263650-1-liyupeng@zbhlos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpNS0hWGkJJGRofT09KSB
        4aVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ky46KQw*Ij0#AwpLOTY9Cw8B
        LTYwFDBVSlVKTU5PQ0lPS0tKS0lPVTMWGhIXVRcSAg4LHhUcOwEZExcUCFUYFBZFWVdZEgtZQVlJ
        T0seQUhNGkFKT0JLQR1KS0tBSE5LHUFOHx4ZQUNJTUFIQhpKWVdZCAFZQUlNTko3Bg++
X-HM-Tid: 0a814b325ba7d991kuws3ed5d4001f7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  cpu_logical_map is only defined for CONFIG_SMP builds, when we are in an
  UP configuration, the boot CPU is 0. Some kernel compilation error 
  information is as follows:

  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      drivers/irqchip/irq-loongson-liointc.o
drivers/irqchip/irq-loongson-liointc.c: In function 'liointc_chained_handle_irq':
drivers/irqchip/irq-loongson-liointc.c:60:13: error: implicit declaration of function 'cpu_logical_map' [-Werror=implicit-function-declaration]
  int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
             ^~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:249:drivers/irqchip/irq-loongson-liointc.o] error 1
make[1]: *** [scripts/Makefile.build:466:drivers/irqchip] error 2

Acked-by: Caicai <caizp2008@163.com>
Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
---
 drivers/irqchip/irq-loongson-liointc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index aed88857d90f..927e236bf18e 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -57,7 +57,11 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
 	struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_chip_generic *gc = handler->priv->gc;
+#ifdef CONFIG_SMP
 	int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
+#else
+	int core = 0;
+#endif
 	u32 pending;
 
 	chained_irq_enter(chip, desc);
-- 
2.34.1

