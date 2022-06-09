Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C854525B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344886AbiFIQvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344418AbiFIQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:50:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032AC69B4C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:50:29 -0700 (PDT)
Date:   Thu, 09 Jun 2022 16:50:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654793428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwhaKIkwmAx4RL5BhQowW7xjxXNHezvmyZZs5SRMSyQ=;
        b=gPoImVNRnseZdW1S4UvjCjeNcBAVQpMyJLgGqOxEG9XIEORApie6+TAPYBvTaE1HXCxweC
        q8a96gHHOU6Z/appOq1txEJCVSWJosXSifkgbEqD/H1z0JbjkbY66Q2S5Rrw+PqR/oX/+g
        Dl7kNOZkZy52Z1pH5X+W8eWKcovs7jjp44Uq50IJh3PSV1s2f16xOm2MCdIX2SpaRCcvDi
        /YYOvUwmwpKqgfytuyfp7iMoZh6dO0GRadIKxhVjNTvFpNDtdwG07wHX/nE24XzgAWyVE3
        F/4YNtFob6bmOGgDC/HhD8HejyU9mZYmjZPJbrWTolWt9jfOKxYW23I3PQNapA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654793428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwhaKIkwmAx4RL5BhQowW7xjxXNHezvmyZZs5SRMSyQ=;
        b=8BkKvIq31BAG7lctmloeg40Wjh8QD5PqZw5brjjIfEmDmuzdvvMkDsoVdt1rk2IPmMdM59
        ovqUKeWHrZqXmCDw==
From:   "irqchip-bot for Miaoqian Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/apple-aic: Fix refcount leak in
 aic_of_ic_init
Cc:     Miaoqian Lin <linmq006@gmail.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220601080930.31005-4-linmq006@gmail.com>
References: <20220601080930.31005-4-linmq006@gmail.com>
MIME-Version: 1.0
Message-ID: <165479342703.4207.11307569031053264673.tip-bot2@tip-bot2>
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

Commit-ID:     3d45670fab3c25a7452721e4588cc95c51cda134
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3d45670fab3c25a7452721e4588cc95c51cda134
Author:        Miaoqian Lin <linmq006@gmail.com>
AuthorDate:    Wed, 01 Jun 2022 12:09:27 +04:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 09 Jun 2022 17:36:57 +01:00

irqchip/apple-aic: Fix refcount leak in aic_of_ic_init

of_get_child_by_name() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: a5e8801202b3 ("irqchip/apple-aic: Parse FIQ affinities from device-tree")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220601080930.31005-4-linmq006@gmail.com
---
 drivers/irqchip/irq-apple-aic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 478d0af..5ac8318 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -1144,6 +1144,7 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 		for_each_child_of_node(affs, chld)
 			build_fiq_affinity(irqc, chld);
 	}
+	of_node_put(affs);
 
 	set_handle_irq(aic_handle_irq);
 	set_handle_fiq(aic_handle_fiq);
