Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EED4A5C1C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiBAMVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:21:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57000 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiBAMVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:21:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 777636157C;
        Tue,  1 Feb 2022 12:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A4CC340F3;
        Tue,  1 Feb 2022 12:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643717990;
        bh=YPnsZuKHzTt0USZewAkQ8dcDN1KgYjxmgRotElZ29kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzzyS+Je27Vic0KQ6SKZsB0x5RgTquGiRDYZvxgfXQeUubcPo3/lUdndokVU4WUBD
         6D44M30SVOrfUIVhqtOvyZLkqzjGzIn83fqhDIc2QiJtdB9PxmA9WP5rzY03djGxze
         pFuiyLhORMfcnsTguuG//idDDgk86SV3+HCRzQ47UmWN5NdRKx7S4NJdyJ9JVm/bJ4
         yV655smSrIyI869ex8sGxnUOy9XtmOkFTAG/pwIQfdTbRZ+91xxLLDLfOjZRsg4jik
         ppogTt/KiEfwFfkSrx1VFWY7uiaWYb9o8WA6vmEDclI10v38BM4NLxBOXOY0g+DJKg
         LpJqqIbFh++ww==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nErsj-004d46-RR; Tue, 01 Feb 2022 12:03:33 +0000
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
Subject: [PATCH 12/12] genirq: Kill irq_chip::parent_device
Date:   Tue,  1 Feb 2022 12:03:10 +0000
Message-Id: <20220201120310.878267-13-maz@kernel.org>
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

Now that noone is using irq_chip::parent_device in the tree, get
rid of it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h | 2 --
 kernel/irq/chip.c   | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 848e1e12c5c6..2cb2e2ac2703 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -456,7 +456,6 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
 /**
  * struct irq_chip - hardware interrupt chip descriptor
  *
- * @parent_device:	pointer to parent device for irqchip
  * @name:		name for /proc/interrupts
  * @irq_startup:	start up the interrupt (defaults to ->enable if NULL)
  * @irq_shutdown:	shut down the interrupt (defaults to ->disable if NULL)
@@ -503,7 +502,6 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @flags:		chip specific flags
  */
 struct irq_chip {
-	struct device	*parent_device;
 	const char	*name;
 	unsigned int	(*irq_startup)(struct irq_data *data);
 	void		(*irq_shutdown)(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index a2a12cdbe872..24b6f2b40e5e 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1560,9 +1560,6 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 
 static struct device *irq_get_parent_device(struct irq_data *data)
 {
-	if (data->chip->parent_device)
-		return data->chip->parent_device;
-
 	if (data->domain)
 		return data->domain->dev;
 
-- 
2.30.2

