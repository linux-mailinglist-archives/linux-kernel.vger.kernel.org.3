Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04FE4982FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243567AbiAXPDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:03:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:63901 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240212AbiAXPCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643036558; x=1674572558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aMt9dMQFnuWJAh9cVzkqMUEeYOnZHiNvm0HEf2p9qHU=;
  b=SxnucDkiQgUA75N32Y5DrXTWnRRHSEPDmbDzP8U8pD2imqSbgjG03DPI
   Gx9hNlRqZdtTDSdrKV9vqXRSqzx1r7G3KsROfjxrTEBxCMBZjaaH7n/QH
   zogxmbzPQE4e3NIUkwkrF4WVpGOYU8LTJUSMAu+4Wh20CDZrKy4bxfuAS
   zQcZWJQAzv9zxmpLT9fzbJW0yLG0/75qMBtY/S8iTXd5TP4N+L4t8x8r4
   HuKKq8QVKirgfMo/mD0OyKubvauPL4hOQku2PPTRA6gDCHZthMTg0yGHa
   R/iHEHE39W2mw7+N5SZSUzB5zOdFA8GZZpe+nK/l3fRMz9xbmNLnC79HX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226734722"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226734722"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 07:02:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="562680298"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2022 07:02:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9E09CDA5; Mon, 24 Jan 2022 17:02:20 +0200 (EET)
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
Subject: [PATCHv2 27/29] ACPICA: Avoid cache flush on TDX guest
Date:   Mon, 24 Jan 2022 18:02:13 +0300
Message-Id: <20220124150215.36893-28-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

