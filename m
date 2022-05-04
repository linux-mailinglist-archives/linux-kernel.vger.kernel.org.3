Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A75519FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349853AbiEDMnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbiEDMnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:43:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BA6E326F5
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:40:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22CDD1042;
        Wed,  4 May 2022 05:40:05 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B03A3FA50;
        Wed,  4 May 2022 05:40:04 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        Jan Stancek <jstancek@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH] iommu: Make sysfs robust for non-API groups
Date:   Wed,  4 May 2022 13:39:58 +0100
Message-Id: <86ada41986988511a8424e84746dfe9ba7f87573.1651667683.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Groups created by VFIO backends outside the core IOMMU API should never
be passed directly into the API itself, however they still expose their
standard sysfs attributes, so we can still stumble across them that way.
Take care to consider those cases before jumping into our normal
assumptions of a fully-initialised core API group.

Fixes: 3f6634d997db ("iommu: Use right way to retrieve iommu_ops")
Reported-by: Jan Stancek <jstancek@redhat.com>
Tested-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

/me has a vested interest in not going backwards on dev_iommu_ops() :)

 drivers/iommu/iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 29906bc16371..41ea2deaee03 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -510,6 +510,13 @@ int iommu_get_group_resv_regions(struct iommu_group *group,
 	list_for_each_entry(device, &group->devices, list) {
 		struct list_head dev_resv_regions;
 
+		/*
+		 * Non-API groups still expose reserved_regions in sysfs,
+		 * so filter out calls that get here that way.
+		 */
+		if (!device->dev->iommu)
+			break;
+
 		INIT_LIST_HEAD(&dev_resv_regions);
 		iommu_get_resv_regions(device->dev, &dev_resv_regions);
 		ret = iommu_insert_device_resv_regions(&dev_resv_regions, head);
@@ -2977,7 +2984,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
 
-	if (WARN_ON(!group))
+	if (WARN_ON(!group) || !group->default_domain)
 		return -EINVAL;
 
 	if (sysfs_streq(buf, "identity"))
-- 
2.35.3.dirty

