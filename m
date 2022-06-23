Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2707F558A54
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiFWUmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiFWUmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:42:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B404C62725
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:42:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4917761DED
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:42:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43CEC341C6;
        Thu, 23 Jun 2022 20:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656016943;
        bh=jlNYjWurEdzPUkhRWla+Ar30+xgxtRe+BrmNrF65GQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I/85UWyLR6LQC3jHWDKLYIfqY1LfDlm03E0sAx6g5sjSat+Lt1OO+lVxxhDe3cxmm
         ND3brS3LVcjlVWZlqW6oPocKv3wLQw2+rddg1igvHNu6KD2vsc9gPoUAfcz/p6NnKF
         jUewg+dAAMm73sJ46K/1E0v3YIoxHzgtsnBC0BulTZJX7NIHgRnEQlc1+5LGiw4N0Z
         TWItXz7uz/QNMLuBpvkQM0eCnlEonGgxtiy9TBG+Cv37owZWMd8aCZO7ar+oPINhMI
         Jo/Dk/HdmBFUjQU6Pe42NTVtFMsm4ktYlDNAV8moDP7hiRhyV4Zf1nXxyn7RnTu/76
         mDiKqyoyJEtPA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 6/9] habanalabs: don't send addr and size to scrub_device_mem cb
Date:   Thu, 23 Jun 2022 23:42:09 +0300
Message-Id: <20220623204212.1628709-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623204212.1628709-1-ogabbay@kernel.org>
References: <20220623204212.1628709-1-ogabbay@kernel.org>
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

We use scrub_device_mem only to scrub the entire SRAM and entire
DRAM. Therefore there is no need to send addr and size
args to the callback.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c    |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h |  4 +-
 drivers/misc/habanalabs/gaudi/gaudi.c       | 64 ++++++++++-----------
 drivers/misc/habanalabs/goya/goya.c         |  2 +-
 drivers/misc/habanalabs/goya/goyaP.h        |  2 +-
 5 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index 64ac65d9268b..60e3e3125fbc 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -108,7 +108,7 @@ static void hl_ctx_fini(struct hl_ctx *ctx)
 		hl_encaps_sig_mgr_fini(hdev, &ctx->sig_mgr);
 
 		/* Scrub both SRAM and DRAM */
-		hdev->asic_funcs->scrub_device_mem(hdev, 0, 0);
+		hdev->asic_funcs->scrub_device_mem(hdev);
 	} else {
 		dev_dbg(hdev->dev, "closing kernel context\n");
 		hdev->asic_funcs->ctx_fini(ctx);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 44752e5954ca..4d2f69fb4b9d 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1248,7 +1248,7 @@ struct fw_load_mgr {
  *                           dma_free_coherent(). This is ASIC function because
  *                           its implementation is not trivial when the driver
  *                           is loaded in simulation mode (not upstreamed).
- * @scrub_device_mem: Scrub device memory given an address and size
+ * @scrub_device_mem: Scrub the entire SRAM and DRAM.
  * @scrub_device_dram: Scrub the dram memory of the device.
  * @get_int_queue_base: get the internal queue base address.
  * @test_queues: run simple test on all queues for sanity check.
@@ -1359,7 +1359,7 @@ struct hl_asic_funcs {
 					dma_addr_t *dma_handle, gfp_t flag);
 	void (*asic_dma_free_coherent)(struct hl_device *hdev, size_t size,
 					void *cpu_addr, dma_addr_t dma_handle);
-	int (*scrub_device_mem)(struct hl_device *hdev, u64 addr, u64 size);
+	int (*scrub_device_mem)(struct hl_device *hdev);
 	int (*scrub_device_dram)(struct hl_device *hdev, u64 val);
 	void* (*get_int_queue_base)(struct hl_device *hdev, u32 queue_id,
 				dma_addr_t *dma_handle, u16 *queue_len);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 453de3d27d0c..bc5e74505d03 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1657,7 +1657,7 @@ static int gaudi_late_init(struct hl_device *hdev)
 	}
 
 	/* Scrub both SRAM and DRAM */
-	rc = hdev->asic_funcs->scrub_device_mem(hdev, 0, 0);
+	rc = hdev->asic_funcs->scrub_device_mem(hdev);
 	if (rc)
 		goto disable_pci_access;
 
@@ -4846,51 +4846,49 @@ static int gaudi_scrub_device_dram(struct hl_device *hdev, u64 val)
 	return 0;
 }
 
-static int gaudi_scrub_device_mem(struct hl_device *hdev, u64 addr, u64 size)
+static int gaudi_scrub_device_mem(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
+	u64 addr, size, dummy_val;
 	int rc = 0;
 	u64 val = 0;
 
 	if (!hdev->memory_scrub)
 		return 0;
 
-	if (!addr && !size) {
-		/* Wait till device is idle */
-		rc = hl_poll_timeout(
-				hdev,
-				mmDMA0_CORE_STS0/* dummy */,
-				val/* dummy */,
-				(hdev->asic_funcs->is_device_idle(hdev, NULL,
-						0, NULL)),
-						1000,
-						HBM_SCRUBBING_TIMEOUT_US);
-		if (rc) {
-			dev_err(hdev->dev, "waiting for idle timeout\n");
-			return -EIO;
-		}
+	/* Wait till device is idle */
+	rc = hl_poll_timeout(hdev,
+			mmDMA0_CORE_STS0 /* dummy */,
+			dummy_val /* dummy */,
+			(hdev->asic_funcs->is_device_idle(hdev, NULL, 0, NULL)),
+			1000,
+			HBM_SCRUBBING_TIMEOUT_US);
+	if (rc) {
+		dev_err(hdev->dev, "waiting for idle timeout\n");
+		return -EIO;
+	}
 
-		/* Scrub SRAM */
-		addr = prop->sram_user_base_address;
-		size = hdev->pldm ? 0x10000 :
-				(prop->sram_size - SRAM_USER_BASE_OFFSET);
-		val = 0x7777777777777777ull;
+	/* Scrub SRAM */
+	addr = prop->sram_user_base_address;
+	size = hdev->pldm ? 0x10000 : prop->sram_size - SRAM_USER_BASE_OFFSET;
+	val = 0x7777777777777777ull;
 
-		rc = gaudi_memset_device_memory(hdev, addr, size, val);
-		if (rc) {
-			dev_err(hdev->dev,
-				"Failed to clear SRAM in mem scrub all\n");
-			return rc;
-		}
+	dev_dbg(hdev->dev, "Scrubing SRAM: 0x%09llx - 0x%09llx val: 0x%llx\n",
+			addr, addr + size, val);
+	rc = gaudi_memset_device_memory(hdev, addr, size, val);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to clear SRAM (%d)\n", rc);
+		return rc;
+	}
 
-		/* Scrub HBM using all DMA channels in parallel */
-		rc = gaudi_scrub_device_dram(hdev, 0xdeadbeaf);
-		if (rc)
-			dev_err(hdev->dev,
-				"Failed to clear HBM in mem scrub all\n");
+	/* Scrub HBM using all DMA channels in parallel */
+	rc = gaudi_scrub_device_dram(hdev, 0xdeadbeaf);
+	if (rc) {
+		dev_err(hdev->dev, "Failed to clear HBM (%d)\n", rc);
+		return rc;
 	}
 
-	return rc;
+	return 0;
 }
 
 static void *gaudi_get_int_queue_base(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 40c082cafbd7..25b1e3e139e8 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3019,7 +3019,7 @@ static void goya_dma_free_coherent(struct hl_device *hdev, size_t size,
 	dma_free_coherent(&hdev->pdev->dev, size, cpu_addr, fixed_dma_handle);
 }
 
-int goya_scrub_device_mem(struct hl_device *hdev, u64 addr, u64 size)
+int goya_scrub_device_mem(struct hl_device *hdev)
 {
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 54b5b6125df5..d6ec43d6f6b0 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -233,7 +233,7 @@ void goya_add_end_of_cb_packets(struct hl_device *hdev, void *kernel_address,
 				u32 len, u32 original_len, u64 cq_addr, u32 cq_val,
 				u32 msix_vec, bool eb);
 int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser);
-int goya_scrub_device_mem(struct hl_device *hdev, u64 addr, u64 size);
+int goya_scrub_device_mem(struct hl_device *hdev);
 void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
 				dma_addr_t *dma_handle,	u16 *queue_len);
 u32 goya_get_dma_desc_list_size(struct hl_device *hdev, struct sg_table *sgt);
-- 
2.25.1

