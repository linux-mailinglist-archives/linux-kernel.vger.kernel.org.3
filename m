Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0B57A127
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbiGSOTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiGSOS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:18:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48D7F52D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 06:55:51 -0700 (PDT)
Date:   Tue, 19 Jul 2022 13:55:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658238949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0Z032i2fbmIcavT6MKuRkssXwrodwgFJfgRl0JPKHQ=;
        b=tpYg8B3OMFF1RXppKC6vtw4EWHwLe/KGxC6aKEuaD36k7/QBbfNmUoP//eQdmO3B1qykWr
        mYSSsQomo17OkDtY/I95DIoTD8kE906Crdggxzga8PceQcvtjYgJrQ7OXKFJJTS/VFRS5A
        hPpOQbvGVzs797FUNb92zdLz0jzhyx2C2ex36rrcqEynAe3Mv32yXOoOrvN4hXBKNnmPBw
        ho2+ujcdRLq3GPFEZ0L6BkuTtKF2gOzBTzRCKkg+tjLSDhHGzU/5yUy087K9eLYUVmDeRI
        5QB9vhHGDW08IOaldjDAHtBUksiGeilVuy1Jme91zNy56vKHiy5xzcLnXArh/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658238949;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0Z032i2fbmIcavT6MKuRkssXwrodwgFJfgRl0JPKHQ=;
        b=1OWiWy0HbhCOQ0T3aXT4zWWfrLy3BaidMgnJVDUNjyOH6wzTk1YJ3peOh5wDDvpqHGQMEq
        t8JxdoF/JunbR6Cw==
From:   "irqchip-bot for Xu Qiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqdomain: Use hwirq_max instead of
 revmap_size for NOMAP domains
Cc:     Xu Qiang <xuqiang36@huawei.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220719063641.56541-3-xuqiang36@huawei.com>
References: <20220719063641.56541-3-xuqiang36@huawei.com>
MIME-Version: 1.0
Message-ID: <165823894768.15455.2097114111818938534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     ef50cd57a73a8bbfad403e5e2edb3309611f58ad
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ef50cd57a73a8bbfad403e5e2edb3309611f58ad
Author:        Xu Qiang <xuqiang36@huawei.com>
AuthorDate:    Tue, 19 Jul 2022 06:36:41 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Jul 2022 14:51:56 +01:00

irqdomain: Use hwirq_max instead of revmap_size for NOMAP domains

NOMAP irq domains use the revmap_size field to indicate the maximum
hwirq number the domain accepts. This is a bit confusing as
revmap_size is usually used to indicate the size of the revmap array,
which a NOMAP domain doesn't have.

Instead, use the hwirq_max field which has the correct semantics, and
keep revmap_size to 0 for a NOMAP domain.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
[maz: commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220719063641.56541-3-xuqiang36@huawei.com
---
 kernel/irq/irqdomain.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 481abb8..8fe1da9 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -147,7 +147,8 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 	static atomic_t unknown_domains;
 
 	if (WARN_ON((size && direct_max) ||
-		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max)))
+		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max) ||
+		    (direct_max && (direct_max != hwirq_max))))
 		return NULL;
 
 	domain = kzalloc_node(struct_size(domain, revmap, size),
@@ -219,7 +220,6 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 	domain->hwirq_max = hwirq_max;
 
 	if (direct_max) {
-		size = direct_max;
 		domain->flags |= IRQ_DOMAIN_FLAG_NO_MAP;
 	}
 
@@ -650,9 +650,9 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain)
 		pr_debug("create_direct virq allocation failed\n");
 		return 0;
 	}
-	if (virq >= domain->revmap_size) {
-		pr_err("ERROR: no free irqs available below %i maximum\n",
-			domain->revmap_size);
+	if (virq >= domain->hwirq_max) {
+		pr_err("ERROR: no free irqs available below %lu maximum\n",
+			domain->hwirq_max);
 		irq_free_desc(virq);
 		return 0;
 	}
@@ -906,7 +906,7 @@ struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
 		return desc;
 
 	if (irq_domain_is_nomap(domain)) {
-		if (hwirq < domain->revmap_size) {
+		if (hwirq < domain->hwirq_max) {
 			data = irq_domain_get_irq_data(domain, hwirq);
 			if (data && data->hwirq == hwirq)
 				desc = irq_data_to_desc(data);
