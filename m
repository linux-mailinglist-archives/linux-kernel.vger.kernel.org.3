Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB976567C38
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiGFC7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 22:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiGFC7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 22:59:52 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7BD1A83C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 19:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657076391; x=1688612391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FSiZChhVHv7Wpj5PCg89R1fUdgobRIw3yEg1zu2dmng=;
  b=BSb/NTZLY51WaZpwq2p/RNqLQgkCR28LRo+0MDFBQuS5qxkydMORtQ/H
   nOAVIqQDFOg6Z/Bwin5dEaJGLfOV/fOwBWKyumyHOj+rFiOSMVvO7KLfu
   XVryVFGqefIdptf/b7tuHiqb1msXP87+3i7q+rIbVgGquYnIYKdjODMdA
   8hVVICc8E3G9WngkoSJUkkKNsb3KylNf293TH1Uet/I4R1LnhyToihD4C
   PpfEjji3PD/jalHvjXrUe/IzZ08yhpllhMvH+c6T1B9c5L4f/cs/KR9HH
   esyW5qUp/pri5mCaZX6LDrzHbIzVwEaY1VU0oOYzWDVnN57C6lyKozDGA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272409516"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="272409516"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 19:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="567874753"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 19:59:48 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org, iommu@lists.linux.dev
Cc:     Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 00/11] iommu/vt-d: Optimize the use of locks
Date:   Wed,  6 Jul 2022 10:55:13 +0800
Message-Id: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
https://github.com/LuBaolu/intel-iommu/commits/intel-iommu-lock-optimization-v4

Your comments and suggestions are very appreciated.

Best regards,
baolu

Change log:

v4:
 - Kevin pointed out that the copy table failure path needs some
   improvements. We agreed that it worth a separated series to handle
   all improvements on copy table.
 - Kevin suggested that we could put all spinlock replacement changes in
   a single patch. Updated in this series.
 - Others look good to Kevin. (Thanks and very appreciated for all the
   review comments.)

v3:
 - https://lore.kernel.org/linux-iommu/20220629074725.2331441-1-baolu.lu@linux.intel.com/
 - Split reduction of lock ranges from changing irqsave.
   https://lore.kernel.org/linux-iommu/BN9PR11MB52760A3D7C6BF1AF9C9D34658CAA9@BN9PR11MB5276.namprd11.prod.outlook.com/
 - Fully initialize the dev_info before adding it to the list.
   https://lore.kernel.org/linux-iommu/BN9PR11MB52764D7CD86448C5E4EB46668CAA9@BN9PR11MB5276.namprd11.prod.outlook.com/
 - Various code and comments refinement.

v2:
 - https://lore.kernel.org/linux-iommu/20220614025137.1632762-1-baolu.lu@linux.intel.com/
 - Split the lock-free page walk issue into a new patch:
   https://lore.kernel.org/linux-iommu/20220609070811.902868-1-baolu.lu@linux.intel.com/
 - Drop the conversion from spinlock to mutex and make this series
   cleanup purpose only.
 - Address several comments received during v1 review.

v1:
 - https://lore.kernel.org/linux-iommu/20220527063019.3112905-1-baolu.lu@linux.intel.com/
 - Initial post.

Lu Baolu (11):
  iommu/vt-d: debugfs: Remove device_domain_lock usage
  iommu/vt-d: Remove clearing translation data in disable_dmar_iommu()
  iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()
  iommu/vt-d: Unnecessary spinlock for root table alloc and free
  iommu/vt-d: Replace spin_lock_irqsave() with spin_lock()
  iommu/vt-d: Acquiring lock in domain ID allocation helpers
  iommu/vt-d: Acquiring lock in pasid manipulation helpers
  iommu/vt-d: Check device list of domain in domain free path
  iommu/vt-d: Fold __dmar_remove_one_dev_info() into its caller
  iommu/vt-d: Use device_domain_lock accurately
  iommu/vt-d: Convert global spinlock into per domain lock

 drivers/iommu/intel/iommu.h   |   3 +-
 drivers/iommu/intel/pasid.h   |   1 +
 drivers/iommu/intel/debugfs.c |  49 ++++---
 drivers/iommu/intel/iommu.c   | 249 ++++++++++------------------------
 drivers/iommu/intel/pasid.c   | 103 +++++++-------
 drivers/iommu/intel/svm.c     |   5 +-
 6 files changed, 163 insertions(+), 247 deletions(-)

-- 
2.25.1

