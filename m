Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9840647F8BA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 21:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhLZUCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 15:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhLZT7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:59:36 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D1CC061401
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 11:59:36 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:201f:9f28:b747:b33a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id E80B7288174;
        Sun, 26 Dec 2021 20:59:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640548774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RffKHmKHsI7Q9f2s/yP75xd+8RX8KcPe5WgjwZP779I=;
        b=XHIWqvF0ek/Z8tWa9Xqr6uGIrmAXY9r0yJSxi54xQCRDsx4YcYPF7gpL/BXFsryvqpMXeX
        9Y2jmIuoxEVVzlXlhmN/vkr4YIivTuFCncNBOPa6eOVttOLrphgYC2xyX3sN7/Vm2kD0NG
        2tZ40liUhNwQWsfgFBKf2vRbV4wK+4o6qpYtpA9dakzdldxDtH00G2cJLR6wzgQmEJ/IQx
        DAnArK3TFqGsvVLwQ/KFX+ZWBSxLNPAj7f6NWD42xaVxIqZXQvihtRNBJh+6h+7GTjNKyC
        1EieD0lxCuWtY5/yUNxEJOg4+k0/Udv4s7N9MLJpk9E+4Uy0tMkme+0MKlKGbg==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v2 2/5] irqchip/realtek-rtl: fix off-by-one in routing
Date:   Sun, 26 Dec 2021 20:59:25 +0100
Message-Id: <2235a7748b8f7689a96b1e0f91461e36a946a4ef.1640548009.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640548009.git.sander@svanheule.net>
References: <cover.1640548009.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an offset between routing values (1..6) and the connected MIPS
CPU interrupts (2..7), but no distinction was made between these two
values.

This issue was previously hidden during testing, because an interrupt
mapping was used where for each required interrupt another (unused)
routing was configured, with an offset of +1.

Offset the CPU IRQ numbers by -1 to retrieve the correct routing value.

Fixes: 9f3a0f34b84a ("irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller")
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/irqchip/irq-realtek-rtl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index d6788dd93c7b..568614edd88f 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -95,7 +95,8 @@ static void realtek_irq_dispatch(struct irq_desc *desc)
  * SoC interrupts are cascaded to MIPS CPU interrupts according to the
  * interrupt-map in the device tree. Each SoC interrupt gets 4 bits for
  * the CPU interrupt in an Interrupt Routing Register. Max 32 SoC interrupts
- * thus go into 4 IRRs.
+ * thus go into 4 IRRs. A routing value of '0' means the interrupt is left
+ * disconnected. Routing values {1..15} connect to output lines {0..14}.
  */
 static int __init map_interrupts(struct device_node *node, struct irq_domain *domain)
 {
@@ -134,7 +135,7 @@ static int __init map_interrupts(struct device_node *node, struct irq_domain *do
 		of_node_put(cpu_ictl);
 
 		cpu_int = be32_to_cpup(imap + 2);
-		if (cpu_int > 7)
+		if (cpu_int > 7 || cpu_int < 2)
 			return -EINVAL;
 
 		if (!(mips_irqs_set & BIT(cpu_int))) {
@@ -143,7 +144,8 @@ static int __init map_interrupts(struct device_node *node, struct irq_domain *do
 			mips_irqs_set |= BIT(cpu_int);
 		}
 
-		regs[(soc_int * 4) / 32] |= cpu_int << (soc_int * 4) % 32;
+		/* Use routing values (1..6) for CPU interrupts (2..7) */
+		regs[(soc_int * 4) / 32] |= (cpu_int - 1) << (soc_int * 4) % 32;
 		imap += 3;
 	}
 
-- 
2.33.1

