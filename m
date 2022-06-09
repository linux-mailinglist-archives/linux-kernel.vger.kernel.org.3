Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C8B54524F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241599AbiFIQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344341AbiFIQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:50:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B9166697
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:50:26 -0700 (PDT)
Date:   Thu, 09 Jun 2022 16:50:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654793425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhKH1yxu8Nd19qenTU9pmGPW5HTzql6v7KbpC10J9bY=;
        b=Vom3qQATKmqbnUAeyWuquGe1SNl1tVDLhISRmAaRfT3FY0sjlMHctn91gzLtqqlLS6u+71
        YmMilFSZF4CDL5U4wKAxB4T/9P63f45kp83VEOqgo9p565amT6DfHxfc58NLj+OERF87f2
        bonP5oJUG2Tok7BKYH2deajbQjo0STVN/ZZ6ZUQdz1XrW93SEFy/Usly0bBqlCvt7pz57y
        TtfwBD+N5bfS2UsXNS+im9NhcQPA4lXPMnsaMlsC9GbLrZa1BZPIDtGKXCq/SHoRH/U+SU
        4iR70Nh/FL48AT0HHwP/NSedk7pxMIsBApLTlu9WYSuf7z25u5eAfysQf6z/ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654793425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhKH1yxu8Nd19qenTU9pmGPW5HTzql6v7KbpC10J9bY=;
        b=H4IwG33wDtfhv7sLfUtADsC/iO/8+rWdtlrm7g0eFtkV+Kmv3zfPCl0pDOvdw2FejEgdtv
        LJ63LxH01/5KgJCA==
From:   "irqchip-bot for Miaoqian Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/realtek-rtl: Fix refcount leak
 in map_interrupts
Cc:     Miaoqian Lin <linmq006@gmail.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220601080930.31005-7-linmq006@gmail.com>
References: <20220601080930.31005-7-linmq006@gmail.com>
MIME-Version: 1.0
Message-ID: <165479342400.4207.12312718284931443520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     eff4780f83d0ae3e5b6c02ff5d999dc4c1c5c8ce
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/eff4780f83d0ae3e5b6c02ff5d999dc4c1c5c8ce
Author:        Miaoqian Lin <linmq006@gmail.com>
AuthorDate:    Wed, 01 Jun 2022 12:09:30 +04:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 09 Jun 2022 17:36:57 +01:00

irqchip/realtek-rtl: Fix refcount leak in map_interrupts

of_find_node_by_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
This function doesn't call of_node_put() in error path.
Call of_node_put() directly after of_property_read_u32() to cover
both normal path and error path.

Fixes: 9f3a0f34b84a ("irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220601080930.31005-7-linmq006@gmail.com
---
 drivers/irqchip/irq-realtek-rtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 50a5682..56bf502 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -134,9 +134,9 @@ static int __init map_interrupts(struct device_node *node, struct irq_domain *do
 		if (!cpu_ictl)
 			return -EINVAL;
 		ret = of_property_read_u32(cpu_ictl, "#interrupt-cells", &tmp);
+		of_node_put(cpu_ictl);
 		if (ret || tmp != 1)
 			return -EINVAL;
-		of_node_put(cpu_ictl);
 
 		cpu_int = be32_to_cpup(imap + 2);
 		if (cpu_int > 7 || cpu_int < 2)
