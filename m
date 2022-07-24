Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF657F4B9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiGXLA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 07:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGXLAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 07:00:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F72E64C6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 04:00:24 -0700 (PDT)
Date:   Sun, 24 Jul 2022 11:00:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658660421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJW+dt5eAcXnvma6LPfcUwm+T9G0Jk72nagiTEpj6vI=;
        b=yLzeC/4pyyebwYdzpSZkFLr8Il+lMuUFuK7LUGGU6mIUv5/lY1MjGlN/nTIDVoBit4l1Ep
        KwBtjMuuA+Uq9P1uFhYY9lx0yUcPmOOWbqpU2VsXRktVLO4+sMLkoRVN06k5ItjiH6TyLB
        z9iae6Vi8QSiyx58azbqjagnZrq2EWOS4f4cGV+CcRSH5xEwlaMRsXlccyc3utdPSvYJCt
        lHN6hYaL/PqyploHqzgehRY3qm7x7nUUFfijGp1oRd+4aVX4k59i6AMsTPeFbtLR1ABmF0
        uCdzQgUEdswtsQUNxFB2e9QOZN10CxzukAxYRDI4gzV3w5dck1qAa95Db2Ydhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658660421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJW+dt5eAcXnvma6LPfcUwm+T9G0Jk72nagiTEpj6vI=;
        b=0LOdaRxnm3j48kXMMI0CEXxtTh099dNRsK/7Vx34TziktBEzl6lSDZDbm8jU00YxhQ1LPj
        pM9rlFrYSihbSQBA==
From:   "irqchip-bot for William Dean" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mips-gic: Check the return value
 of ioremap() in gic_of_init()
Cc:     Hacash Robot <hacashRobot@santino.com>,
        William Dean <williamsukatube@163.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220723100128.2964304-1-williamsukatube@163.com>
References: <20220723100128.2964304-1-williamsukatube@163.com>
MIME-Version: 1.0
Message-ID: <165866041980.15455.8736055814592911853.tip-bot2@tip-bot2>
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

Commit-ID:     71349cc85e5930dce78ed87084dee098eba24b59
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/71349cc85e5930dce78ed87084dee098eba24b59
Author:        William Dean <williamsukatube@163.com>
AuthorDate:    Sat, 23 Jul 2022 18:01:28 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 24 Jul 2022 10:54:44 +01:00

irqchip/mips-gic: Check the return value of ioremap() in gic_of_init()

The function ioremap() in gic_of_init() can fail, so
its return value should be checked.

Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@163.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220723100128.2964304-1-williamsukatube@163.com
---
 drivers/irqchip/irq-mips-gic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ff89b36..a1f6d95 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -734,6 +734,10 @@ static int __init gic_of_init(struct device_node *node,
 	}
 
 	mips_gic_base = ioremap(gic_base, gic_len);
+	if (!mips_gic_base) {
+		pr_err("Failed to ioremap gic_base\n");
+		return -ENOMEM;
+	}
 
 	gicconfig = read_gic_config();
 	gic_shared_intrs = FIELD_GET(GIC_CONFIG_NUMINTERRUPTS, gicconfig);
