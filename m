Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEFA500DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243513AbiDNMpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243489AbiDNMpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:45:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B46948CDB1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:42:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 556F31424;
        Thu, 14 Apr 2022 05:42:54 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A88B3F70D;
        Thu, 14 Apr 2022 05:42:52 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, sven@svenpeter.dev,
        robdclark@gmail.com, m.szyprowski@samsung.com,
        baolu.lu@linux.intel.com, yong.wu@mediatek.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        zhang.lyra@gmail.com, thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] iommu/amd: Clean up bus_set_iommu()
Date:   Thu, 14 Apr 2022 13:42:32 +0100
Message-Id: <0ca792523ac9ca1a6ca63a7712aa8b9454f17e3d.1649935679.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1649935679.git.robin.murphy@arm.com>
References: <cover.1649935679.git.robin.murphy@arm.com>
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

Stop calling bus_set_iommu() since it's now unnecessary, and
garbage-collect the last remnants of amd_iommu_init_api().

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 -
 drivers/iommu/amd/init.c      |  9 +--------
 drivers/iommu/amd/iommu.c     | 21 ---------------------
 3 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1ab31074f5b3..384393ce57fb 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -18,7 +18,6 @@ extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
-extern int amd_iommu_init_api(void);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0467918bf7fd..1cb10d8b0df4 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1970,20 +1970,13 @@ static int __init amd_iommu_init_pci(void)
 	/*
 	 * Order is important here to make sure any unity map requirements are
 	 * fulfilled. The unity mappings are created and written to the device
-	 * table during the amd_iommu_init_api() call.
+	 * table during the iommu_init_pci() call.
 	 *
 	 * After that we call init_device_table_dma() to make sure any
 	 * uninitialized DTE will block DMA, and in the end we flush the caches
 	 * of all IOMMUs to make sure the changes to the device table are
 	 * active.
 	 */
-	ret = amd_iommu_init_api();
-	if (ret) {
-		pr_err("IOMMU: Failed to initialize IOMMU-API interface (error=%d)!\n",
-		       ret);
-		goto out;
-	}
-
 	init_device_table_dma();
 
 	for_each_iommu(iommu)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6366a473ef0d..c0f8a541a7d6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -11,8 +11,6 @@
 #include <linux/ratelimit.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
-#include <linux/amba/bus.h>
-#include <linux/platform_device.h>
 #include <linux/pci-ats.h>
 #include <linux/bitmap.h>
 #include <linux/slab.h>
@@ -1838,25 +1836,6 @@ void amd_iommu_domain_update(struct protection_domain *domain)
 	amd_iommu_domain_flush_complete(domain);
 }
 
-int __init amd_iommu_init_api(void)
-{
-	int err;
-
-	err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
-	if (err)
-		return err;
-#ifdef CONFIG_ARM_AMBA
-	err = bus_set_iommu(&amba_bustype, &amd_iommu_ops);
-	if (err)
-		return err;
-#endif
-	err = bus_set_iommu(&platform_bus_type, &amd_iommu_ops);
-	if (err)
-		return err;
-
-	return 0;
-}
-
 /*****************************************************************************
  *
  * The following functions belong to the exported interface of AMD IOMMU
-- 
2.28.0.dirty

