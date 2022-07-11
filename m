Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE556D4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiGKGai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiGKGaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4489AAE56
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFB09611EA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B7DC34115;
        Mon, 11 Jul 2022 06:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657521017;
        bh=HWr2/dy137HprWFt2Ex5jIfKt6IaG8hMYIe7QZYqwMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iBXx+XcsRiat3qnFp2gEQ5hTM/JCx33CTAQJnZT2YqhpoMH6t8t44WU0GReXmbhyp
         K4S1zPItAdNnLnXhQqb8FadOGLOpmkAECPKKK4W8HFxtWd6cv77TNMKaxB91j4JJaA
         qvXsNCSvw0Umhdnk+Cf+Pl2z/RVb8ve6bPlx7BwgqBhTp6xt5u6K4SAFMcfiCwjf1Z
         u4tptUAF5C+o3mlYpUttRutqS0iKIi4ye1o3YsORSYIs4FveVWqlge+tmurcC+RTvt
         znOqwwboCSYi/R9bSY4slKB3wlXg8K/aKG/RaxbOy89yMUFMd0I7v6FVljyfcSa+WH
         akx8p+5HVPpHQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 07/12] habanalabs/gaudi2: map virtual MSI-X doorbell memory for user
Date:   Mon, 11 Jul 2022 09:29:58 +0300
Message-Id: <20220711063003.3182795-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711063003.3182795-1-ogabbay@kernel.org>
References: <20220711063003.3182795-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Upon the initialization of a user context, map the host memory page of
the virtual MSI-X doorbell in the device MMU.
A reserved VA is used for this purpose, so user can use it directly
without any allocation/map operation.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c       | 43 ++++++++++++++++++-
 .../misc/habanalabs/include/gaudi2/gaudi2.h   |  3 ++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 760ce5b7f955..eba8b0d674c3 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -1920,7 +1920,7 @@ static int gaudi2_set_fixed_properties(struct hl_device *hdev)
 	prop->pmmu.hop_table_size = prop->mmu_hop_table_size;
 	prop->pmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
 
-	prop->hints_host_reserved_va_range.start_addr =	RESERVED_VA_RANGE_FOR_ARC_ON_HOST_START;
+	prop->hints_host_reserved_va_range.start_addr = RESERVED_VA_FOR_VIRTUAL_MSIX_DOORBELL_START;
 	prop->hints_host_reserved_va_range.end_addr = RESERVED_VA_RANGE_FOR_ARC_ON_HOST_END;
 	prop->hints_host_hpage_reserved_va_range.start_addr =
 			RESERVED_VA_RANGE_FOR_ARC_ON_HOST_HPAGE_START;
@@ -9241,6 +9241,35 @@ static void gaudi2_restore_user_registers(struct hl_device *hdev)
 	gaudi2_restore_user_qm_registers(hdev);
 }
 
+static int gaudi2_map_virtual_msix_doorbell_memory(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	struct gaudi2_device *gaudi2 = hdev->asic_specific;
+	int rc;
+
+	rc = hl_mmu_map_page(ctx, RESERVED_VA_FOR_VIRTUAL_MSIX_DOORBELL_START,
+				gaudi2->virt_msix_db_dma_addr, prop->pmmu.page_size, true);
+	if (rc)
+		dev_err(hdev->dev, "Failed to map VA %#llx for virtual MSI-X doorbell memory\n",
+			RESERVED_VA_FOR_VIRTUAL_MSIX_DOORBELL_START);
+
+	return rc;
+}
+
+static void gaudi2_unmap_virtual_msix_doorbell_memory(struct hl_ctx *ctx)
+{
+	struct hl_device *hdev = ctx->hdev;
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	int rc;
+
+	rc = hl_mmu_unmap_page(ctx, RESERVED_VA_FOR_VIRTUAL_MSIX_DOORBELL_START,
+				prop->pmmu.page_size, true);
+	if (rc)
+		dev_err(hdev->dev, "Failed to unmap VA %#llx of virtual MSI-X doorbell memory\n",
+			RESERVED_VA_FOR_VIRTUAL_MSIX_DOORBELL_START);
+}
+
 static int gaudi2_ctx_init(struct hl_ctx *ctx)
 {
 	int rc;
@@ -9257,7 +9286,15 @@ static int gaudi2_ctx_init(struct hl_ctx *ctx)
 	else
 		gaudi2_restore_user_registers(ctx->hdev);
 
-	return gaudi2_internal_cb_pool_init(ctx->hdev, ctx);
+	rc = gaudi2_internal_cb_pool_init(ctx->hdev, ctx);
+	if (rc)
+		return rc;
+
+	rc = gaudi2_map_virtual_msix_doorbell_memory(ctx);
+	if (rc)
+		gaudi2_internal_cb_pool_fini(ctx->hdev, ctx);
+
+	return rc;
 }
 
 static void gaudi2_ctx_fini(struct hl_ctx *ctx)
@@ -9266,6 +9303,8 @@ static void gaudi2_ctx_fini(struct hl_ctx *ctx)
 		return;
 
 	gaudi2_internal_cb_pool_fini(ctx->hdev, ctx);
+
+	gaudi2_unmap_virtual_msix_doorbell_memory(ctx);
 }
 
 static int gaudi2_pre_schedule_cs(struct hl_cs *cs)
diff --git a/drivers/misc/habanalabs/include/gaudi2/gaudi2.h b/drivers/misc/habanalabs/include/gaudi2/gaudi2.h
index 071fc5a820f7..5b4f9e108798 100644
--- a/drivers/misc/habanalabs/include/gaudi2/gaudi2.h
+++ b/drivers/misc/habanalabs/include/gaudi2/gaudi2.h
@@ -54,6 +54,9 @@
 #define RESERVED_VA_RANGE_FOR_ARC_ON_HBM_START	0x1001500000000000ull
 #define RESERVED_VA_RANGE_FOR_ARC_ON_HBM_END	0x10016FFFFFFFFFFFull
 
+#define RESERVED_VA_FOR_VIRTUAL_MSIX_DOORBELL_START	0xFFF077FFFFFF0000ull
+#define RESERVED_VA_FOR_VIRTUAL_MSIX_DOORBELL_END	0xFFF077FFFFFFFFFFull
+
 #define RESERVED_VA_RANGE_FOR_ARC_ON_HOST_START	0xFFF0780000000000ull
 #define RESERVED_VA_RANGE_FOR_ARC_ON_HOST_END	0xFFF07FFFFFFFFFFFull
 
-- 
2.25.1

