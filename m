Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0B851B515
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiEEBNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiEEBNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:13:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC0749275
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651713009; x=1683249009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bObumrYm1BRiO8NC7JGkJj5WU3DlBUMAdCew4SD9ic0=;
  b=J8bb7iBtLkNUf6sIqIkROBwztiAw2ABtRPOkYBT7Q5RVJsjeF3hIj7e+
   5hhx2W/Dfy3RQL8tO7gjO2I8yruz78rYZIc+JJO5dA0UGYojkZgi76YQu
   FjW4JkNRYlQ9+z7zfFcb7pbUyHE6dYl4rl84FMX4PsqitFpuoDw3K1Y5C
   3ZbNzRwUSbOmkV3bVsEf9AbUy6BSSvrEN984IgLI7dIdKtEQ76fVGmpvB
   7Hy9kq5YLM1XWR2xVnsIpRnlWqSKo74mU8zDjbkiHmqDJL09hQ3+mmCYt
   MlZJLJzI4nbFwEkcxj0O9N1wMrfohAQrb/Fij/t7l8JIb4mbD3KRtKGTp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267832591"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="267832591"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:10:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="708713892"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 May 2022 18:10:06 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/4] iommu/vt-d: Force snooping improvement
Date:   Thu,  5 May 2022 09:07:06 +0800
Message-Id: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
v2:
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
 drivers/iommu/intel/iommu.c | 88 ++++++++++++++++++++++---------------
 drivers/iommu/intel/pasid.c | 26 +++++++++--
 4 files changed, 78 insertions(+), 39 deletions(-)

-- 
2.25.1

