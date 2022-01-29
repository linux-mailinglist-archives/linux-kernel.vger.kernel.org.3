Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191094A3090
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 17:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352632AbiA2Q2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 11:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352602AbiA2Q17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 11:27:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426BBC061714;
        Sat, 29 Jan 2022 08:27:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D52C160EEF;
        Sat, 29 Jan 2022 16:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8959C36AE2;
        Sat, 29 Jan 2022 16:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643473678;
        bh=mj+16Yua//ZuWpSt7mb3n3M0MCT6abub/gnEMjyeKxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njlalEVBnq+YsBF/eQPkAGjPEqHK+QGU/iCXJE2G2TgMRF64o2SB0JgTa62jAXO4R
         b1ch9HX9WIdXD8JuUSXgSbdSKj++6mu5j4boufWOQJn6oE/qhebiQeo+3tis57ZaVU
         xn56YMVU+1donPQ9lWVN51aca0XevX6aqm3L80NjVXNCBjGfjigK7wPOF2G0TGQMAx
         3snex1IAG2c9E99a1FlLUEsAN9Eb4hRtA6n/m3I71up9qI/YEqPbxGuNTYu9GTeeuz
         ZlkxOxm6s+2jkFiUbbni/Dtu/VZXc9rcu5erGrelM6bDPl0wkGQvZprWghYCYXSbse
         R7RTA/9H5Hp+g==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, maz@kernel.org,
        tglx@linutronix.de, palmer@dabbelt.com, samuel@sholland.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V6 2/2] irqchip/sifive-plic: Fixup thead,c900-plic dt parse in opensbi
Date:   Sun, 30 Jan 2022 00:27:26 +0800
Message-Id: <20220129162726.1154501-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220129162726.1154501-1-guoren@kernel.org>
References: <20220129162726.1154501-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The thead,c900-plic has been used in opensbi to distinguish
PLIC [1]. Although PLICs have the same behaviors in Linux,
they are different hardware with some custom initializing in
firmware(opensbi).

[1]: https://github.com/riscv-software-src/opensbi/commit/78c2b19218bd62653b9fb31623a42ced45f38ea6

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-sifive-plic.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 259065d271ef..245655928076 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -172,7 +172,7 @@ static void plic_irq_eoi(struct irq_data *d)
 	}
 }
 
-static struct irq_chip plic_chip = {
+static struct irq_chip sifive_plic_chip = {
 	.name		= "SiFive PLIC",
 	.irq_mask	= plic_irq_mask,
 	.irq_unmask	= plic_irq_unmask,
@@ -182,12 +182,24 @@ static struct irq_chip plic_chip = {
 #endif
 };
 
+static struct irq_chip thead_plic_chip = {
+	.name		= "T-Head PLIC",
+	.irq_mask	= plic_irq_mask,
+	.irq_unmask	= plic_irq_unmask,
+	.irq_eoi	= plic_irq_eoi,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = plic_set_affinity,
+#endif
+};
+
+static struct irq_chip *def_plic_chip = &sifive_plic_chip;
+
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
 	struct plic_priv *priv = d->host_data;
 
-	irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
+	irq_domain_set_info(d, irq, hwirq, def_plic_chip, d->host_data,
 			    handle_fasteoi_irq, NULL, NULL);
 	irq_set_noprobe(irq);
 	irq_set_affinity(irq, &priv->lmask);
@@ -396,5 +408,14 @@ static int __init plic_init(struct device_node *node,
 	return error;
 }
 
+static int __init thead_c900_plic_init(struct device_node *node,
+		struct device_node *parent)
+{
+	def_plic_chip = &thead_plic_chip;
+
+	return plic_init(node, parent);
+}
+
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
+IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", thead_c900_plic_init);
-- 
2.25.1

