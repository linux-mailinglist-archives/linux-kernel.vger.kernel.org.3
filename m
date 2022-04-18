Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E878504A47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 02:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiDRAzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 20:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbiDRAzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 20:55:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0499C13EAA
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 17:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650243162; x=1681779162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6K2eWlxOyc65iXu8zh1miLOHRYvCLILUgOV92SuDu+w=;
  b=Ohb1rcZEeaCzCebWlZI9kSIjpAkot11RKJOmHwuoD9NsAmgVJYPznfWS
   9bBVbir5je7mmqot0Ud9LiwZlP1RzIjZsajo+4ZcsopZ97pPnjwh3l8uc
   /WK3jaWYCv5RWhgmT4LMvTN/lvZ4Y2VkM28pGiwf+kbKOKuDUFB2Zmjpi
   6081IxD+S3U+G5DrgiHZTywWaXhlVeUlgFZI+hDgw/ey3FqCGZNQiMHE8
   wa2yIwEh4G3688d4lyFeq3/iNi69cDmteUS3rqCkB9oDqGNKJx1OmV5ig
   nHOj2LTKtf+HgUuFSNo6qcyTHBO/v/BgJLjyBcgr44eZ62xUkIlVWGgbR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="245313221"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="245313221"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 17:52:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="701651294"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2022 17:52:40 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v8 05/11] PCI: pci_stub: Set driver_managed_dma
Date:   Mon, 18 Apr 2022 08:49:54 +0800
Message-Id: <20220418005000.897664-6-baolu.lu@linux.intel.com>
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

The current VFIO implementation allows pci-stub driver to be bound to
a PCI device with other devices in the same IOMMU group being assigned
to userspace. The pci-stub driver has no dependencies on DMA or the
IOVA mapping of the device, but it does prevent the user from having
direct access to the device, which is useful in some circumstances.

The pci_dma_configure() marks the iommu_group as containing only devices
with kernel drivers that manage DMA. For compatibility with the VFIO
usage, avoid this default behavior for the pci_stub. This allows the
pci_stub still able to be used by the admin to block driver binding after
applying the DMA ownership to VFIO.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-stub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index e408099fea52..d1f4c1ce7bd1 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -36,6 +36,7 @@ static struct pci_driver stub_driver = {
 	.name		= "pci-stub",
 	.id_table	= NULL,	/* only dynamic id's */
 	.probe		= pci_stub_probe,
+	.driver_managed_dma = true,
 };
 
 static int __init pci_stub_init(void)
-- 
2.25.1

