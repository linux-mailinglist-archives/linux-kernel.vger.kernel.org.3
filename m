Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C99147E3E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 14:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348543AbhLWNBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 08:01:04 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:33880 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348429AbhLWNBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 08:01:01 -0500
X-IronPort-AV: E=Sophos;i="5.88,229,1635174000"; 
   d="scan'208";a="104966906"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 23 Dec 2021 22:01:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C3D2E4366C26;
        Thu, 23 Dec 2021 22:00:58 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Cc:     Xin Tan <tanxin.ctf@gmail.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] iommu/arm-smmu: Use platform_irq_count() to get the interrupt count
Date:   Thu, 23 Dec 2021 13:00:45 +0000
Message-Id: <20211223130046.9365-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211223130046.9365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211223130046.9365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq_count().

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4bc75c4ce402..4844cd075644 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2105,12 +2105,12 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (IS_ERR(smmu))
 		return PTR_ERR(smmu);
 
-	num_irqs = 0;
-	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, num_irqs))) {
-		num_irqs++;
-		if (num_irqs > smmu->num_global_irqs)
-			smmu->num_context_irqs++;
-	}
+	num_irqs = platform_irq_count(pdev);
+	if (num_irqs < 0)
+		return num_irqs;
+
+	if (num_irqs > smmu->num_global_irqs)
+		smmu->num_context_irqs += (num_irqs - smmu->num_global_irqs);
 
 	if (!smmu->num_context_irqs) {
 		dev_err(dev, "found %d interrupts but expected at least %d\n",
-- 
2.17.1

