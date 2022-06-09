Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49567545258
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbiFIQvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344675AbiFIQuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:50:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6B16C0C6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:50:31 -0700 (PDT)
Date:   Thu, 09 Jun 2022 16:50:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654793430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHielvjeadYHFGOtQOVaGYUxq8bvjP3EnPYD76F6TmU=;
        b=jI6uonFeKyqsyvgfnLhgVXBrrGtFANnEChLos7FFqAczLtwOHR13TKWO2xVIgQh+ctyU+s
        NsaMI2sPstwz7oGTZ0smgQsK7S4qYkcZRr8rZIbQXdk1qxl+SO0OfPnY01zQcOp26/EUfZ
        5FOag7rdfbGO3opAgwYQNbfE8gS551JMWwqODiBZapALOj+4nG49J90kUPRtl9pmI75V8h
        ljbzhmjVJT9xMlLlLqhu+A+Qw8NilgoJMrqOhQv4NqBmO5bCVK3PcsE20Zg5XWOMShM4uq
        bauFMPQBT1q/pBdcgNR0D87uGC90P9BVWzFhFqdbde74F3qnq8awQ0gJrRkUvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654793430;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHielvjeadYHFGOtQOVaGYUxq8bvjP3EnPYD76F6TmU=;
        b=sGodCvLZ3gr2mBUAXr4VtKNdrBRJ01vpKsCr2br3aWdpbISgea6f603WiOL3XFuSHM61Te
        q8B0tpk7hYNZJOBw==
From:   "irqchip-bot for Miaoqian Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/gic/realview: Fix refcount leak
 in realview_gic_of_init
Cc:     Miaoqian Lin <linmq006@gmail.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220601080930.31005-2-linmq006@gmail.com>
References: <20220601080930.31005-2-linmq006@gmail.com>
MIME-Version: 1.0
Message-ID: <165479342917.4207.8528273657753463802.tip-bot2@tip-bot2>
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

Commit-ID:     f4b98e314888cc51486421bcf6d52852452ea48b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f4b98e314888cc51486421bcf6d52852452ea48b
Author:        Miaoqian Lin <linmq006@gmail.com>
AuthorDate:    Wed, 01 Jun 2022 12:09:25 +04:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 09 Jun 2022 17:36:57 +01:00

irqchip/gic/realview: Fix refcount leak in realview_gic_of_init

of_find_matching_node_and_match() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 82b0a434b436 ("irqchip/gic/realview: Support more RealView DCC variants")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220601080930.31005-2-linmq006@gmail.com
---
 drivers/irqchip/irq-gic-realview.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-gic-realview.c b/drivers/irqchip/irq-gic-realview.c
index b4c1924..38fab02 100644
--- a/drivers/irqchip/irq-gic-realview.c
+++ b/drivers/irqchip/irq-gic-realview.c
@@ -57,6 +57,7 @@ realview_gic_of_init(struct device_node *node, struct device_node *parent)
 
 	/* The PB11MPCore GIC needs to be configured in the syscon */
 	map = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (!IS_ERR(map)) {
 		/* new irq mode with no DCC */
 		regmap_write(map, REALVIEW_SYS_LOCK_OFFSET,
