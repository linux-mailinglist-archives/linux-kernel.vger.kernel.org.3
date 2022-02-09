Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631444AF65F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiBIQSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236049AbiBIQRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:17:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E7EC05CB82
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:17:53 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:17:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gysh4+prL/gni25Y2Kzb7s1L4KqqjXM+nQ1aWZFbd/M=;
        b=3JS+Z3fpKFomtHRMwD9o2Q3hjRqyp1XHoDFm9AoRE/1pzR9AnHgKICGsJPy/JpZMQDyHCB
        fKUlmuFf31JwWWPt6DpgcIDNCm4YIAJbvGUqZseOkqZHE8gdWvtnhCAygG/mDzdRDuucxU
        CQeVedmtlrawy9gBLSd7WekYZ3f3M5uWmQ9DTetCobgSEKzRgJGyrRdDeLiYSUl1H33JMT
        Ecc+WNYyl3Un1aADDH4+1YEzzpoOW+wPVc3bVW+08oHdy2ak+pXeOt0ILyUnn+SBRKiF4Q
        y4A+5E7k1yggAYOMU4Gf4FZp+/+vM+W9mkwsDYSOlYLq10mbEm5dXOL8qEPXdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423472;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gysh4+prL/gni25Y2Kzb7s1L4KqqjXM+nQ1aWZFbd/M=;
        b=Ips0cujsc5HyUUmZoqJ1mXgCLKwwkcHogiTxSvVQ4x+O1jqVYZhQOWrks8MUZSgM5pcUdb
        Rs7vHB2YaJ/Fm0Bw==
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
Message-ID: <164442347119.16921.17205637028888702613.tip-bot2@tip-bot2>
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

Commit-ID:     d3a33cefbb37d963bab883aca5b96109d61071a8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d3a33cefbb37d963bab883aca5b96109d61071a8
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:03:10 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:36:54 

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
 
