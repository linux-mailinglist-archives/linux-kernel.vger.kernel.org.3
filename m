Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAB651B518
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiEEBOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbiEEBOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:14:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790023BEE
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651713019; x=1683249019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XgW8rlF4IpFvJOQeR4CXpS7+6gb9RvEfOiJoKHKujHw=;
  b=EQogdNyNieyjnnc1G7R1DhWjdrBta38PONpTUzvy3ugsMWo7roy7ZWat
   FbbgGavzpu02YXNkt3u3eXudS1DOOMPd9yszjKsCqREkyaXO2ysM9pTCz
   L3Eoo4rVqA3JslmijCrY24XdHvAsLMXIUD7bH9aIk/VdMEubmxgwczRgJ
   EkeFZjujgNQSvCyIR/BudPCZBt6eEFRYUJU7kieuD/YgIzN0uGxsYtJqp
   /nlcrytgvKulGbRVAPXWcZ8dzOo66nOsIbgPxdkIWNYMrzpie3jVRlh2k
   Zi3To8DOpktcsBYxUxTQWJy2DoGj6qS2cq0knZ1v4/tcJFdblK8EKW4vO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267832615"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="267832615"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 18:10:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="708713927"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 04 May 2022 18:10:16 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 4/4] iommu/vt-d: Remove hard coding PGSNP bit in PASID entries
Date:   Thu,  5 May 2022 09:07:10 +0800
Message-Id: <20220505010710.1477739-5-baolu.lu@linux.intel.com>
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

As enforce_cache_coherency has been introduced into the iommu_domain_ops,
the kernel component which owns the iommu domain is able to opt-in its
requirement for force snooping support. The iommu driver has no need to
hard code the page snoop control bit in the PASID table entries anymore.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 41a0e3b02c79..0abfa7fc7fb0 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -710,9 +710,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pasid_set_fault_enable(pte);
 	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
 
-	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
-		pasid_set_pgsnp(pte);
-
 	/*
 	 * Since it is a second level only translation setup, we should
 	 * set SRE bit as well (addresses are expected to be GPAs).
-- 
2.25.1

