Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4315AEEF2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238118AbiIFPfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbiIFPdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:33:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5E6C482C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:44:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F21CCB81637
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 14:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC432C433D7;
        Tue,  6 Sep 2022 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662475411;
        bh=dujjoVostzoEL7cyA8gxejJxB915okrzwWy56eQRGGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUw6LPdUPageAavPjriu6rCJGX1zhecxZdnMuLt0seBW41WB6ZYiabtp70tsvSQQN
         WqWftfPS8HYPpOdUKfTFjl38tfUSH2/A8qj8XSL3sMxG7TdJf/uQ6YWlKbJemec6PX
         pC/n/tWpMcrRe45flyrQs24AlL4aDQmx7rfxvEr56rgLWpjLRElfuuJRJdNHlLNcP7
         HUxMmZWugUCrvCH/wV14FU4ptuq2SWygOBHE8j8nZbKyzfzjlxZ3o/a8iZLtuX7xrE
         U5cFvf19IYulrMOlV8ZrWTb+EDBGP1lKBInZE7elTbZKPTnk/WhWTEEcRpcCXaWtZE
         z0EkJIUKTjAcA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 6/9] habanalabs: fix resetting the DRAM BAR
Date:   Tue,  6 Sep 2022 17:43:15 +0300
Message-Id: <20220906144318.1890416-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906144318.1890416-1-ogabbay@kernel.org>
References: <20220906144318.1890416-1-ogabbay@kernel.org>
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

From: Ohad Sharabi <osharabi@habana.ai>

Current code does not takes into account the new DRAM region base
and so calculated address is wrong and can lead to crush.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 41 +++++++++++++------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 9407b14d4b0d..456bd1bfe1a8 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -28,8 +28,9 @@ enum dma_alloc_type {
 /*
  * hl_set_dram_bar- sets the bar to allow later access to address
  *
- * @hdev: pointer to habanalabs device structure
+ * @hdev: pointer to habanalabs device structure.
  * @addr: the address the caller wants to access.
+ * @region: the PCI region.
  *
  * @return: the old BAR base address on success, U64_MAX for failure.
  *	    The caller should set it back to the old address after use.
@@ -39,10 +40,10 @@ enum dma_alloc_type {
  * This function can be called also if the bar doesn't need to be set,
  * in that case it just won't change the base.
  */
-static uint64_t hl_set_dram_bar(struct hl_device *hdev, u64 addr)
+static u64 hl_set_dram_bar(struct hl_device *hdev, u64 addr, struct pci_mem_region *region)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	u64 bar_base_addr;
+	u64 bar_base_addr, old_base;
 
 	if (is_power_of_2(prop->dram_pci_bar_size))
 		bar_base_addr = addr & ~(prop->dram_pci_bar_size - 0x1ull);
@@ -50,51 +51,53 @@ static uint64_t hl_set_dram_bar(struct hl_device *hdev, u64 addr)
 		bar_base_addr = DIV_ROUND_DOWN_ULL(addr, prop->dram_pci_bar_size) *
 				prop->dram_pci_bar_size;
 
-	return hdev->asic_funcs->set_dram_bar_base(hdev, bar_base_addr);
-}
+	old_base = hdev->asic_funcs->set_dram_bar_base(hdev, bar_base_addr);
 
+	/* in case of success we need to update the new BAR base */
+	if (old_base != U64_MAX)
+		region->region_base = bar_base_addr;
+
+	return old_base;
+}
 
 static int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val,
 	enum debugfs_access_type acc_type, enum pci_region region_type)
 {
 	struct pci_mem_region *region = &hdev->pci_mem_region[region_type];
+	void __iomem *acc_addr;
 	u64 old_base = 0, rc;
 
 	if (region_type == PCI_REGION_DRAM) {
-		old_base = hl_set_dram_bar(hdev, addr);
+		old_base = hl_set_dram_bar(hdev, addr, region);
 		if (old_base == U64_MAX)
 			return -EIO;
 	}
 
+	acc_addr = hdev->pcie_bar[region->bar_id] + addr - region->region_base +
+			region->offset_in_bar;
 	switch (acc_type) {
 	case DEBUGFS_READ8:
-		*val = readb(hdev->pcie_bar[region->bar_id] +
-			addr - region->region_base + region->offset_in_bar);
+		*val = readb(acc_addr);
 		break;
 	case DEBUGFS_WRITE8:
-		writeb(*val, hdev->pcie_bar[region->bar_id] +
-			addr - region->region_base + region->offset_in_bar);
+		writeb(*val, acc_addr);
 		break;
 	case DEBUGFS_READ32:
-		*val = readl(hdev->pcie_bar[region->bar_id] +
-			addr - region->region_base + region->offset_in_bar);
+		*val = readl(acc_addr);
 		break;
 	case DEBUGFS_WRITE32:
-		writel(*val, hdev->pcie_bar[region->bar_id] +
-			addr - region->region_base + region->offset_in_bar);
+		writel(*val, acc_addr);
 		break;
 	case DEBUGFS_READ64:
-		*val = readq(hdev->pcie_bar[region->bar_id] +
-			addr - region->region_base + region->offset_in_bar);
+		*val = readq(acc_addr);
 		break;
 	case DEBUGFS_WRITE64:
-		writeq(*val, hdev->pcie_bar[region->bar_id] +
-			addr - region->region_base + region->offset_in_bar);
+		writeq(*val, acc_addr);
 		break;
 	}
 
 	if (region_type == PCI_REGION_DRAM) {
-		rc = hl_set_dram_bar(hdev, old_base);
+		rc = hl_set_dram_bar(hdev, old_base, region);
 		if (rc == U64_MAX)
 			return -EIO;
 	}
-- 
2.25.1

