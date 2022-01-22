Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32086496DC4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiAVT6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiAVT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73082C06173D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:57:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10CB060F06
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C536BC340E5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881475;
        bh=iRTJVaYGd7Y6vRUiEAAlp1PTyrRBTe9D6yc7/go2g5M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=s5my+j5dO3AOrv2zkF5FTVXOdfQhFGxSTeQhyjY/OiP+2AEct1kdEijlIQJCmIX2p
         Y4Tv2qfR0HICYPwz3QL+xEfoQDyZgKX2kswEeaGWHKrW+oFIR/jW5RLGDceNKWMoTH
         BdkXAat0xJ6/xmH9VcjYulStuBCcC1o5MjqpMFeNga2sjYw7+vXZ3HPjSDbo7zalYL
         ffP77hOYbKQN652ftvVWldOpCHec4Ty3kkVTCf5VwXCTW5FvTR5IyStFtKk9PmZlxk
         kY2dmlXwre102Vf8nNedS7uBkBQhpIPKKuPlst6FGUn7DM0G2GOHx/H+AcaUceBkcz
         pRfBKU+f9imGQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 15/30] habanalabs: use common wrapper for MMU cache invalidation
Date:   Sat, 22 Jan 2022 21:57:16 +0200
Message-Id: <20220122195731.934494-15-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a common function that wraps the call to the MMU cache
invalidation function, which is ASIC-specific. The wrapper checks
the return value and prints error if necessary. For consistency, try
to use the wrapper when possible.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 6 +++---
 drivers/misc/habanalabs/goya/goya.c   | 5 ++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 66c90164be6b..c58e21e2db3b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3855,7 +3855,7 @@ static int gaudi_mmu_init(struct hl_device *hdev)
 	/* mem cache invalidation */
 	WREG32(mmSTLB_MEM_CACHE_INVALIDATION, 1);
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, 0);
+	hl_mmu_invalidate_cache(hdev, true, 0);
 
 	WREG32(mmMMU_UP_MMU_ENABLE, 1);
 	WREG32(mmMMU_UP_SPI_MASK, 0xF);
@@ -8595,7 +8595,7 @@ static int gaudi_internal_cb_pool_init(struct hl_device *hdev,
 			hdev->internal_cb_pool_dma_addr,
 			HOST_SPACE_INTERNAL_CB_SZ);
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, false, MMU_OP_USERPTR);
+	hl_mmu_invalidate_cache(hdev, false, MMU_OP_USERPTR);
 	mutex_unlock(&ctx->mmu_lock);
 
 	if (rc)
@@ -8630,7 +8630,7 @@ static void gaudi_internal_cb_pool_fini(struct hl_device *hdev,
 			HOST_SPACE_INTERNAL_CB_SZ);
 	hl_unreserve_va_block(hdev, ctx, hdev->internal_cb_va_base,
 			HOST_SPACE_INTERNAL_CB_SZ);
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
+	hl_mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR);
 	mutex_unlock(&ctx->mmu_lock);
 
 	gen_pool_destroy(hdev->internal_cb_pool);
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 1bd23578cb83..d8c6dea7c809 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2700,8 +2700,7 @@ int goya_mmu_init(struct hl_device *hdev)
 	WREG32_AND(mmSTLB_STLB_FEATURE_EN,
 			(~STLB_STLB_FEATURE_EN_FOLLOWER_EN_MASK));
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, true,
-					MMU_OP_USERPTR | MMU_OP_PHYS_PACK);
+	hl_mmu_invalidate_cache(hdev, true, MMU_OP_USERPTR | MMU_OP_PHYS_PACK);
 
 	WREG32(mmMMU_MMU_ENABLE, 1);
 	WREG32(mmMMU_SPI_MASK, 0xF);
@@ -5341,7 +5340,7 @@ static int goya_mmu_invalidate_cache_range(struct hl_device *hdev,
 	/* Treat as invalidate all because there is no range invalidation
 	 * in Goya
 	 */
-	return hdev->asic_funcs->mmu_invalidate_cache(hdev, is_hard, flags);
+	return hl_mmu_invalidate_cache(hdev, is_hard, flags);
 }
 
 int goya_send_heartbeat(struct hl_device *hdev)
-- 
2.25.1

