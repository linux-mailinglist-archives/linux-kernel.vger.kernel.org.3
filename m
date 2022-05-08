Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6648E51ED84
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 14:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiEHMma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 08:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiEHMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 08:42:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD51E0FF
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652013516; x=1683549516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ss1Py9xKSsfOz68o9vHCUmEfR+D8C1SL1jYJcqrSmD8=;
  b=h5lPD25yg9pB42xAjf+6ooDujvldZoHiGTkpOiRq+SlnJTV6Hr5gE7lF
   72k0Vxb5gJFnIa2xLDQWrasYIdqyfiyQd9N02rfVov+IIs0B7J74q5XCm
   UXm3goywtoLmucCnaUAa83uyE9KWmtgCQwSaJteBepagoKM37aQNgzr8u
   M3/m4UBWjarP1X4bE52nQHsSeVZzN81bVK9NYzdS9OFaG6RgI9a1NHc+G
   hab3gA8d11Cy8UkyBNmQSQrXjWtgDSLep4R/zAZb69Ox/7Bp2aCN1lK94
   VNj8SfhCqb/YMs2ma3Akz0KNIZ0c7UoWq03phxM/25uy4Wz4/hkayy/o3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="267674807"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="267674807"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 05:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="710143729"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 08 May 2022 05:38:34 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 1/4] iommu/vt-d: Block force-snoop domain attaching if no SC support
Date:   Sun,  8 May 2022 20:35:22 +0800
Message-Id: <20220508123525.1973626-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
References: <20220508123525.1973626-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2990f80c5e08..b4802f4055a0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4367,6 +4367,9 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
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

