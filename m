Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED749E985
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245403AbiA0R5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:57:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:19415 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244803AbiA0Rzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306141; x=1674842141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m/ObHfnUjtOOeBMl3JoeXOlyP2CRjZaVHbLDfc2RsE4=;
  b=EcIYjo5Nz7rrtYAAQgR10uqPrfK+IHGLhZf9VWa9O/Wnwmsjn7ampO9H
   F/S+x48ielLNX6rEWukLWT4JtaNoxTWnOZKvK9+ZxpSSrROtJQuAJPun3
   /je2o2chzq2R0TGjj1WLQlOIwJeZXyjLIT2SuopKrwPCQaSw8xVaUI0IA
   qB+kT8yp/iU+4OwbIMuZi7wd6Tvtu2e4x99xlKHN51kYlohH1exHsfLTA
   ledXDdCm1IcQlnTp20/AeHFIt+m8MG6SVLamGUKusWCgeiDtBT2u6VvVi
   qM94+Fh5tdZpxjMAVWe5LMIQZJbSA+rF39K25UI1y1x4vjzvNGjgGxWgw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302450"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302450"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796165"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:12 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 32/44] memremap_pages: Add Kconfig for DEVMAP_ACCESS_PROTECTION
Date:   Thu, 27 Jan 2022 09:54:53 -0800
Message-Id: <20220127175505.851391-33-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The persistent memory (PMEM) driver uses the memremap_pages facility to
provide 'struct page' metadata (vmemmap) for PMEM.  Given that PMEM
capacity maybe orders of magnitude higher capacity than System RAM it
presents a large vulnerability surface to stray writes.  Unlike stray
writes to System RAM, which may result in a crash or other undesirable
behavior, stray writes to PMEM additionally are more likely to result in
permanent data loss. Reboot is not a remediation for PMEM corruption
like it is for System RAM.

Given that PMEM access from the kernel is limited to a constrained set
of locations (PMEM driver, Filesystem-DAX, and direct-I/O to a DAX
page), it is amenable to supervisor pkey protection.

Not all systems with PMEM will want additional protections.  Therefore,
add a Kconfig option for the user to configure the additional devmap
protections.

Only systems with supervisor protection keys (PKS) are able to support
this new protection so depend on ARCH_HAS_SUPERVISOR_PKEYS.
Furthermore, select ARCH_ENABLE_SUPERVISOR_PKEYS to ensure that the
architecture support is enabled if PMEM is the only use case.

Only PMEM which is advertised to the memory subsystem needs this
protection.  Therefore, the feature depends on NVDIMM_PFN.

A default of (NVDIMM_PFN && ARCH_HAS_SUPERVISOR_PKEYS) was suggested but
logically that is the same as saying default 'yes' because both
NVDIMM_PFN and ARCH_HAS_SUPERVISOR_PKEYS are required.  Therefore a
default of 'yes' is used.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Split this out from
		[PATCH V7 13/18] memremap_pages: Add access protection via supervisor Protection Keys (PKS)
---
 mm/Kconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 46f2bb15aa4e..67e0264acf7d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -776,6 +776,24 @@ config ZONE_DEVICE
 
 	  If FS_DAX is enabled, then say Y.
 
+config DEVMAP_ACCESS_PROTECTION
+	bool "Access protection for memremap_pages()"
+	depends on NVDIMM_PFN
+	depends on ARCH_HAS_SUPERVISOR_PKEYS
+	select ARCH_ENABLE_SUPERVISOR_PKEYS
+	default y
+
+	help
+	  Enable extra protections on device memory.  This protects against
+	  unintended access to devices such as a stray writes.  This feature is
+	  particularly useful to protect against corruption of persistent
+	  memory.
+
+	  This depends on architecture support of supervisor PKeys and has no
+	  overhead if the architecture does not support them.
+
+	  If you have persistent memory say 'Y'.
+
 config DEV_PAGEMAP_OPS
 	bool
 
-- 
2.31.1

