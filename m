Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA9255C391
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbiF0QNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbiF0QNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:13:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DEB186E5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:13:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 528D3B81186
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D22C3411D;
        Mon, 27 Jun 2022 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656346412;
        bh=5Eiao4YckIx1rV8LSQxic4/kEhehVORgdHvrvRDRKu0=;
        h=From:To:Cc:Subject:Date:From;
        b=qu7hLvCDcgOTXERvXWEdBRsbjojMj9azE7PYdGf1axLagEfZ0jOKE7xd7Jernf99T
         aiDSBcY9dPeemPEXKAo2LVDaxTySyKtwkde5FB8VfrT1pLOXJ/hx533f3Mwcgw1f4M
         ED3RDkNajY0xCAXUuOoYkZzsrOpSmCVAlFkwhP4wz3sQ6qcQmZqhVnTS4GeCJJ54Je
         va5JG6kvjI2fCJbVLeLfEKWwZEIbSYUVll4DUfW22DTVnurdt0vrG6hkgZInEgigGf
         rR1SnpK8P/D+vv7QTJzNJ4ozyeiyTTZOmkw42FwMwYfSF4XNtSAuuIIsPc1S/4OfLq
         bxLkfTxKB/9/Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: remove redundant argument in access_dev_mem APIs
Date:   Mon, 27 Jun 2022 19:13:27 +0300
Message-Id: <20220627161327.775077-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Region structure is derived from region type, hence no need to pass
it as an argument.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    | 3 +--
 drivers/misc/habanalabs/common/device.c     | 5 ++---
 drivers/misc/habanalabs/common/habanalabs.h | 8 ++++----
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 0f07c2de986b..aaf5235a58d5 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -695,8 +695,7 @@ static int hl_access_dev_mem_by_region(struct hl_device *hdev, u64 addr,
 		if (addr >= mem_reg->region_base &&
 			addr <= mem_reg->region_base + mem_reg->region_size - acc_size) {
 			*found = true;
-			return hdev->asic_funcs->access_dev_mem(hdev, mem_reg, i,
-				addr, val, acc_type);
+			return hdev->asic_funcs->access_dev_mem(hdev, i, addr, val, acc_type);
 		}
 	}
 	return 0;
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index c42557052f88..adf0ff26636c 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -245,14 +245,13 @@ int hl_access_cfg_region(struct hl_device *hdev, u64 addr, u64 *val,
  * hl_access_dev_mem - access device memory
  *
  * @hdev: pointer to habanalabs device structure
- * @region: the memory region the address belongs to
  * @region_type: the type of the region the address belongs to
  * @addr: the address to access
  * @val: the value to write from or read to
  * @acc_type: the type of access (r/w, 32/64)
  */
-int hl_access_dev_mem(struct hl_device *hdev, struct pci_mem_region *region,
-		enum pci_region region_type, u64 addr, u64 *val, enum debugfs_access_type acc_type)
+int hl_access_dev_mem(struct hl_device *hdev, enum pci_region region_type,
+			u64 addr, u64 *val, enum debugfs_access_type acc_type)
 {
 	switch (region_type) {
 	case PCI_REGION_CFG:
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index c5f9501b1113..c7401b524aed 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1455,8 +1455,8 @@ struct hl_asic_funcs {
 	u32* (*get_stream_master_qid_arr)(void);
 	int (*mmu_get_real_page_size)(struct hl_device *hdev, struct hl_mmu_properties *mmu_prop,
 					u32 page_size, u32 *real_page_size, bool is_dram_addr);
-	int (*access_dev_mem)(struct hl_device *hdev, struct pci_mem_region *region,
-		enum pci_region region_type, u64 addr, u64 *val, enum debugfs_access_type acc_type);
+	int (*access_dev_mem)(struct hl_device *hdev, enum pci_region region_type,
+				u64 addr, u64 *val, enum debugfs_access_type acc_type);
 	u64 (*set_dram_bar_base)(struct hl_device *hdev, u64 addr);
 };
 
@@ -3133,8 +3133,8 @@ void hl_dma_unmap_sgtable(struct hl_device *hdev, struct sg_table *sgt,
 				enum dma_data_direction dir);
 int hl_access_cfg_region(struct hl_device *hdev, u64 addr, u64 *val,
 	enum debugfs_access_type acc_type);
-int hl_access_dev_mem(struct hl_device *hdev, struct pci_mem_region *region,
-		enum pci_region region_type, u64 addr, u64 *val, enum debugfs_access_type acc_type);
+int hl_access_dev_mem(struct hl_device *hdev, enum pci_region region_type,
+			u64 addr, u64 *val, enum debugfs_access_type acc_type);
 int hl_device_open(struct inode *inode, struct file *filp);
 int hl_device_open_ctrl(struct inode *inode, struct file *filp);
 bool hl_device_operational(struct hl_device *hdev,
-- 
2.25.1

