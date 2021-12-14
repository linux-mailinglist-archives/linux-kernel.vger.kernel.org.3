Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC55E4739E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244584AbhLNA7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:59:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:21415 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244546AbhLNA7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:59:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639443579; x=1670979579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=z/ErRUKlY7D4FY0txm0LkQ3s6d6OybLiabjK2vRaL2s=;
  b=WSM2EVpoJwrq+2tTNHawm8W58Q70/wKv1a6tMfsQCmMngorqJcwwy605
   nIkgZH7fbiUQxQ6v+p9eeW6lCPWBL4BmLpPrdWLzA75h01hcV6mLxoWi8
   ixcMfF/IeY5miZ91cv5fowJozV8rdFjKAe66xVYflLl3gOZIjV1w2Md0D
   o1tE1ly8TPWNXbc+6MTAyO1t3QajCwEzz3TUyLIu/Kpf6NcGgYecyiwvs
   RijsXJAwKGFZuFJZaXwfmk0A4t9zhzVger5WvL60rppqn76qur7WcefSm
   jxDEi3H4OM6POh/F793sgttuWs/8sha6G5LlEYa0jjf1ZPfMEgaNeqceg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325139619"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="325139619"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 16:59:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505148577"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 16:59:38 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH v4 04/13] x86/asm: Add a wrapper function for the LOADIWKEY instruction
Date:   Mon, 13 Dec 2021 16:52:03 -0800
Message-Id: <20211214005212.20588-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214005212.20588-1-chang.seok.bae@intel.com>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Key Locker introduces a CPU-internal wrapping key to encode a user key to a
key handle. Then a key handle is referenced instead of the plain text key.

The new instruction loads an internal wrapping key in the
software-inaccessible CPU state. It operates only in kernel mode.

Define struct iwkey to pass the key value.

The kernel will use this function to load a new key at boot time when the
feature is enabled.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from RFC v2:
* Separate out the code as a new patch.
* Improve the usability with the new struct as an argument.
  (Dan Williams)

Note, Dan wondered if:
  WARN_ON(!irq_fpu_usable());
would be appropriate in the load_xmm_iwkey() function.
---
 arch/x86/include/asm/keylocker.h     | 25 ++++++++++++++++++++++
 arch/x86/include/asm/special_insns.h | 32 ++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 arch/x86/include/asm/keylocker.h

diff --git a/arch/x86/include/asm/keylocker.h b/arch/x86/include/asm/keylocker.h
new file mode 100644
index 000000000000..df84c83228a1
--- /dev/null
+++ b/arch/x86/include/asm/keylocker.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_KEYLOCKER_H
+#define _ASM_KEYLOCKER_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/fpu/types.h>
+
+/**
+ * struct iwkey - A temporary internal wrapping key storage.
+ * @integrity_key:	A 128-bit key to check that key handles have not
+ *			been tampered with.
+ * @encryption_key:	A 256-bit encryption key used in
+ *			wrapping/unwrapping a clear text key.
+ *
+ * This storage should be flushed immediately after loaded.
+ */
+struct iwkey {
+	struct reg_128_bit integrity_key;
+	struct reg_128_bit encryption_key[2];
+};
+
+#endif /*__ASSEMBLY__ */
+#endif /* _ASM_KEYLOCKER_H */
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 68c257a3de0d..3e50d8396ee1 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -9,6 +9,7 @@
 #include <asm/processor-flags.h>
 #include <linux/irqflags.h>
 #include <linux/jump_label.h>
+#include <asm/keylocker.h>
 
 /*
  * The compiler should not reorder volatile asm statements with respect to each
@@ -294,6 +295,37 @@ static inline int enqcmds(void __iomem *dst, const void *src)
 	return 0;
 }
 
+/**
+ * load_xmm_iwkey - Load a CPU-internal wrapping key
+ * @key:	A struct iwkey pointer.
+ *
+ * Load @key to XMMs then do LOADIWKEY. After this, flush XMM
+ * registers. Caller is responsible for kernel_cpu_begin().
+ */
+static inline void load_xmm_iwkey(struct iwkey *key)
+{
+	struct reg_128_bit zeros = { 0 };
+
+	asm volatile ("movdqu %0, %%xmm0; movdqu %1, %%xmm1; movdqu %2, %%xmm2;"
+		      :: "m"(key->integrity_key), "m"(key->encryption_key[0]),
+			 "m"(key->encryption_key[1]));
+
+	/*
+	 * LOADIWKEY %xmm1,%xmm2
+	 *
+	 * EAX and XMM0 are implicit operands. Load a key value
+	 * from XMM0-2 to a software-invisible CPU state. With zero
+	 * in EAX, CPU does not do hardware randomization and the key
+	 * backup is allowed.
+	 *
+	 * This instruction is supported by binutils >= 2.36.
+	 */
+	asm volatile (".byte 0xf3,0x0f,0x38,0xdc,0xd1" :: "a"(0));
+
+	asm volatile ("movdqu %0, %%xmm0; movdqu %0, %%xmm1; movdqu %0, %%xmm2;"
+		      :: "m"(zeros));
+}
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_X86_SPECIAL_INSNS_H */
-- 
2.17.1

