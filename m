Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBFF526E90
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiENC7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiENC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:58:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88DC199492
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652492807; x=1684028807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wuco7zHOI8upW/toCZeZhBQ9k0tR0YA88Idt0JHdMVY=;
  b=LvVuezdvRNL14aeBxlRTemOXZfCJemHdEPDGreXaBwBWCGBEM3J3uEnp
   mBmSidITX+nPmpD8HkXbbqD9dCY0XfZ/s/lXDE9M5D8oP7JFaWkDxOyEf
   lFy69cp1j9d6K4pBiQJ34nopQVyDcX1Np+uC/wMupQmMbAqdjVXl24PiD
   UyXy95N7K8Wa4/fm25Av+LEdP4YO8/yAImJDZcv7rgPUiwKLEAUOwam1k
   GGEA03ZQkzs3PKCO/tAhcViAiF3hiBRaDaRMKEGxx2ygw4Ew2cwGD3+UP
   zK+/hu7TuiqWEiFs+B51j1nygiqL3ptX9wzI3pDgO/J+9sJkZUNxdlGq1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270581939"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270581939"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 18:46:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="712630780"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:46:42 -0700
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
Subject: [PATCH 2/7] agp/intel: Use per device iommu check
Date:   Sat, 14 May 2022 09:43:17 +0800
Message-Id: <20220514014322.2927339-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
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

