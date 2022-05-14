Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D52F526ECF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiENC7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiENC6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:58:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E852DD1EB
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652492802; x=1684028802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VEv3FSPSgIXzTD6OswoTPktFlXlfBLKoUGoPMD7VvYY=;
  b=OxBFZvLXwcrTcCVwe3hDaOI034nE76ZJcJIiqLaLwL4jVLTg3zrLwAeB
   in9CYpEsZDxw+C2zNU3lrWGlp7zIFlzZi2Bon9L5tH9k0rGkwMU6BbdnD
   Gqug2SmuvRkanq+UfcbEuE07rqgLMt+RqX7zbFlpbDowcUqgFjhvrgLwk
   OnAxwqeNbE/cKauFJ+vWyF35yc+3d6OBfLqNCJkeDWKpgr/Lmb0AF5y3T
   OYCvJgTjaUHTkq25VkngieOO77JguNgZ5wrwlpGGr8RnInWnIAg85DLzi
   wuhTz53XOp7UfpVXMjpqQDz44rlZLkvGYK6mycKd518Wh+dQoKYMHCpCJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="250977523"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="250977523"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 18:46:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="712630770"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:46:36 -0700
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
Subject: [PATCH 1/7] iommu/vt-d: Move trace/events/intel_iommu.h under iommu
Date:   Sat, 14 May 2022 09:43:16 +0800
Message-Id: <20220514014322.2927339-2-baolu.lu@linux.intel.com>
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

This header file is private to the Intel IOMMU driver. Move it to the
driver folder.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 .../trace/events/intel_iommu.h => drivers/iommu/intel/trace.h | 4 ++++
 drivers/iommu/intel/dmar.c                                    | 2 +-
 drivers/iommu/intel/svm.c                                     | 2 +-
 drivers/iommu/intel/trace.c                                   | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename include/trace/events/intel_iommu.h => drivers/iommu/intel/trace.h (94%)

diff --git a/include/trace/events/intel_iommu.h b/drivers/iommu/intel/trace.h
similarity index 94%
rename from include/trace/events/intel_iommu.h
rename to drivers/iommu/intel/trace.h
index e5c1ca6d16ee..25cb7f88e1a2 100644
--- a/include/trace/events/intel_iommu.h
+++ b/drivers/iommu/intel/trace.h
@@ -91,4 +91,8 @@ TRACE_EVENT(prq_report,
 #endif /* _TRACE_INTEL_IOMMU_H */
 
 /* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH ../../drivers/iommu/intel/
+#define TRACE_INCLUDE_FILE trace
 #include <trace/define_trace.h>
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 4de960834a1b..b02d72097a8c 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -31,10 +31,10 @@
 #include <linux/limits.h>
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
-#include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
 #include "perf.h"
+#include "trace.h"
 
 typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
 struct dmar_res_callback {
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7ee37d996e15..70b40d007a52 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -21,11 +21,11 @@
 #include <linux/ioasid.h>
 #include <asm/page.h>
 #include <asm/fpu/api.h>
-#include <trace/events/intel_iommu.h>
 
 #include "pasid.h"
 #include "perf.h"
 #include "../iommu-sva-lib.h"
+#include "trace.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, u32 pasid);
diff --git a/drivers/iommu/intel/trace.c b/drivers/iommu/intel/trace.c
index bfb6a6e37a88..117e626e3ea9 100644
--- a/drivers/iommu/intel/trace.c
+++ b/drivers/iommu/intel/trace.c
@@ -11,4 +11,4 @@
 #include <linux/types.h>
 
 #define CREATE_TRACE_POINTS
-#include <trace/events/intel_iommu.h>
+#include "trace.h"
-- 
2.25.1

