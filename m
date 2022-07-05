Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF89B567542
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiGERJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiGERJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:09:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AED61F2E7;
        Tue,  5 Jul 2022 10:09:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 717221595;
        Tue,  5 Jul 2022 10:09:01 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90A0B3F66F;
        Tue,  5 Jul 2022 10:08:59 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/15] iommu/ipmmu-vmsa: Clean up bus_set_iommu()
Date:   Tue,  5 Jul 2022 18:08:33 +0100
Message-Id: <52d6d0ce3b2d51a67bd9d9fa6f41fd87ab28f417.1657034828.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1657034827.git.robin.murphy@arm.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
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

Stop calling bus_set_iommu() since it's now unnecessary. This also
leaves the custom initcall effectively doing nothing but register
the driver, which no longer needs to happen early either, so convert
it to builtin_platform_driver().

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v3: No change

 drivers/iommu/ipmmu-vmsa.c | 35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 8fdb84b3642b..2549d32f0ddd 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1090,11 +1090,6 @@ static int ipmmu_probe(struct platform_device *pdev)
 		ret = iommu_device_register(&mmu->iommu, &ipmmu_ops, &pdev->dev);
 		if (ret)
 			return ret;
-
-#if defined(CONFIG_IOMMU_DMA)
-		if (!iommu_present(&platform_bus_type))
-			bus_set_iommu(&platform_bus_type, &ipmmu_ops);
-#endif
 	}
 
 	/*
@@ -1168,32 +1163,4 @@ static struct platform_driver ipmmu_driver = {
 	.probe = ipmmu_probe,
 	.remove	= ipmmu_remove,
 };
-
-static int __init ipmmu_init(void)
-{
-	struct device_node *np;
-	static bool setup_done;
-	int ret;
-
-	if (setup_done)
-		return 0;
-
-	np = of_find_matching_node(NULL, ipmmu_of_ids);
-	if (!np)
-		return 0;
-
-	of_node_put(np);
-
-	ret = platform_driver_register(&ipmmu_driver);
-	if (ret < 0)
-		return ret;
-
-#if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &ipmmu_ops);
-#endif
-
-	setup_done = true;
-	return 0;
-}
-subsys_initcall(ipmmu_init);
+builtin_platform_driver(ipmmu_driver);
-- 
2.36.1.dirty

