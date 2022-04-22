Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8371950AF32
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 06:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443964AbiDVEii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 00:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiDVEif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:38:35 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08194D9EC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 21:35:43 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id j8so8254613pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 21:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=date:message-id:from:to:cc:subject:content-transfer-encoding
         :mime-version;
        bh=M1zEA4Rd5ZCLKn8oAHlEJHTf7wmuwA1tinGTJbg3ppg=;
        b=J/LGr+AYL2LkSJruw9Mq7DUwEztITkVnezCYsdrnM1iWTRF6ck8koUOm3aAXKKGYMs
         WpwzS4ecREa8hYV8BxpUi6BIxsCOb9tCb3iYNq6K+uUmmir7ZWCaHX05UTLMa6qY0cLd
         k5dXTqH3SPnz7XhWmBUSoKQ3Pk07s7fNed8WUYkSn4rv1bm7Rsr9+58e6wRmmVWVJsRV
         1YT9UKS4r3rEgJc++lVO8SV508tBbbLdEXEqCCpSqfRKNlx0YOs3ILVu7MDJ/ow0AXKP
         Vvv5ZytdJ+PLr0wb+NB97drTHtfCXDmp+NmGjyXnYbpWdyF43vsSg5QY9kiDPWv6EnrC
         YJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:from:to:cc:subject
         :content-transfer-encoding:mime-version;
        bh=M1zEA4Rd5ZCLKn8oAHlEJHTf7wmuwA1tinGTJbg3ppg=;
        b=kdT+2kw00KMXSswd2mtN8+OG66AZorFpLVaNXlJ8lGReO67N42aryYRRBu8577TMSc
         WS8qhvj2v/hEB76UfC3rxSS1AhxLfMI9ias7i67IIkRYceWpd5kOPF90E5Nua7OXgYL5
         1j7v7moLTqZXMteZvxaSUKDNQ6yOhHGKi13peBveEc7XHb9LyW2QNfxIo3aQB3P2EPt5
         2Kt5K3+nsQWflMecWFJ5z168esnbfM4khOt0H22MbCv83ujYc8p4ht7ljvrOVS/BL/EI
         eOEyV9d/izBBFVx6X4MCrgJSHZZptPmY/6Fl2oT+WpXfh8OibyQzQrO/oChclTwUAxu3
         sbhA==
X-Gm-Message-State: AOAM530B1Boi56oX5g07eQRD2httHsDj8Y2asSDmLQkjQcuJvfWtLFed
        mLsKjM4nszQi/G6XkH6AXLk3RKH11e/aZ8j0
X-Google-Smtp-Source: ABdhPJwKhx39fbI71kRs5X1XA98OniySoQqpUED7T+qElt+e6D4ffxxTzZra+lkjcUeep11dQVRr0Q==
X-Received: by 2002:a17:90a:940e:b0:1cd:c4f3:6a6c with SMTP id r14-20020a17090a940e00b001cdc4f36a6cmr3293516pjo.28.1650602143210;
        Thu, 21 Apr 2022 21:35:43 -0700 (PDT)
Received: from [127.0.1.1] (117-20-68-98.751444.bne.nbn.aussiebb.net. [117.20.68.98])
        by smtp.gmail.com with UTF8SMTPSA id s3-20020a056a00194300b004f6da3a1a3bsm790639pfk.8.2022.04.21.21.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 21:35:42 -0700 (PDT)
Date:   Fri, 22 Apr 2022 04:35:32 +0000
Message-Id: <20220422043532.146946-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan@nathanrossi.com>,
        Nathan Rossi <nathan.rossi@digi.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH v2] irqchip/armada-370-xp: Enable MSI affinity configuration
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
Changes in v2:
- Use BIT()
- Remove added #ifdef CONFIG_SMP within compose_msi_msg/msi_set_affinity
- Refactor duplication of per cpu doorbell mask and interrupt enable
  configuration
---
 drivers/irqchip/irq-armada-370-xp.c | 45 +++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 5b8d571c04..c877285d70 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -209,15 +209,29 @@ static struct msi_domain_info armada_370_xp_msi_domain_info = {
 
 static void armada_370_xp_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
+	unsigned int cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
+
 	msg->address_lo = lower_32_bits(msi_doorbell_addr);
 	msg->address_hi = upper_32_bits(msi_doorbell_addr);
-	msg->data = 0xf00 | (data->hwirq + PCI_MSI_DOORBELL_START);
+	msg->data = BIT(cpu + 8) | (data->hwirq + PCI_MSI_DOORBELL_START);
 }
 
 static int armada_370_xp_msi_set_affinity(struct irq_data *irq_data,
 					  const struct cpumask *mask, bool force)
 {
-	 return -EINVAL;
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
 }
 
 static struct irq_chip armada_370_xp_msi_bottom_irq_chip = {
@@ -264,11 +278,21 @@ static const struct irq_domain_ops armada_370_xp_msi_domain_ops = {
 	.free	= armada_370_xp_msi_free,
 };
 
-static int armada_370_xp_msi_init(struct device_node *node,
-				  phys_addr_t main_int_phys_base)
+static void armada_370_xp_msi_reenable_percpu(void)
 {
 	u32 reg;
 
+	/* Enable MSI doorbell mask and combined cpu local interrupt */
+	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
+		| PCI_MSI_DOORBELL_MASK;
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
+	/* Unmask local doorbell interrupt */
+	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+}
+
+static int armada_370_xp_msi_init(struct device_node *node,
+				  phys_addr_t main_int_phys_base)
+{
 	msi_doorbell_addr = main_int_phys_base +
 		ARMADA_370_XP_SW_TRIG_INT_OFFS;
 
@@ -287,18 +311,13 @@ static int armada_370_xp_msi_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
-	reg = readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK_OFFS)
-		| PCI_MSI_DOORBELL_MASK;
-
-	writel(reg, per_cpu_int_base +
-	       ARMADA_370_XP_IN_DRBEL_MSK_OFFS);
-
-	/* Unmask IPI interrupt */
-	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
+	armada_370_xp_msi_reenable_percpu();
 
 	return 0;
 }
 #else
+static void armada_370_xp_msi_reenable_percpu(void) {}
+
 static inline int armada_370_xp_msi_init(struct device_node *node,
 					 phys_addr_t main_int_phys_base)
 {
@@ -501,6 +520,8 @@ static void armada_xp_mpic_reenable_percpu(void)
 	}
 
 	ipi_resume();
+
+	armada_370_xp_msi_reenable_percpu();
 }
 
 static int armada_xp_mpic_starting_cpu(unsigned int cpu)
---
2.35.2
