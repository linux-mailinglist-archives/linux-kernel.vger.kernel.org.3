Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23274B3FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239288AbiBNC6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:58:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237462AbiBNC6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:58:41 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA03550B16
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644807514; x=1676343514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U5LogFle85DF75CuzggC6SMHtkreQy9inDpsfSOHuaY=;
  b=M23YRmBMI0qsy2SUtOPfUqp5HlKFk0ssb9D+cKpImFGfHG8TCVGBoiPk
   zv+NOWGsbIvRk8OCsrRamSh+AC6cx4OSyfDRFNqBXniGFYCBp+BFqNPiR
   YyjWzBXfLpycF838S9V6rb5TLL5MVz8QFCjA70nEnrwn3IWZ6A09547WO
   OrUcYBE3ZRdc+bAKIVww7xmKBDG02aHI1g7MzgeDALovh19gIfChJGRpJ
   cJeGw01PEYRmyLTa6ihzcpO5zWTqy7ctzNpBz8ecfkNhQo6eMe8nC8z1S
   P4mwEo0hsINnav85ot+iIug/d7fqy1yzzTf/QygjYhW9j6ewoIO27t+LH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313280396"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="313280396"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 18:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="501514886"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 18:58:31 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 00/11] iommu/vt-d: Some Intel IOMMU cleanups
Date:   Mon, 14 Feb 2022 10:56:53 +0800
Message-Id: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

After a long time of evolution, the drivers/iommu/intel/iommu.c
becomes a bit messy. This series tries to cleanup and refactor
the driver to make it more concise.

It includes,

- Remove some unnecessary code, includes and prototypes;
- Move creating per-device driver data from domain_attach to
  device_probe callback.
- Use an array for global per-device driver data so that they
  could be searched repidly.
- Use the rculist for per-domain device driver data and remove
  the existing spinlock.
- Code style fix.

Your comments are very appreciated.

Best regards,
baolu

Change log:

v1: initial post
 - https://lore.kernel.org/linux-iommu/20220207064142.1092846-1-baolu.lu@linux.intel.com/

v2:
 - Avoid migration of large amounts of code.
 - Split the cleanup patches into separated ones for convenient code
   review.
 - This version of series is available on github:
   https://github.com/LuBaolu/intel-iommu/commits/iommu-vtd-cleanup-v2

Lu Baolu (11):
  iommu/vt-d: Remove intel_iommu::domains
  iommu/vt-d: Remove finding domain in dmar_insert_one_dev_info()
  iommu/vt-d: Remove iova_cache_get/put()
  iommu/vt-d: Remove domain and devinfo mempool
  iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
  iommu/vt-d: Remove unnecessary includes
  iommu/vt-d: Remove unnecessary prototypes
  iommu/vt-d: Fix indentation of goto labels
  iommu/vt-d: Remove commented code
  iommu/vt-d: Use xarray for global device_domain_info
  iommu/vt-d: Use rculist for per-domain device list

 include/linux/intel-iommu.h   |   6 +-
 drivers/iommu/intel/debugfs.c |  14 +-
 drivers/iommu/intel/iommu.c   | 597 +++++++++-------------------------
 drivers/iommu/intel/pasid.c   |  12 +-
 drivers/iommu/intel/svm.c     |   6 +-
 5 files changed, 165 insertions(+), 470 deletions(-)

-- 
2.25.1

