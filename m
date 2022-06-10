Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51025545E22
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347114AbiFJIFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347082AbiFJIFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:05:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C3C2B199
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:05:00 -0700 (PDT)
Date:   Fri, 10 Jun 2022 08:04:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654848298;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0N8DC9YiixUnBDUbCMkl/hkU2FVaOtBGL3Vg0n8cwds=;
        b=Vj5FPN5FKVWRZPwXxXfhOvf3uHWERgZexwxayMb2/dVAIuJ+hGSUAO3PE641wave9OCFG/
        eLN1vZHRiSPHoDICcWmgwzwiqhi9g1ZVrp1lBJ0d3HOCWNJwsNE4FjG0HVllx47nKhunny
        NHbeX8uDC6Qzn4Pc5qI3kyN98q3YZgI/agx9ESpq8JqD43iQRxY9nElx9S7rifMCLCt0MW
        7e2jA+fm8YIuZkRUKamLHf4srCaVq+vPIDtBGQCC7Uchq+z8e3simuq/2ZgfL4y8WWFDhv
        KGE9sJooxMqH/EmhzYtOtfB/+ztWDmA7ElJ0+0ZU39BJXQ+27ZpxBlRhv1jBdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654848298;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0N8DC9YiixUnBDUbCMkl/hkU2FVaOtBGL3Vg0n8cwds=;
        b=VQ/ikr4TkOALtDvUGSO7VtK8fGg7/TPQZ+mM96GlPiH6xHKmbhE41JZILhxjSi/GPBgFMp
        Bv8PJkLSTl1GSFDA==
From:   "irqchip-bot for Jiaxun Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/loongson-liointc: Use
 architecture register to get coreid
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220609175242.977-1-jiaxun.yang@flygoat.com>
References: <20220609175242.977-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Message-ID: <165484829710.4207.11924416657167515441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     6fac824f40987a54a08dfbcc36145869d02e45b1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/6fac824f40987a54a08dfbcc36145869d02e45b1
Author:        Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate:    Thu, 09 Jun 2022 18:52:41 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 10 Jun 2022 08:57:19 +01:00

irqchip/loongson-liointc: Use architecture register to get coreid

fa84f89395e0 ("irqchip/loongson-liointc: Fix build error for
LoongArch") replaced get_ebase_cpunum with physical processor
id from SMP facilities. However that breaks MIPS non-SMP build
and makes booting from other cores inpossible on non-SMP kernel.

Thus we revert get_ebase_cpunum back and use get_csr_cpuid for
LoongArch.

Fixes: fa84f89395e0 ("irqchip/loongson-liointc: Fix build error for LoongArch")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220609175242.977-1-jiaxun.yang@flygoat.com
---
 drivers/irqchip/irq-loongson-liointc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index aed8885..8d05d8b 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -39,6 +39,12 @@
 
 #define LIOINTC_ERRATA_IRQ	10
 
+#if defined(CONFIG_MIPS)
+#define liointc_core_id get_ebase_cpunum()
+#else
+#define liointc_core_id get_csr_cpuid()
+#endif
+
 struct liointc_handler_data {
 	struct liointc_priv	*priv;
 	u32			parent_int_map;
@@ -57,7 +63,7 @@ static void liointc_chained_handle_irq(struct irq_desc *desc)
 	struct liointc_handler_data *handler = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_chip_generic *gc = handler->priv->gc;
-	int core = cpu_logical_map(smp_processor_id()) % LIOINTC_NUM_CORES;
+	int core = liointc_core_id % LIOINTC_NUM_CORES;
 	u32 pending;
 
 	chained_irq_enter(chip, desc);
