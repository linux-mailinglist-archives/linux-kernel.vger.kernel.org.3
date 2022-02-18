Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6AC4BBD47
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiBRQSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:18:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbiBRQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406A03A5EE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201047; x=1676737047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aMt9dMQFnuWJAh9cVzkqMUEeYOnZHiNvm0HEf2p9qHU=;
  b=hPeLwVdNkRiLdmPxBsIpWST6CNQWEh58GMhWO7r/1IpTds9E4ryW3oU0
   GIgkqhuWalzD03jWfAJl5m1CN+OobftVheS1weVQFlZhYzRMfX9zQOHHR
   TZ6kts48rT76mit6zo5cqgiq+PA1rLkAVCHG0i2CDbar/EbPqcrzSy9+f
   FF7atMWAU+HW0zBzvH/0nAKKSVYCAZwzAWXbckNeiYl6hZmkCUsesr80M
   yJWCP4jAtzdFLjbvpvEp4xC1s935BMy5soGKDRpYFH06RtoX10bRFV/Z3
   RzizuDWLAXfZqFJ84icfvjrxSULquAG3gVE9COHRjEC/RePvs3eOsN0WP
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231791737"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="231791737"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="572355147"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 18 Feb 2022 08:17:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9A97210B0; Fri, 18 Feb 2022 18:17:23 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 31/32] ACPICA: Avoid cache flush on TDX guest
Date:   Fri, 18 Feb 2022 19:17:17 +0300
Message-Id: <20220218161718.67148-32-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI_FLUSH_CPU_CACHE() flushes caches on entering sleep states. It is
required to prevent data loss.

While running inside TDX guest, the kernel can bypass cache flushing.
Changing sleep state in a virtual machine doesn't affect the host system
sleep state and cannot lead to data loss.

The approach can be generalized to all guest kernels, but, to be
cautious, let's limit it to TDX for now.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/acenv.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acenv.h b/arch/x86/include/asm/acenv.h
index 9aff97f0de7f..d19deca6dd27 100644
--- a/arch/x86/include/asm/acenv.h
+++ b/arch/x86/include/asm/acenv.h
@@ -13,7 +13,21 @@
 
 /* Asm macros */
 
-#define ACPI_FLUSH_CPU_CACHE()	wbinvd()
+/*
+ * ACPI_FLUSH_CPU_CACHE() flushes caches on entering sleep states.
+ * It is required to prevent data loss.
+ *
+ * While running inside TDX guest, the kernel can bypass cache flushing.
+ * Changing sleep state in a virtual machine doesn't affect the host system
+ * sleep state and cannot lead to data loss.
+ *
+ * TODO: Is it safe to generalize this from TDX guests to all guest kernels?
+ */
+#define ACPI_FLUSH_CPU_CACHE()					\
+do {								\
+	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))	\
+		wbinvd();					\
+} while (0)
 
 int __acpi_acquire_global_lock(unsigned int *lock);
 int __acpi_release_global_lock(unsigned int *lock);
-- 
2.34.1

