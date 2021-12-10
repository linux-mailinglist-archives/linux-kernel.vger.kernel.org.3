Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3E6470B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbhLJT5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243009AbhLJT5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:57:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083E0C061746;
        Fri, 10 Dec 2021 11:54:07 -0800 (PST)
Date:   Fri, 10 Dec 2021 19:54:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639166045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epiUa76umDAbG/HLR7eWWX92OxRyI0/aSc27IhkOv20=;
        b=DG//gKL5YbcHSbec2FkotBJU0gwLLz2q2ePeDkVRStTX9EJyYpYRjuTJY8jJHbtIfpx/mO
        dsq630R8qj0HX7CVMyQW48WYHQP0v4+uaEhMhQMGifC3AFkxz6EuaI/K2SDhoRRnno9pax
        fMEtOUE5KpU7FncthTxUhdWDpKtE6tfm4AevtOSfNgiwNKAQIcBgwmAk+Q/A23VzGjKAhL
        X6RT981tfcZj5Ca1QOLWY06XFZtQD/BiLRDrrYAj7dYliXk6e0iJ4oRlcv6GAkCWn6xc0w
        mdGBsV6P4RYNSqszgdKaeALXogckU15kt827D6TsM/6FlixYGAkqFR5rC4UzUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639166045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epiUa76umDAbG/HLR7eWWX92OxRyI0/aSc27IhkOv20=;
        b=bcW81XweNGr9hGhtl8fV+8zxHCuyvi68l8rwDGMZVxaWSs9QQRRuRzDhdRrqdfD+sKWjMX
        NZ5m5Ziask9ol2AQ==
From:   "tip-bot2 for Nitesh Narayan Lal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] mailbox: Use irq_update_affinity_hint()
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jassi Brar <jaswinder.singh@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210903152430.244937-11-nitesh@redhat.com>
References: <20210903152430.244937-11-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <163916604465.23020.15766592626270091148.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bf886e1ef11a0155714ca93c975bb3f770e79d72
Gitweb:        https://git.kernel.org/tip/bf886e1ef11a0155714ca93c975bb3f770e79d72
Author:        Nitesh Narayan Lal <nitesh@redhat.com>
AuthorDate:    Fri, 03 Sep 2021 11:24:26 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Dec 2021 20:47:39 +01:00

mailbox: Use irq_update_affinity_hint()

The driver uses irq_set_affinity_hint() to:

  - Set the affinity_hint which is consumed by the userspace for
    distributing the interrupts

  - Enforce affinity

As per commit 6ac17fe8c14a ("mailbox: bcm-flexrm-mailbox: Set IRQ affinity
hint for FlexRM ring IRQs") the latter is done to ensure that the FlexRM
ring interrupts are evenly spread across all available CPUs. However, since
commit a0c9259dc4e1 ("irq/matrix: Spread interrupts on allocation") the
spreading of interrupts is dynamically performed at the time of allocation.
Hence, there is no need for the drivers to enforce their own affinity for
the spreading of interrupts.

Also, irq_set_affinity_hint() applying the provided cpumask as an affinity
for the interrupt is an undocumented side effect. To remove this side
effect irq_set_affinity_hint() has been marked as deprecated and new
interfaces have been introduced. Hence, replace the irq_set_affinity_hint()
with the new interface irq_update_affinity_hint() that only sets the
affinity_hint pointer.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
Link: https://lore.kernel.org/r/20210903152430.244937-11-nitesh@redhat.com

---
 drivers/mailbox/bcm-flexrm-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 78073ad..16982c1 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1298,7 +1298,7 @@ static int flexrm_startup(struct mbox_chan *chan)
 	val = (num_online_cpus() < val) ? val / num_online_cpus() : 1;
 	cpumask_set_cpu((ring->num / val) % num_online_cpus(),
 			&ring->irq_aff_hint);
-	ret = irq_set_affinity_hint(ring->irq, &ring->irq_aff_hint);
+	ret = irq_update_affinity_hint(ring->irq, &ring->irq_aff_hint);
 	if (ret) {
 		dev_err(ring->mbox->dev,
 			"failed to set IRQ affinity hint for ring%d\n",
@@ -1425,7 +1425,7 @@ static void flexrm_shutdown(struct mbox_chan *chan)
 
 	/* Release IRQ */
 	if (ring->irq_requested) {
-		irq_set_affinity_hint(ring->irq, NULL);
+		irq_update_affinity_hint(ring->irq, NULL);
 		free_irq(ring->irq, ring);
 		ring->irq_requested = false;
 	}
