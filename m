Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019274CA81B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbiCBOaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243018AbiCBO3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:29:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF6D50E19
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646231298; x=1677767298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=la+c8iM46i+BcjimR1ZxMdTr/2Sfz8iKXvQOOPZwCk8=;
  b=I1gMbU1+rJmAEIPfWWDxxUxowmhfa3heiapkxTb1kdYQ6OZK8E3zA3Qb
   ++Fr9mLlFh+mo8jbu1FANEOaFSWLA03Ag/9Gu6WsNbm+oL/tRq7lIXbcc
   bcA6Lbs0ZJGy4ykKNArewKIHzfhAgN4D9fqWF6fuJBd9PXhwy/sG/xi8a
   46CHMgu96In3j7AwTviNMeGr5rlzuIM08Fqd86p9De5NKrGLUAvxBEVDV
   0DWFAdxwObS8iPHBceoP+itggKdvWAToroWRgWRgKKI1w2wUEPEaS1/kp
   AFi85ZJMQL+vfA0t5SUTPsaj/j6dc2/bDVwnCNJZSSBRJomCzesAWGWmi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="240824396"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="240824396"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 06:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="709524830"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2022 06:28:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 404FE647; Wed,  2 Mar 2022 16:28:13 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 29/30] ACPICA: Avoid cache flush inside virtual machines
Date:   Wed,  2 Mar 2022 17:28:05 +0300
Message-Id: <20220302142806.51844-30-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WBINVD is not supported in TDX guest and triggers #VE. There's no robust
way to emulate it. The kernel has to avoid it.

ACPI_FLUSH_CPU_CACHE() flushes caches usign WBINVD on entering sleep
states. It is required to prevent data loss.

While running inside virtual machine, the kernel can bypass cache
flushing. Changing sleep state in a virtual machine doesn't affect the
host system sleep state and cannot lead to data loss.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/acenv.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
index 9aff97f0de7f..d937c55e717e 100644
--- a/arch/x86/include/asm/acenv.h
+++ b/arch/x86/include/asm/acenv.h
@@ -13,7 +13,19 @@
 
 /* Asm macros */
 
-#define ACPI_FLUSH_CPU_CACHE()	wbinvd()
+/*
+ * ACPI_FLUSH_CPU_CACHE() flushes caches on entering sleep states.
+ * It is required to prevent data loss.
+ *
+ * While running inside virtual machine, the kernel can bypass cache flushing.
+ * Changing sleep state in a virtual machine doesn't affect the host system
+ * sleep state and cannot lead to data loss.
+ */
+#define ACPI_FLUSH_CPU_CACHE()					\
+do {								\
+	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))	\
+		wbinvd();					\
+} while (0)
 
 int __acpi_acquire_global_lock(unsigned int *lock);
 int __acpi_release_global_lock(unsigned int *lock);
-- 
2.34.1

