Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87346D2FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhLHMLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:11:43 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44478 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhLHMLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:11:41 -0500
Received: from localhost.localdomain (unknown [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E7B1B1F45C87;
        Wed,  8 Dec 2021 12:08:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638965289; bh=/ksqLGRqcx9RPvezQU0f63T25oDST3xu9zSisBbGyqQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=i/LWg2n8z2KMdp8HIIjkNn1xo/fr0fLDwfwLt7svKE9NR2p3Gf9/2bv4lH9xOHzpD
         /+dwsNPVKbByunLTi8ZVdEh4acbq+KKVnEbl4+2fPAhJYOOgxUwed1R6yu/Nmqni8q
         XZuGjkKlFUI5u6zNGwHf4UlNMaOncuL2fzEHgM+x2giWgW7hjwEcVAAwWlbBnzXFJv
         hMkCCAU5b5YKfQATsvJNRoqjzqwX1opyFxS1ZipzmaJviXYtelzgCiuGzLlpsbRNUo
         R6DEHUTh7mfJezgGkhq1Ranbr+Fuq6RSOXh38z18YtmYh8z2t9QPuS7SiUdNBzf+ft
         QeIZilzrM/dhQ==
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     iommu@lists.linux-foundation.org, Yong Wu <yong.wu@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org (moderated list:MEDIATEK IOMMU
        DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        dafna.hirschfeld@collabora.com, kernel@collabora.com,
        linux-media@vger.kernel.org, sebastian.reichel@collabora.com
Subject: [PATCH v2 1/5] iommu/mediatek: Remove for_each_m4u in tlb_sync_all
Date:   Wed,  8 Dec 2021 14:07:40 +0200
Message-Id: <20211208120744.2415-2-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
References: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong Wu <yong.wu@mediatek.com>

The tlb_sync_all is called from these three functions:
a) flush_iotlb_all: it will be called for each a iommu HW.
b) tlb_flush_range_sync: it already has for_each_m4u.
c) in irq: When IOMMU HW translation fault, Only need flush itself.

Thus, No need for_each_m4u in this tlb_sync_all. Remove it.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 507123ae7485..342aa562ab6a 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -210,17 +210,15 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 
 static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
-	for_each_m4u(data) {
-		if (pm_runtime_get_if_in_use(data->dev) <= 0)
-			continue;
+	if (pm_runtime_get_if_in_use(data->dev) <= 0)
+		return;
 
-		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
-			       data->base + data->plat_data->inv_sel_reg);
-		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
-		wmb(); /* Make sure the tlb flush all done */
+	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
+		       data->base + data->plat_data->inv_sel_reg);
+	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
+	wmb(); /* Make sure the tlb flush all done */
 
-		pm_runtime_put(data->dev);
-	}
+	pm_runtime_put(data->dev);
 }
 
 static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
-- 
2.17.1

