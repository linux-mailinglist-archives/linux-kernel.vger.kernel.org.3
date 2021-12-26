Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC7647F8BF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 21:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhLZUCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 15:02:45 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:57542 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhLZT7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:59:37 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:201f:9f28:b747:b33a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 2A5FC288177;
        Sun, 26 Dec 2021 20:59:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640548776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tboXP4goP5ZcMhJTfz6d5ExIJnyvh4FVmcwRpjzX8U=;
        b=ZKVplqAxgh3uB2I5MozredAqciHl2raryWchRJC+Sk/SFQHiONUqLfzqys4W2hcWNJFfn+
        Xj4a8DoakijxUB9JAF66Rz9fu7yhkQclFnVAQLy11pesKltvdRATuK5d0oB50Q1fbvMU9r
        h32H48XVQOpuU4Q/dmhGotnoeDCxYEOKxM5QK7GMTmDXN/oGEHXOgxYlwv+YPjVkU5EcAl
        WjJNJMFIZdszdB1RG8LCSo/c2uWxf7WOGMx3CUehmnl7EfwYGQNGAFGT5W+7ap3NRblgk3
        V3tC3eWF7J4iiCHfAKtPcv24y+N87pzjWo1KoFClVv8bJCbjBIdrptC/EuF5Aw==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v2 5/5] irqchip/realtek-rtl: add explicit output routing
Date:   Sun, 26 Dec 2021 20:59:28 +0100
Message-Id: <5ac543a6b61bbf825519e5cb0e36f8fe218f7054.1640548009.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640548009.git.sander@svanheule.net>
References: <cover.1640548009.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the list of parent interrupts, and the optional output validity
mask, to build the list of routed output interrupts. This enables us to
remove the assumption that interrupt outputs (1..6) are always connected
to MIPS CPU interrupts (2..7).

Since the use of interrupt-map is non-standard, extra logic is required
to resolve the specified interrupts to one of the parent interrupts.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/irqchip/irq-realtek-rtl.c | 137 +++++++++++++++++++++++++-----
 1 file changed, 117 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 1f8f21a0bd1a..1b9c1108e945 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -22,6 +22,8 @@
 #define RTL_ICTL_IRR2		0x10
 #define RTL_ICTL_IRR3		0x14
 
+/* Support up to 6 active outputs for now */
+#define RTL_ICTL_OUTPUT_MASK	GENMASK(14, 0)
 #define RTL_ICTL_NUM_OUTPUTS	6
 
 #define REG(x)		(realtek_ictl_base + x)
@@ -31,6 +33,7 @@ static void __iomem *realtek_ictl_base;
 static struct irq_domain *realtek_ictl_domain;
 
 struct realtek_ictl_output {
+	int parent;
 	unsigned int routing_value;
 	u32 child_mask;
 };
@@ -142,10 +145,58 @@ static void __init set_routing(struct realtek_ictl_output *output, unsigned int
 	write_irr(REG(RTL_ICTL_IRR0), soc_int, output->routing_value);
 }
 
+static int __init resolve_parent(struct device_node *node, const __be32 *table,
+	unsigned int table_len, int *parent)
+{
+	struct of_phandle_args parent_irq;
+	struct device_node *parent_ictl;
+	unsigned int parent_cell_count;
+	unsigned int table_len_left;
+	int cell;
+	int ret;
+
+	if (!table_len)
+		return -EINVAL;
+
+	parent_ictl = of_find_node_by_phandle(be32_to_cpup(table++));
+	table_len_left = table_len - 1;
+
+	if (!parent_ictl)
+		return -EINVAL;
+
+	parent_irq.np = parent_ictl;
+
+	parent_cell_count = 0;
+	ret = of_property_read_u32(parent_ictl, "#interrupt-cells", &parent_cell_count);
+	if (ret)
+		goto out;
+
+	if (table_len_left < parent_cell_count) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	parent_irq.args_count = parent_cell_count;
+
+	for (cell = 0; cell < parent_cell_count; cell++)
+		parent_irq.args[cell] = be32_to_cpup(table++);
+
+	table_len_left -= parent_cell_count;
+
+	ret = of_irq_parse_raw(of_get_property(node, "reg", NULL), &parent_irq);
+	if (ret < 0)
+		goto out;
+
+	*parent = irq_create_of_mapping(&parent_irq);
+	ret = table_len - table_len_left;
+out:
+	of_node_put(parent_ictl);
+	return ret;
+}
+
 static int __init map_interrupts(struct device_node *node)
 {
 	struct realtek_ictl_output *output;
-	struct device_node *cpu_ictl;
 	const __be32 *imap;
 	u32 imaplen, soc_int, cpu_int, tmp;
 	int ret, i;
@@ -158,34 +209,76 @@ static int __init map_interrupts(struct device_node *node)
 	if (!imap || imaplen % 3)
 		return -EINVAL;
 
-	for (i = 0; i < imaplen; i += 3 * sizeof(u32)) {
-		soc_int = be32_to_cpup(imap);
-		if (soc_int > 31)
-			return -EINVAL;
+	imaplen /= sizeof(*imap);
+	while (imaplen > 1) {
+		soc_int = be32_to_cpup(imap++);
+		imaplen--;
 
-		cpu_ictl = of_find_node_by_phandle(be32_to_cpup(imap + 1));
-		if (!cpu_ictl)
-			return -EINVAL;
-		ret = of_property_read_u32(cpu_ictl, "#interrupt-cells", &tmp);
-		if (ret || tmp != 1)
+		if (soc_int > 31)
 			return -EINVAL;
-		of_node_put(cpu_ictl);
 
-		cpu_int = be32_to_cpup(imap + 2);
-		if (cpu_int > 7 || cpu_int < 2)
-			return -EINVAL;
+		cpu_int = 0;
+		ret = resolve_parent(node, imap, imaplen, &cpu_int);
+		if (ret < 0)
+			return ret;
+		imaplen -= ret;
+		imap += ret;
 
-		output = &realtek_ictl_outputs[cpu_int - 2];
+		i = 0;
+		output = &realtek_ictl_outputs[0];
 
-		if (!output->routing_value) {
-			irq_set_chained_handler_and_data(cpu_int, realtek_irq_dispatch, output);
-			/* Use routing values (1..6) for CPU interrupts (2..7) */
-			output->routing_value = cpu_int - 1;
+		while (i < RTL_ICTL_NUM_OUTPUTS && output->parent != cpu_int) {
+			output++;
+			i++;
 		}
 
+		if (i == RTL_ICTL_NUM_OUTPUTS)
+			return -EINVAL;
+
 		set_routing(output, soc_int);
+	}
+
+	return 0;
+}
 
-		imap += 3;
+static int __init route_parent_interrupts(struct device_node *node)
+{
+	struct realtek_ictl_output *output;
+	unsigned int current_output;
+	unsigned int num_parents;
+	unsigned int parent;
+	u32 output_mask;
+	int parent_irq;
+
+	output_mask = RTL_ICTL_OUTPUT_MASK;
+	of_property_read_u32(node, "realtek,output-valid-mask", &output_mask);
+	if (output_mask & ~RTL_ICTL_OUTPUT_MASK) {
+		pr_warn("realtek,output-valid-mask contains unsupported outputs\n");
+		output_mask &= RTL_ICTL_OUTPUT_MASK;
+	}
+
+	num_parents = of_irq_count(node);
+	if (num_parents > RTL_ICTL_NUM_OUTPUTS) {
+		pr_err("too many parent interrupts\n");
+		return -EINVAL;
+	}
+
+	for (parent = 0; output_mask && parent < num_parents; parent++) {
+		current_output = __ffs(output_mask);
+
+		parent_irq = of_irq_get(node, parent);
+		if (parent_irq < 0)
+			return parent_irq;
+		else if (!parent_irq)
+			return -ENODEV;
+
+		output = &realtek_ictl_outputs[parent];
+		output->parent = parent_irq;
+		output->routing_value = current_output + 1;
+
+		irq_set_chained_handler_and_data(parent_irq, realtek_irq_dispatch, output);
+
+		output_mask &= ~BIT(current_output);
 	}
 
 	return 0;
@@ -209,6 +302,10 @@ static int __init realtek_rtl_of_init(struct device_node *node, struct device_no
 
 	realtek_ictl_domain = irq_domain_add_simple(node, 32, 0, &irq_domain_ops, NULL);
 
+	ret = route_parent_interrupts(node);
+	if (ret)
+		return ret;
+
 	ret = map_interrupts(node);
 	if (ret) {
 		pr_err("invalid interrupt map\n");
-- 
2.33.1

