Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723C75A45FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiH2JXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiH2JXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:23:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0E55A803
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DB0E60F9E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD69C433D6;
        Mon, 29 Aug 2022 09:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661764979;
        bh=ZAzOvK4gC1xZVcDimGoSZTNJKR5HPaVPTF2VQEUcUTg=;
        h=From:To:Cc:Subject:Date:From;
        b=NmjGcfpnEZC7KbsnG8lLgckwIJZCktK/i5HX38SQ2IMFRtQXGftT+2tGgjdPseeC5
         yC9IwTP1QG31evpiKVrL5B9cG9KAPsrXyMXZSf2HaLRJ2t0lb7LvEHBe+hauONMDC7
         v3n7T/D8Du7LGz5IRrMNGYby96+P4QZRLk9GNobFoQpK6qNXNqfYt2xD4IJZacxLZd
         ZlorA/oxTjrjjyLVzr2ByxnYmskz70LQ8lf2GKhx34r5HuGzbIT/QPGQptkB1D4byB
         EIjfN+BzODz6U054sGtUD1g4mhJmu7551dv/9A2yI8rewc6iXEGfIUCHgYzg0FVMMM
         Zrr2BoYj5fReA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 1/7] habanalabs: set command buffer host VA dynamically
Date:   Mon, 29 Aug 2022 12:22:48 +0300
Message-Id: <20220829092254.930753-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

Set the addresses for userspace command buffer dynamically
instead of hard-coded. There is no reason for it to
be hard-coded.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_buffer.c    | 18 ++++++++++++++----
 drivers/misc/habanalabs/common/habanalabs.h    | 10 +++-------
 drivers/misc/habanalabs/common/memory.c        |  2 +-
 drivers/misc/habanalabs/gaudi2/gaudi2.c        |  3 ---
 drivers/misc/habanalabs/gaudi2/gaudi2P.h       |  3 ---
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index b027f66f8bd4..c3e2568542a1 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -12,6 +12,8 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
+#define CB_VA_POOL_SIZE		(4UL * SZ_1G)
+
 static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 {
 	struct hl_device *hdev = ctx->hdev;
@@ -25,7 +27,7 @@ static int cb_map_mem(struct hl_ctx *ctx, struct hl_cb *cb)
 
 	if (!hdev->supports_cb_mapping) {
 		dev_err_ratelimited(hdev->dev,
-				"Cannot map CB because no VA range is allocated for CB mapping\n");
+				"Mapping a CB to the device's MMU is not supported\n");
 		return -EINVAL;
 	}
 
@@ -566,16 +568,23 @@ int hl_cb_va_pool_init(struct hl_ctx *ctx)
 		return -ENOMEM;
 	}
 
-	rc = gen_pool_add(ctx->cb_va_pool, prop->cb_va_start_addr,
-			prop->cb_va_end_addr - prop->cb_va_start_addr, -1);
+	ctx->cb_va_pool_base = hl_reserve_va_block(hdev, ctx, HL_VA_RANGE_TYPE_HOST,
+					CB_VA_POOL_SIZE, HL_MMU_VA_ALIGNMENT_NOT_NEEDED);
+	if (!ctx->cb_va_pool_base) {
+		rc = -ENOMEM;
+		goto err_pool_destroy;
+	}
+	rc = gen_pool_add(ctx->cb_va_pool, ctx->cb_va_pool_base, CB_VA_POOL_SIZE, -1);
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to add memory to VA gen pool for CB mapping\n");
-		goto err_pool_destroy;
+		goto err_unreserve_va_block;
 	}
 
 	return 0;
 
+err_unreserve_va_block:
+	hl_unreserve_va_block(hdev, ctx, ctx->cb_va_pool_base, CB_VA_POOL_SIZE);
 err_pool_destroy:
 	gen_pool_destroy(ctx->cb_va_pool);
 
@@ -590,4 +599,5 @@ void hl_cb_va_pool_fini(struct hl_ctx *ctx)
 		return;
 
 	gen_pool_destroy(ctx->cb_va_pool);
+	hl_unreserve_va_block(hdev, ctx, ctx->cb_va_pool_base, CB_VA_POOL_SIZE);
 }
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 43b9427d9c97..d7fd4f57abf3 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -567,10 +567,6 @@ struct hl_hints_range {
  * @tpc_binning_mask: which TPCs are binned. 0 means usable and 1 means binned.
  * @dram_enabled_mask: which DRAMs are enabled.
  * @dram_binning_mask: which DRAMs are binned. 0 means usable, 1 means binned.
- * @cb_va_start_addr: virtual start address of command buffers which are mapped
- *                    to the device's MMU.
- * @cb_va_end_addr: virtual end address of command buffers which are mapped to
- *                  the device's MMU.
  * @dram_hints_align_mask: dram va hint addresses alignment mask which is used
  *                  for hints validity check.
  * @cfg_base_address: config space base address.
@@ -713,8 +709,6 @@ struct asic_fixed_properties {
 	u64				tpc_binning_mask;
 	u64				dram_enabled_mask;
 	u64				dram_binning_mask;
-	u64				cb_va_start_addr;
-	u64				cb_va_end_addr;
 	u64				dram_hints_align_mask;
 	u64				cfg_base_address;
 	u64				mmu_cache_mng_addr;
@@ -1803,6 +1797,7 @@ struct hl_cs_outcome_store {
  * @cb_va_pool: device VA pool for command buffers which are mapped to the
  *              device's MMU.
  * @sig_mgr: encaps signals handle manager.
+ * @cb_va_pool_base: the base address for the device VA pool
  * @cs_sequence: sequence number for CS. Value is assigned to a CS and passed
  *			to user so user could inquire about CS. It is used as
  *			index to cs_pending array.
@@ -1838,6 +1833,7 @@ struct hl_ctx {
 	struct hl_cs_counters_atomic	cs_counters;
 	struct gen_pool			*cb_va_pool;
 	struct hl_encaps_signals_mgr	sig_mgr;
+	u64				cb_va_pool_base;
 	u64				cs_sequence;
 	u64				*dram_default_hops;
 	spinlock_t			cs_lock;
@@ -3600,7 +3596,7 @@ void hl_hw_block_mem_init(struct hl_ctx *ctx);
 void hl_hw_block_mem_fini(struct hl_ctx *ctx);
 
 u64 hl_reserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
-		enum hl_va_range_type type, u32 size, u32 alignment);
+		enum hl_va_range_type type, u64 size, u32 alignment);
 int hl_unreserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
 		u64 start_addr, u64 size);
 int hl_pin_host_memory(struct hl_device *hdev, u64 addr, u64 size,
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index e3b40dbf154c..0a653fff08d4 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -755,7 +755,7 @@ static u64 get_va_block(struct hl_device *hdev,
  * - Return the start address of the virtual block.
  */
 u64 hl_reserve_va_block(struct hl_device *hdev, struct hl_ctx *ctx,
-		enum hl_va_range_type type, u32 size, u32 alignment)
+		enum hl_va_range_type type, u64 size, u32 alignment)
 {
 	return get_va_block(hdev, ctx->va_range[type], size, 0,
 			max(alignment, ctx->va_range[type]->page_size),
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index c907e0fbf182..ff0f9e9db1b5 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -2022,9 +2022,6 @@ static int gaudi2_set_fixed_properties(struct hl_device *hdev)
 
 	prop->server_type = HL_SERVER_TYPE_UNKNOWN;
 
-	prop->cb_va_start_addr = VA_HOST_SPACE_USER_MAPPED_CB_START;
-	prop->cb_va_end_addr = VA_HOST_SPACE_USER_MAPPED_CB_END;
-
 	prop->max_dec = NUMBER_OF_DEC;
 
 	prop->clk_pll_index = HL_GAUDI2_MME_PLL;
diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2P.h b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
index 347ea1dd78e2..9094a702678d 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2P.h
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2P.h
@@ -139,9 +139,6 @@
 #define VA_HOST_SPACE_HPAGE_START		0xFFF0800000000000ull
 #define VA_HOST_SPACE_HPAGE_END			0xFFF1000000000000ull /* 140TB */
 
-#define VA_HOST_SPACE_USER_MAPPED_CB_START	0xFFF1000000000000ull
-#define VA_HOST_SPACE_USER_MAPPED_CB_END	0xFFF1000100000000ull /* 4GB */
-
 /* 140TB */
 #define VA_HOST_SPACE_PAGE_SIZE		(VA_HOST_SPACE_PAGE_END - VA_HOST_SPACE_PAGE_START)
 
-- 
2.25.1

