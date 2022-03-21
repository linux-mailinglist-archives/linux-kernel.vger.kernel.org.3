Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8A74E2A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349202AbiCUOQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351521AbiCUOLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:11:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E180201BB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:07:29 -0700 (PDT)
Date:   Mon, 21 Mar 2022 14:07:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647871648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6yc/vA9uu+Mbg963qnjC5ATlEBMQUpuZ5tmykv0Ezc=;
        b=gLmIrEwl0xiSHN1s1Tz4dWgQ7PSiRKoL460wq2IOsxWLM9Q4Zxw/sQ5sSQjULlTibOejYP
        bUBwlEKkTcBFCYrW1HkEIIFNW5uHT/D1cWH2Vy07yQbzzBJUSGDkybo0OK6PJUN3VBBiKy
        9Sx0M8ZSc35SYPgta9Ilfdlu8+/O/xDEhmh6S/zM6nVp3QJ32fqwoaGQO1WvfDbfgAg/fS
        p2xUr/y/eDB20NXVFRaNxd+DA94qWF6Wsxj1mtrLQQDG9yxhZvXphEMERLONlC2xVR71yz
        LpHiY47iaxWUwfOgPvPYYwLpKmifT4DB0Y+58I7KGDrgs+3kGXCSwm6ukfML4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647871648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6yc/vA9uu+Mbg963qnjC5ATlEBMQUpuZ5tmykv0Ezc=;
        b=mvi85GYiWcsg0zhDNaj1HxLau1NtWDHdZHt+8SctVA2Jmr0q7kaztvHmWc2PojAxvWQZ+g
        FVmzD93QbJdyexDA==
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
Message-ID: <164787164696.389.6013852304037958343.tip-bot2@tip-bot2>
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

Commit-ID:     e307414a346d99ead7b1e962daee331e71467d18
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e307414a346d99ead7b1e962daee331e71467d18
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 17 Mar 2022 09:49:02 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 21 Mar 2022 14:02:32 

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
Fixes: 57e3cebd022f ("KVM: arm64: Delay the polling of the GICR_VPENDBASER.Dirty bit")
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
