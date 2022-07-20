Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B2057B528
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiGTLPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGTLPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:15:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1655D1D32A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 41EADCE1ECE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2C3C341CB;
        Wed, 20 Jul 2022 11:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658315730;
        bh=BsNjCaeTJqLQGUGZM209BMxUAA7r6qlSKV6Yyr3KTsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R5mMwdbkSzZSpAZNauUsMwN7Lop5yS4VWdrfIH3jvEO4spLTs3yO6ENcLOTj+xENM
         M6bxUNLF0i8D1Rht7eX94GyBr2lUt90EWYomsPkD7CLxcgWZb4GxxZj3RkDWuV7LCS
         xruZGT0yqgMkypJzI0Pz6Ox7C9STUvuWV+Co2uz/62VKDJn+EM4gzBSle23pW3OVgu
         p13ND+j/1MiaN2PR4fDdUeEF82nZJ2OdEVVXkjoY3kPOJiao0+KmCEpLFFJq2OPD0O
         vDvl4+bL5KVbBt2oLS2wN20pcHni/bUKVXrl4x126tr8QBVjZhazbJ3MwFGIWvUhUj
         hpvyTFmSrzl6w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 2/9] habanalabs/gaudi2: enable all MMU SPI/SEI interrupts
Date:   Wed, 20 Jul 2022 14:15:16 +0300
Message-Id: <20220720111523.4069830-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220720111523.4069830-1-ogabbay@kernel.org>
References: <20220720111523.4069830-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Currently only part of the MMU SPI/SEI interrupts are enabled, although
there is no real reason to not enable all.
The only exception is "burst_fifo_full" which is expected for PMMU
because it has a 2 entries FIFO, and thus is it not enabled for it.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index ab6ad06cec03..465d9c319c3c 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -117,6 +117,12 @@
 #define MMU_RANGE_INV_ASID_EN_SHIFT		1
 #define MMU_RANGE_INV_ASID_SHIFT		2
 
+/* The last SPI_SEI cause bit, "burst_fifo_full", is expected to be triggered in PMMU because it has
+ * a 2 entries FIFO, and hence it is not enabled for it.
+ */
+#define GAUDI2_PMMU_SPI_SEI_ENABLE_MASK		GENMASK(GAUDI2_NUM_OF_MMU_SPI_SEI_CAUSE - 2, 0)
+#define GAUDI2_HMMU_SPI_SEI_ENABLE_MASK		GENMASK(GAUDI2_NUM_OF_MMU_SPI_SEI_CAUSE - 1, 0)
+
 #define GAUDI2_MAX_STRING_LEN			64
 
 #define GAUDI2_VDEC_MSIX_ENTRIES		(GAUDI2_IRQ_NUM_SHARED_DEC1_ABNRM - \
@@ -4956,8 +4962,7 @@ static int gaudi2_mmu_update_hop0_addr(struct hl_device *hdev, u32 stlb_base)
 	return 0;
 }
 
-static int gaudi2_mmu_init_common(struct hl_device *hdev, u32 mmu_base,
-					u32 stlb_base)
+static int gaudi2_mmu_init_common(struct hl_device *hdev, u32 mmu_base, u32 stlb_base)
 {
 	u32 status, timeout_usec;
 	int rc;
@@ -4985,7 +4990,6 @@ static int gaudi2_mmu_init_common(struct hl_device *hdev, u32 mmu_base,
 		return rc;
 
 	WREG32(mmu_base + MMU_BYPASS_OFFSET, 0);
-	WREG32(mmu_base + MMU_SPI_SEI_MASK_OFFSET, 0xF);
 
 	rc = hl_poll_timeout(
 		hdev,
@@ -5042,6 +5046,8 @@ static int gaudi2_pci_mmu_init(struct hl_device *hdev)
 			DCORE0_HMMU0_MMU_STATIC_MULTI_PAGE_SIZE_CFG_8_BITS_HOP_MODE_EN_MASK);
 	}
 
+	WREG32(mmu_base + MMU_SPI_SEI_MASK_OFFSET, GAUDI2_PMMU_SPI_SEI_ENABLE_MASK);
+
 	rc = gaudi2_mmu_init_common(hdev, mmu_base, stlb_base);
 	if (rc)
 		return rc;
@@ -5092,6 +5098,8 @@ static int gaudi2_dcore_hmmu_init(struct hl_device *hdev, int dcore_id,
 	RMWREG32(stlb_base + STLB_HOP_CONFIGURATION_OFFSET, 1,
 			STLB_HOP_CONFIGURATION_ONLY_LARGE_PAGE_MASK);
 
+	WREG32(mmu_base + MMU_SPI_SEI_MASK_OFFSET, GAUDI2_HMMU_SPI_SEI_ENABLE_MASK);
+
 	rc = gaudi2_mmu_init_common(hdev, mmu_base, stlb_base);
 	if (rc)
 		return rc;
-- 
2.25.1

