Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50774F4EA6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836013AbiDFAeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457386AbiDEQDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC9B2704
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:40:01 -0700 (PDT)
Date:   Tue, 05 Apr 2022 15:39:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649173199;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYLX3zMwYYS/2mN49h0AH7UMJtTws3J3pqHyjIi/IxM=;
        b=ehbVtxmz1Q9X6qmneErmigDyIgiViqG41BF7LScvI3Rp2HAkIaHZfw5jSXCjWvJBK3lWH4
        9VCVpjR1unlsk7W3PNHMmrP6dcqkPJ52rmvirVHUgyE2EmJPfu3/j60x5wRYgna25OwI6A
        qotnuFZzP+BL/Zruc3+StU3W4dJ8i2/ZefJI8ia7EJO6T9n542mDLxMxl+JRVCH/CkQmSM
        xnzLfkNR2FqOAYMmaBVHSPXRK5LuMKR39rceD7vjD0jRtsanRW0Oek3BkMxVDSclJ/i3Zz
        ef8FZphKpAdJowv/9CaqN0wWMHsq2XSywwPbp8vSNnB5NVykEps+ZH91I3357Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649173199;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYLX3zMwYYS/2mN49h0AH7UMJtTws3J3pqHyjIi/IxM=;
        b=M391MSaHICL7bCwBLE3YYQnbytAbiCNIZKhlpsTumXmArmzxWcTXvLpU2bNU4uG6CYh01c
        GWCAPNgJfakdutBQ==
From:   "irqchip-bot for Andre Przywara" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic, gic-v3: Prevent GSI to SGI
 translations
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220404110842.2882446-1-andre.przywara@arm.com>
References: <20220404110842.2882446-1-andre.przywara@arm.com>
MIME-Version: 1.0
Message-ID: <164917319858.389.17170980222692377777.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     544808f7e21cb9ccdb8f3aa7de594c05b1419061
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/544808f7e21cb9ccdb8f3aa7de594c05b1419061
Author:        Andre Przywara <andre.przywara@arm.com>
AuthorDate:    Mon, 04 Apr 2022 12:08:42 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 05 Apr 2022 16:33:47 +01:00

irqchip/gic, gic-v3: Prevent GSI to SGI translations

At the moment the GIC IRQ domain translation routine happily converts
ACPI table GSI numbers below 16 to GIC SGIs (Software Generated
Interrupts aka IPIs). On the Devicetree side we explicitly forbid this
translation, actually the function will never return HWIRQs below 16 when
using a DT based domain translation.

We expect SGIs to be handled in the first part of the function, and any
further occurrence should be treated as a firmware bug, so add a check
and print to report this explicitly and avoid lengthy debug sessions.

Fixes: 64b499d8df40 ("irqchip/gic-v3: Configure SGIs as standard interrupts")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220404110842.2882446-1-andre.przywara@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 6 ++++++
 drivers/irqchip/irq-gic.c    | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 9b63165..b252d55 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1466,6 +1466,12 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		if(fwspec->param_count != 2)
 			return -EINVAL;
 
+		if (fwspec->param[0] < 16) {
+			pr_err(FW_BUG "Illegal GSI%d translation request\n",
+			       fwspec->param[0]);
+			return -EINVAL;
+		}
+
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1];
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 58ba835..09c710e 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1123,6 +1123,12 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		if(fwspec->param_count != 2)
 			return -EINVAL;
 
+		if (fwspec->param[0] < 16) {
+			pr_err(FW_BUG "Illegal GSI%d translation request\n",
+			       fwspec->param[0]);
+			return -EINVAL;
+		}
+
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1];
 
