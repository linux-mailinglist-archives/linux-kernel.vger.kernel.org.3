Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE724DA7CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiCPCNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352955AbiCPCLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:11:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4005E760
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647396615; x=1678932615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=unLt1bQdnxAfB2G6yZ+wvJG5KNuky09eVm7UrRu/Wkg=;
  b=BajA5+SUIfSnzWrntLB5qFKBBfxGf2Ju9iEg7hjAD8GmP4Zx8WyuSDEV
   SCSsRSCgASzvIa3C1iIq2YH2vX+zuvGLnyT70oFxi09uGJQA1taZUussE
   f3JFd7h25D+wiW4U64v+VAtmGLVSbD1kp5XR5qKu3yxb5+rIYnjLytt2Y
   QrSgjvp0cbzVwOZIHqXPc90BkZMOA3RwckxgVffII/s8LC2tlUoTltq+S
   XtNySVZNjKutFbmK7PCp/Myb4pahfdGn9a+8RLrC1QhjMnWHelRz9Pyd+
   99j78hl1qsizDx6TwtKDZFiy+dIUnArcAkQnwrwq2Ln2OeAq7WUBmKpnt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342898593"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="342898593"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="646462117"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2022 19:10:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0BC6AEF6; Wed, 16 Mar 2022 04:10:11 +0200 (EET)
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
Subject: [PATCHv6 29/30] ACPICA: Avoid cache flush inside virtual machines
Date:   Wed, 16 Mar 2022 05:08:55 +0300
Message-Id: <20220316020856.24435-30-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running inside virtual machine, the kernel can bypass cache
flushing. Changing sleep state in a virtual machine doesn't affect the
host system sleep state and cannot lead to data loss.

Before entering sleep states, the ACPI code flushes caches to prevent
data loss using the WBINVD instruction.  This mechanism is required on
bare metal.

But, any use WBINVD inside of a guest is worthless.  Changing sleep
state in a virtual machine doesn't affect the host system sleep state
and cannot lead to data loss, so most hypervisors simply ignore it.
Despite this, the ACPI code calls WBINVD unconditionally anyway.
It's useless, but also normally harmless.

In TDX guests, though, WBINVD stops being harmless; it triggers a
virtualization exception (#VE).  If the ACPI cache-flushing WBINVD
were left in place, TDX guests would need handling to recover from
the exception.

Avoid using WBINVD whenever running under a hypervisor.  This both
removes the useless WBINVDs and saves TDX from implementing WBINVD
handling.

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

