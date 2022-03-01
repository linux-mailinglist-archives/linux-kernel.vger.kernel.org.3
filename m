Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1484C9328
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 19:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbiCAS2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 13:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbiCAS2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:28:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D841C139
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 10:27:58 -0800 (PST)
Date:   Tue, 01 Mar 2022 18:27:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646159276;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2D2STxz7T8Xq/nR5uyA+P9QjoqQeHUiQIWsDf9UHP8=;
        b=jTQ3a8WfwtmI35js/Lmz5/eegMbGOVEZovwyJGRl2xV0EV8BDrWUpl7gT12o7rHPOZvX9j
        S1lfglsoij+5FwGqPZp52IxI2IUBPbtRcwBoh+7z5RJvGdVcydAnS6CKzJnZgCkG9X3pVM
        Avz93LJAkLkTtgEwhVKAfhR9Xzpd3d5h2MMonXGTRTnMbIuysafpto+XBQ2DrGzJhuJrOl
        bYrEicBd6Onv5RBkqQvT0Bd082Yli4+U7mPK1gxh802TBs8CogXfo0xU+tKlf0vO774wA9
        NfMdHutelgeBIy6LqX5haEU/JyVHrJK/AAw1vcOcdfd9teWc8+DaOiUvVOo/Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646159276;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2D2STxz7T8Xq/nR5uyA+P9QjoqQeHUiQIWsDf9UHP8=;
        b=YVMgD5KM8ZD8PLFRD3WzrSob8hBAcluKDYB24XFJHnQh3XAh5vjhn/ItrmEI9UBuz1Mi67
        M389HHhUwrYIkfCQ==
From:   "irqchip-bot for Souptick Joarder (HPE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/nvic: Release nvic_base upon failure
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220218163303.33344-1-jrdr.linux@gmail.com>
References: <20220218163303.33344-1-jrdr.linux@gmail.com>
MIME-Version: 1.0
Message-ID: <164615927490.16921.9273664965460113512.tip-bot2@tip-bot2>
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

Commit-ID:     e414c25e3399b2b3d7337dc47abccab5c71b7c8f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e414c25e3399b2b3d7337dc47abccab5c71b7c8f
Author:        Souptick Joarder (HPE) <jrdr.linux@gmail.com>
AuthorDate:    Fri, 18 Feb 2022 22:03:03 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 01 Mar 2022 10:19:51 

irqchip/nvic: Release nvic_base upon failure

smatch warning was reported as below ->

smatch warnings:
drivers/irqchip/irq-nvic.c:131 nvic_of_init()
warn: 'nvic_base' not released on lines: 97.

Release nvic_base upon failure.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220218163303.33344-1-jrdr.linux@gmail.com
---
 drivers/irqchip/irq-nvic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index ba4759b..9423030 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -107,6 +107,7 @@ static int __init nvic_of_init(struct device_node *node,
 
 	if (!nvic_irq_domain) {
 		pr_warn("Failed to allocate irq domain\n");
+		iounmap(nvic_base);
 		return -ENOMEM;
 	}
 
@@ -116,6 +117,7 @@ static int __init nvic_of_init(struct device_node *node,
 	if (ret) {
 		pr_warn("Failed to allocate irq chips\n");
 		irq_domain_remove(nvic_irq_domain);
+		iounmap(nvic_base);
 		return ret;
 	}
 
