Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DCC5094DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 03:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383747AbiDUCA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 22:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383734AbiDUCA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 22:00:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E22FD18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:57:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b7so3463566plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:from:to:cc:subject:content-transfer-encoding
         :mime-version;
        bh=PkQCm/hv+dakAJ31Bhx1KOY7qDepq0YeQjh3xq+XJxM=;
        b=SefjBQ/rQ0ZqcPgHqFtPrw5Dds9UH3ZASpjT6pvV6Umt01dlcrym6GWBP8P4uTxn/w
         wscp6pyLzkVFScXWm10VzFcOFRC6gnYgkiq6EYiPuoO2HVS1EJvRveTK/vHd9QdTUl2w
         Nm7ruTCFCGGqOtjjD/5KAnHCA6VcJ6s50z01fZTMjUR+Mc2r5syuwSNdxmmepPg1jdsL
         MDLTfJvsgqbQ+XkpD5zcp9uJuKyl2y4Aak2NbEJ7ww9S+lt6j3D7j9YFfpVzjUW4ltoA
         S8Te7aGNZJBNC3QXc8iltHLDuz7XA1ccrvhBAU+INtq2xvhlI8+BVb+z+snWzTJGoVzH
         RAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=PkQCm/hv+dakAJ31Bhx1KOY7qDepq0YeQjh3xq+XJxM=;
        b=uGeSg3NKSJ2vlc71kpcSiJw6lXAupFNoo0a53hUiYRFfAK76U9wEb7eFzxEeODG1fK
         SQi0KxeUCUE3Vunb6Fj4oPfYlqE1iCspQEwv+CUeNbSzvNi1x91glztKy7jlfHeLd4PZ
         Lp+F1SxNDxLlN7jXhk9t5Q+eXGc/votlRDHfXTKxegda4nYEA38tWMR0rkxBZT8Ik/I9
         H35bU2x6Ok6EHVFKTnbO5rj+ed6a1XGYQBpcI02+LYE0I5M0vzwgtjJuHgg71+sYOhYK
         ncU7lb8Ij4EDGn1WurKrZpY3ZMNsJiC9lVVdJntQqd7cr07qIVJy/WzZe+DauApvBx5f
         0W6w==
X-Gm-Message-State: AOAM530GxU/2I7lMLuw0RBoW2YR30gbZETUIT0cyeogbT+hbAsR1Si5a
        VRbUWC2T8Nw5OJRN8+6xjl77Cg==
X-Google-Smtp-Source: ABdhPJzu+x9+ninN9ACAeOJUNvaV1Ck0J1iur4vKcu5hzsnskw+1zrZ2Zg+2R1kRIX4h+MtBEmZ4Rg==
X-Received: by 2002:a17:90b:314d:b0:1d2:7cd4:20a1 with SMTP id ip13-20020a17090b314d00b001d27cd420a1mr7672423pjb.52.1650506259367;
        Wed, 20 Apr 2022 18:57:39 -0700 (PDT)
Received: from [127.0.1.1] (117-20-68-98.751444.bne.nbn.aussiebb.net. [117.20.68.98])
        by smtp.gmail.com with UTF8SMTPSA id h189-20020a636cc6000000b0039841f669bcsm21441025pgc.78.2022.04.20.18.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:57:38 -0700 (PDT)
Date:   Thu, 21 Apr 2022 01:57:28 +0000
Message-Id: <20220421015728.86912-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip/armada-370-xp: Enable MSI affinity configuration
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Rossi <nathan.rossi@digi.com>

With multiple devices attached via PCIe to an Armada 385 it is possible
to overwhelm a single CPU with MSI interrupts. Under certain scenarios
configuring the interrupts to be handled by more than one CPU would
prevent the system from being overwhelmed. However the
irqchip-aramada-370-xp driver is configured to only handle MSIs on the
boot CPU, and provides no affinity configuration.

This change adds support to the armada-370-xp driver to allow for
configuring the affinity of specific MSI irqs and to generate the
interrupts on secondary CPUs. This is done by enabling the private
doorbell for all online CPUs and configures all CPUs to unmask MSI
specific private doorbell bits. The CPU affinity selection of the
interrupt is handled by the target list of the software triggered
interrupt value, which is provided as the MSI message. The message has
the associated CPU bit set for the target CPU. For private doorbell
interrupts only one bit can be set otherwise all CPUs will receive the
interrupt, so the lowest CPU in the affinity mask is used. This means
that by default the first CPU will handle all the interrupts as was the
case before.

Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 5b8d571c04..42c257f576 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -209,15 +209,37 @@ static struct msi_domain_info armada_370_xp_msi_domain_info = {
 
 static void armada_370_xp_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
+#ifdef CONFIG_SMP
+	unsigned int cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
+
+	msg->data = (1 << (cpu + 8)) | (data->hwirq + PCI_MSI_DOORBELL_START);
+#else
+	msg->data = 0xf00 | (data->hwirq + PCI_MSI_DOORBELL_START);
+#endif
 	msg->address_lo = lower_32_bits(msi_doorbell_addr);
 	msg->address_hi = upper_32_bits(msi_doorbell_addr);
-	msg->data = 0xf00 | (data->hwirq + PCI_MSI_DOORBELL_START);
 }
 
 static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
 					  const struct cpumask *mask, bool force)
 {
-	 return -EINVAL;
+#ifdef CONFIG_SMP
+	unsigned int cpu;
+
+	if (!force)
+		cpu = cpumask_any_and(mask, cpu_online_mask);
+	else
+		cpu = cpumask_first(mask);
+
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	irq_data_update_effective_affinity(irq_data, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK;
+#else
+	return -EINVAL;
+#endif
 }
 
 static struct irq_chip armada_370_xp_msi_bottom_irq_chip = {
@@ -482,6 +504,7 @@ static void armada_xp_mpic_smp_cpu_init(void)
 static void armada_xp_mpic_reenable_percpu(void)
 {
 	unsigned int irq;
+	u32 reg;
 
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
 	for (irq = 0; irq < ARMADA_370_XP_MAX_PER_CPU_IRQS; irq++) {
@@ -501,6 +524,13 @@ static void armada_xp_mpic_reenable_percpu(void)
 	}
 
 	ipi_resume();
+
+	/* Enable MSI doorbell mask and combined cpu local interrupt */
+	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
+		| PCI_MSI_DOORBELL_MASK;
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	/* Unmask local doorbell interrupt */
+	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
 
 static int armada_xp_mpic_starting_cpu(unsigned int cpu)
---
2.35.2
