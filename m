Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141BD4EA734
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiC2FmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiC2FmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:42:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B52531935
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648532420; x=1680068420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hl0RI/UgCJ86U9MWOz/qKbzv7cGWyLDs3VmWUCZbxMU=;
  b=kBnlTwIM8aKiCnN+nJLuMhtMPhf/vttZSYhRjhNIRJT+6iBNebYfWROh
   GXMc5fNta7iXoPkN0GhkT3ZIC7KIM1yE85AMRiN5NdTC0S2ophsCBsQyb
   mzlpnLyuqnYisyal0wIMr7iVP4AfueMyzJpt9Xf1YAidUrZRw0HDBCbIL
   EuM+K2Zhh4YvWzmtyqRUWolhT21bqMeb4CKI9eMCTGYrKbK4KP2PS4U4h
   7QoC101Lvd9obkIzQBDg3JgG3TUCa5gBpN+OH7jA2evYvms9P0gjr26JV
   LmkOM8HIQ9eRv3+70bFpYcDKAkrnFycKB+5ROYZnxsg5FvPda26lEbviY
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259136969"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="259136969"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 22:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="694603582"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2022 22:40:16 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Date:   Tue, 29 Mar 2022 13:37:51 +0800
Message-Id: <20220329053800.3049561-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the interfaces in the IOMMU core require that only a single
kernel device driver controls the device in the IOMMU group. The
existing method is to check the device count in the IOMMU group in
the interfaces. This is unreliable because any device added to the
IOMMU group later breaks this assumption without notifying the driver
using the interface. This adds iommu_group_singleton_lockdown() that
checks the requirement and locks down the IOMMU group with only single
device driver bound.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c42ece25854..9fb8a5b4491e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -48,6 +48,7 @@ struct iommu_group {
 	struct list_head entry;
 	unsigned int owner_cnt;
 	void *owner;
+	bool singleton_lockdown;
 };
 
 struct group_device {
@@ -968,15 +969,16 @@ void iommu_group_remove_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_group_remove_device);
 
-static int iommu_group_device_count(struct iommu_group *group)
+/* Callers should hold the group->mutex. */
+static bool iommu_group_singleton_lockdown(struct iommu_group *group)
 {
-	struct group_device *entry;
-	int ret = 0;
-
-	list_for_each_entry(entry, &group->devices, list)
-		ret++;
+	if (group->owner_cnt != 1 ||
+	    group->domain != group->default_domain ||
+	    group->owner)
+		return false;
+	group->singleton_lockdown = true;
 
-	return ret;
+	return true;
 }
 
 static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
@@ -1936,7 +1938,7 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 	 */
 	mutex_lock(&group->mutex);
 	ret = -EINVAL;
-	if (iommu_group_device_count(group) != 1)
+	if (!iommu_group_singleton_lockdown(group))
 		goto out_unlock;
 
 	ret = __iommu_attach_group(domain, group);
@@ -1979,7 +1981,7 @@ void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 		return;
 
 	mutex_lock(&group->mutex);
-	if (iommu_group_device_count(group) != 1) {
+	if (!iommu_group_singleton_lockdown(group)) {
 		WARN_ON(1);
 		goto out_unlock;
 	}
@@ -2745,7 +2747,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 	 * affected by the problems that required IOMMU groups (lack of ACS
 	 * isolation, device ID aliasing and other hardware issues).
 	 */
-	if (iommu_group_device_count(group) != 1)
+	if (!iommu_group_singleton_lockdown(group))
 		goto out_unlock;
 
 	handle = ops->sva_bind(dev, mm, drvdata);
@@ -2842,7 +2844,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	 * case) that has already acquired some of the device locks and might be
 	 * waiting for T1 to release other device locks.
 	 */
-	if (iommu_group_device_count(group) != 1) {
+	if (!iommu_group_singleton_lockdown(group)) {
 		dev_err_ratelimited(prev_dev, "Cannot change default domain: Group has more than one device\n");
 		ret = -EINVAL;
 		goto out;
@@ -2975,7 +2977,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	 * 2. Get struct *dev which is needed to lock device
 	 */
 	mutex_lock(&group->mutex);
-	if (iommu_group_device_count(group) != 1) {
+	if (!iommu_group_singleton_lockdown(group)) {
 		mutex_unlock(&group->mutex);
 		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
 		return -EINVAL;
@@ -3050,6 +3052,7 @@ int iommu_device_use_default_domain(struct device *dev)
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
 		if (group->domain != group->default_domain ||
+		    group->singleton_lockdown ||
 		    group->owner) {
 			ret = -EBUSY;
 			goto unlock_out;
@@ -3084,6 +3087,9 @@ void iommu_device_unuse_default_domain(struct device *dev)
 	if (!WARN_ON(!group->owner_cnt))
 		group->owner_cnt--;
 
+	if (!group->owner_cnt)
+		group->singleton_lockdown = false;
+
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 }
-- 
2.25.1

