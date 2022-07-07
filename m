Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B76569E21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbiGGIuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbiGGIuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:50:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6202F326D7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:50:06 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:50:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657183805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIqB3lqmfF/tCeHVhFSym0/aQP+f3lSmEFisKgrZPaY=;
        b=Ljh3PhFM9qHbN7rIVO0/izrDE7oIAElb/z5fe/oz4aYjElbDFvhBewSkaWeidBK6MaTNdU
        4uanEvQMUeA1hzxbFrtDOX9Y0rc5dk3WSbLttn3mzGhgtsDF1oW+PFiQejUubf9QwmbMsO
        fkv4tG++ExT5kYJK3Dkd4/g0/DlqAK0NwWyl3ksWoj2pgFNKyvyoDZgF6yR47XEUSBoNSw
        DtQwZGcdzA4/3NTDbhNU8Rh6ECR6fFvybmJdbiY7eekOTNgRzrOqn1HO3HzZ/lk8riT2bB
        geagAqumVu3syNb41udFCH+qMwpGlrXm105NLjZT9qanAXoy7rel42DFLTGt4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657183805;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIqB3lqmfF/tCeHVhFSym0/aQP+f3lSmEFisKgrZPaY=;
        b=meOUTEcUxSnCZWmjAgsyDK/BR442wNvaabUT9K7bLvj6ZT3fa4es1OeP5uGYLVd5RLfurd
        ZMPy7fyCiTVI6vAg==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Drop redundant
 irq_init_effective_affinity
Cc:     Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220701200056.46555-5-samuel@sholland.org>
References: <20220701200056.46555-5-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165718380398.15455.12411017966126102035.tip-bot2@tip-bot2>
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

Commit-ID:     610306306aaa56ab324d03a55138ea611be9e282
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/610306306aaa56ab324d03a55138ea611be9e282
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Fri, 01 Jul 2022 15:00:52 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:38:04 +01:00

genirq: Drop redundant irq_init_effective_affinity

It does exactly the same thing as irq_data_update_effective_affinity.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220701200056.46555-5-samuel@sholland.org
---
 kernel/irq/manage.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8c39631..40fe780 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -205,16 +205,8 @@ static void irq_validate_effective_affinity(struct irq_data *data)
 	pr_warn_once("irq_chip %s did not update eff. affinity mask of irq %u\n",
 		     chip->name, data->irq);
 }
-
-static inline void irq_init_effective_affinity(struct irq_data *data,
-					       const struct cpumask *mask)
-{
-	cpumask_copy(irq_data_get_effective_affinity_mask(data), mask);
-}
 #else
 static inline void irq_validate_effective_affinity(struct irq_data *data) { }
-static inline void irq_init_effective_affinity(struct irq_data *data,
-					       const struct cpumask *mask) { }
 #endif
 
 int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
@@ -347,7 +339,7 @@ static bool irq_set_affinity_deactivated(struct irq_data *data,
 		return false;
 
 	cpumask_copy(desc->irq_common_data.affinity, mask);
-	irq_init_effective_affinity(data, mask);
+	irq_data_update_effective_affinity(data, mask);
 	irqd_set(data, IRQD_AFFINITY_SET);
 	return true;
 }
