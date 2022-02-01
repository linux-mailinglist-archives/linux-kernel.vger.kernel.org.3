Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BC24A5BBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbiBAMDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbiBAMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:03:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63610C061714;
        Tue,  1 Feb 2022 04:03:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD113B82D90;
        Tue,  1 Feb 2022 12:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DBFC340EE;
        Tue,  1 Feb 2022 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643717010;
        bh=G+5KjErBUoA0VuKd1uOcKIKve23dzp6jS3teZfj++fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMy53Qwmrcncf5BHGzL250502XwXPLmtxMRd1aahJ0T8SqL5+NxKeHlffqkIkDWMQ
         1FiqZopp55JVNFSJ2uE5eTmPn0gmnsZC6cHLet/wWitIVNuvJf93Eg+r3Epu7X9LqO
         M9jDPqCMrLXKCyIDkFC9DTJAsAvF3yRAjMXkddgX2nyaHeQV3mwAXWvIGu/Pl9JuRs
         QbeD18EcYsFfuFotJEbw+YLhmlhpVGAJB7C4bBlAuOL/4psKBufAW6hEbKrd739Hoz
         BFrCczw+rT+OP4QJfT0s0pQX94JOuJ2LZ1qkMihp0LPCIW7wGK/MbVYjhvqxUGxaHg
         sdqxp/NQeK1rw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nErse-004d46-UF; Tue, 01 Feb 2022 12:03:28 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: [PATCH 01/12] genirq: Allow the PM device to originate from irq domain
Date:   Tue,  1 Feb 2022 12:02:59 +0000
Message-Id: <20220201120310.878267-2-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220201120310.878267-1-maz@kernel.org>
References: <20220201120310.878267-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, tglx@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, kernel@esmil.dk
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation to moving the reference to the device used for
runtime power management, add a new 'dev' field to the irqdomain
structure for that exact purpose.

The irq_chip_pm_{get,put}() helpers are made aware of the dual
location via a new private helper.

No functional change intended.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h | 10 ++++++++++
 kernel/irq/chip.c         | 23 ++++++++++++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d476405802e9..be25a33293e5 100644
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
index c09324663088..a2a12cdbe872 100644
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
-- 
2.30.2

