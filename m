Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1DD4739EC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbhLNA7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:59:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:21416 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244575AbhLNA7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:59:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639443580; x=1670979580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1V/dk8Rvp2t7cZ0TsHo5VqbvzAF7aweSJpF+npM/Zw4=;
  b=SlMEjkFplMRDYgqW59FAVn9h3XFPrG5AXIjQmkx4cwtdNQXeJw0lLHdT
   msqmbqO6opJkXtaiG9CxigVGZC5UuleHzOj+pKYjj/ei0gKFpn9BN1cVM
   HxKU60Ij2SONlR+x3YpLL7XR9PpbAQSuQ7arcX99u3D78TCe2bbT4ed2Q
   KQqoulEOt/A/BG4OzjmVH3PRhDU9I2AyzeRi50ODOXPOH9mB+hQofWxhS
   MOTdfVYtwLs+CmRAdMz+MGsnDNaMYXf0GpkWrOCwGqtv/mDEOEYXyosbL
   64/oG/54Rn9yuJQc0dc/LkwQJx0b2QrICYytFcyKJNsVWIoONMC8Ss7Wo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325139626"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="325139626"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 16:59:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505148585"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 16:59:39 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH v4 06/13] x86/keylocker: Define Key Locker CPUID leaf
Date:   Mon, 13 Dec 2021 16:52:05 -0800
Message-Id: <20211214005212.20588-7-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214005212.20588-1-chang.seok.bae@intel.com>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the feature-specific CPUID leaf and bits. Both Key Locker enabling
code in the x86 core and AES Key Locker code in the crypto library will
reference them.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from RFC v2:
* Separate out the code as a new patch.
---
 arch/x86/include/asm/keylocker.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
index df84c83228a1..e85dfb6c1524 100644
--- a/arch/x86/include/asm/keylocker.h
+++ b/arch/x86/include/asm/keylocker.h
@@ -5,6 +5,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bits.h>
 #include <asm/fpu/types.h>
 
 /**
@@ -21,5 +22,11 @@ struct iwkey {
 	struct reg_128_bit encryption_key[2];
 };
 
+#define KEYLOCKER_CPUID			0x019
+#define KEYLOCKER_CPUID_EAX_SUPERVISOR	BIT(0)
+#define KEYLOCKER_CPUID_EBX_AESKLE	BIT(0)
+#define KEYLOCKER_CPUID_EBX_WIDE	BIT(2)
+#define KEYLOCKER_CPUID_EBX_BACKUP	BIT(4)
+
 #endif /*__ASSEMBLY__ */
 #endif /* _ASM_KEYLOCKER_H */
-- 
2.17.1

