Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C532507619
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355676AbiDSRKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355576AbiDSRJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8880125CE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388020; x=1681924020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3treoGF538ZRvO/T0g44eU89daYldwoSNScF2DK9tso=;
  b=c1wRbMFoUjauiQnLKrGko9zbVflt8LQ8772CGPWBWJZYRTnnV78Mj2uH
   ZlzGbZk68lBZtYIGIdiYaa23OVvjdXJ8W0Cx3nI5XOBa0yKVsLpM4zoAc
   S0hXENvWA5sVVwM2zlih+pzLgPtUC20fc2FTK5U7vciGnWbwdwkmzeY6S
   AafPy5/QHNAQ7jVpoUaTE+OWOUuVKDLnovUORjBCpkq8m2/ynxaHkpC0S
   2JmyrpxTeQCcZZABWmJCL2tvPqUrfaaxErIqMVt2Q+l0xBf87Y2xHuHA4
   iqgbQCnAOm+n+IwxcUESMuaqIUDdgCLXVEZuIIS7908AzL95bYqjk2uhK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263280356"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="263280356"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="666579647"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:54 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 05/44] mm/pkeys: Add Kconfig options for PKS
Date:   Tue, 19 Apr 2022 10:06:10 -0700
Message-Id: <20220419170649.1022246-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Consumers wishing to implement additional protections on memory pages
can use PKS.  However, PKS is only available on some architectures.

For this reason PKS code, both in the core and in the consumers, is dead
code without PKS being both available and used.

Add Kconfig options to allow for the elimination of unneeded code by
detecting architecture PKS support (ARCH_HAS_SUPERVISOR_PKEYS) and
requiring an indication of consumer need (ARCH_ENABLE_SUPERVISOR_PKEYS).

In this patch ARCH_ENABLE_SUPERVISOR_PKEYS remains off until the first
kernel consumer sets it.

Cc: "Moger, Babu" <Babu.Moger@amd.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Dave Hansen
		Don't exclude AMD, cpu supported bits will properly turn
		the feature off.
		Clarify commit message
		Depend on CPU_SUP_INTEL

Changes for V8
	Split this out to a single change patch
---
 arch/x86/Kconfig | 1 +
 mm/Kconfig       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e01002e..c53deda2ea25 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1879,6 +1879,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
+	select ARCH_HAS_SUPERVISOR_PKEYS
 	help
 	  Memory Protection Keys provides a mechanism for enforcing
 	  page-based protections, but without requiring modification of the
diff --git a/mm/Kconfig b/mm/Kconfig
index 034d87953600..29c272974aa9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -821,6 +821,10 @@ config ARCH_USES_HIGH_VMA_FLAGS
 	bool
 config ARCH_HAS_PKEYS
 	bool
+config ARCH_HAS_SUPERVISOR_PKEYS
+	bool
+config ARCH_ENABLE_SUPERVISOR_PKEYS
+	bool
 
 config PERCPU_STATS
 	bool "Collect percpu memory statistics"
-- 
2.35.1

