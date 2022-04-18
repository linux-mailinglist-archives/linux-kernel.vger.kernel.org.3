Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92F504A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 02:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiDRAza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 20:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbiDRAzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 20:55:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF92A13EAA
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 17:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650243163; x=1681779163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/kFQnsBqkXI0hmaJKub5IQkJHcP80qmW7WdRtl8Uumc=;
  b=LgZ21s+BWqna2vdpF2VKdYSHo3T5Q1tx8mJgxH4XhmWBX3gRNqBovVor
   cdRO4Y8xj90rOyavy1t2NQSCtbrmI8fpcRpqogKy2uKhuAfbMqYYsoNXB
   AZ1Whodxj2Mof7uat+4hf9tgxug0kEFgjLDF+yBSfyoZmQscMAZpSkwYR
   4e8kk2PBOL2Ia3fF3XB/djiZpDFL3TphYnmG4f6sN5mxiXStkfmaxnMdR
   6bmgQlA4PvmsfONUCn5uZPXNKjEllIbvvEtW0HIcy5YrFvEbV/Hr0wKyC
   Y/qxTueIZVIKhDeXSTm3cVSXy2EVhBnhrTwbEw3mVb4C38EWwnOtYSc2t
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="245313223"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="245313223"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 17:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="701651301"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2022 17:52:41 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v8 06/11] PCI: portdrv: Set driver_managed_dma
Date:   Mon, 18 Apr 2022 08:49:55 +0800
Message-Id: <20220418005000.897664-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418005000.897664-1-baolu.lu@linux.intel.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a switch lacks ACS P2P Request Redirect, a device below the switch can
bypass the IOMMU and DMA directly to other devices below the switch, so
all the downstream devices must be in the same IOMMU group as the switch
itself.

The existing VFIO framework allows the portdrv driver to be bound to the
bridge while its downstream devices are assigned to user space. The
pci_dma_configure() marks the IOMMU group as containing only devices
with kernel drivers that manage DMA. Avoid this default behavior for the
portdrv driver in order for compatibility with the current VFIO usage.

We achieve this by setting ".driver_managed_dma = true" in pci_driver
structure. It is safe because the portdrv driver meets below criteria:

- This driver doesn't use DMA, as you can't find any related calls like
  pci_set_master() or any kernel DMA API (dma_map_*() and etc.).
- It doesn't use MMIO as you can't find ioremap() or similar calls. It's
  tolerant to userspace possibly also touching the same MMIO registers
  via P2P DMA access.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 4b8801656ffb..7f8788a970ae 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -202,6 +202,8 @@ static struct pci_driver pcie_portdriver = {
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
+	.driver_managed_dma = true,
+
 	.driver.pm	= PCIE_PORTDRV_PM_OPS,
 };
 
-- 
2.25.1

