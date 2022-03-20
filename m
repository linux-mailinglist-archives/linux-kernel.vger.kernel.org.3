Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F17A4E1A74
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244823AbiCTGoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiCTGoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:44:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E312102A7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647758558; x=1679294558;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gbEDJc7UjnYqXMs/lN72CbHb0WPgXfSbE7JnkNcwm3E=;
  b=b8jFe7F/fa9zsRQMHevFjyQHzkRWASeQ/8F7FXDLZgxS3mWDZ0ncmGjk
   AHlmdG5Y5fPBEgkbNumPH6ASed/piIr3atalT1trbqbMGPZEkg82072Ug
   OFx1hzWCMNLPJ0D1U9/sXayY7v8aCoSIsSXMrYuloFg07aoguns+oB96Z
   O07T8kHyTRoCdcXsCiVgJwvefiagKP4ug/EpGYHyU89XKBgE/8+W+QIwE
   zCzzgAejtHeg/ASquxmhpxz7Xq+IEKErPzorJAFtB/iHy9U+AZGgyjCFk
   ZS0hjlOQMS/kNy1qesOkFB1ko1MyQb9/1i3bNFl0IlZNAPOkT21qvNMg/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="254924005"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="254924005"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 23:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="691839857"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:42:34 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH RFC 00/11] iommu: SVA and IOPF refactoring
Date:   Sun, 20 Mar 2022 14:40:19 +0800
Message-Id: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The former part of this series refactors the IOMMU SVA code by assigning
an SVA type of iommu_domain to a shared virtual address and replacing
sva_bind/unbind iommu ops with attach/detach_dev_pasid domain ops.

The latter part changes the existing I/O page fault handling framework
from only serving SVA to a generic one. Any driver or component could
handle the I/O page faults for its domain in its own way by installing
an I/O page fault handler.

This series overlaps with another series posted here [1]. For the
convenience of review, I included all relevant patches in this series.
We will solve the overlap problem later.

This series is also available on github here [2].

[1] https://lore.kernel.org/lkml/20220315050713.2000518-1-jacob.jun.pan@linux.intel.com/
[2] https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v1

Please help review and suggest.

Best regards,
baolu

Lu Baolu (11):
  iommu: Add pasid_bits field in struct dev_iommu
  iommu: Add iommu_domain type for SVA
  iommu: Add attach/detach_dev_pasid domain ops
  iommu/vt-d: Add SVA domain support
  arm-smmu-v3/sva: Add SVA domain support
  iommu/sva: Use attach/detach_pasid_dev in SVA interfaces
  iommu: Remove SVA related callbacks from iommu ops
  iommu: Handle IO page faults directly
  iommu: Add iommu_get_domain_for_dev_pasid()
  iommu: Make IOPF handling framework generic
  iommu: Rename iommu-sva-lib.{c,h}

 include/linux/intel-iommu.h                   |   5 +-
 include/linux/iommu.h                         |  95 +++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  25 +-
 .../iommu/{iommu-sva-lib.h => iommu-sva.h}    |   0
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  96 ++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  19 +-
 drivers/iommu/intel/iommu.c                   |  36 +--
 drivers/iommu/intel/svm.c                     |  85 +++----
 drivers/iommu/io-pgfault.c                    |  69 +-----
 drivers/iommu/iommu-sva-lib.c                 |  71 ------
 drivers/iommu/iommu-sva.c                     | 230 ++++++++++++++++++
 drivers/iommu/iommu.c                         | 175 ++++++-------
 drivers/iommu/Makefile                        |   2 +-
 13 files changed, 515 insertions(+), 393 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (100%)
 delete mode 100644 drivers/iommu/iommu-sva-lib.c
 create mode 100644 drivers/iommu/iommu-sva.c

-- 
2.25.1

