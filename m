Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C471949E963
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbiA0Rzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:65462 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244552AbiA0RzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306116; x=1674842116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=whd0rbHsJD2wQTJItd3B2b9RjvqZN0XqO5BWc+Y0ono=;
  b=Mby0gyH6gNwDxdVlS03ginNmOrW2vKAk+EVcbX5ZKRzOZBo5k7HDTnUU
   pAcmSiVPkPfGHIbBZBTZk9gh8iQj+E65hyWlubHo9GWAitEEAGj8eRQCj
   RSQ3P9xcQ5PUomizIsKMR97gxTXzPplLPeKhjhOGaoSClHESk4mZ3W9Z6
   rHUMIj8c76f4HdsSbGZWKPVYUzVms70Y8Jw5F4RfSkL4yw0wG8gop0Bep
   +9QjCk5/8F64zsatvef7bd6zjr3l+rigII9o2vg3j2n2pkF+55/e1n5Ib
   y79s4Bt2EbGNQF2njkneH2hPM9jCefnhAaZrTmQZMjsbATIBbcOR6A+ss
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899120"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899120"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796057"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:07 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 05/44] x86/fpu: Refactor arch_set_user_pkey_access()
Date:   Thu, 27 Jan 2022 09:54:26 -0800
Message-Id: <20220127175505.851391-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Both PKU and PKS update their register values in the same way.  They can
therefore share the update code.

Define a helper, pkey_update_pkval(), which will be used to support both
Protection Key User (PKU) and the new Protection Key for Supervisor
(PKS) in subsequent patches.

pkey_update_pkval() contributed by Thomas

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Update for V8:
	Replace the code Peter provided in update_pkey_reg() for
	Thomas' pkey_update_pkval()
		-- https://lore.kernel.org/lkml/20200717085442.GX10769@hirez.programming.kicks-ass.net/
---
 arch/x86/include/asm/pkeys.h |  2 ++
 arch/x86/kernel/fpu/xstate.c | 22 ++++------------------
 arch/x86/mm/pkeys.c          | 16 ++++++++++++++++
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 1d5f14aff5f6..cc4d4f552f9d 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -131,4 +131,6 @@ static inline int vma_pkey(struct vm_area_struct *vma)
 	return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
 }
 
+u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits);
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d8ddd306d225..00d059db4106 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1071,8 +1071,7 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 			      unsigned long init_val)
 {
-	u32 old_pkru, new_pkru_bits = 0;
-	int pkey_shift;
+	u32 pkru;
 
 	/*
 	 * This check implies XSAVE support.  OSPKE only gets
@@ -1089,22 +1088,9 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
 		return -EINVAL;
 
-	/* Set the bits needed in PKRU:  */
-	if (init_val & PKEY_DISABLE_ACCESS)
-		new_pkru_bits |= PKR_AD_BIT;
-	if (init_val & PKEY_DISABLE_WRITE)
-		new_pkru_bits |= PKR_WD_BIT;
-
-	/* Shift the bits in to the correct place in PKRU for pkey: */
-	pkey_shift = pkey * PKR_BITS_PER_PKEY;
-	new_pkru_bits <<= pkey_shift;
-
-	/* Get old PKRU and mask off any old bits in place: */
-	old_pkru = read_pkru();
-	old_pkru &= ~((PKR_AD_BIT|PKR_WD_BIT) << pkey_shift);
-
-	/* Write old part along with new part: */
-	write_pkru(old_pkru | new_pkru_bits);
+	pkru = read_pkru();
+	pkru = pkey_update_pkval(pkru, pkey, init_val);
+	write_pkru(pkru);
 
 	return 0;
 }
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index aa7042f272fb..cf12d8bf122b 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -190,3 +190,19 @@ static __init int setup_init_pkru(char *opt)
 	return 1;
 }
 __setup("init_pkru=", setup_init_pkru);
+
+/*
+ * Kernel users use the same flags as user space:
+ *     PKEY_DISABLE_ACCESS
+ *     PKEY_DISABLE_WRITE
+ */
+u32 pkey_update_pkval(u32 pkval, int pkey, u32 accessbits)
+{
+	int shift = pkey * PKR_BITS_PER_PKEY;
+
+	if (WARN_ON_ONCE(accessbits & ~PKEY_ACCESS_MASK))
+		accessbits &= PKEY_ACCESS_MASK;
+
+	pkval &= ~(PKEY_ACCESS_MASK << shift);
+	return pkval | accessbits << shift;
+}
-- 
2.31.1

