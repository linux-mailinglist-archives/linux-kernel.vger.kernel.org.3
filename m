Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3795E516411
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345754AbiEALbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 07:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiEALbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 07:31:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D2F6D1A2
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651404466; x=1682940466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3qeW65sQDvzITMvI5ssPSJmfcPTkH+Ogq406imqFvIA=;
  b=Fog2L3pGnRB/POOojhHnEYEmjxDGIsU7aQdF3J4zBdilIwa5CBqlhwpw
   ofNLcRn4Dnf7xqP38B6Sxc+RznYVJuLh0EeE5Wmqf0uX91VHmLTohKw+n
   sdr9YvV5wY1eXFMSQYNyQx5ovoijN6xJGQf2jcPb/LOlCnWpBwDzMJvfg
   iauGY68wSzpEm++P/+AE4CbqmN/xJrrVNElFLLds5HmNhSQspaOhckpb/
   jCjrSTLhwiM4Txc7vZ9ae9RnEAbV77356Oe8P1jwJ8zvZ1p4mP7dpVc0o
   gk4g7gbJbxsPKw1Y3EDsa6MlzTcoccMRStnCwEGS7i3avI9w3dkeySU4Y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="246912703"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="246912703"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 04:27:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="545114742"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 01 May 2022 04:27:43 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>
Cc:     Jacob jun Pan <jacob.jun.pan@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/5] iommu/vt-d: Force snooping improvement
Date:   Sun,  1 May 2022 19:24:29 +0800
Message-Id: <20220501112434.874236-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Previously, the IOMMU capability of enforcing cache coherency is queried
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

Lu Baolu (5):
  iommu/vt-d: Block force-snoop domain attaching if no SC support
  iommu/vt-d: Set SNP bit only in second-level page table entries
  iommu/vt-d: Check domain force_snooping against attached devices
  iommu/vt-d: Remove domain_update_iommu_snooping()
  iommu/vt-d: Remove hard coding PGSNP bit in PASID entries

 drivers/iommu/intel/pasid.h |  3 +-
 drivers/iommu/intel/iommu.c | 92 ++++++++++++++++++++++---------------
 drivers/iommu/intel/pasid.c | 24 +++++++---
 3 files changed, 74 insertions(+), 45 deletions(-)

-- 
2.25.1

