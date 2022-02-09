Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955954AF662
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbiBIQSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiBIQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:18:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60458C05CB98
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:18:03 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:18:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hfuuq327J/t23hwIsWuFw4G1RD978pqM5j+Rd/fe28E=;
        b=3S6XpcZGHVz7IElwfa0yqHkwPaDLkWKLtUJ9fh+l2T8revXlkXf12bVVObwW4rGbZJkdUQ
        LxzkmXrT6cUvLSuEkIN+qo1W42KySymVMg3zP/CXCrSWleYXgvW1d/qtP2neKqe44/Evw8
        NHo3panZVhdwwjTkeDvHXL8kXfH9qL1z8a8EoXEI8mQLEVXKqqSC3KBQsIHMjNpVNqoP02
        /EJDgFV8D+CxJNGaZ2PngpEEFTVczNJ7ufGnztVc0LK8B21eY72AHNbygSbZGDz7vBDrl6
        eFfxObwNTF9pwRGL4SmZYeH5hPxLtM5y9jP8Dlt0oKBwqNwzxQB7Vj36/MjZpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423482;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hfuuq327J/t23hwIsWuFw4G1RD978pqM5j+Rd/fe28E=;
        b=1IycszLzgvS1IrkjbJTjFT+CN7pEqJp8ISTaNcHvDzgFfsvUW1H2VAFws/91FrB/rQiI8g
        pRPmcMvJZ9sM96Cg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Allow the PM device to originate
 from irq domain
Cc:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, tglx@linutronix.de
In-Reply-To: <20220201120310.878267-2-maz@kernel.org>
References: <20220201120310.878267-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164442348103.16921.9094020077297342205.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     1f8863bfb5ca500ea1c7669b16b1931ba27fce20
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1f8863bfb5ca500ea1c7669b16b1931ba27fce20
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:02:59 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:35:56 

genirq: Allow the PM device to originate from irq domain

As a preparation to moving the reference to the device used for
runtime power management, add a new 'dev' field to the irqdomain
structure for that exact purpose.

The irq_chip_pm_{get,put}() helpers are made aware of the dual
location via a new private helper.

No functional change intended.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Tony Lindgren <tony@atomide.com>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Link: https://lore.kernel.org/r/20220201120310.878267-2-maz@kernel.org
---
 include/linux/irqdomain.h | 10 ++++++++++
 kernel/irq/chip.c         | 23 ++++++++++++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d476405..be25a33 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -151,6 +151,8 @@ struct irq_domain_chip_generic;
  * @gc: Pointer to a list of generic chips. There is a helper function for
  *      setting up one or more generic chips for interrupt controllers
  *      drivers using the generic chip library which uses this pointer.
+ * @dev: Pointer to a device that the domain represent, and that will be
+ *       used for power management purposes.
  * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
  *
  * Revmap data, used internally by irq_domain
@@ -171,6 +173,7 @@ struct irq_domain {
 	struct fwnode_handle *fwnode;
 	enum irq_domain_bus_token bus_token;
 	struct irq_domain_chip_generic *gc;
+	struct device *dev;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain *parent;
 #endif
@@ -226,6 +229,13 @@ static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
 	return to_of_node(d->fwnode);
 }
 
+static inline void irq_domain_set_pm_device(struct irq_domain *d,
+					    struct device *dev)
+{
+	if (d)
+		d->dev = dev;
+}
+
 #ifdef CONFIG_IRQ_DOMAIN
 struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 						const char *name, phys_addr_t *pa);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index c093246..a2a12cd 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1558,6 +1558,17 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	return 0;
 }
 
+static struct device *irq_get_parent_device(struct irq_data *data)
+{
+	if (data->chip->parent_device)
+		return data->chip->parent_device;
+
+	if (data->domain)
+		return data->domain->dev;
+
+	return NULL;
+}
+
 /**
  * irq_chip_pm_get - Enable power for an IRQ chip
  * @data:	Pointer to interrupt specific data
@@ -1567,12 +1578,13 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
  */
 int irq_chip_pm_get(struct irq_data *data)
 {
+	struct device *dev = irq_get_parent_device(data);
 	int retval;
 
-	if (IS_ENABLED(CONFIG_PM) && data->chip->parent_device) {
-		retval = pm_runtime_get_sync(data->chip->parent_device);
+	if (IS_ENABLED(CONFIG_PM) && dev) {
+		retval = pm_runtime_get_sync(dev);
 		if (retval < 0) {
-			pm_runtime_put_noidle(data->chip->parent_device);
+			pm_runtime_put_noidle(dev);
 			return retval;
 		}
 	}
@@ -1590,10 +1602,11 @@ int irq_chip_pm_get(struct irq_data *data)
  */
 int irq_chip_pm_put(struct irq_data *data)
 {
+	struct device *dev = irq_get_parent_device(data);
 	int retval = 0;
 
-	if (IS_ENABLED(CONFIG_PM) && data->chip->parent_device)
-		retval = pm_runtime_put(data->chip->parent_device);
+	if (IS_ENABLED(CONFIG_PM) && dev)
+		retval = pm_runtime_put(dev);
 
 	return (retval < 0) ? retval : 0;
 }
