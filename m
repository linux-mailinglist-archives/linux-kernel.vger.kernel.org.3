Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3FD4C01C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbiBVS63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiBVS6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:58:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D665D205D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645556279; x=1677092279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yfB7BEiFcDeCEeGFve1GIQOD1WyQln7kKbaZCHmlqwQ=;
  b=l6p6qt+2fOMCvrA4BXIGPJTsZTVhvb2oObbdDHJyl07aVyw/+rAIXl65
   UChJ7ObfK9v7XS9crt/tdKp9ifEh+DeUtgkDkzqFp+/+V/TbyH8lKAWZ4
   QY9pm+HvkDQZToLtF0kWvFLx3pUppwLIfXBGV4EHoO37wrc33fZPeWexc
   DdvvQ+ZUoMB+uMDgyTs4gOEOOjyRUjOnT+10z+ftsUEONr/SgwQtDOsWe
   hXSoNXME8NrfBcz1lZAuPgSqXJ7fKqg3+y+xwta2JyF7s/qfiUxP0RrDF
   BOQk8EdcngdU8xCPZXuLs7MTTyh+tpSnM/N+9F4LzCfO04pojkUVldhCj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="315013536"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="315013536"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="543044104"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2022 10:57:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5176B1ED; Tue, 22 Feb 2022 20:57:51 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/4] x86: Rename cc_platform.c to arch/x86/coco/core.c
Date:   Tue, 22 Feb 2022 21:57:38 +0300
Message-Id: <20220222185740.26228-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
References: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move cc_platform.c to the newly created arch/x86/coco. The directly is
going to be a home space for code related to confidential computing.

Intel TDX code will land here. AMD SEV code will also eventually be
moved there.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kbuild                                | 2 ++
 arch/x86/coco/Makefile                         | 6 ++++++
 arch/x86/{kernel/cc_platform.c => coco/core.c} | 0
 arch/x86/kernel/Makefile                       | 5 -----
 4 files changed, 8 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/coco/Makefile
 rename arch/x86/{kernel/cc_platform.c => coco/core.c} (100%)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f384cb1a4f7a..5a83da703e87 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ARCH_HAS_CC_PLATFORM) += coco/
+
 obj-y += entry/
 
 obj-$(CONFIG_PERF_EVENTS) += events/
diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
new file mode 100644
index 000000000000..c1ead00017a7
--- /dev/null
+++ b/arch/x86/coco/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS_REMOVE_core.o	= -pg
+KASAN_SANITIZE_core.o	:= n
+CFLAGS_core.o		+= -fno-stack-protector
+
+obj-y += core.o
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/coco/core.c
similarity index 100%
rename from arch/x86/kernel/cc_platform.c
rename to arch/x86/coco/core.c
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 6aef9ee28a39..6462e3dd98f4 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -21,7 +21,6 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
-CFLAGS_REMOVE_cc_platform.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
@@ -30,7 +29,6 @@ KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
 KASAN_SANITIZE_sev.o					:= n
-KASAN_SANITIZE_cc_platform.o				:= n
 
 # With some compiler versions the generated code results in boot hangs, caused
 # by several compilation units. To be safe, disable all instrumentation.
@@ -49,7 +47,6 @@ endif
 KCOV_INSTRUMENT		:= n
 
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
-CFLAGS_cc_platform.o	+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
@@ -151,8 +148,6 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
-obj-$(CONFIG_ARCH_HAS_CC_PLATFORM)	+= cc_platform.o
-
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
-- 
2.34.1

