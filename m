Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A1151B514
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiEEBNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiEEBNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:13:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9ED49275
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651713011; x=1683249011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PRZRBX++Efk2v9ceAa9+fz1iRVPizH/HlrNAHp7PqhA=;
  b=g4eQiVOalO1MmvlZrXYLaRIELirnOyO712uEYuUyJQUOuoHVppnu2fR8
   p27J9nNJaogjxhVwpORJmKG/m+LyK0+ZszySwKEx29itCJNyINIjf1U8H
   4AHwW0SF22N+TRAWBrZylpB0Ar8HnKIb8UXbacAjFhujvBJMrJRZz7fX+
   BLHo44t0TDZecwrDLVoKR2vajMKH8KRFEgcqXodk2ZFtxC7cfJ6iRfTA3
   9OMoFp6aO94cFLDDIL0hqB9jXPfd1eE4bul1Jz3eKBpRQLbHQ57mhImGY
   hi0Iza6z5HJNrQfGv5JnO5UZ50h87+0PplwgDYvf1mvIDSV0daq1i+z0m
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267832594"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="267832594"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:10:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="708713900"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 May 2022 18:10:09 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 1/4] iommu/vt-d: Block force-snoop domain attaching if no SC support
Date:   Thu,  5 May 2022 09:07:07 +0800
Message-Id: <20220505010710.1477739-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
References: <20220505010710.1477739-1-baolu.lu@linux.intel.com>
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

In the attach_dev callback of the default domain ops, if the domain has
been set force_snooping, but the iommu hardware of the device does not
support SC(Snoop Control) capability, the callback should block it and
return a corresponding error code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cf43e8f9091b..d68f5bbf3e93 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4354,6 +4354,9 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
 	if (!iommu)
 		return -ENODEV;
 
+	if (dmar_domain->force_snooping && !ecap_sc_support(iommu->ecap))
+		return -EOPNOTSUPP;
+
 	/* check if this iommu agaw is sufficient for max mapped address */
 	addr_width = agaw_to_width(iommu->agaw);
 	if (addr_width > cap_mgaw(iommu->cap))
-- 
2.25.1

