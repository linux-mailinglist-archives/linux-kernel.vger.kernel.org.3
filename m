Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7C0526EBC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiENC6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiENC52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:57:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A53A253C
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652492836; x=1684028836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h9H5Br/N5inR8hBGkTrWQLfQT0kDOku9gguSP1OEsxA=;
  b=IhVnR980ayc/Cr3b86axBshi7VWW/0hqvbekTAC4ICQRhwKg7U8cU147
   27iViuIGAAjj7zeg+ZJsjaiwXgD1CtcQKrNUC208V8pTp6oJks8HqdWfU
   4/8siVttweixv+lwpTwKWSrIHXo+b+hWLfMu1bg0RKx+P5Y0XVOVxvDgx
   9Abw7QmFAeSdMTdNb1bKRmZ4JWifNegRU9oo/uR3u6gHkXyzkVgnuDq/7
   4oZB3+9EJBTP0Ud46hnhh3Z+KhUyEbmPG1tYjVjYCwYhunTyw6BApQ7RL
   Ols79Ak6rFzOY8QmTHPaXvU0SLKWl7Zzjx/wqhxfFfnYq8THCLOjcmp9Z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="258005813"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="258005813"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 18:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="712630839"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:47:09 -0700
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
Subject: [PATCH 7/7] iommu/vt-d: Move include/linux/intel_iommu.h under iommu
Date:   Sat, 14 May 2022 09:43:22 +0800
Message-Id: <20220514014322.2927339-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header file is private to the Intel IOMMU driver. Move it to the
driver folder.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/intel-iommu.h => drivers/iommu/intel/iommu.h | 0
 drivers/iommu/intel/trace.h                                | 3 ++-
 drivers/iommu/intel/cap_audit.c                            | 2 +-
 drivers/iommu/intel/debugfs.c                              | 2 +-
 drivers/iommu/intel/dmar.c                                 | 2 +-
 drivers/iommu/intel/iommu.c                                | 2 +-
 drivers/iommu/intel/irq_remapping.c                        | 2 +-
 drivers/iommu/intel/pasid.c                                | 2 +-
 drivers/iommu/intel/perf.c                                 | 2 +-
 drivers/iommu/intel/svm.c                                  | 2 +-
 MAINTAINERS                                                | 1 -
 11 files changed, 10 insertions(+), 10 deletions(-)
 rename include/linux/intel-iommu.h => drivers/iommu/intel/iommu.h (100%)

diff --git a/include/linux/intel-iommu.h b/drivers/iommu/intel/iommu.h
similarity index 100%
rename from include/linux/intel-iommu.h
rename to drivers/iommu/intel/iommu.h
diff --git a/drivers/iommu/intel/trace.h b/drivers/iommu/intel/trace.h
index 25cb7f88e1a2..93d96f93a89b 100644
--- a/drivers/iommu/intel/trace.h
+++ b/drivers/iommu/intel/trace.h
@@ -13,7 +13,8 @@
 #define _TRACE_INTEL_IOMMU_H
 
 #include <linux/tracepoint.h>
-#include <linux/intel-iommu.h>
+
+#include "iommu.h"
 
 #define MSG_MAX		256
 
diff --git a/drivers/iommu/intel/cap_audit.c b/drivers/iommu/intel/cap_audit.c
index 71596fc62822..3ee68393122f 100644
--- a/drivers/iommu/intel/cap_audit.c
+++ b/drivers/iommu/intel/cap_audit.c
@@ -10,7 +10,7 @@
 
 #define pr_fmt(fmt)	"DMAR: " fmt
 
-#include <linux/intel-iommu.h>
+#include "iommu.h"
 #include "cap_audit.h"
 
 static u64 intel_iommu_cap_sanity;
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index ed796eea4581..d927ef10641b 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -10,11 +10,11 @@
 
 #include <linux/debugfs.h>
 #include <linux/dmar.h>
-#include <linux/intel-iommu.h>
 #include <linux/pci.h>
 
 #include <asm/irq_remapping.h>
 
+#include "iommu.h"
 #include "pasid.h"
 #include "perf.h"
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index b02d72097a8c..059af0ef2a9d 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -19,7 +19,6 @@
 #include <linux/pci.h>
 #include <linux/dmar.h>
 #include <linux/iova.h>
-#include <linux/intel-iommu.h>
 #include <linux/timer.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -32,6 +31,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
 
+#include "iommu.h"
 #include "../irq_remapping.h"
 #include "perf.h"
 #include "trace.h"
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ea1c3bcd38d5..1af4b6562266 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -17,7 +17,6 @@
 #include <linux/dma-direct.h>
 #include <linux/dma-iommu.h>
 #include <linux/dmi.h>
-#include <linux/intel-iommu.h>
 #include <linux/intel-svm.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
@@ -26,6 +25,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/tboot.h>
 
+#include "iommu.h"
 #include "../irq_remapping.h"
 #include "../iommu-sva-lib.h"
 #include "pasid.h"
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index a67319597884..2e9683e970f8 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -10,7 +10,6 @@
 #include <linux/hpet.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
-#include <linux/intel-iommu.h>
 #include <linux/acpi.h>
 #include <linux/irqdomain.h>
 #include <linux/crash_dump.h>
@@ -21,6 +20,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/pci-direct.h>
 
+#include "iommu.h"
 #include "../irq_remapping.h"
 #include "cap_audit.h"
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index cb4c1d0cf25c..b2ac5869286f 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -12,13 +12,13 @@
 #include <linux/bitops.h>
 #include <linux/cpufeature.h>
 #include <linux/dmar.h>
-#include <linux/intel-iommu.h>
 #include <linux/iommu.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/spinlock.h>
 
+#include "iommu.h"
 #include "pasid.h"
 
 /*
diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
index 0e8e03252d92..94ee70ac38e3 100644
--- a/drivers/iommu/intel/perf.c
+++ b/drivers/iommu/intel/perf.c
@@ -9,8 +9,8 @@
  */
 
 #include <linux/spinlock.h>
-#include <linux/intel-iommu.h>
 
+#include "iommu.h"
 #include "perf.h"
 
 static DEFINE_SPINLOCK(latency_lock);
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 70b40d007a52..580713aa9e07 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -5,7 +5,6 @@
  * Authors: David Woodhouse <dwmw2@infradead.org>
  */
 
-#include <linux/intel-iommu.h>
 #include <linux/mmu_notifier.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
@@ -22,6 +21,7 @@
 #include <asm/page.h>
 #include <asm/fpu/api.h>
 
+#include "iommu.h"
 #include "pasid.h"
 #include "perf.h"
 #include "../iommu-sva-lib.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index a2095c832d84..81458c7f9a32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9870,7 +9870,6 @@ L:	iommu@lists.linux-foundation.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	drivers/iommu/intel/
-F:	include/linux/intel-iommu.h
 F:	include/linux/intel-svm.h
 
 INTEL IOP-ADMA DMA DRIVER
-- 
2.25.1

