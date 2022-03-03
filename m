Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D204CC25B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiCCQMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiCCQM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:12:29 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEEE198D37
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:11:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a8so11704038ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 08:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u+FSFzjUyL4tO84NqXDYnBQRJcBY+3fyVlESA0iCML0=;
        b=sDUL18TKOrFy0EYFjbVgGUAo88xuwcWCafNF9Z3Qv5MK9RswflDq6wcvyZt7JjkBZ0
         lCUKfKBRRzLvgGvwC04sE0vlxxbdFGK2JHeelVLIWZaYeAtcDRDoGjKH9VNzaXs2e24x
         hgD56fllm3ElTxItXi6kOXjzLPrBbfOOojk4k4g8IO2cySSza2Cv8H1te2MPyyoju2cS
         Hf+ZYtimQd9FLemaKAU2/PMPl8K17GgBfaoaTztT4N70cdeuMErbBkTFLTtvlhrc1YHj
         9nEp5yOtOTbPNW3AZOwBdhMxNGWvdscHnjxfOwmYfm7zDDQibBPkhI7vn00KEVjnojD5
         vPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=u+FSFzjUyL4tO84NqXDYnBQRJcBY+3fyVlESA0iCML0=;
        b=pzS016q6Lo/11FPGXggcPT6I2PD9ebuAcTcYJnN8Ha4A2l6OByo075dMQUqZvLyYp4
         2UGhU09GTVNlM7YZp8oiwKBqPe75kzV9eZIgy8c71H+kajIJlud4ECUUqkRhPCVQ9+wn
         8B9Od7LF3kMh482ELPtytPABFkscd8h+0mZjGL2Inhej8VtibnpaHuutctH3R+YDx3NW
         DbJ22TngrgMRt3ZY088eTCAdqYZcyQ3FL6BNMMJkuvkoz96dZGMTjpXPSCiyxZ0HxLh/
         6RPstlkkFEWNAVF7JlielkYpl9mC2lecIUcdFULgiSdrr3lrpo6MmPPx+9IY6deScAb/
         IQkA==
X-Gm-Message-State: AOAM532oLfI2m3GmhabKp8JAR7kuadCt/pT/YzGP/P9FKI8odi1Kk2ku
        hB/Ji/xRDNjFqpo0x9UppMLdGbq4N9Lyeg==
X-Google-Smtp-Source: ABdhPJztb420UBKT7kn2KUMnFMdp+OioG0SxxR0JgBDOl5FFeF6+8y/JW7c457/+xSm2ImS90VKlJw==
X-Received: by 2002:a17:906:2ec6:b0:69f:286a:66ab with SMTP id s6-20020a1709062ec600b0069f286a66abmr27825769eji.684.1646323901445;
        Thu, 03 Mar 2022 08:11:41 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm843289ejj.142.2022.03.03.08.11.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Mar 2022 08:11:40 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Robert Hancock <robert.hancock@calian.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] irqchip: xilinx: Enable generic irq multi handler
Date:   Thu,  3 Mar 2022 17:11:39 +0100
Message-Id: <2a08d6c33e95d5da5d564ed3fbddc835983ef355.1646323896.git.michal.simek@xilinx.com>
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

 arch/microblaze/Kconfig           |  2 ++
 arch/microblaze/include/asm/irq.h |  3 ---
 arch/microblaze/kernel/irq.c      | 16 +---------------
 drivers/irqchip/irq-xilinx-intc.c | 22 +++++++++++++++++++++-
 4 files changed, 24 insertions(+), 19 deletions(-)

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
index 356a59755d63..c6710190c152 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -110,7 +110,7 @@ static struct irq_chip intc_dev = {
 	.irq_mask_ack = intc_mask_ack,
 };
 
-unsigned int xintc_get_irq(void)
+static unsigned int xintc_get_irq(void)
 {
 	unsigned int irq = -1;
 	u32 hwirq;
@@ -164,6 +164,25 @@ static void xil_intc_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static u32 concurrent_irq;
+
+static void xil_intc_handle_irq(struct pt_regs *regs)
+{
+	unsigned int irq;
+
+	irq = xintc_get_irq();
+next_irq:
+	BUG_ON(!irq);
+	generic_handle_irq(irq);
+
+	irq = xintc_get_irq();
+	if (irq != -1U) {
+		pr_debug("next irq: %d\n", irq);
+		++concurrent_irq;
+		goto next_irq;
+	}
+}
+
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
@@ -233,6 +252,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 	} else {
 		primary_intc = irqc;
 		irq_set_default_host(primary_intc->root_domain);
+		set_handle_irq(xil_intc_handle_irq);
 	}
 
 	return 0;
-- 
2.35.1

