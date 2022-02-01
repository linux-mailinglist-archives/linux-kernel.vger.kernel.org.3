Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A8A4A5C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbiBAMb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:31:26 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:64667 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbiBAMbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:31:24 -0500
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id EsJZnNwfKIz5VEsJanR6Gw; Tue, 01 Feb 2022 13:31:22 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 01 Feb 2022 13:31:22 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     christophe.leroy@csgroup.eu, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, allison@lohutok.net,
        tglx@linutronix.de, clg@kaod.org, groug@kaod.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/xive: Add some error handling code to 'xive_spapr_init()'
Date:   Tue,  1 Feb 2022 13:31:16 +0100
Message-Id: <564998101804886b151235c8a9f93020923bfd2c.1643718324.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'xive_irq_bitmap_add()' can return -ENOMEM.
In this case, we should free the memory already allocated and return
'false' to the caller.

Also add an error path which undoes the 'tima = ioremap(...)'

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
NOT compile tested (I don't have a cross compiler and won't install one).
So if some correction or improvement are needed, feel free to propose and
commit it directly.

v2: rebase with latest -next
---
 arch/powerpc/sysdev/xive/spapr.c | 36 +++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index 928f95004501..29456c255f9f 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -67,6 +67,17 @@ static int __init xive_irq_bitmap_add(int base, int count)
 	return 0;
 }
 
+static void xive_irq_bitmap_remove_all(void)
+{
+	struct xive_irq_bitmap *xibm, *tmp;
+
+	list_for_each_entry_safe(xibm, tmp, &xive_irq_bitmaps, list) {
+		list_del(&xibm->list);
+		kfree(xibm->bitmap);
+		kfree(xibm);
+	}
+}
+
 static int __xive_irq_bitmap_alloc(struct xive_irq_bitmap *xibm)
 {
 	int irq;
@@ -803,7 +814,7 @@ bool __init xive_spapr_init(void)
 	u32 val;
 	u32 len;
 	const __be32 *reg;
-	int i;
+	int i, err;
 
 	if (xive_spapr_disabled())
 		return false;
@@ -828,23 +839,26 @@ bool __init xive_spapr_init(void)
 	}
 
 	if (!xive_get_max_prio(&max_prio))
-		return false;
+		goto err_unmap;
 
 	/* Feed the IRQ number allocator with the ranges given in the DT */
 	reg = of_get_property(np, "ibm,xive-lisn-ranges", &len);
 	if (!reg) {
 		pr_err("Failed to read 'ibm,xive-lisn-ranges' property\n");
-		return false;
+		goto err_unmap;
 	}
 
 	if (len % (2 * sizeof(u32)) != 0) {
 		pr_err("invalid 'ibm,xive-lisn-ranges' property\n");
-		return false;
+		goto err_unmap;
 	}
 
-	for (i = 0; i < len / (2 * sizeof(u32)); i++, reg += 2)
-		xive_irq_bitmap_add(be32_to_cpu(reg[0]),
-				    be32_to_cpu(reg[1]));
+	for (i = 0; i < len / (2 * sizeof(u32)); i++, reg += 2) {
+		err = xive_irq_bitmap_add(be32_to_cpu(reg[0]),
+					  be32_to_cpu(reg[1]));
+		if (err < 0)
+			goto err_mem_free;
+	}
 
 	/* Iterate the EQ sizes and pick one */
 	of_property_for_each_u32(np, "ibm,xive-eq-sizes", prop, reg, val) {
@@ -855,10 +869,16 @@ bool __init xive_spapr_init(void)
 
 	/* Initialize XIVE core with our backend */
 	if (!xive_core_init(np, &xive_spapr_ops, tima, TM_QW1_OS, max_prio))
-		return false;
+		goto err_mem_free;
 
 	pr_info("Using %dkB queues\n", 1 << (xive_queue_shift - 10));
 	return true;
+
+err_mem_free:
+	xive_irq_bitmap_remove_all();
+err_unmap:
+	iounmap(tima);
+	return false;
 }
 
 machine_arch_initcall(pseries, xive_core_debug_init);
-- 
2.32.0

