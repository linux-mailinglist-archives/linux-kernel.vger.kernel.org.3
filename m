Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1904D9399
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344860AbiCOFMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344839AbiCOFMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:12:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6183849245
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647321064; x=1678857064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tpMOnF3L21oRMXjbylyNzJFTycaw/Dvgw48xE8xN/vo=;
  b=ff/BKFLexkH7MWANopPTcbf6zZoExGNNPjkFLDPT+anmlb2HFA2z9qV4
   IaWbAzQxj+5Isux1vBJfhRqaY98yGuVpKgywLvlwfFlcXYcWGjyvmsf86
   aYCUHGCbSqasS22XBbfMif0IG+PpYPS28myYI+PYqx/EhNaasAY/3N2Dy
   Lowe24c101GssxGvLnNEdQvsm3DqpDzCHJ3sm6AizQOIOtEyUvWvmmwq0
   ul6zjBnDIjg8aiun1rUESyu9d/t5VNLsctfryyWAtorVt27LMQ2IQIDZa
   OC1dCifYoUpMQjwVU1yoLUwaKIISxKlraD4AT8FD560D0obFVoM07gImD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236159098"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="236159098"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 22:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="580383563"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by orsmga001.jf.intel.com with ESMTP; 14 Mar 2022 22:03:58 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 0/8] Enable PASID for DMA API users
Date:   Mon, 14 Mar 2022 22:07:04 -0700
Message-Id: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some modern accelerators such as Intel's Data Streaming Accelerator (DSA)
require PASID in DMA requests to be operational. Specifically, the work
submissions with ENQCMD on shared work queues require PASIDs. The use cases
include both user DMA with shared virtual addressing (SVA) and in-kernel
DMA similar to legacy DMA w/o PASID. Here we address the latter.

DMA mapping API is the de facto standard for in-kernel DMA. However, it
operates on a per device or Requester ID(RID) basis which is not
PASID-aware. To leverage DMA API for devices relies on PASIDs, this
patchset introduces the following APIs

1. A driver facing API that enables DMA API PASID usage:
iommu_enable_pasid_dma(struct device *dev, ioasid_t &pasid);

2. An IOMMU op that allows attaching device-domain-PASID generically (will
be used beyond DMA API PASID support)

Once PASID DMA is enabled and attached to the appropriate IOMMU domain,
device drivers can continue to use DMA APIs as-is. There is no difference
in terms of mapping in dma_handle between without PASID and with PASID.
The DMA mapping performed by IOMMU will be identical for both requests, let
it be IOVA or PA in case of pass-through.

In addition, this set converts DSA driver in-kernel DMA with PASID from SVA
lib to DMA API. There have been security and functional issues with the
kernel SVA approach:
(https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/)
The highlights are as the following:
 - The lack of IOTLB synchronization upon kernel page table updates.
   (vmalloc, module/BPF loading, CONFIG_DEBUG_PAGEALLOC etc.)
 - Other than slight more protection, using kernel virtual address (KVA)
has little advantage over physical address. There are also no use cases yet
where DMA engines need kernel virtual addresses for in-kernel DMA.

Subsequently, cleanup is done around the usage of sva_bind_device() for
in-kernel DMA. Removing special casing code in VT-d driver and tightening
SVA lib API.

This work and idea behind it is a collaboration with many people, many
thanks to Baolu Lu, Jason Gunthorpe, Dave Jiang, and others.


ChangeLog:
v2
	- Do not reserve a special PASID for DMA API usage. Use IOASID
	  allocation instead.
	- Introduced a generic device-pasid-domain attachment IOMMU op.
	  Replaced the DMA API only IOMMU op.
	- Removed supervisor SVA support in VT-d
	- Removed unused sva_bind_device parameters
	- Use IOMMU specific data instead of struct device to store PASID
	  info

Jacob Pan (6):
  iommu/vt-d: Implement device_pasid domain attach ops
  iommu/vt-d: Use device_pasid attach op for RID2PASID
  iommu: Add PASID support for DMA mapping API users
  dmaengine: idxd: Use DMA API for in-kernel DMA with PASID
  iommu/vt-d: Delete supervisor/kernel SVA
  iommu: Remove unused driver data in sva_bind_device

Lu Baolu (2):
  iommu: Assign per device max PASID
  iommu: Add attach/detach_dev_pasid domain ops

 drivers/dma/idxd/cdev.c                       |   2 +-
 drivers/dma/idxd/idxd.h                       |   1 -
 drivers/dma/idxd/init.c                       |  34 +--
 drivers/dma/idxd/sysfs.c                      |   7 -
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   5 +-
 drivers/iommu/dma-iommu.c                     |  65 ++++++
 drivers/iommu/intel/iommu.c                   | 214 ++++++++++++++++--
 drivers/iommu/intel/svm.c                     |  51 +----
 drivers/iommu/iommu.c                         |   4 +-
 drivers/misc/uacce/uacce.c                    |   2 +-
 include/linux/dma-iommu.h                     |   7 +
 include/linux/intel-iommu.h                   |  15 +-
 include/linux/iommu.h                         |  37 ++-
 14 files changed, 338 insertions(+), 108 deletions(-)

-- 
2.25.1

