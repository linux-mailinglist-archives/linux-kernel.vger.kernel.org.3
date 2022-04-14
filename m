Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D84C50176F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbiDNPhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350468AbiDNOWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:22:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0059C559C;
        Thu, 14 Apr 2022 07:14:16 -0700 (PDT)
Date:   Thu, 14 Apr 2022 14:14:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649945654;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIr4M3QpkhZ27uYr8qH26LQUlJTGuaEdmvLzEra2awI=;
        b=DQcQ0wBmY5ZEPT3/sRn62sx9BzIOfd6C24/BPV99lB4dKwkfSq+Tl+A0m1UOwWUjdnuv8x
        CGm6tcs0C4I+PYmp5cmw8F0UZNI+Iy81NKUGobY79sthLFIWBnZ9Ly7D2bQoBdEXJK6Mrs
        P5RNJPzjvlytUrNO8mMn9SjYvgOtfaTkQqmKMfAzRSQVWKwXaesfd/Q+cyNibkie8S/azx
        da2KiPOs7jOm/hljdjfI+CFhaRCUeeVp3PIuYMPB7ciqRWMNX3WRPtOKteYuesrb2Wrflj
        i/Wm9AL3IPjpt6jvBKY0GbT5UieaCavDUcxtYXhP+bKePISGq90c4cgoYBKWmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649945654;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIr4M3QpkhZ27uYr8qH26LQUlJTGuaEdmvLzEra2awI=;
        b=6mejPmbqNLlHFxDkB+3xJWMIrs32bqTE5xGhGMSZ2DxVixMOP0FYhT0mXsO8TJYGUF8UvP
        VVGCp5SECrMO6zDw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Take the proposed affinity at face value if
 force==true
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <4b7fc13c-887b-a664-26e8-45aed13f048a@samsung.com>
References: <4b7fc13c-887b-a664-26e8-45aed13f048a@samsung.com>
MIME-Version: 1.0
Message-ID: <164994565359.4207.6678120431812780133.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c48c8b829d2b966a6649827426bcdba082ccf922
Gitweb:        https://git.kernel.org/tip/c48c8b829d2b966a6649827426bcdba082ccf922
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 14 Apr 2022 15:00:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Apr 2022 16:11:25 +02:00

genirq: Take the proposed affinity at face value if force==true

Although setting the affinity of an interrupt to a set of CPUs that doesn't
have any online CPU is generally frowned apon, there are a few limited
cases where such affinity is set from a CPUHP notifier, setting the
affinity to a CPU that isn't online yet.

The saving grace is that this is always done using the 'force' attribute,
which gives a hint that the affinity setting can be outside of the online
CPU mask and the callsite set this flag with the knowledge that the
underlying interrupt controller knows to handle it.

This restores the expected behaviour on Marek's system.

Fixes: 33de0aa4bae9 ("genirq: Always limit the affinity to online CPUs")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/4b7fc13c-887b-a664-26e8-45aed13f048a@samsung.com
Link: https://lore.kernel.org/r/20220414140011.541725-1-maz@kernel.org

---
 kernel/irq/manage.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f71ecc1..f1d5a94 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -266,10 +266,16 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 		prog_mask = mask;
 	}
 
-	/* Make sure we only provide online CPUs to the irqchip */
+	/*
+	 * Make sure we only provide online CPUs to the irqchip,
+	 * unless we are being asked to force the affinity (in which
+	 * case we do as we are told).
+	 */
 	cpumask_and(&tmp_mask, prog_mask, cpu_online_mask);
-	if (!cpumask_empty(&tmp_mask))
+	if (!force && !cpumask_empty(&tmp_mask))
 		ret = chip->irq_set_affinity(data, &tmp_mask, force);
+	else if (force)
+		ret = chip->irq_set_affinity(data, mask, force);
 	else
 		ret = -EINVAL;
 
