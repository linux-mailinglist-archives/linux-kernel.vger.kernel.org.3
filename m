Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7276559D78
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiFXPiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFXPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:37:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCD849936
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 08:37:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77797B828D6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 15:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42984C3411C;
        Fri, 24 Jun 2022 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656085070;
        bh=q+Ebe9JSgoQ4a4AQNtuUJMemoYWuPZSwvZi2GsiZL0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kAS3ZnZxwPXb4pNjZo/m4cxgBXhqmO7JzN8FuoXfxAS3DD/GBmUeBq66ozn+PdTQd
         9LPN3b/zsY9HwKBflsRZhPBh4pvMM3y6n+cAOx/iGo0CRtfZeHS8ONdMaEdJwfFD2r
         SG7iQe2kjwBDsESIXroOW+Q0S57rKF96EVFQqO8c1PkK7VHhZuxYcjTMKAtmrnkTOn
         teisN2d2l4+XuaqW2BqLhqNaZabs+Z7fMf/jowbW129/dMCvd/5yOSzEL5MlQdtYt+
         iMRHAfIUjQ7crScsyDqBfIE/h19+ynSY6OzLxCvMVL4mxgnBA2QUzBZf5Nq4vYl9+k
         6r1oFfbE+WoIg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/2] habanalabs: page size can only be a power of 2
Date:   Fri, 24 Jun 2022 18:37:43 +0300
Message-Id: <20220624153743.1825744-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624153743.1825744-1-ogabbay@kernel.org>
References: <20220624153743.1825744-1-ogabbay@kernel.org>
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

From: Ohad Sharabi <osharabi@habana.ai>

We dropped support for page sizes that are not power of 2.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 3 ---
 drivers/misc/habanalabs/common/memory.c     | 4 ++--
 drivers/misc/habanalabs/gaudi/gaudi.c       | 1 -
 drivers/misc/habanalabs/goya/goya.c         | 1 -
 4 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index c5c0861f2059..df8d1038723d 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1332,8 +1332,6 @@ struct fw_load_mgr {
  * @get_sob_addr: get SOB base address offset.
  * @set_pci_memory_regions: setting properties of PCI memory regions
  * @get_stream_master_qid_arr: get pointer to stream masters QID array
- * @is_valid_dram_page_size: return true if page size is supported in device
- *                           memory allocation, otherwise false.
  * @get_valid_dram_page_orders: get valid device memory allocation page orders
  * @access_dev_mem: access device memory
  * @set_dram_bar_base: set the base of the DRAM BAR
@@ -1453,7 +1451,6 @@ struct hl_asic_funcs {
 	u32 (*get_sob_addr)(struct hl_device *hdev, u32 sob_id);
 	void (*set_pci_memory_regions)(struct hl_device *hdev);
 	u32* (*get_stream_master_qid_arr)(void);
-	bool (*is_valid_dram_page_size)(u32 page_size);
 	int (*mmu_get_real_page_size)(struct hl_device *hdev, struct hl_mmu_properties *mmu_prop,
 					u32 page_size, u32 *real_page_size, bool is_dram_addr);
 	void (*get_valid_dram_page_orders)(struct hl_info_dev_memalloc_page_sizes *info);
diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 039fd87021ab..4f35a5668fcb 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -36,8 +36,8 @@ static int set_alloc_page_size(struct hl_device *hdev, struct hl_mem_in *args, u
 	if (prop->supports_user_set_page_size && args->alloc.page_size) {
 		psize = args->alloc.page_size;
 
-		if (!hdev->asic_funcs->is_valid_dram_page_size(psize)) {
-			dev_err(hdev->dev, "user page size (%#x) is not valid\n", psize);
+		if (!is_power_of_2(psize)) {
+			dev_err(hdev->dev, "user page size (%#x) is not power of 2\n", psize);
 			return -EINVAL;
 		}
 	} else {
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8d206c848e9a..33ad7226dd8c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9350,7 +9350,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.get_sob_addr = gaudi_get_sob_addr,
 	.set_pci_memory_regions = gaudi_set_pci_memory_regions,
 	.get_stream_master_qid_arr = gaudi_get_stream_master_qid_arr,
-	.is_valid_dram_page_size = NULL,
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
 	.get_valid_dram_page_orders = gaudi_get_valid_dram_page_orders,
 	.access_dev_mem = hl_access_dev_mem,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 9d5245275726..49f859a1f07a 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5504,7 +5504,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.get_sob_addr = &goya_get_sob_addr,
 	.set_pci_memory_regions = goya_set_pci_memory_regions,
 	.get_stream_master_qid_arr = goya_get_stream_master_qid_arr,
-	.is_valid_dram_page_size = NULL,
 	.mmu_get_real_page_size = hl_mmu_get_real_page_size,
 	.get_valid_dram_page_orders = goya_get_valid_dram_page_orders,
 	.access_dev_mem = hl_access_dev_mem,
-- 
2.25.1

