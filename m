Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6896646D306
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhLHMLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhLHMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:11:47 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B428C0617A2;
        Wed,  8 Dec 2021 04:08:15 -0800 (PST)
Received: from localhost.localdomain (unknown [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 32EAE1F45CD8;
        Wed,  8 Dec 2021 12:08:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638965294; bh=G9wyjm+JcpBuGTU5PaSnqlWsQq2znoMjrDZdkywQlnY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kb9C2fVQI5+8rtQymm3l8HLiyN1QCH1KfHOfc2PhFGn8d4y6GjxkbBlNqwN+BWm8r
         tch0oDrm0FD0HQdryvlsVIfJJ0dusjcsu2ADofkLLCSrNiFxzl5Ay5tGUcX/vRNjtu
         XG9fcXd7SfGgSRwLqI5j9+emeLaPrb5hXG4cR/ltLxktw69haPyl5fE2wG9ubSqsZS
         /utSX3pQofgpXnRw3rJz+I1lKY5tZXhenJxqYb+3VgBZMuCiiphKm9mU2BXHI6f4dO
         JvyNF2dk2EPtspUhBswvj2ItrSCam2agdjtme10+dlxlepmxpFM6GtmItR2U+vr7Nt
         LeT/rOo5k21/w==
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
Subject: [PATCH v2 5/5] iommu/mediatek: Always tlb_flush_all when each PM resume
Date:   Wed,  8 Dec 2021 14:07:44 +0200
Message-Id: <20211208120744.2415-6-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
References: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong Wu <yong.wu@mediatek.com>

Prepare for 2 HWs that sharing pgtable in different power-domains.

When there are 2 M4U HWs, it may has problem in the flush_range in which
we get the pm_status via the m4u dev, BUT that function don't reflect the
real power-domain status of the HW since there may be other HW also use
that power-domain.

DAM allocation is often done while the allocating device is runtime
suspended. In such a case the iommu will also be suspended and partial
flushing of the tlb will not be executed.
Therefore, we add a tlb_flush_all in the pm_runtime_resume to make
sure the tlb is always clean.

In other case, the iommu's power should be active via device
link with smi.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
[move the call to mtk_iommu_tlb_flush_all to the bottom of resume cb, improve doc/log]
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 195a411e3087..4799cd06511b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -997,6 +997,13 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
 	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
 	writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK, base + REG_MMU_PT_BASE_ADDR);
+
+	/*
+	 * Users may allocate dma buffer before they call pm_runtime_get,
+	 * in which case it will lack the necessary tlb flush.
+	 * Thus, make sure to update the tlb after each PM resume.
+	 */
+	mtk_iommu_tlb_flush_all(data);
 	return 0;
 }
 
-- 
2.17.1

