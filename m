Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FACB49C931
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241027AbiAZL7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:59:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:38161 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241021AbiAZL7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643198357; x=1674734357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lzcd9mEtBpXKathMy3g71SKlsqfPyQg5ZNTfE2LVMKM=;
  b=IhdY+cCiVqsEr7SXAg6OarVbZTMmacPw7D829we6Bt+YS5E0XQ1RJLMf
   eCIBAvxVESY6nrtm2qkWWtYrZOUBhP5vCPFjeBvJRwRlRaF/W7N8jQPTf
   t8U+fqw4xm72hpONOP3ZD8rbVYK3iStwTuZaYRCqYzXHjWhurwR0o++80
   gDgX/a39Iq/PGz8WumNpHu6rie9Yra8qWhP8dpjwRsRLk0khcwHNDU74z
   NbzQufPGWcgSOuDxQPfO8SOzduptoegcf1+HrIR1CkjyscvRY3l9BsLCV
   /RS9ITc6ItQbxZIZ/dpyL1Blins4pvBzgoBiL1uv80bVW0V4rULRHDf4h
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="309849135"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="309849135"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 03:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="628284145"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 26 Jan 2022 03:59:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7DAE4167; Wed, 26 Jan 2022 13:59:27 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     x86@kernel.org, thomas.lendacky@amd.com, lkp@intel.com,
        ak@linux.intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, tony.luck@intel.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/mm: Fix warning on build with X86_MEM_ENCRYPT=y
Date:   Wed, 26 Jan 2022 14:59:19 +0300
Message-Id: <20220126115919.7691-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202201261113.3P3URW2n-lkp@intel.com>
References: <202201261113.3P3URW2n-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, AMD_MEM_ENCRYPT is the only user of X86_MEM_ENCRYPT. TDX will be
the second. It will make mem_encrypt.c build without AMD_MEM_ENCRYPT,
which triggers a warning:

arch/x86/mm/mem_encrypt.c:69:13: warning: no previous prototype for
	function 'mem_encrypt_init' [-Wmissing-prototypes]

Fix it by moving mem_encrypt_init() declaration outside of #ifdef
CONFIG_AMD_MEM_ENCRYPT.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: 20f07a044a76 ("x86/sev: Move common memory encryption code to mem_encrypt.c")
---
 arch/x86/include/asm/mem_encrypt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index e2c6f433ed10..88ceaf3648b3 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -49,9 +49,6 @@ void __init early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages,
 
 void __init mem_encrypt_free_decrypted_mem(void);
 
-/* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void);
-
 void __init sev_es_init_vc_handling(void);
 
 #define __bss_decrypted __section(".bss..decrypted")
@@ -89,6 +86,9 @@ static inline void mem_encrypt_free_decrypted_mem(void) { }
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
+/* Architecture __weak replacement functions */
+void __init mem_encrypt_init(void);
+
 /*
  * The __sme_pa() and __sme_pa_nodebug() macros are meant for use when
  * writing to or comparing values from the cr3 register.  Having the
-- 
2.34.1

