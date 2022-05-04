Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D3851A52E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353319AbiEDQUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353212AbiEDQSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:18:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEF646B15
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:15:09 -0700 (PDT)
Date:   Wed, 04 May 2022 16:15:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651680907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yA1sTY9Jle7zj5xm6NV1rAOpJd/IVFrtzkRW+PpczMs=;
        b=lVlQP3SS3ybpCC/s0pIPyQl2wUHNrXIu9IGhi5ijEypIrxRDT0ai3WCNn7aEKPxNVIcJHv
        yZTmfIJM6qk4HkE1cCmNqb0SsGPsHbQ2sOUADsBP3PPeAG2ulW3ilSLQQ0nugCf41EdSBI
        AGbida9vbuP8sUqFwcJ7Jk8VOVoxZBVIAbX+OSMNa9VWWEf/HxxcRmsUKmVi1rkywRMffn
        DVrY3S5x2QdzAdCFhXvLHoe5AB3LmYPI7oT2QkuxzahREbA/Bhw0fNzFhR8gURoEGDcZBs
        akffyBufDti1rTO4JC0H0r8+YMnpePHlhlv5JWQPNzJrTOhBxagoMu0YLvP3dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651680907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yA1sTY9Jle7zj5xm6NV1rAOpJd/IVFrtzkRW+PpczMs=;
        b=we9/pTWtNtu8numDxfdc0asJX/9PpD4xDnwyyF4OFUedMMwvGAN4jT8gzmE+LXg5Pgx1Aa
        7j+2bYaViiwE9lBA==
From:   "irqchip-bot for Florian Fainelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic: Improved warning about
 incorrect type
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220308201117.3870678-1-f.fainelli@gmail.com>
References: <20220308201117.3870678-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <165168090597.4207.9063975379392037281.tip-bot2@tip-bot2>
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

Commit-ID:     4c5b2be1d071af26749790429726712e4d9105fb
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/4c5b2be1d071af26749790429726712e4d9105fb
Author:        Florian Fainelli <f.fainelli@gmail.com>
AuthorDate:    Tue, 08 Mar 2022 12:11:16 -08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 16:52:28 +01:00

irqchip/gic: Improved warning about incorrect type

Issue the warning for interrupt lines that have an incorrect interrupt
type and also print the hardware interrupt number to facilitate the
resolution of such problems.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220308201117.3870678-1-f.fainelli@gmail.com
---
 drivers/irqchip/irq-gic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 09c710e..820404c 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1115,7 +1115,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
 
 		/* Make it clear that broken DTs are... broken */
-		WARN_ON(*type == IRQ_TYPE_NONE);
+		WARN(*type == IRQ_TYPE_NONE,
+		     "HW irq %ld has invalid type\n", *hwirq);
 		return 0;
 	}
 
@@ -1132,7 +1133,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1];
 
-		WARN_ON(*type == IRQ_TYPE_NONE);
+		WARN(*type == IRQ_TYPE_NONE,
+		     "HW irq %ld has invalid type\n", *hwirq);
 		return 0;
 	}
 
