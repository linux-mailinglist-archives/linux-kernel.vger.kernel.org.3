Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79964AB561
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbiBGG6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357129AbiBGGoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:44:03 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 22:44:02 PST
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D33C0401C7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 22:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644216242; x=1675752242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yco+/+LynFN8oIASNk8w1jMvxVl0gBS6tYwskQzaS3g=;
  b=ElnpGqjbE+2aT/y3ODsdvkITGStceZKeigwY1hpB1lrftKzvueP0hzpo
   LSBvi3YUoqDAqMcQ2x6BLTSzOREf4yHTmhvsJr8heHvQjEJgHNQT841EH
   ci+AY7eJiNN94ATzcsTSXEpQJ8XoRihJoEPfSui4jfBs5Bc6Lu6f/Zpem
   GNjLhJv6rsWveq93oA7UFNl6tYi+L7N06gZegs/iHMuUjaJmWkZN5bZ3l
   +POQoTXkv7+uaRNZp3EGlq2coS9b6kcT+5jLCt2rGinsHK48f9/zPW3mZ
   QLXwyD950rOXhRFYynxL8mSlblvXjINkBMaJBDey69bzksqaK2dPC+NWs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273171129"
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="273171129"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 22:42:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,349,1635231600"; 
   d="scan'208";a="525020172"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 06 Feb 2022 22:42:56 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v1 00/10] iommu/vt-d: Some Intel IOMMU cleanups
Date:   Mon,  7 Feb 2022 14:41:32 +0800
Message-Id: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

After a long time of evolution, the drivers/iommu/intel/iommu.c becomes
fat and a bit messy. This series tries to cleanup and refactor the
driver to make it more concise. Your comments are very appreciated.

Best regards,
baolu

Lu Baolu (10):
  iommu/vt-d: Move DMAR specific helpers into dmar.c
  iommu/vt-d: Remove intel_iommu::domains
  iommu/vt-d: Remove finding domain in dmar_insert_one_dev_info()
  iommu/vt-d: Remove iova_cache_get/put()
  iommu/vt-d: Remove domain and devinfo mempool
  iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
  iommu/vt-d: Use an xarray for global device_domain_info
  iommu/vt-d: Use rculist for dmar_domain::devices
  iommu/vt-d: Refactor dmar_insert_one_dev_info()
  iommu/vt-d: Some cleanups in iommu.c

 include/linux/dmar.h          |   43 +-
 include/linux/intel-iommu.h   |  220 ++++++-
 drivers/iommu/intel/debugfs.c |    3 -
 drivers/iommu/intel/dmar.c    |  216 ++++++-
 drivers/iommu/intel/iommu.c   | 1109 ++++++---------------------------
 5 files changed, 650 insertions(+), 941 deletions(-)

-- 
2.25.1

