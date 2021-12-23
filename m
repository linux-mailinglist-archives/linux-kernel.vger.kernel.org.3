Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345A247E2FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348177AbhLWMJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348142AbhLWMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:53 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA09BC06175A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:08:52 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:29a7:866a:cac1:4c27])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id E4C292866B5;
        Thu, 23 Dec 2021 13:08:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640261331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1em+x8emmOQHJWrevz6ZnKRMz4D+64SPUIqqFXJFNjw=;
        b=hdHdmMl+XnxcLO+RcCPLd5mCF4gZdJHlaNZQq+zxdXjbodOB47Jq3jGL09JkK6kx2lVib2
        y/moD9fDm1bXChCRSKHKKLvB0r4kSDlc+Ld9qjkefIlVzCBZUogxyUOGbItHXYW40co+9T
        txisnMzyrxfcOG2v230K03+6h0DtXGkVj7jXobSOCIfDvBeEehfNxAjt+u3qnN4a3sBwWH
        ruVPzlEZOVJfXCA+YwgUnpANhLIEUnB4ygPFE4T0l7uD0I4NZocxO2akRu6cq5gB/eDL0V
        06CNgi8590l5GvcgHH7aiHqPb4u6PZVv8EtF50h75EwAe0WTxOi431GMc3Mk8Q==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v1 4/4] irqchip: realtek-rtl: replace custom interrupt-map
Date:   Thu, 23 Dec 2021 13:08:34 +0100
Message-Id: <97c90aa00c1bf31152585d204636a569bd86d745.1640261161.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640261161.git.sander@svanheule.net>
References: <cover.1640261161.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To match the updated realtek,rtl-intc devicetree binding, replace the
interrupt routing parsing.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/irqchip/irq-realtek-rtl.c | 77 +++++++++++++++----------------
 1 file changed, 36 insertions(+), 41 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 71366f1cf721..d80fbc5e651b 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -160,55 +160,50 @@ static int __init setup_parent_interrupt(struct realtek_ictl_priority *prio_ctl,
 	return request_irq(parent, realtek_irq_dispatch, flags, "rtl-intc", prio_ctl);
 }
 
-static int __init map_interrupts(struct device_node *node)
+static int __init route_interrupts(struct device_node *node)
 {
 	struct realtek_ictl_priority *prio_ctl;
-	struct device_node *cpu_ictl;
-	const __be32 *imap;
-	u32 imaplen, soc_int, priority, tmp;
-	int ret, i;
-
-	ret = of_property_read_u32(node, "#address-cells", &tmp);
-	if (ret || tmp)
-		return -EINVAL;
-
-	imap = of_get_property(node, "interrupt-map", &imaplen);
-	if (!imap || imaplen % 3)
-		return -EINVAL;
-
-	for (i = 0; i < imaplen; i += 3 * sizeof(u32)) {
-		soc_int = be32_to_cpup(imap);
-		if (soc_int > 31)
-			return -EINVAL;
+	unsigned int num_prio, parent_idx;
+	const __be32 *routing_table;
+	int table_len;
+	u32 hw_irq;
+	int ret;
 
-		cpu_ictl = of_find_node_by_phandle(be32_to_cpup(imap + 1));
-		if (!cpu_ictl)
-			return -EINVAL;
-		ret = of_property_read_u32(cpu_ictl, "#interrupt-cells", &tmp);
-		if (ret || tmp != 1)
-			return -EINVAL;
-		of_node_put(cpu_ictl);
+	num_prio = of_irq_count(node);
+	if (num_prio > RTL_ICTL_NUM_PRIO) {
+		pr_err("too many parent interrupts\n");
+		return -ENODEV;
+	}
 
-		/* Map priority (1..6) to MIPS CPU interrupt (2..7) */
-		priority = be32_to_cpup(imap + 2);
-		if (priority > 6 || priority < 1)
-			return -EINVAL;
+	for (parent_idx = 0; parent_idx < num_prio; parent_idx++) {
+		prio_ctl = &priorities[parent_idx];
 
-		prio_ctl = &priorities[priority - 1];
+		ret = irq_of_parse_and_map(node, parent_idx);
+		if (ret < 0)
+			return ret;
 
-		if (!prio_ctl->routing_value) {
-			ret = setup_parent_interrupt(prio_ctl, priority + 1);
-			if (ret)
-				return ret;
+		ret = setup_parent_interrupt(prio_ctl, ret);
+		if (ret)
+			return ret;
 
-			prio_ctl->routing_value = priority;
-		}
+		prio_ctl->routing_value = parent_idx + 1;
+	}
 
-		set_routing(prio_ctl, soc_int);
+	routing_table = of_get_property(node, "realtek,interrupt-routing", &table_len);
+	if (!routing_table)
+		return -ENOENT;
 
-		imap += 3;
-	}
+	for (table_len /= sizeof(*routing_table); table_len >= 2; table_len -= 2) {
+		hw_irq = be32_to_cpup(routing_table++);
+		if (hw_irq > 31)
+			return -EINVAL;
 
+		parent_idx = be32_to_cpup(routing_table++);
+		if (parent_idx >= num_prio)
+			return -EINVAL;
+
+		set_routing(&priorities[parent_idx], hw_irq);
+	}
 
 	return 0;
 }
@@ -231,9 +226,9 @@ static int __init realtek_rtl_of_init(struct device_node *node, struct device_no
 
 	realtek_ictl_domain = irq_domain_add_simple(node, 32, 0, &irq_domain_ops, NULL);
 
-	ret = map_interrupts(node);
+	ret = route_interrupts(node);
 	if (ret) {
-		pr_err("invalid interrupt map\n");
+		pr_err("invalid interrupt routing\n");
 		return ret;
 	}
 
-- 
2.33.1

