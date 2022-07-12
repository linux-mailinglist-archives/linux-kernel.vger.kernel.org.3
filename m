Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FD4570EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiGLANv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGLANo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:13:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DE1EB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584822; x=1689120822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eG1dMwRZBBGiJ/exhj5l7l6h4h7y0PvHPNn95XiHisA=;
  b=QIDcU/gbQZ69L+o2qEsZEg4jts46UjxJ0KCU0+WhrvufOM2k35iN59P+
   VrdMNPJr8rwZj4gpAi929/eM72DdiSRIkiOSqtpI7bcCa/VeVDakmuxte
   4aYfAvEbdEHqhazp0UmQz6mUnLGGfpv3fJyKHwh3K5Fpt440MpZgTNVU/
   RdvIrp57HK/tf6XIELrAlx6yEGd3YkK+ecSuNMJ0u3G5x4m0CfpgA5Bwj
   xeArJPdmM/QRMXjbRTJjuR9WuWsakIfydUhW3BNAOXIziPLOCh7MDJJkG
   YRjNnoN0hnJriCBzDQ0+iCLoaNImlwVjt/rzxD75wMTLk2IT/f4Yj63Tg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284827875"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="284827875"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445685"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:13:41 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/25] agp/intel: Use per device iommu check
Date:   Tue, 12 Jul 2022 08:08:45 +0800
Message-Id: <20220712000908.3431936-3-baolu.lu@linux.intel.com>
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

The IOMMU subsystem has already provided an interface to query whether
the IOMMU hardware is enabled for a specific device. This changes the
check from Intel specific intel_iommu_gfx_mapped (globally exported by
the Intel IOMMU driver) to probing the presence of IOMMU on a specific
device using the generic device_iommu_mapped().

This follows commit cca084692394a ("drm/i915: Use per device iommu check")
which converted drm/i915 driver to use device_iommu_mapped().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lore.kernel.org/r/20220514014322.2927339-3-baolu.lu@linux.intel.com
---
 drivers/char/agp/intel-gtt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index 79a1b65527c2..cfcb450e9b59 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -20,7 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
 #include <linux/agp_backend.h>
-#include <linux/intel-iommu.h>
+#include <linux/iommu.h>
 #include <linux/delay.h>
 #include <asm/smp.h>
 #include "agp.h"
@@ -573,18 +573,15 @@ static void intel_gtt_cleanup(void)
  */
 static inline int needs_ilk_vtd_wa(void)
 {
-#ifdef CONFIG_INTEL_IOMMU
 	const unsigned short gpu_devid = intel_private.pcidev->device;
 
-	/* Query intel_iommu to see if we need the workaround. Presumably that
-	 * was loaded first.
+	/*
+	 * Query iommu subsystem to see if we need the workaround. Presumably
+	 * that was loaded first.
 	 */
-	if ((gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_D_IG ||
-	     gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_M_IG) &&
-	     intel_iommu_gfx_mapped)
-		return 1;
-#endif
-	return 0;
+	return ((gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_D_IG ||
+		 gpu_devid == PCI_DEVICE_ID_INTEL_IRONLAKE_M_IG) &&
+		device_iommu_mapped(&intel_private.pcidev->dev));
 }
 
 static bool intel_gtt_can_wc(void)
-- 
2.25.1

