Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3360054A73D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355066AbiFNC77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355527AbiFNC6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:58:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD101B7B6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655175335; x=1686711335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xv7uOd/xCgYNJDUjhoE9+434r7HieimT10GGGhVoaEI=;
  b=KmigKTkHqYWz018J+KI3JAATIX47ttMcph2Gf/xCV/kz4/t+rvRUKdcN
   4Hkoh16EAk126Ou+79dpggNF3Cw0erWquLUaQVqFSJ25iewl5rRXBlpcL
   oJKPcImFXNwHvtMDHXx/DyI6rY16RQ2jtO+wHEI2XdtSK0TpNTxxzML9S
   5QjG816oNuy9TPNNSG0zh6jCrq9TTGcr6etqF6YvFD2Xt/jW39lnHX/Um
   ZZu1kufGBl1yzXUX4CuSG9zgUpZXhS124Wm550T0ZW4klgAx0qsKMaWUj
   UaeJLb8x/0kV1ssQWZo91gqFGt1L0Es+28dePvbmRKnpejrMha0LIDBic
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258930159"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="258930159"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 19:55:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="588166389"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 19:55:32 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 00/12] iommu/vt-d: Optimize the use of locks
Date:   Tue, 14 Jun 2022 10:51:25 +0800
Message-Id: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

This series tries to optimize the uses of two locks in the Intel IOMMU
driver:

- The intel_iommu::lock is used to protect the IOMMU resources shared by
  devices. They include the IOMMU root and context tables, the pasid
  tables and the domain IDs.
- The global device_domain_lock is used to protect the global and the
  per-domain device tracking lists.

The optimization includes:

- Remove the unnecessary global device tracking list;
- Remove unnecessary locking;
- Reduce the scope of the lock as much as possible, that is, use the
  lock only where necessary;
- The global lock is transformed into a local lock to improve the
  efficiency.

This series is also available on github:
https://github.com/LuBaolu/intel-iommu/commits/intel-iommu-lock-optimization-v2

Your comments and suggestions are very appreciated.

Best regards,
baolu

Change log:

v2:
 - Split the lock-free page walk issue into a new patch:
   https://lore.kernel.org/linux-iommu/20220609070811.902868-1-baolu.lu@linux.intel.com/
 - Drop the conversion from spinlock to mutex and make this series
   cleanup purpose only.
 - Address several comments received during v1 review.

v1:
 - https://lore.kernel.org/linux-iommu/20220527063019.3112905-1-baolu.lu@linux.intel.com/
 - Initial post.

Lu Baolu (12):
  iommu/vt-d: debugfs: Remove device_domain_lock usage
  iommu/vt-d: Remove for_each_device_domain()
  iommu/vt-d: Remove clearing translation data in disable_dmar_iommu()
  iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()
  iommu/vt-d: Unnecessary spinlock for root table alloc and free
  iommu/vt-d: Acquiring lock in domain ID allocation helpers
  iommu/vt-d: Acquiring lock in pasid manipulation helpers
  iommu/vt-d: Replace spin_lock_irqsave() with spin_lock()
  iommu/vt-d: Check device list of domain in domain free path
  iommu/vt-d: Fold __dmar_remove_one_dev_info() into its caller
  iommu/vt-d: Use device_domain_lock accurately
  iommu/vt-d: Convert global spinlock into per domain ones

 drivers/iommu/intel/iommu.h   |   5 +-
 drivers/iommu/intel/pasid.h   |   1 +
 drivers/iommu/intel/debugfs.c |  55 ++++---
 drivers/iommu/intel/iommu.c   | 279 ++++++++++------------------------
 drivers/iommu/intel/pasid.c   | 149 +++++++++---------
 drivers/iommu/intel/svm.c     |   5 +-
 6 files changed, 185 insertions(+), 309 deletions(-)

-- 
2.25.1

