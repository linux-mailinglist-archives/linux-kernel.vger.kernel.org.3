Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1024C4E22C7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbiCUJBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244330AbiCUJBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:01:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E607665146
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:59:44 -0700 (PDT)
Date:   Mon, 21 Mar 2022 08:59:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647853182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x56KENgwqjeFrYk/9zKTjFLP7GFUcIr5JFJFkbNIIYA=;
        b=rWUdDb8P3DkhYiT7GdHQxIFwSXMEOLn+aToXjZREnm6iub9cqm+w4SpZBzPaJu2EDYsnQv
        3N9sYLPDGXHYj52jpvdnWkDi3SNiM8gWTUleCXM9CSjKq4nOtk/PD9bZLyjkMBc4Ge5cRH
        0k136CsTxL1IDZNpbKya1XWSOwTKtoa8nBTvNjLz8GG7LeibNveeVyOCNvOt2ayxvAFJR8
        Q631Vqx3YrmJ3lJDyHC+HI2wY519E5lXxzuagKnzexOyjjwONNBMTM28QGlr18QUPa9eAm
        FAiCn+nfCrz3bpRAuuFgBlC4T8x2KPiFHCHF08J+PsMRb9SVRsvdkz8w2e2SMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647853182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x56KENgwqjeFrYk/9zKTjFLP7GFUcIr5JFJFkbNIIYA=;
        b=6WZeZDOAhv0bnJ/oW/R531WhxEubd0Gqm+7wSO2yKL6x0ZUJiB8zb3uFjXOv4na8YvHwpU
        fh0YfbYPHVcdvFAg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v4: Wait for
 GICR_VPENDBASER.Dirty to clear before descheduling
Cc:     Jingyi Wang <wangjingyi11@huawei.com>,
        Nianyao Tang <tangnianyao@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <4aae10ba-b39a-5f84-754b-69c2eb0a2c03@huawei.com>
References: <4aae10ba-b39a-5f84-754b-69c2eb0a2c03@huawei.com>
MIME-Version: 1.0
Message-ID: <164785318046.389.4078543658581148621.tip-bot2@tip-bot2>
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

Commit-ID:     686121ebe6fce266f16978e98ecda35a72c39dbf
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/686121ebe6fce266f16978e98ecda35a72c39dbf
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 17 Mar 2022 09:49:02 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Mar 2022 08:53:05 

irqchip/gic-v4: Wait for GICR_VPENDBASER.Dirty to clear before descheduling

The way KVM drives GICv4.{0,1} is as follows:
- vcpu_load() makes the VPE resident, instructing the RD to start
  scanning for interrupts
- just before entering the guest, we check that the RD has finished
  scanning and that we can start running the vcpu
- on preemption, we deschedule the VPE by making it invalid on
  the RD

However, we are preemptible between the first two steps. If it so
happens *and* that the RD was still scanning, we nonetheless write
to the GICR_VPENDBASER register while Dirty is set, and bad things
happen (we're in UNPRED land).

This affects both the 4.0 and 4.1 implementations.

Make sure Dirty is cleared before performing the deschedule,
meaning that its_clear_vpend_valid() becomes a sort of full VPE
residency barrier.

Reported-by: Jingyi Wang <wangjingyi11@huawei.com>
Tested-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Fixes: 57e3cebd022f ("KVM: arm64: Delay the polling of the GICR_VPENDBASER.Dirty
bit")
Link: https://lore.kernel.org/r/4aae10ba-b39a-5f84-754b-69c2eb0a2c03@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9e93ff2..c9b1df9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3011,18 +3011,12 @@ static int __init allocate_lpi_tables(void)
 	return 0;
 }
 
-static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
+static u64 read_vpend_dirty_clear(void __iomem *vlpi_base)
 {
 	u32 count = 1000000;	/* 1s! */
 	bool clean;
 	u64 val;
 
-	val = gicr_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
-	val &= ~GICR_VPENDBASER_Valid;
-	val &= ~clr;
-	val |= set;
-	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
-
 	do {
 		val = gicr_read_vpendbaser(vlpi_base + GICR_VPENDBASER);
 		clean = !(val & GICR_VPENDBASER_Dirty);
@@ -3033,10 +3027,26 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
 		}
 	} while (!clean && count);
 
-	if (unlikely(val & GICR_VPENDBASER_Dirty)) {
+	if (unlikely(!clean))
 		pr_err_ratelimited("ITS virtual pending table not cleaning\n");
+
+	return val;
+}
+
+static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
+{
+	u64 val;
+
+	/* Make sure we wait until the RD is done with the initial scan */
+	val = read_vpend_dirty_clear(vlpi_base);
+	val &= ~GICR_VPENDBASER_Valid;
+	val &= ~clr;
+	val |= set;
+	gicr_write_vpendbaser(val, vlpi_base + GICR_VPENDBASER);
+
+	val = read_vpend_dirty_clear(vlpi_base);
+	if (unlikely(val & GICR_VPENDBASER_Dirty))
 		val |= GICR_VPENDBASER_PendingLast;
-	}
 
 	return val;
 }
