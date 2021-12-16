Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53544775D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238473AbhLPPYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:24:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55028 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbhLPPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:24:46 -0500
Date:   Thu, 16 Dec 2021 15:24:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639668284;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OhQYileyD3Z9YENiIX0BbEo5n9Xk2spRiYaeGDW+kCw=;
        b=Cxvg65/drPEPMjlIQpJev13hjAudDVze83PPKCZDgFfsXFMIt54zh79P/UjctcouIACe5/
        xoCZWs02KGcYf7lvlKiiBoNEbGipDFyUTuhy+C4zeX5RoqsohQQ1PGUEenFr8BqE/6uanb
        6K6cpeZ1lvNfzfYUhEqAJ5SfX8oxI+xxKsdDn1GEEbHHq3KgfZNK2e0jwDGpDMBVx+IwDO
        H2MrJugeLgAWuKOh8mRH14soN2+7soxI2E/1tIaGPkX8BfxHWYU3ry4gUbSo1AQjDkr6HT
        0RQdFKe+94N9oC1hnxird2EWj6dV66675LvDEdhsnWSEbou1WA7mIyCIOtfbng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639668284;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OhQYileyD3Z9YENiIX0BbEo5n9Xk2spRiYaeGDW+kCw=;
        b=wUkIdk3HEo3V54TOZ8JpzcntFNfmyy3agTs4lSzPrlWR6vTewdKNX2tI5o2el5CRFHFvdd
        LaUTHiNffETtvqAg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v4: Disable redistributors'
 view of the VPE table at boot time
Cc:     Jay Chen <jkchen@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        tglx@linutronix.de
In-Reply-To: <20211214064716.21407-1-jkchen@linux.alibaba.com>
References: <20211214064716.21407-1-jkchen@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <163966828357.23020.3431040692428134241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     79a7f77b9b154d572bd9d2f1eecf58c4d018d8e2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/79a7f77b9b154d572bd9d2f1eecf58c4d018d8e2
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 16 Dec 2021 14:32:27 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 16 Dec 2021 15:19:52 

irqchip/gic-v4: Disable redistributors' view of the VPE table at boot time

Jay Chen reported that using a kdump kernel on a GICv4.1 system
results in a RAS error being delivered when the secondary kernel
configures the ITS's view of the new VPE table.

As it turns out, that's because each RD still has a pointer to
the previous instance of the VPE table, and that particular
implementation is very upset by seeing two bits of the HW that
should point to the same table with different values.

To solve this, let's invalidate any reference that any RD has to
the VPE table when discovering the RDs. The ITS can then be
programmed as expected.

Reported-by: Jay Chen <jkchen@linux.alibaba.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Link: https://lore.kernel.org/r/20211214064716.21407-1-jkchen@linux.alibaba.com
Link: https://lore.kernel.org/r/20211216144804.1578566-1-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index daec330..8639752 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -920,6 +920,22 @@ static int __gic_update_rdist_properties(struct redist_region *region,
 {
 	u64 typer = gic_read_typer(ptr + GICR_TYPER);
 
+	/* Boot-time cleanip */
+	if ((typer & GICR_TYPER_VLPIS) && (typer & GICR_TYPER_RVPEID)) {
+		u64 val;
+
+		/* Deactivate any present vPE */
+		val = gicr_read_vpendbaser(ptr + SZ_128K + GICR_VPENDBASER);
+		if (val & GICR_VPENDBASER_Valid)
+			gicr_write_vpendbaser(GICR_VPENDBASER_PendingLast,
+					      ptr + SZ_128K + GICR_VPENDBASER);
+
+		/* Mark the VPE table as invalid */
+		val = gicr_read_vpropbaser(ptr + SZ_128K + GICR_VPROPBASER);
+		val &= ~GICR_VPROPBASER_4_1_VALID;
+		gicr_write_vpropbaser(val, ptr + SZ_128K + GICR_VPROPBASER);
+	}
+
 	gic_data.rdists.has_vlpis &= !!(typer & GICR_TYPER_VLPIS);
 
 	/* RVPEID implies some form of DirectLPI, no matter what the doc says... :-/ */
