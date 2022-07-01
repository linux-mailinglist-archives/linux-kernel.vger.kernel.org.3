Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D82563602
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiGAOj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiGAOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:39:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE3240B7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:37:36 -0700 (PDT)
Date:   Fri, 01 Jul 2022 14:37:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656686255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUoMgTHhSSvlIOgd1zvrVpqrdKWHpTa+0t+QlhsnRDo=;
        b=ltvKfgFpwKDPPvdIV0UgkrRqjqTvNawGf5sKfy5ukZYeLnGucTaeZcB0wX4PU1MVpMaWvL
        crtX05wjXhq1RLn34VP8HB+BDqtjzruGtwW8pMpgm3BhOvBlMYJgTE4bMj3tZ651PaXZl3
        Yu1ryPxCxFp3Aqa4qJqmmIIN2A6+XmSuLWI+Yl+I16noPn9bOtkckJh6lgCwdeA6/GU3JL
        h2Ft2Nr+/qQxAMg1KZAIDHe+mUlGC982tdDFh9lDu4yJNJ4KFAz7Wwd2U1UT4c0yeIT2ep
        j21Nui4Ar2xpkYi/XSu/t6F51pZ/fdqsGDsdMrrjt6Mc4xI/fXm74NJQ8bvI8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656686255;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUoMgTHhSSvlIOgd1zvrVpqrdKWHpTa+0t+QlhsnRDo=;
        b=ZSRHOlQ+2TRePjqpBuocVw9PgQO4uExmnXBLurpriXV8j62SNSPtt0FKZl77xI2ljz55hk
        7417buo42sy7bTCg==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/sifive-plic: Fix T-HEAD PLIC edge
 trigger handling
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220630100241.35233-5-samuel@sholland.org>
References: <20220630100241.35233-5-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165668625402.15455.4363084082479610088.tip-bot2@tip-bot2>
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

Commit-ID:     5873ba559101fa37ad9764e79856f71bf54021aa
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5873ba559101fa37ad9764e79856f71bf54021aa
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Thu, 30 Jun 2022 05:02:41 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 01 Jul 2022 15:27:23 +01:00

irqchip/sifive-plic: Fix T-HEAD PLIC edge trigger handling

The T-HEAD PLIC ignores additional edges seen while an edge-triggered
interrupt is being handled. Because of this behavior, the driver needs
to complete edge-triggered interrupts in the .irq_ack callback before
handling them, instead of in the .irq_eoi callback afterward. Otherwise,
it could miss some interrupts.

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220630100241.35233-5-samuel@sholland.org
---
 drivers/irqchip/irq-sifive-plic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 90e4436..b3a36dc 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -474,7 +474,6 @@ static int __init plic_init(struct device_node *node,
 
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
-IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmware driver */
 
 static int __init plic_edge_init(struct device_node *node,
 				 struct device_node *parent)
@@ -483,3 +482,4 @@ static int __init plic_edge_init(struct device_node *node,
 }
 
 IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
+IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
