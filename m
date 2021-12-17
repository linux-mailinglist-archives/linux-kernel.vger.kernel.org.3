Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A928E4796C8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhLQWCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:02:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:26506 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230488AbhLQWBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639778512; x=1671314512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=38m/Q2AQH9Kv2z7BUSt3cLQo4zzkwKxvDeDlsUIPs6Y=;
  b=fZhWndzYNf+obEbGwvxXTTQ1by0lyNl6vp9IqV7WhX6x869DgVEDyO93
   g01aTeWt60rBhO0AXiX1qdURf9MxyliqS+w0teVoRdhFno+y5Nxu60HlH
   fjyXAcxamWFR5phFcgsSXv6Ep0NZoo/lcuEJ2KkAZ7Y6cvjJJA0/5IUs9
   JHPPMR7bKx06dlLlj4/7PpaY0zi3TzpcafhKVKd510Nr8Rhw+OuEXvPc9
   jPUHkytwHYRUVlqb4rsqMeYjNgQqePRtS77Nihzo3E8Tb+Lt9rA7gwfBb
   DPgKdT4dCHwvI8+RMSFVXSA/mIkmEwApV2MEiyPGbM/XUBKGdnvRJQCvy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="237381602"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="237381602"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 14:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="506928107"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga007.jf.intel.com with ESMTP; 17 Dec 2021 14:01:51 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 09/11] x86/cpufeatures: Re-enable ENQCMD
Date:   Fri, 17 Dec 2021 22:01:34 +0000
Message-Id: <20211217220136.2762116-10-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217220136.2762116-1-fenghua.yu@intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ENQCMD is handled by #GP fix up, it can be re-enabled.

The ENQCMD feature can only be used if CONFIG_INTEL_IOMMU_SVM is set. Add
X86_FEATURE_ENQCMD to the disabled features mask as appropriate so that
cpu_feature_enabled() can be used to check the feature.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Update the commit message (Tony).

 arch/x86/include/asm/disabled-features.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 8f28fafa98b3..1231d63f836d 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -56,8 +56,11 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
-/* Force disable because it's broken beyond repair */
-#define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
+#ifdef CONFIG_INTEL_IOMMU_SVM
+# define DISABLE_ENQCMD		0
+#else
+# define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
+#endif
 
 #ifdef CONFIG_X86_SGX
 # define DISABLE_SGX	0
-- 
2.34.1

