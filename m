Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3182D526ECE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiENC6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiENC5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:57:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D6E3A2539
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652492829; x=1684028829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v3kPt++FiQ9ARnwZa6X+VCG2cZHcHXHj7nyunngZA8s=;
  b=gVV2fmw7+XSUAA+RPpZUTwqXiqCfx28egKZIWy7WX+aHtqrVHLBEzeI1
   G7EPLf8BWZsvND16aNehslH7+rD9UKVtasrK4YoKqlIhY9KzkfmKo3NZg
   pF9dtFcte8QINLbobVbDqdBAv6a4EB+nXYghThwEbLJq5Hcses+aKgvjy
   Pz2kISGI8Hctj4XCiAfiNxo0YlhMnM3K/aXrMpLOHlGHFDzuIjvbuJTF1
   UnuilzoQks66zT1WSow783wEpIkqgLfnCjU02iK7czBKOcy7oYTfTPfoO
   ByhdmSJcehXCHo4zvBzyU9QKVG5O1fndmWGxPisOAShReD2VypTNk21Cy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270388075"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270388075"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 18:47:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="712630826"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:47:04 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ning Sun <ning.sun@intel.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 6/7] x86/boot/tboot: Move tboot_force_iommu() to Intel IOMMU
Date:   Sat, 14 May 2022 09:43:21 +0800
Message-Id: <20220514014322.2927339-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
index f9af561c3cd4..6eb9c4146f17 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -6,7 +6,6 @@
  * Copyright (c) 2006-2009, Intel Corporation
  */
 
-#include <linux/intel-iommu.h>
 #include <linux/init_task.h>
 #include <linux/spinlock.h>
 #include <linux/export.h>
@@ -517,17 +516,3 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
 
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
index 744af407d0da..ea1c3bcd38d5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4043,6 +4043,20 @@ static int __init probe_acpi_namespace_devices(void)
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

