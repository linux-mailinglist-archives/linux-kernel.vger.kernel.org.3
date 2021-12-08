Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947C846D2FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhLHMLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbhLHMLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:11:43 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A2AC061746;
        Wed,  8 Dec 2021 04:08:11 -0800 (PST)
Received: from localhost.localdomain (unknown [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 43A021F45C96;
        Wed,  8 Dec 2021 12:08:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638965290; bh=rAjPBWxPWs9ZhCznZcphsRB07TQmg0ZmOocuWwcZPdo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=f/vO251EHLPyVm053WAAlGD5ZluE01MipX147UdEpPozfAvQUmA0GqCw/VG28eiYz
         K/eQk54EWsarB1kn5sV9dfYT6JoIcy8m5QVHzuHmBHlPEdSHMbeUMukUBU82RcbuB2
         /6fJwiOUO54WsU/BwTZWMYAjcpwpTBlJSVj23je4jk7Be1kW11P/Mkp23k7Z2xRw/u
         ggeknqvodXEDZaOBbZjeqGVHGfQTVsAxUS/k6PHaDlfo8XpxsPhNPYOK0Km99EGPmE
         u1KPL9AA+Ifi4xcOUazYlQKMfFmfd1HQrtkbsq4zirX6c+YeICbbbrpSJ+g0VnLjq5
         GXYmErfCY16Jw==
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
Subject: [PATCH v2 2/5] iommu/mediatek: Always check runtime PM status in tlb flush range callback
Date:   Wed,  8 Dec 2021 14:07:41 +0200
Message-Id: <20211208120744.2415-3-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
References: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

In case of v4l2_reqbufs() it is possible, that a TLB flush is done
without runtime PM being enabled. In that case the "Partial TLB flush
timed out, falling back to full flush" warning is printed.

Commit c0b57581b73b ("iommu/mediatek: Add power-domain operation")
introduced has_pm as optimization to avoid checking runtime PM
when there is no power domain attached. But without the PM domain
there is still the device driver's runtime PM suspend handler, which
disables the clock. Thus flushing should also be avoided when there
is no PM domain involved.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 342aa562ab6a..dd2c08c54df4 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -225,16 +225,13 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 					   size_t granule,
 					   struct mtk_iommu_data *data)
 {
-	bool has_pm = !!data->dev->pm_domain;
 	unsigned long flags;
 	int ret;
 	u32 tmp;
 
 	for_each_m4u(data) {
-		if (has_pm) {
-			if (pm_runtime_get_if_in_use(data->dev) <= 0)
-				continue;
-		}
+		if (pm_runtime_get_if_in_use(data->dev) <= 0)
+			continue;
 
 		spin_lock_irqsave(&data->tlb_lock, flags);
 		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
@@ -259,8 +256,7 @@ static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
 		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
 		spin_unlock_irqrestore(&data->tlb_lock, flags);
 
-		if (has_pm)
-			pm_runtime_put(data->dev);
+		pm_runtime_put(data->dev);
 	}
 }
 
-- 
2.17.1

