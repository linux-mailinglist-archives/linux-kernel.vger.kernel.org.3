Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84EF589C94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 15:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbiHDN0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 09:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239162AbiHDN0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 09:26:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14C0BF4C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 06:26:07 -0700 (PDT)
Date:   Thu, 04 Aug 2022 13:26:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659619566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFHLBCO5SHBgy6/VPCSR/0dLlOdvs5/InwJBhBRvG+M=;
        b=sdDSQk7ujJckDHFtwb9v+FZrVwIh+u6Jz9fXMZthKcv4mQBJN101iot+otIfR4KrSlVEfG
        ZRjkONRx3t8T1tq7LuVXYuOkmhdlpEU+m1dRI3+1nsJn9h75b1I8G7SRFbYaHM3keMAOHo
        uaVEuHoP8mdFb4OK6B77Gc4yEviW8S8YywSlJz3+AYHm2OWG7s+VfNkNpiMUrZwl9Y2/Hx
        LqYc9Uiwo3sAaA5C7IRPx3uu3n1BLW92sPUeLePuNGI3KZe5hHy0LUB/T1/IihTaOKdFLj
        4DrTB8rVpDCosDg1D/nbpaB5i8l6vb/P6voFgi+o9OD0ZLpURHj/6wnEgvpeog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659619566;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cFHLBCO5SHBgy6/VPCSR/0dLlOdvs5/InwJBhBRvG+M=;
        b=fMuUpipGtXVPWpy00NFrMyAqRtA6M/FIuxlcupvKeLlpdIdxJBQeA+G3HiplRjy8r3b15x
        vk/PWVWRwdvj5FBg==
From:   "irqchip-bot for Michael Kelley" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] iommu/hyper-v: Use helper instead of
 directly accessing affinity
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
References: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Message-ID: <165961956454.15455.6170338476537736674.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     b0a4ab7ca4ce993d1cc51cbc85e9f341c729a3d4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/b0a4ab7ca4ce993d1cc51cbc85e9f341c729a3d4
Author:        Michael Kelley <mikelley@microsoft.com>
AuthorDate:    Mon, 25 Jul 2022 17:53:40 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 04 Aug 2022 10:02:09 +01:00

iommu/hyper-v: Use helper instead of directly accessing affinity

Recent changes to solve inconsistencies in handling IRQ masks #ifdef
out the affinity field in irq_common_data for non-SMP configurations.
The current code in hyperv_irq_remapping_alloc() gets a compiler error
in that case.

Fix this by using the new irq_data_update_affinity() helper, which
handles the non-SMP case correctly.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Fixes: aa0813581b8d ("genirq: Provide an IRQ affinity mask in non-SMP configs")
Link: https://lore.kernel.org/r/1658796820-2261-1-git-send-email-mikelley@microsoft.com
---
 drivers/iommu/hyperv-iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
index 51bd66a..e190bb8 100644
--- a/drivers/iommu/hyperv-iommu.c
+++ b/drivers/iommu/hyperv-iommu.c
@@ -68,7 +68,6 @@ static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
 {
 	struct irq_alloc_info *info = arg;
 	struct irq_data *irq_data;
-	struct irq_desc *desc;
 	int ret = 0;
 
 	if (!info || info->type != X86_IRQ_ALLOC_TYPE_IOAPIC || nr_irqs > 1)
@@ -90,8 +89,7 @@ static int hyperv_irq_remapping_alloc(struct irq_domain *domain,
 	 * Hypver-V IO APIC irq affinity should be in the scope of
 	 * ioapic_max_cpumask because no irq remapping support.
 	 */
-	desc = irq_data_to_desc(irq_data);
-	cpumask_copy(desc->irq_common_data.affinity, &ioapic_max_cpumask);
+	irq_data_update_affinity(irq_data, &ioapic_max_cpumask);
 
 	return 0;
 }
