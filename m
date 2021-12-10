Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27134707D3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244908AbhLJR6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:58:47 -0500
Received: from foss.arm.com ([217.140.110.172]:45360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244868AbhLJR6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:58:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2BED12FC;
        Fri, 10 Dec 2021 09:55:08 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2BAB93F73B;
        Fri, 10 Dec 2021 09:55:07 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, suravee.suthikulpanit@amd.com,
        baolu.lu@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com,
        linux-mm@kvack.org, Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v2 03/11] drm/tegra: vic: Fix DMA API misuse
Date:   Fri, 10 Dec 2021 17:54:44 +0000
Message-Id: <6b86f6e530b504a5eee864af10e2ae1570d7b645.1639157090.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1639157090.git.robin.murphy@arm.com>
References: <cover.1639157090.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon failure, dma_alloc_coherent() returns NULL. If that does happen,
passing some uninitialised stack contents to dma_mapping_error() - which
belongs to a different API in the first place - has precious little
chance of detecting it.

Also include the correct header, because the fragile transitive
inclusion currently providing it is going to break soon.

Fixes: 20e7dce255e9 ("drm/tegra: Remove memory allocation from Falcon library")
CC: Thierry Reding <thierry.reding@gmail.com>
CC: Mikko Perttunen <mperttunen@nvidia.com>
CC: dri-devel@lists.freedesktop.org
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---

It also doesn't appear to handle failure of the tegra_drm_alloc() path
either, but that's a loose thread I have no desire to pull on... ;)

v2: Resend as part of the series, originally posted separately here:

https://lore.kernel.org/dri-devel/2703882439344010e33bf21ecd63cf9e5e6dc00d.1637781007.git.robin.murphy@arm.com/

 drivers/gpu/drm/tegra/vic.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index c02010ff2b7f..da4af5371991 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <linux/host1x.h>
 #include <linux/iommu.h>
 #include <linux/module.h>
@@ -232,10 +233,8 @@ static int vic_load_firmware(struct vic *vic)
 
 	if (!client->group) {
 		virt = dma_alloc_coherent(vic->dev, size, &iova, GFP_KERNEL);
-
-		err = dma_mapping_error(vic->dev, iova);
-		if (err < 0)
-			return err;
+		if (!virt)
+			return -ENOMEM;
 	} else {
 		virt = tegra_drm_alloc(tegra, size, &iova);
 	}
-- 
2.28.0.dirty

