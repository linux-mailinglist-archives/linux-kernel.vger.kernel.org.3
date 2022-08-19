Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28FF599611
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346933AbiHSH3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346343AbiHSH3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:29:14 -0400
Received: from mail-m11877.qiye.163.com (mail-m11877.qiye.163.com [115.236.118.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17D683F22
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:29:10 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:36a:14ad:4200:c235:eeb6:bee9:4da8])
        by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 32B45400733;
        Fri, 19 Aug 2022 15:22:52 +0800 (CST)
From:   Yupeng Li <liyupeng@zbhlos.com>
To:     chenhuacai@kernel.org, kernel@xen0n.name, tglx@linutronix.de,
        maz@kernel.org
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yupeng Li <liyupeng@zbhlos.com>, Caicai <caizp2008@163.com>
Subject: [PATCH 1/2] irqchip: Fixed LoongArch CPU interrupt types defined.
Date:   Fri, 19 Aug 2022 15:22:39 +0800
Message-Id: <20220819072239.60378-1-liyupeng@zbhlos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHhpDVktPGUoZThlLGEsaTVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSE0aQUpPGh9BT0lLS0EYSUhOQR4eGU1BGR4eQkFPHxpDWVdZFhoPEhUdFF
        lBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRg6Pzo*CT05ERYoVkMTHREw
        VjgKCh1VSlVKTU1LQ0JITExIS0tCVTMWGhIXVRcSAg4LHhUcOwEZExcUCFUYFBZFWVdZEgtZQVlJ
        T0seQUhNGkFKTxofQU9JS0tBGElITkEeHhlNQRkeHkJBTx8aQ1lXWQgBWUFIQk5DNwY+
X-HM-Tid: 0a82b4fbbafa2eb3kusn32b45400733
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_LOONGSON_LIOINTC,CONFIG_LOONGSON_EIOINTC,
CONFIG_LOONGSON_PCH_LPC,CONFIG_LOONGSON_PCH_PIC was disabled,
build kernel with errors like:

MODPOST vmlinux.symvers
MODINFO modules.builtin.modinfo
GEN     modules.builtin
LD      .tmp_vmlinux.kallsyms1
loongarch64-linux-gnu-ld: drivers/irqchip/irq-loongarch-cpu.o: in function `lpic_get_gsi_domain_id':
irq-loongarch-cpu.c:(.text+0x8): undefined reference to `pch_lpc_handle'
loongarch64-linux-gnu-ld: irq-loongarch-cpu.c:(.text+0xc): undefined reference to `pch_lpc_handle'
loongarch64-linux-gnu-ld: irq-loongarch-cpu.c:(.text+0xc): undefined reference to `pch_lpc_handle'
make: *** [Makefile:1171：vmlinux] 错误 1

Reviewed-by: Caicai <caizp2008@163.com>
Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
---
 drivers/irqchip/irq-loongarch-cpu.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-loongarch-cpu.c b/drivers/irqchip/irq-loongarch-cpu.c
index 327f3ab62c03..d296f704cbb6 100644
--- a/drivers/irqchip/irq-loongarch-cpu.c
+++ b/drivers/irqchip/irq-loongarch-cpu.c
@@ -27,24 +27,30 @@ static u32 lpic_gsi_to_irq(u32 gsi)
 
 static struct fwnode_handle *lpic_get_gsi_domain_id(u32 gsi)
 {
+#ifdef CONFIG_LOONGSON_PCH_PIC
 	int id;
+#endif
 	struct fwnode_handle *domain_handle = NULL;
 
 	switch (gsi) {
 	case GSI_MIN_CPU_IRQ ... GSI_MAX_CPU_IRQ:
+#ifdef CONFIG_LOONGSON_LIOINTC
 		if (liointc_handle)
 			domain_handle = liointc_handle;
+#endif
 		break;
-
 	case GSI_MIN_LPC_IRQ ... GSI_MAX_LPC_IRQ:
+#ifdef CONFIG_LOONGSON_PCH_LPC
 		if (pch_lpc_handle)
 			domain_handle = pch_lpc_handle;
+#endif
 		break;
-
 	case GSI_MIN_PCH_IRQ ... GSI_MAX_PCH_IRQ:
+#ifdef CONFIG_LOONGSON_PCH_PIC
 		id = find_pch_pic(gsi);
 		if (id >= 0 && pch_pic_handle[id])
 			domain_handle = pch_pic_handle[id];
+#endif
 		break;
 	}
 
@@ -92,6 +98,7 @@ static const struct irq_domain_ops loongarch_cpu_intc_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
+#ifdef CONFIG_LOONGSON_LIOINTC
 static int __init
 liointc_parse_madt(union acpi_subtable_headers *header,
 		       const unsigned long end)
@@ -100,7 +107,8 @@ liointc_parse_madt(union acpi_subtable_headers *header,
 
 	return liointc_acpi_init(irq_domain, liointc_entry);
 }
-
+#endif
+#ifdef CONFIG_LOONGSON_EIOINTC
 static int __init
 eiointc_parse_madt(union acpi_subtable_headers *header,
 		       const unsigned long end)
@@ -109,13 +117,17 @@ eiointc_parse_madt(union acpi_subtable_headers *header,
 
 	return eiointc_acpi_init(irq_domain, eiointc_entry);
 }
-
+#endif
 static int __init acpi_cascade_irqdomain_init(void)
 {
+#ifdef CONFIG_LOONGSON_LIOINTC
 	acpi_table_parse_madt(ACPI_MADT_TYPE_LIO_PIC,
 			      liointc_parse_madt, 0);
+#endif
+#ifdef CONFIG_LOONGSON_EIOINTC
 	acpi_table_parse_madt(ACPI_MADT_TYPE_EIO_PIC,
 			      eiointc_parse_madt, 0);
+#endif
 	return 0;
 }
 
-- 
2.34.1

