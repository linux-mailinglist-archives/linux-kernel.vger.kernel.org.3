Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3614B0BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbiBJLKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:10:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiBJLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:09:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B1D128
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:09:59 -0800 (PST)
Date:   Thu, 10 Feb 2022 11:09:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644491397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KoxvSvnhBNxmfm9wViQ+nmVvSqCzOf5DxlgMFg3IMCU=;
        b=gGHEouClfDeVTX2Akg1c9lsSrgGZHNv3pIHJxWfrSH9foSohqWi7I7iHhGCNA6j3k0Jrh1
        764uUjrsqbTkPYAzIocw+BkIVLjgKAZjnMv0yXo9g2vN0h8UeoprsFimTncWknyWAUpaz+
        YU3FupnWrVJw/EizWwkMe2itnLBHC3bUreY5puK523BG94v6b7gAPt0d3glMAL+Npxt+8J
        yuh+Vud+Q6VPtAOqZzQpKNf3l4gsqGzoSyGZ+03Z5F5CZ7a7ptLdPK+AOl1MHrDJDVPG3C
        PWED/sP0+VjTUxXItR2R5H2DnG7kGx1C0XsEHpkBXoVgwKVLDNEbkMROpoPIJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644491397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KoxvSvnhBNxmfm9wViQ+nmVvSqCzOf5DxlgMFg3IMCU=;
        b=+hcfXYm0vd1tQ6sSDmg0Kn/8nF+E6FdllGOSLsoBOcUw+opqzX77dBhc7uP/TofvdwJdBf
        Ejb7PuoyHoUo05Bg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Kill irq_chip::parent_device
Cc:     Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
        tglx@linutronix.de
In-Reply-To: <20220201120310.878267-13-maz@kernel.org>
References: <20220201120310.878267-13-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164449139615.16921.13885708159426012054.tip-bot2@tip-bot2>
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

Commit-ID:     beb0622138cd2848dec06b0651a988c39d099574
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/beb0622138cd2848dec06b0651a988c39d099574
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:03:10 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Feb 2022 11:07:04 

genirq: Kill irq_chip::parent_device

Now that noone is using irq_chip::parent_device in the tree, get
rid of it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Link: https://lore.kernel.org/r/20220201120310.878267-13-maz@kernel.org
---
 include/linux/irq.h | 2 --
 kernel/irq/chip.c   | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 848e1e1..2cb2e2a 100644
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
index a2a12cd..24b6f2b 100644
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
 
