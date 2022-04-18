Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F32504A50
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 02:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiDRAzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 20:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiDRAzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 20:55:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E313E3F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 17:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650243153; x=1681779153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=szoCLBC/pIys3NwbIzrfbRFurpriz5wEpftUR2JNNlw=;
  b=giQmoFeeA4n9lrN3XXVEHmjc3hJ6tAUaA2TJ1ORojvcSZ5bVuO/TB9qD
   PrD3aGOQr42Q44/AhI7Ujtzo8uyvB1Ci0pUPRu2Ch8JhXUZAclwKUUGY3
   unsiEgwHs+fJaTpeFS4maRpRr4avAlmCEcRiN4XHG7/z7dhBn++nmRW+w
   FCAUSbx5IaxAzXuI6chFWsUyxSGGT+KFkOORrvr5v2dA3Oy46H3tr2Oaa
   P8uqJUZIwGGXLUrahT8GYlSpT7HrTIGWHJRBKHwyehXL06HIKshwqjAsx
   4kKuc61kAVl4RVDybYIf8AEZIuVIRx7D4Mtle9D+C6YHn6PveFOqLwHxI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="245313205"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="245313205"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 17:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="701651270"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2022 17:52:30 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Date:   Mon, 18 Apr 2022 08:49:49 +0800
Message-Id: <20220418005000.897664-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

Hi Joerg,

This is a resend version of v8 posted here:
https://lore.kernel.org/linux-iommu/20220308054421.847385-1-baolu.lu@linux.intel.com/
as we discussed in this thread:
https://lore.kernel.org/linux-iommu/Yk%2Fq1BGN8pC5HVZp@8bytes.org/

All patches can be applied perfectly except this one:
 - [PATCH v8 02/11] driver core: Add dma_cleanup callback in bus_type
It conflicts with below refactoring commit:
 - 4b775aaf1ea99 "driver core: Refactor sysfs and drv/bus remove hooks"
The conflict has been fixed in this post.

No functional changes in this series. I suppress cc-ing this series to
all v8 reviewers in order to avoid spam.

Please consider it for your iommu tree.

Best regards,
baolu

Change log:
- v8 and before:
  - Please refer to v8 post for all the change history.

- v8-resend
  - Rebase the series on top of v5.18-rc3.
  - Add Reviewed-by's granted by Robin.
  - Add a Tested-by granted by Eric.

Jason Gunthorpe (1):
  vfio: Delete the unbound_list

Lu Baolu (10):
  iommu: Add DMA ownership management interfaces
  driver core: Add dma_cleanup callback in bus_type
  amba: Stop sharing platform_dma_configure()
  bus: platform,amba,fsl-mc,PCI: Add device DMA ownership management
  PCI: pci_stub: Set driver_managed_dma
  PCI: portdrv: Set driver_managed_dma
  vfio: Set DMA ownership for VFIO devices
  vfio: Remove use of vfio_group_viable()
  vfio: Remove iommu group notifier
  iommu: Remove iommu group changes notifier

 include/linux/amba/bus.h              |   8 +
 include/linux/device/bus.h            |   3 +
 include/linux/fsl/mc.h                |   8 +
 include/linux/iommu.h                 |  54 +++---
 include/linux/pci.h                   |   8 +
 include/linux/platform_device.h       |  10 +-
 drivers/amba/bus.c                    |  37 +++-
 drivers/base/dd.c                     |   5 +
 drivers/base/platform.c               |  21 ++-
 drivers/bus/fsl-mc/fsl-mc-bus.c       |  24 ++-
 drivers/iommu/iommu.c                 | 228 ++++++++++++++++--------
 drivers/pci/pci-driver.c              |  18 ++
 drivers/pci/pci-stub.c                |   1 +
 drivers/pci/pcie/portdrv_pci.c        |   2 +
 drivers/vfio/fsl-mc/vfio_fsl_mc.c     |   1 +
 drivers/vfio/pci/vfio_pci.c           |   1 +
 drivers/vfio/platform/vfio_amba.c     |   1 +
 drivers/vfio/platform/vfio_platform.c |   1 +
 drivers/vfio/vfio.c                   | 245 ++------------------------
 19 files changed, 338 insertions(+), 338 deletions(-)

-- 
2.25.1

