Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA175229E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbiEKCaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbiEKC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:29:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E4D21AAA1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652236183; x=1683772183;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7o08EsiH9rBqx3Xez/FIIKap6Mag0l46E+Gl2UX4hIw=;
  b=VS35aDYzeK4iL2qnl2NhGKM5VOy8SwzrsJ/sLkhB0HpGOb0VgfiB/oep
   QMR6Wn9uNgpGNJYaz0KRY2l8iwn7oUB7YpjSirK+Jf0DoBxuqkzeW0zlB
   /KYHQHZpumtOznbJQvcBaex7X9Rs1PcgPISNKD2JLE+M4fglRqCrZDKZq
   32jk2Pr+U7y8FP76vOFRUBe/CyA9id2PKE+k2OXxy0OADGJ4bECSuqN5P
   JMpmyOWGVL63TY4vuKEUlXQp1l+7NwaABf32gGBFqbQlumjHeZxiGCTf2
   X3Rj+9kKbskoB198DH7CHEpPJExkbk+lX7GpZQyKg7HO4o+FLXnHTvKCo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="355985770"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="355985770"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="636218429"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 May 2022 19:29:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3AAF1512; Wed, 11 May 2022 05:28:01 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFCv2 05/10] x86/mm: Provide untagged_addr() helper
Date:   Wed, 11 May 2022 05:27:46 +0300
Message-Id: <20220511022751.65540-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper used by the core-mm to strip tag bits and get the address to
the canonical shape. In only handles userspace addresses.

For LAM, the address gets sanitized according to the thread features.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/page_32.h |  3 +++
 arch/x86/include/asm/page_64.h | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index df42f8aa99e4..2d35059b90c1 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -15,6 +15,9 @@ extern unsigned long __phys_addr(unsigned long);
 #define __phys_addr_symbol(x)	__phys_addr(x)
 #define __phys_reloc_hide(x)	RELOC_HIDE((x), 0)
 
+#define untagged_addr(addr)	(addr)
+#define untagged_ptr(ptr)	(ptr)
+
 #ifdef CONFIG_FLATMEM
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #endif /* CONFIG_FLATMEM */
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index e9c86299b835..3a40c958b24a 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -7,6 +7,7 @@
 #ifndef __ASSEMBLY__
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
+#include <uapi/asm/prctl.h>
 
 /* duplicated to the one in bootmem.h */
 extern unsigned long max_pfn;
@@ -90,6 +91,25 @@ static __always_inline unsigned long task_size_max(void)
 }
 #endif	/* CONFIG_X86_5LEVEL */
 
+#define __untagged_addr(addr, n)	\
+	((__force __typeof__(addr))sign_extend64((__force u64)(addr), n))
+
+#define untagged_addr(addr)	({					\
+	u64 __addr = (__force u64)(addr);				\
+	if (__addr >> 63 == 0) {					\
+		if (current->thread.features & X86_THREAD_LAM_U57)	\
+			__addr &= __untagged_addr(__addr, 56);		\
+		else if (current->thread.features & X86_THREAD_LAM_U48)	\
+			__addr &= __untagged_addr(__addr, 47);		\
+	}								\
+	(__force __typeof__(addr))__addr;				\
+})
+
+#define untagged_ptr(ptr)	({					\
+	u64 __ptrval = (__force u64)(ptr);				\
+	__ptrval = untagged_addr(__ptrval);				\
+	(__force __typeof__(*(ptr)) *)__ptrval;				\
+})
 #endif	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
-- 
2.35.1

