Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D32A507612
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355617AbiDSRJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355515AbiDSRJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A2F2AF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388016; x=1681924016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ve/4jZtTUjdgGjXgqqd9l88h+YQVxKChCdKoifAV604=;
  b=dJiSPti57wzMt2LeuZt/rUwDpAkfl3rRLeozQJ00L5GHH4dPZDq+MuMP
   WikST/I8o5lnLWT1ALaEnkF7toqV6vi6Rye/xOBxrjobOaAhvefz3FQ7D
   l/X6ELVEcrWKjW64/yYzc2yaVyia4jXUN2AlFc1HBVpEWu6+KOEg9GLsW
   EdLYRNrersqAYqtt0saCC82HF2MG0iK/WxKWpZwNVnCTisjw0ww1DmSz8
   y1IAE0yJNorZu/lWBlrkY/pkrDshiZLxaFbFH8xH99uQw37AVF6Z/ysG9
   gPZRtHnvxRSPNZ52HF37G00UHdJxi/p9R2COv2G9NI6VaahabxjOs7ysd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="350267544"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="350267544"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="625733252"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:55 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 06/44] x86/pkeys: Add PKS CPU feature bit
Date:   Tue, 19 Apr 2022 10:06:11 -0700
Message-Id: <20220419170649.1022246-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Memory Protection Keys (pkeys) provides a mechanism for enforcing
page-based protections, but without requiring modification of the page
tables when an application changes protection domains.

The supervisor support for memory protection keys is referred to as
PKS (Protection Keys Supervisor).

Add the defines for the CPU support bit and the boilerplate disable
infrastructure predicated on the new ARCH_ENABLE_SUPERVISOR_PKEYS
Kconfig option.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Dave Hansen
		New commit message

Changes for V8
	Split this out into it's own patch
---
 arch/x86/include/asm/cpufeatures.h       | 1 +
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 73e643ae94b6..a98a9aa2b845 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -368,6 +368,7 @@
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
 #define X86_FEATURE_ENQCMD		(16*32+29) /* ENQCMD and ENQCMDS instructions */
 #define X86_FEATURE_SGX_LC		(16*32+30) /* Software Guard Extensions Launch Control */
+#define X86_FEATURE_PKS			(16*32+31) /* Protection Keys for Supervisor pages */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 1231d63f836d..cc73453bc218 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -44,6 +44,12 @@
 # define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
 #endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
 
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+# define DISABLE_PKS		0
+#else
+# define DISABLE_PKS		(1<<(X86_FEATURE_PKS & 31))
+#endif
+
 #ifdef CONFIG_X86_5LEVEL
 # define DISABLE_LA57	0
 #else
@@ -88,7 +94,7 @@
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
+			 DISABLE_ENQCMD|DISABLE_PKS)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK19	0
-- 
2.35.1

