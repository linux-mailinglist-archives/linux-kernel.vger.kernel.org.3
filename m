Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C19A569E02
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiGGIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiGGIuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:50:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D2E326D7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:50:02 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:50:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657183801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pk/nyvZvfxAsWaQ3xp5fqzHH5sPv5ifPLKhjyXhXNqk=;
        b=qR+Ld5OgdVuHp+IIYV9XLlVoUtNUrbkWERmthwLzGURyo32bK1csF6qHlsyVAiFc9nSgp5
        Lvmyx7RM9vZdW+9kjIxS8tFb5ZEehLFqm9LYV8XB38iVAXLMgqoLN4Aq9v9bwC0GMaEde2
        Jf52hXE0s2CXnZvYRTyDrkKJ+CwBWf5Gtgo6Q/BVKZP6w/s1rHv8MRiAubLvhCfgvXyUlM
        aaMXSlUhUD8TvOHSuQyPAFpZZxhsyJ20BbrwP+t9iTLVC75M66vLouS1F5ZWbIvZZSl4z6
        8I9fGqHvg2puICabbVZgMH9+RLnzKpYE7lVhckqHmQdTgj+zN4VFCHGMERhf+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657183801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pk/nyvZvfxAsWaQ3xp5fqzHH5sPv5ifPLKhjyXhXNqk=;
        b=0Nklokvjus2i1w2vy3+rIb9pCAZYU+pTRtDayT6rXY0IYx+ogajMHrTx+YDvUI00DmTgi7
        ynoCq+nwE9v1f7AA==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Provide an IRQ affinity mask in
 non-SMP configs
Cc:     Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220701200056.46555-9-samuel@sholland.org>
References: <20220701200056.46555-9-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165718380003.15455.9821341691594991462.tip-bot2@tip-bot2>
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

Commit-ID:     aa0813581b8d37bdd91cd40b67ef79ffa45104b2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/aa0813581b8d37bdd91cd40b67ef79ffa45104b2
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Fri, 01 Jul 2022 15:00:56 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:38:04 +01:00

genirq: Provide an IRQ affinity mask in non-SMP configs

IRQ affinity masks are not allocated in uniprocessor configurations.
This requires special case non-SMP code in drivers for irqchips which
have per-CPU enable or mask registers.

Since IRQ affinity is always the same in a uniprocessor configuration,
we can provide a correct affinity mask without allocating one per IRQ.

By returning a real cpumask from irq_data_get_affinity_mask even when
SMP is disabled, irqchip drivers which iterate over that mask will
automatically do the right thing.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220701200056.46555-9-samuel@sholland.org
---
 include/linux/irq.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 02073f7..996e227 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -151,7 +151,9 @@ struct irq_common_data {
 #endif
 	void			*handler_data;
 	struct msi_desc		*msi_desc;
+#ifdef CONFIG_SMP
 	cpumask_var_t		affinity;
+#endif
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	cpumask_var_t		effective_affinity;
 #endif
@@ -882,13 +884,19 @@ static inline int irq_data_get_node(struct irq_data *d)
 static inline
 const struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
 {
+#ifdef CONFIG_SMP
 	return d->common->affinity;
+#else
+	return cpumask_of(0);
+#endif
 }
 
 static inline void irq_data_update_affinity(struct irq_data *d,
 					    const struct cpumask *m)
 {
+#ifdef CONFIG_SMP
 	cpumask_copy(d->common->affinity, m);
+#endif
 }
 
 static inline const struct cpumask *irq_get_affinity_mask(int irq)
