Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9675351D0BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346681AbiEFFeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347742AbiEFFeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:34:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5593819008
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651815027; x=1683351027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5UPUZjJVdMzrW2rShCCX+WFC3SvhnCk41EqWtRxsWIE=;
  b=JItjtE5h2SaXLKCLYHuxSb7eMMsfPGYba+keTLnWcYdCS9kbVSEWwwrr
   jYoldxBFF3VMuSwV5GpqqSKbD1YW9cEbilSzx//SXUGzytJkAma134QTk
   +kLQYU9cf2HU84Dy65l6fXzt1pDpQ22/WYBbE7NSm0eaavcDzNIQ2Fgsk
   BTE/bGwAUxouEjoADGWeKNvAXh2wSzjBlKUnK+CBQLUe9mXv1wwfz9r2c
   oqpX7YKaLSQO4zRJSVi/cp4FvATSfTfcSjiv7ptzcuAwFZeVM7Q+keXTs
   JaNtKxMyMW3Tr/TJ4/G3EEBVQqYvMoAV/6UzAPV2+XmW09iSuGpc83AXv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="255838457"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="255838457"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="695011041"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 22:30:24 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/4] iommu/vt-d: Force snooping improvement
Date:   Fri,  6 May 2022 13:27:23 +0800
Message-Id: <20220506052727.1689687-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Previously, the IOMMU capability of enforcing cache coherency was queried
through iommu_capable(IOMMU_CAP_CACHE_COHERENCY). This is a global
capability, hence the IOMMU driver reports support for this capability
only when all IOMMUs in the system has this support.

Commit 6043257b1de06 ("iommu: Introduce the domain op
enforce_cache_coherency()") converts this into a per-domain test-and-set
option, and the previous iommu_capable(IOMMU_CAP_CACHE_COHERENCY) is
deprecated.

This is a follow-up series which improves the Intel IOMMU driver to
support the per-domain scheme better.

Best regards,
baolu

Change log:
v3:
 - Hold the device_domain_lock when check and set force snooping.
 - Refind the commit messages.

v2:
 - https://lore.kernel.org/linux-iommu/20220505010710.1477739-1-baolu.lu@linux.intel.com/
 - Check whether force_snooping has already been set in
   intel_iommu_enforce_cache_coherency().
 - Set PGSNP pasid bit field during domain attaching if forcing_snooping
   is set.
 - Remove redundant list_empty() checks.
 - Add dmar_domain->set_pte_snp and set it if force snooping is enforced
   on a domain with 2nd-level translation.

v1:
 - https://lore.kernel.org/linux-iommu/20220501112434.874236-1-baolu.lu@linux.intel.com
 - Initial post.

Lu Baolu (4):
  iommu/vt-d: Block force-snoop domain attaching if no SC support
  iommu/vt-d: Check domain force_snooping against attached devices
  iommu/vt-d: Remove domain_update_iommu_snooping()
  iommu/vt-d: Remove hard coding PGSNP bit in PASID entries

 include/linux/intel-iommu.h |  1 +
 drivers/iommu/intel/pasid.h |  2 +
 drivers/iommu/intel/iommu.c | 90 ++++++++++++++++++++++---------------
 drivers/iommu/intel/pasid.c | 26 +++++++++--
 4 files changed, 80 insertions(+), 39 deletions(-)

-- 
2.25.1

