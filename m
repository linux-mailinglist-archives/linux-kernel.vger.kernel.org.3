Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3075932F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiHOQU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiHOQUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:20:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2256811153
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:20:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B19141477;
        Mon, 15 Aug 2022 09:20:33 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 78BB63F70D;
        Mon, 15 Aug 2022 09:20:31 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/16] iommu/amd: Clean up bus_set_iommu()
Date:   Mon, 15 Aug 2022 17:20:07 +0100
Message-Id: <6bcc367e8802ae5a2b2840cbe4e9661ee024e80e.1660572783.git.robin.murphy@arm.com>
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

Stop calling bus_set_iommu() since it's now unnecessary, and
garbage-collect the last remnants of amd_iommu_init_api().

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: No change

 drivers/iommu/amd/amd_iommu.h |  1 -
 drivers/iommu/amd/init.c      |  9 +--------
 drivers/iommu/amd/iommu.c     | 21 ---------------------
 3 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 84e5bb1bf01b..c160a332ce33 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -18,7 +18,6 @@ extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 extern int amd_iommu_init_devices(void);
 extern void amd_iommu_uninit_devices(void);
 extern void amd_iommu_init_notifier(void);
-extern int amd_iommu_init_api(void);
 extern void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index fdc642362c14..79e0286da6ce 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2168,20 +2168,13 @@ static int __init amd_iommu_init_pci(void)
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
 	for_each_pci_segment(pci_seg)
 		init_device_table_dma(pci_seg);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5ed9fd40d2a7..7cf532470389 100644
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
@@ -1941,25 +1939,6 @@ void amd_iommu_domain_update(struct protection_domain *domain)
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
2.36.1.dirty

