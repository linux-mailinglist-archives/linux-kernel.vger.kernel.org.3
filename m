Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B63E4774EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbhLPOsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:48:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37192 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhLPOsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:48:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 679D8B82472
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 14:48:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05649C36AE4;
        Thu, 16 Dec 2021 14:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639666090;
        bh=c1muqVKWzdTkKoVi72Ltt3Fqqt0hJ3PhEVtUzfhO0xA=;
        h=From:To:Cc:Subject:Date:From;
        b=btM/+W/wpbDDKHwZ/8Cah9lmlOVWqAEY7hucQO6xlEWUxOsngWGTdREYrHhbjjOdf
         YjFPj7NqZsh+OxiwHTevAGzBfMJY5VRMSGrroVvEv0jACEA8Ox0bA+JMYTUMfZ0KdC
         IoOcmMOEnli49XjRi2jvfR7sW7KquOc/7dhVXPp1HEyj9WQoEA1/6CaI24nWT5Xl69
         Jyutw8e4ySLG39P7WByb7XyqhcZYTxR/OQ/DJ16KzcMlEFHYVkwEPQk8Zf6l8EWFH3
         uV9ADm0GYkcJlhoX4mC1+QXD9TPEBfPpoCa0WnmrnLrJIV7NrEcn6rsvjqhkZdj2Qc
         vKKk6PsQ2kyhQ==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mxs3D-00CY4x-Qk; Thu, 16 Dec 2021 14:48:07 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Jay Chen <jkchen@linux.alibaba.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] irqchip/gic-v4: Disable redistributors' view of the VPE table at boot time
Date:   Thu, 16 Dec 2021 14:48:04 +0000
Message-Id: <20211216144804.1578566-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, kernel-team@android.com, jkchen@linux.alibaba.com, lorenzo.pieralisi@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/irqchip/irq-gic-v3.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index daec3309b014..86397522e786 100644
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
-- 
2.30.2

