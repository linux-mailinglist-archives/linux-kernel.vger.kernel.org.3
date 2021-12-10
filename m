Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF72D4700AC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 13:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhLJMcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 07:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbhLJMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 07:32:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E90AC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 04:28:39 -0800 (PST)
Date:   Fri, 10 Dec 2021 12:28:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639139318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWvvPeefb5wAVdBUaSFitXfdtUJM/SKMRLLOdOzVdwk=;
        b=V9fMlNGV09XtVWkCC5EbIp4xIYV5g+CHx47/Mt7kWNumfcpnG7DSE4GVa6NH1Oc1xYvVay
        QJ6coH39x7B8zJ5FDKzSoSkAjlhgh8718Y9s4aEHydNQEh6HPNvUQ0Wcc21x+8ZnmRk+zC
        WC4yXc4jFOkr25hw66KgUD09SHklPfF5KUG56DVkTwLbD8wUS1bwk0txq+1dJMxuNcFaNO
        Nw5H6vQ2Xx3CgbHi5zJRd+/gERc/Zt/aWp8dNxbylRULV8o7WPV65Dh7EVSvmdnH3N9/b0
        LWiPsogrjLHkShZioYEr07M0E1HnC1YiLkZRarA7GxsI8ghrQqe8RqPx6dROaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639139318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWvvPeefb5wAVdBUaSFitXfdtUJM/SKMRLLOdOzVdwk=;
        b=91wyoW4u5Bso98dfj1BGAVqO+a6/+cJ9ZavDiGr9Lms5jAkkv96KbJDPhCSnAOX3GCYP5+
        xPF5wlzSWFRdAnAQ==
From:   "irqchip-bot for Ye Guojin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/irq-bcm7120-l2: add put_device()
 after of_find_device_by_node()
Cc:     Zeal Robot <zealci@zte.com.cn>, Ye Guojin <ye.guojin@zte.com.cn>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20211109055958.130287-1-ye.guojin@zte.com.cn>
References: <20211109055958.130287-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Message-ID: <163913931655.23020.9945692348507871507.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     5c19cd0a9ed9f7a067a7d9c444ff0590d1dce73f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5c19cd0a9ed9f7a067a7d9c444ff0590d1dce73f
Author:        Ye Guojin <ye.guojin@zte.com.cn>
AuthorDate:    Tue, 09 Nov 2021 05:59:58 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 10 Dec 2021 12:25:00 

irqchip/irq-bcm7120-l2: add put_device() after of_find_device_by_node()

This was found by coccicheck:
./drivers/irqchip/irq-bcm7120-l2.c,328,1-7,ERROR  missing put_device;
call of_find_device_by_node on line 234, but without a corresponding
object release within this function.
./drivers/irqchip/irq-bcm7120-l2.c,341,1-7,ERROR  missing put_device;
call of_find_device_by_node on line 234, but without a corresponding
object release within this function.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20211109055958.130287-1-ye.guojin@zte.com.cn
---
 drivers/irqchip/irq-bcm7120-l2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index d80e67a..bb6609c 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -238,6 +238,7 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 	}
 
 	data->num_parent_irqs = platform_irq_count(pdev);
+	put_device(&pdev->dev);
 	if (data->num_parent_irqs <= 0) {
 		pr_err("invalid number of parent interrupts\n");
 		ret = -ENOMEM;
