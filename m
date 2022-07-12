Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BDE570EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiGLAOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbiGLANs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:13:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D8ACFB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584827; x=1689120827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qHJmFrLLUxOirz4GJC/4U7xWCuECOoNr1MnGlU4dmuk=;
  b=HyKo00oqyRtzifdAUN9xpXp0+rtBPQ4LyOET9ABfjggIv/2zjzYZU6YF
   vfIZi72OPsqrPBdSvpCJsNE+rRXgLD6HaYYKD8HX1WEFBVLFB8K+otSOp
   eNC6oT2QfSUCmpsAlTuMXg3zQgPwFeTUfPWZQsbndMQwg8HRZjF+w1X5W
   13XpAxnMUoKu88ptEQQ3jGq3hWfTcdeZDJBIFEmjxgV74yLXTkTmWWDxF
   x/XUwfQ5/AF4ISQsKM91LFcyG2eFfBU4hJCh2G2TtkysxfatX4fRt4Xc1
   c3AEKcSqoXwwOxl3NQRsxwQJ/pgqkCKbl1/GcXTmyywuprkYK0ot0tP9l
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284827901"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="284827901"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:13:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445704"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:46 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/25] x86/boot/tboot: Move tboot_force_iommu() to Intel IOMMU
Date:   Tue, 12 Jul 2022 08:08:49 +0800
Message-Id: <20220712000908.3431936-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tboot_force_iommu() is only called by the Intel IOMMU driver. Move the
helper into that driver. No functional change intended.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220514014322.2927339-7-baolu.lu@linux.intel.com
---
 include/linux/tboot.h       |  2 --
 arch/x86/kernel/tboot.c     | 15 ---------------
 drivers/iommu/intel/iommu.c | 14 ++++++++++++++
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/include/linux/tboot.h b/include/linux/tboot.h
index 5146d2574e85..d2279160ef39 100644
--- a/include/linux/tboot.h
+++ b/include/linux/tboot.h
@@ -126,7 +126,6 @@ extern void tboot_probe(void);
 extern void tboot_shutdown(u32 shutdown_type);
 extern struct acpi_table_header *tboot_get_dmar_table(
 				      struct acpi_table_header *dmar_tbl);
-extern int tboot_force_iommu(void);
 
 #else
 
@@ -136,7 +135,6 @@ extern int tboot_force_iommu(void);
 #define tboot_sleep(sleep_state, pm1a_control, pm1b_control)	\
 					do { } while (0)
 #define tboot_get_dmar_table(dmar_tbl)	(dmar_tbl)
-#define tboot_force_iommu()		0
 
 #endif /* !CONFIG_INTEL_TXT */
 
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 0c1154a1c403..3bacd935f840 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2006-2009, Intel Corporation
  */
 
-#include <linux/intel-iommu.h>
 #include <linux/init_task.h>
 #include <linux/spinlock.h>
 #include <linux/export.h>
@@ -516,17 +515,3 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
 
 	return dmar_tbl;
 }
-
-int tboot_force_iommu(void)
-{
-	if (!tboot_enabled())
-		return 0;
-
-	if (no_iommu || dmar_disabled)
-		pr_warn("Forcing Intel-IOMMU to enabled\n");
-
-	dmar_disabled = 0;
-	no_iommu = 0;
-
-	return 1;
-}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6564af7ec0dd..c70948021e8e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4019,6 +4019,20 @@ static int __init probe_acpi_namespace_devices(void)
 	return 0;
 }
 
+static __init int tboot_force_iommu(void)
+{
+	if (!tboot_enabled())
+		return 0;
+
+	if (no_iommu || dmar_disabled)
+		pr_warn("Forcing Intel-IOMMU to enabled\n");
+
+	dmar_disabled = 0;
+	no_iommu = 0;
+
+	return 1;
+}
+
 int __init intel_iommu_init(void)
 {
 	int ret = -ENODEV;
-- 
2.25.1

