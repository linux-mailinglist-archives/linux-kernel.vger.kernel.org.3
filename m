Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019EB59330E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiHOQWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiHOQUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89E4B12AD8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42E451480;
        Mon, 15 Aug 2022 09:20:45 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 014093F70D;
        Mon, 15 Aug 2022 09:20:42 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/16] iommu/omap: Clean up bus_set_iommu()
Date:   Mon, 15 Aug 2022 17:20:14 +0100
Message-Id: <b578af8e2bf8afeccb2c2ce87c1aa38b36f01331.1660572783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1660572783.git.robin.murphy@arm.com>
References: <cover.1660572783.git.robin.murphy@arm.com>
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

Stop calling bus_set_iommu() since it's now unnecessary, and simplify
the init failure path accordingly.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: No change

 drivers/iommu/omap-iommu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d9cf2820c02e..07ee2600113c 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1776,14 +1776,8 @@ static int __init omap_iommu_init(void)
 		goto fail_driver;
 	}
 
-	ret = bus_set_iommu(&platform_bus_type, &omap_iommu_ops);
-	if (ret)
-		goto fail_bus;
-
 	return 0;
 
-fail_bus:
-	platform_driver_unregister(&omap_iommu_driver);
 fail_driver:
 	kmem_cache_destroy(iopte_cachep);
 	return ret;
-- 
2.36.1.dirty

