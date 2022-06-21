Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3475535AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352233AbiFUPPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352393AbiFUPPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:15:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39E66656B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 08:14:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF2301688;
        Tue, 21 Jun 2022 08:14:38 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE5213F66F;
        Tue, 21 Jun 2022 08:14:37 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/3] iommu: Use dev_iommu_ops() for probe_finalize
Date:   Tue, 21 Jun 2022 16:14:25 +0100
Message-Id: <5fe4b0ce22f676f435d332f2b2828dc7ef848a19.1655822151.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1655822151.git.robin.murphy@arm.com>
References: <cover.1655822151.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ->probe_finalize hook only runs after ->probe_device succeeds,
so we can move that over to the new dev_iommu_ops() as well.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 847ad47a2dfd..06d6989f07f6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -272,7 +272,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 
 int iommu_probe_device(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops;
 	struct iommu_group *group;
 	int ret;
 
@@ -313,6 +313,7 @@ int iommu_probe_device(struct device *dev)
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
+	ops = dev_iommu_ops(dev);
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
 
-- 
2.36.1.dirty

