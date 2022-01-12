Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3979B48CDA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiALVVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:21:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:1421 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbiALVUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:20:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642022439; x=1673558439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=uMdyd1hrRDyMtoQYh1kBM7Wy2V/+iZZTwUP9+ypguzw=;
  b=ENZqBzDR2ng3TdNCO5NLUXe4oltU1ihT62RzJM/oZ8D8XBoriCJeoLyD
   OTno4tU1AAJXbfkRStk2NI0Qf4EhupfDDXvMThKQPU87AChThyrmCuMXL
   p9yf12VHvOGYPewRQEXkLE6SxvfRlJKyliLQOig18P6YX5LtvaaBTX3pb
   hOpAAw3oNIudd9R72kpxmhxlDPoDmdmh+25w9sWRF/bIb4+6OjRu4tAqK
   eULvHJPD1UFkQ5VQ+EpIfFw6o0nVyKd5sqFWBK4gSsw5Izci/8Ixpz+SC
   ZoPwLHao1F+pQBI0cYJRfIr5euOAK6JAsUJ9ESlpHQDaQmr4sAt3ZynP6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243810788"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="243810788"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 13:20:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529378239"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2022 13:20:38 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-crypto@vger.kernel.org, dm-devel@redhat.com,
        herbert@gondor.apana.org.au, ebiggers@kernel.org, ardb@kernel.org,
        x86@kernel.org, luto@kernel.org, tglx@linutronix.de, bp@suse.de,
        dave.hansen@linux.intel.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v5 04/12] x86/asm: Add a wrapper function for the LOADIWKEY instruction
Date:   Wed, 12 Jan 2022 13:12:50 -0800
Message-Id: <20220112211258.21115-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112211258.21115-1-chang.seok.bae@intel.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
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
* Improve the usability with the new struct as an argument. (Dan
Williams)

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

