Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DCB49E976
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245059AbiA0R4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:35 -0500
Received: from mga12.intel.com ([192.55.52.136]:65462 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244797AbiA0Rzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306132; x=1674842132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hMk3LMURScwSXrvqat2n+0LCReDi2A4lEtzX2po89nQ=;
  b=ILI/p5427iT3toT7E/iTCKDvA3tZVWowkKROGmlfIGpBJPKoN8rJCC+t
   mVp6i1b/7Ci1OJdDGdAAFbc/zjvX8BQB4v44EL+4GF2QlHMGiYCRSBmOk
   MgVL1zWfgsG5APGDvW3Cg/L7lFKwtv8b1/DiarrmE4AoqvkZ3HIeI3bZB
   Zt0/03mhlCnQL0QDrpE7KZ3j3CZwGKSK1wS6qcMf0f2H5Hw5Cfrkpkiyr
   g743vCTISrYeq+3zPuR3PCSHy2COzRORhXPXpgpPK/aRHf/nBO3RF0twM
   IL8J7KGXNw4W5yHKcv6XlCg6Q2WvYeJMRtj4wgngYw6aBzstGOI4+PNpa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899135"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899135"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796181"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:13 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 36/44] memremap_pages: Reserve a PKS PKey for eventual use by PMEM
Date:   Thu, 27 Jan 2022 09:54:57 -0800
Message-Id: <20220127175505.851391-37-ira.weiny@intel.com>
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
page), it is amenable to supervisor pkey protection.  PMEM uses the
memmap facility to map it's pages into the direct map.

Reserve a PKey for use by the memmap facility.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/pks-keys.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/pks-keys.h b/include/linux/pks-keys.h
index a3fcd8df8688..46bb9a18da5a 100644
--- a/include/linux/pks-keys.h
+++ b/include/linux/pks-keys.h
@@ -42,14 +42,16 @@
  *
  */
 enum pks_pkey_consumers {
-	PKS_KEY_DEFAULT		= 0, /* Must be 0 for default PTE values */
-	PKS_KEY_TEST		= 1,
-	PKS_KEY_NR_CONSUMERS	= 2,
+	PKS_KEY_DEFAULT			= 0, /* Must be 0 for default PTE values */
+	PKS_KEY_TEST			= 1,
+	PKS_KEY_PGMAP_PROTECTION	= 2,
+	PKS_KEY_NR_CONSUMERS		= 3,
 };
 
 #define PKS_INIT_VALUE (PKR_RW_KEY(PKS_KEY_DEFAULT)		| \
 			PKR_AD_KEY(PKS_KEY_TEST)	| \
-			PKR_AD_KEY(2)	| PKR_AD_KEY(3)		| \
+			PKR_AD_KEY(PKS_KEY_PGMAP_PROTECTION)	| \
+			PKR_AD_KEY(3)	| \
 			PKR_AD_KEY(4)	| PKR_AD_KEY(5)		| \
 			PKR_AD_KEY(6)	| PKR_AD_KEY(7)		| \
 			PKR_AD_KEY(8)	| PKR_AD_KEY(9)		| \
-- 
2.31.1

