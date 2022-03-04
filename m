Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF34CCF48
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbiCDHwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbiCDHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:52:23 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF32E190B4B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:51:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id d10so15696885eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 23:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vz7l809wHa5Fftg5BtJ8l6brERiXH+s22ojtiPizhug=;
        b=bqYgHQoJVx2jDn9ok2STWrbnLOKzeu5YSD/Wr+ohdqUidpzPjRNOl/y6jkSuDDct5Y
         WduNlOSq+WNDwPskdd1mMZXhD05/LC8rl+Y9+Fsi64SHbecWXeOqXgDM3F4k34e7rVHb
         TY+fUz9+MIvS48axBh9IRZze89cjs4kj5gDb+yGp6wJ9S9q+YUfsaSwjx32YOoGGrKap
         kJs209V9cJYtAuGt4SCEbTrfPg7HFfsqI37pG1nJt4zwuQu1xhVR8fBe8ruUfuQw3utw
         AZhs9BhjZxtchrI0P1s5UeJ474Rb065KgapWevvEKYwmMvIzCsSgKYp6XTMJZCYecfG5
         QTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vz7l809wHa5Fftg5BtJ8l6brERiXH+s22ojtiPizhug=;
        b=jii/5CGw446pWEp5MrDGQw/0/C63hJMS0PeLHHLz2oF2bQkGU0KfPXYGhwU+Mw2stL
         FakRfaNNoXpteLdRY82ge8WgxpqFyuRHDIg46Md22p7yONI7VB+q7QtvIF23djEOmXSz
         d5buyBGPeKG+BvDF+9Xd6YiaGD0lssIaoUaCPvRgRbh+mA6/Gl4SwAzD3Ylb55rUdKzi
         yUCy7HNVugotRNXoRt3H3LRlvkQNpl4HBvdNRyKigowJrwTrL6o96S7ivRQ9L6bqh6vg
         DJFHpCrLpoyPwzCuonN4ZTkTOSFrJEdKhUMiq+2C/xdZwEwDlnSmnKlhXOc4ODgtbLPG
         1dvw==
X-Gm-Message-State: AOAM530CaxeCvtVelTEDs6adDGCdfeptQqDBqwIaisLB7/QdKk9bDlGZ
        Z9ula6MXxf1PNAsEnd/13H1oYrGOB6VOoQ==
X-Google-Smtp-Source: ABdhPJx71Gte/J9uqyoORu4fghnzOUu7G/X5LmAlDLfQe1KP51rNEaq4zK2+USNa8RcA2g3Opg8YEg==
X-Received: by 2002:a17:906:3ad3:b0:6cd:382b:86e5 with SMTP id z19-20020a1709063ad300b006cd382b86e5mr28762195ejd.145.1646380294245;
        Thu, 03 Mar 2022 23:51:34 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id qw18-20020a1709066a1200b006d6e5c56dd9sm1428638ejc.212.2022.03.03.23.51.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Mar 2022 23:51:33 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Robert Hancock <robert.hancock@calian.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] irqchip: xilinx: Enable generic irq multi handler
Date:   Fri,  4 Mar 2022 08:51:29 +0100
Message-Id: <e6c6595a81f662bf839cee3109d0fa58a596ea47.1646380284.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register default arch handler via driver instead of directly pointing to
xilinx intc controller. This patch makes architecture code more generic.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

Changes in v2:
- Remove concurrent_irq variable
- Use generic_handle_domain_irq() - layout by Marc

 arch/microblaze/Kconfig           |  2 ++
 arch/microblaze/include/asm/irq.h |  3 ---
 arch/microblaze/kernel/irq.c      | 16 +---------------
 drivers/irqchip/irq-xilinx-intc.c | 30 ++++++++++++++++--------------
 4 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 59798e43cdb0..da568e981604 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -45,6 +45,8 @@ config MICROBLAZE
 	select SET_FS
 	select ZONE_DMA
 	select TRACE_IRQFLAGS_SUPPORT
+	select GENERIC_IRQ_MULTI_HANDLER
+	select HANDLE_DOMAIN_IRQ
 
 # Endianness selection
 choice
diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
index 0a28e80bbab0..cb6ab55d1d01 100644
--- a/arch/microblaze/include/asm/irq.h
+++ b/arch/microblaze/include/asm/irq.h
@@ -11,7 +11,4 @@
 struct pt_regs;
 extern void do_IRQ(struct pt_regs *regs);
 
-/* should be defined in each interrupt controller driver */
-extern unsigned int xintc_get_irq(void);
-
 #endif /* _ASM_MICROBLAZE_IRQ_H */
diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
index 903dad822fad..1f8cb4c4f74f 100644
--- a/arch/microblaze/kernel/irq.c
+++ b/arch/microblaze/kernel/irq.c
@@ -20,27 +20,13 @@
 #include <linux/irqchip.h>
 #include <linux/of_irq.h>
 
-static u32 concurrent_irq;
-
 void __irq_entry do_IRQ(struct pt_regs *regs)
 {
-	unsigned int irq;
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	trace_hardirqs_off();
 
 	irq_enter();
-	irq = xintc_get_irq();
-next_irq:
-	BUG_ON(!irq);
-	generic_handle_irq(irq);
-
-	irq = xintc_get_irq();
-	if (irq != -1U) {
-		pr_debug("next irq: %d\n", irq);
-		++concurrent_irq;
-		goto next_irq;
-	}
-
+	handle_arch_irq(regs);
 	irq_exit();
 	set_irq_regs(old_regs);
 	trace_hardirqs_on();
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 356a59755d63..238d3d344949 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -32,6 +32,8 @@
 #define MER_ME (1<<0)
 #define MER_HIE (1<<1)
 
+#define SPURIOUS_IRQ	(-1U)
+
 static DEFINE_STATIC_KEY_FALSE(xintc_is_be);
 
 struct xintc_irq_chip {
@@ -110,20 +112,6 @@ static struct irq_chip intc_dev = {
 	.irq_mask_ack = intc_mask_ack,
 };
 
-unsigned int xintc_get_irq(void)
-{
-	unsigned int irq = -1;
-	u32 hwirq;
-
-	hwirq = xintc_read(primary_intc, IVR);
-	if (hwirq != -1U)
-		irq = irq_find_mapping(primary_intc->root_domain, hwirq);
-
-	pr_debug("irq-xilinx: hwirq=%d, irq=%d\n", hwirq, irq);
-
-	return irq;
-}
-
 static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
 	struct xintc_irq_chip *irqc = d->host_data;
@@ -164,6 +152,19 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static void xil_intc_handle_irq(struct pt_regs *regs)
+{
+	u32 hwirq;
+
+	do {
+		hwirq = xintc_read(primary_intc, IVR);
+		if (unlikely(hwirq == SPURIOUS_IRQ))
+			break;
+
+		generic_handle_domain_irq(primary_intc->root_domain, hwirq);
+	} while (true);
+}
+
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
@@ -233,6 +234,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 	} else {
 		primary_intc = irqc;
 		irq_set_default_host(primary_intc->root_domain);
+		set_handle_irq(xil_intc_handle_irq);
 	}
 
 	return 0;
-- 
2.35.1

