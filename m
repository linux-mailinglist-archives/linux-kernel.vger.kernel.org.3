Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A9C504A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 02:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbiDRAzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 20:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiDRAzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 20:55:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0737413E9E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 17:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650243168; x=1681779168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H2Zhu6AxmojQ/3lG2xTU+DXK14yEf8HftP4/0gbYFoQ=;
  b=Ri/MTgRLdI/EzXss8N1c4yZUgDf+IAP0KFXYe+yu+iqEU4zaS7ZIcFsL
   dNaZyvA216Tnz3FbzmH49+378PH9N1ozsAGSuZPeFDKNpjjmhlIoMNziK
   TECMbd1UHrZqPiHUm++6vEvzSzq7rjioTCUDb3a+SfOlM106P/HmNWB4N
   A1Xy+EdMi2QZceX2cQj28zKDYyuzLLGrP8flTi7F8q70GVLZKAv0dBQAB
   iyYM777GVEm22KZcQAwLs8B/m2703La98QXc/2/+jl0BUW/cIhYLnUqvO
   msUHtTJyjw2UIQgB00RfekcMxhNLrcu8Mbd8a/JDyTEot7Y4aekO+O/LX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="245313232"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="245313232"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 17:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="701651312"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2022 17:52:46 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v8 08/11] vfio: Remove use of vfio_group_viable()
Date:   Mon, 18 Apr 2022 08:49:57 +0800
Message-Id: <20220418005000.897664-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418005000.897664-1-baolu.lu@linux.intel.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As DMA ownership is claimed for the iommu group when a VFIO group is
added to a VFIO container, the VFIO group viability is guaranteed as long
as group->container_users > 0. Remove those unnecessary group viability
checks which are only hit when group->container_users is not zero.

The only remaining reference is in GROUP_GET_STATUS, which could be called
at any time when group fd is valid. Here we just replace the
vfio_group_viable() by directly calling IOMMU core to get viability status.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/vfio.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 56e741cbccce..8a9347f732a5 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1313,12 +1313,6 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
 	return ret;
 }
 
-static bool vfio_group_viable(struct vfio_group *group)
-{
-	return (iommu_group_for_each_dev(group->iommu_group,
-					 group, vfio_dev_viable) == 0);
-}
-
 static int vfio_group_add_container_user(struct vfio_group *group)
 {
 	if (!atomic_inc_not_zero(&group->container_users))
@@ -1328,7 +1322,7 @@ static int vfio_group_add_container_user(struct vfio_group *group)
 		atomic_dec(&group->container_users);
 		return -EPERM;
 	}
-	if (!group->container->iommu_driver || !vfio_group_viable(group)) {
+	if (!group->container->iommu_driver) {
 		atomic_dec(&group->container_users);
 		return -EINVAL;
 	}
@@ -1346,7 +1340,7 @@ static int vfio_group_get_device_fd(struct vfio_group *group, char *buf)
 	int ret = 0;
 
 	if (0 == atomic_read(&group->container_users) ||
-	    !group->container->iommu_driver || !vfio_group_viable(group))
+	    !group->container->iommu_driver)
 		return -EINVAL;
 
 	if (group->type == VFIO_NO_IOMMU && !capable(CAP_SYS_RAWIO))
@@ -1438,11 +1432,11 @@ static long vfio_group_fops_unl_ioctl(struct file *filep,
 
 		status.flags = 0;
 
-		if (vfio_group_viable(group))
-			status.flags |= VFIO_GROUP_FLAGS_VIABLE;
-
 		if (group->container)
-			status.flags |= VFIO_GROUP_FLAGS_CONTAINER_SET;
+			status.flags |= VFIO_GROUP_FLAGS_CONTAINER_SET |
+					VFIO_GROUP_FLAGS_VIABLE;
+		else if (!iommu_group_dma_owner_claimed(group->iommu_group))
+			status.flags |= VFIO_GROUP_FLAGS_VIABLE;
 
 		if (copy_to_user((void __user *)arg, &status, minsz))
 			return -EFAULT;
-- 
2.25.1

