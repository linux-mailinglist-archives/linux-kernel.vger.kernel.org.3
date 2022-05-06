Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCF651D0BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389229AbiEFFep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389203AbiEFFeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:34:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542B01C93D
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 22:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651815038; x=1683351038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ss1Py9xKSsfOz68o9vHCUmEfR+D8C1SL1jYJcqrSmD8=;
  b=mUY6qGhs97Jozf3aJ/5CogctJ77C81mKQXjIsS+p+Cw8FZ3CWlyZt6Kd
   Y4XdWRpxvrj++Tusz8E9JBZ6U9d3zOa7JIjBPyZT6RGZqV+AXn2Xo0q8a
   FgfbtJXOoPDSJbn6AKf859PMZLFtNlWXifjgwfoB9rKHA5AUNMbqamgMr
   2fvHo96BSc0qhiZ4ikiPSeuyrMVeGdbOSbXDBo/oF1qyGpLrg+p4CfW9R
   buFSmpFJdc2kQqFOPt3M/sEl+zEhWG7Ib5qlOL2Js+gu+VckPGoz1TFyY
   aY/mfmG7nNDhyJ/c1d7H1SnDqQVaTNSfo5klWMCZA4N3ogn9MNiZtIcni
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="255838473"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="255838473"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 22:30:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="695011051"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga004.jf.intel.com with ESMTP; 05 May 2022 22:30:26 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 1/4] iommu/vt-d: Block force-snoop domain attaching if no SC support
Date:   Fri,  6 May 2022 13:27:24 +0800
Message-Id: <20220506052727.1689687-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506052727.1689687-1-baolu.lu@linux.intel.com>
References: <20220506052727.1689687-1-baolu.lu@linux.intel.com>
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

