Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2007B46D305
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 13:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhLHMLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 07:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhLHMLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 07:11:44 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4AEC061746;
        Wed,  8 Dec 2021 04:08:12 -0800 (PST)
Received: from localhost.localdomain (unknown [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8C9EB1F45CA2;
        Wed,  8 Dec 2021 12:08:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638965291; bh=MaW1bAocTnYI0OuXYXK0SxPq8wDjTv9Gv1PqEfPZu2A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jjgMZjhwkPkAM1oPyq3VkeyrQe8sgIpKSmT5wUqN+/y1bxPSf/egn5QFQiyiWe3di
         SpmqbzqtecudsZh3h/bapXrjW01wlWQ8hUQFUcrrU6K0xE+ReV222RmQrkk1eLclgQ
         rJKR7i0ZA7k0op1HeiLw2gadna5xsAovm6d9m9P34M+1RcRp6fkiLnupQxCZyV030j
         SxKZP5tLAa0XtRwl8yOAKsnMlmkE2PcLh9wSrwYgvrclqSyhaUnNrtvDXhik5nBfP5
         B+8ekIt3CdetHeEa0xwvQ1uJbanswfW2w22fdYTl+1L1MpDKJB/joxM29gsqjCJbDh
         x+M8G8wITR4oA==
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
Subject: [PATCH v2 3/5] iommu/mediatek: Remove the power status checking in tlb flush all
Date:   Wed,  8 Dec 2021 14:07:42 +0200
Message-Id: <20211208120744.2415-4-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
References: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong Wu <yong.wu@mediatek.com>

To simplify the code, Remove the power status checking in the
tlb_flush_all, remove this:
   if (pm_runtime_get_if_in_use(data->dev) <= 0)
	    continue;

The mtk_iommu_tlb_flush_all is called from
a) isr
b) tlb flush range fail case
c) iommu_create_device_direct_mappings

In first two cases, the power and clock are always enabled.
In the third case tlb flush is unnecessary because in a later patch
in the series a full flush from the pm_runtime_resume callback is added.

In addition, writing the tlb control register when the iommu is not resumed
is ok and the write is ignored.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
[refactor commit log]
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index dd2c08c54df4..e30ac68fab48 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -210,15 +210,10 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
 
 static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
 {
-	if (pm_runtime_get_if_in_use(data->dev) <= 0)
-		return;
-
 	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
 		       data->base + data->plat_data->inv_sel_reg);
 	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
 	wmb(); /* Make sure the tlb flush all done */
-
-	pm_runtime_put(data->dev);
 }
 
 static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
-- 
2.17.1

