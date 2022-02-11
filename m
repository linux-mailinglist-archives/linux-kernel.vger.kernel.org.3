Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495C24B1CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 04:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344837AbiBKDHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 22:07:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbiBKDG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 22:06:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAA455A2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 19:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644548816; x=1676084816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kCYuj8MB7ATRsjZRreWhkD0/omIZjIPw2cvKPR4Oy2o=;
  b=A5q40ln5HxGHkRXUpcSpAZTOeY665L91Ax0PS4yh7NWPvG5QA908P+tb
   mhO1ZStN6UXVMyPxQ2vIawgjJgFwhwMwEq7eVH6z2CkfudWuZaaZllXut
   TNpHSgeGDaOPksgHHVFCWmw4ed4pzSH9HRHmDNMf12sDXnRSj+z5t98gF
   6mziE44EAhSfgYRQtk6uFiaqA45eJ78xQ/7mRIcrLKs9B/8S9Rv2BPu5Z
   w0Fe1VpvnUS7TPezbtid1PbdZSHgkDL7x4OVsllSSnhTV8mv8+QIKmT+G
   gpPmVRWJxCYjAjCKZQmOMdZot+zDmRt2yAo4XgaY1FmHRa7UxS0cnEmAl
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="230289516"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="230289516"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 19:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="483062833"
Received: from allen-box.sh.intel.com ([10.239.159.118])
  by orsmga003.jf.intel.com with ESMTP; 10 Feb 2022 19:06:53 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     David Airlie <airlied@linux.ie>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Nathan Myers <ncm@cantrip.org>
Cc:     Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/2] agp/intel: Use per device iommu check
Date:   Fri, 11 Feb 2022 11:05:30 +0800
Message-Id: <20220211030531.2398789-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211030531.2398789-1-baolu.lu@linux.intel.com>
References: <20220211030531.2398789-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
---
 drivers/char/agp/intel-gtt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index c53cc9868cd8..9631cbc7002e 100644
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

