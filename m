Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D8253595C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbiE0Gd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244912AbiE0Gd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:33:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D05A2C7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653633236; x=1685169236;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7Oir8NuXvQJ0KM9dT/47+p7JMHYeX2jSIoIAZRo5ALk=;
  b=XdcJn/ABkJ3KrcCDLLkJ9DyAKc0gjRGDYMY/nunBEgssa8rg2DXVoF41
   rJYlhIzgyxJmYbPiUEUWOIrbSsFJp0yrPMyxg2bDWdLU5bQx1CF7z7QYc
   ATswvn8EPceC80D3vTOwlDnA+gOvmeCdNgRs9TNPGS1DAFGQFHzOwaCOg
   HaVnnysWhFZK++7PtHXqohxcTAJLCSFLPOKAXVVAIvzxOT2swBdHIuawp
   tRW20n+56GnW9CDBdLz3iyXLL31llep17IhpVE4UFdWxbdyKJa80lfOtQ
   DI3Ee+VqzXla1VVwqwQMtNs0Tuct/5FgVvEtjGZgJLtIC/8RvFAc+L9Mi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335044773"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335044773"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:33:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718688281"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:33:52 -0700
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
Subject: [PATCH 00/12] iommu/vt-d: Optimize the use of locks
Date:   Fri, 27 May 2022 14:30:07 +0800
Message-Id: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
- Convert spinlock into mutex so that non-critical functions could be
  called when the lock is held.

This series is also available on github:
https://github.com/LuBaolu/intel-iommu/commits/intel-iommu-lock-optimization-v1

Your comments and suggestions are very appreciated.

Best regards,
baolu

Lu Baolu (12):
  iommu/vt-d: Use iommu_get_domain_for_dev() in debugfs
  iommu/vt-d: Remove for_each_device_domain()
  iommu/vt-d: Remove clearing translation data in disable_dmar_iommu()
  iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()
  iommu/vt-d: Unncessary spinlock for root table alloc and free
  iommu/vt-d: Acquiring lock in domain ID allocation helpers
  iommu/vt-d: Acquiring lock in pasid manipulation helpers
  iommu/vt-d: Replace spin_lock_irqsave() with spin_lock()
  iommu/vt-d: Check device list of domain in domain free path
  iommu/vt-d: Fold __dmar_remove_one_dev_info() into its caller
  iommu/vt-d: Use device_domain_lock accurately
  iommu/vt-d: Convert device_domain_lock into per-domain mutex

 drivers/iommu/intel/iommu.h   |   5 +-
 drivers/iommu/intel/debugfs.c |  26 ++--
 drivers/iommu/intel/iommu.c   | 271 +++++++++-------------------------
 drivers/iommu/intel/pasid.c   | 143 +++++++++---------
 drivers/iommu/intel/svm.c     |   5 +-
 5 files changed, 147 insertions(+), 303 deletions(-)

-- 
2.25.1

