Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AB74D5047
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbiCJRZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244674AbiCJRWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:45 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA97199E14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932889; x=1678468889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4hjFC+NXpvEUm7/A/v2ExFQdy+qo3ARaIXPhviarIfw=;
  b=F/MR78gYzmbDdTQAmn4L9NbpfcQcPCCOY4uviuNyfucCOIPh/QGJvQmk
   iorJHjYc6+tLiRG5+QKs+b9LSREu0EX/THCHNv4DDPDe78SLAvsuDnRk/
   dYI30TtvYpZ1zNSLo9YujW+J6UMU5ZfW7P0vD177iQYEg1U1bxYrWn522
   mBepOAD6DYSUqaB53bdSqyug76lCzxMTXJhDera6j6S+dh+KDoc4vDBVq
   eqa6BbD+JeIzCSJgxbHJT9e/YfEw7fP2OE3sU6DzV4M7mAY3vcMZw0pQd
   xf/AazF6rcqcq5voRJ39IWjZ6TDTZeFjgVB4+ikg4FVzV/MapJyakr1g/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255504808"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="255504808"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:36 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="514071062"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:35 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 04/45] x86/pkeys: Make PKRU macros generic
Date:   Thu, 10 Mar 2022 09:19:38 -0800
Message-Id: <20220310172019.850939-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Protection Keys User (PKU) and Protection Keys Supervisor (PKS) work in
similar fashions and can share common defines.  Specifically PKS and PKU
each have:

	1. A single control register
	2. The same number of keys
	3. The same number of bits in the register per key
	4. Access and Write disable in the same bit locations

Given the above, share all the macros that synthesize and manipulate
register values between the two features.  Share these defines by moving
them into a new header, change their names to reflect the common use,
and include the header where needed.  This mostly takes the form of
converting names from the PKU-specific "PKRU" to a user/supervisor
agnostic "PKR".

Also while editing the code remove the use of 'we' from comments being
touched.

NOTE the checkpatch errors are ignored for the init_pkru_value to
align the values in the code.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9:
	From Dave Hansen
		Add detail to commit message
		Add Ack
		s/PKR_AD_KEY/PKR_AD_MASK/

Changes from v7:
	Rebased onto latest
---
 arch/x86/include/asm/pkeys_common.h | 11 +++++++++++
 arch/x86/include/asm/pkru.h         | 20 ++++++++------------
 arch/x86/kernel/fpu/xstate.c        | 10 +++++-----
 arch/x86/mm/pkeys.c                 | 20 +++++++++-----------
 4 files changed, 33 insertions(+), 28 deletions(-)
 create mode 100644 arch/x86/include/asm/pkeys_common.h

diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
new file mode 100644
index 000000000000..359b94cdcc0c
--- /dev/null
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PKEYS_COMMON_H
+#define _ASM_X86_PKEYS_COMMON_H
+
+#define PKR_AD_BIT 0x1u
+#define PKR_WD_BIT 0x2u
+#define PKR_BITS_PER_PKEY 2
+
+#define PKR_AD_MASK(pkey)	(PKR_AD_BIT << ((pkey) * PKR_BITS_PER_PKEY))
+
+#endif /*_ASM_X86_PKEYS_COMMON_H */
diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
index 74f0a2d34ffd..06980dd42946 100644
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -3,10 +3,7 @@
 #define _ASM_X86_PKRU_H
 
 #include <asm/cpufeature.h>
-
-#define PKRU_AD_BIT 0x1u
-#define PKRU_WD_BIT 0x2u
-#define PKRU_BITS_PER_PKEY 2
+#include <asm/pkeys_common.h>
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 extern u32 init_pkru_value;
@@ -18,18 +15,17 @@ extern u32 init_pkru_value;
 
 static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
 {
-	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
-	return !(pkru & (PKRU_AD_BIT << pkru_pkey_bits));
+	int pkru_pkey_bits = pkey * PKR_BITS_PER_PKEY;
+
+	return !(pkru & (PKR_AD_BIT << pkru_pkey_bits));
 }
 
 static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
 {
-	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
-	/*
-	 * Access-disable disables writes too so we need to check
-	 * both bits here.
-	 */
-	return !(pkru & ((PKRU_AD_BIT|PKRU_WD_BIT) << pkru_pkey_bits));
+	int pkru_pkey_bits = pkey * PKR_BITS_PER_PKEY;
+
+	/* Access-disable disables writes too so check both bits here. */
+	return !(pkru & ((PKR_AD_BIT|PKR_WD_BIT) << pkru_pkey_bits));
 }
 
 static inline u32 read_pkru(void)
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 7c7824ae7862..d090867c9de3 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1089,19 +1089,19 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	if (WARN_ON_ONCE(pkey >= arch_max_pkey()))
 		return -EINVAL;
 
-	/* Set the bits we need in PKRU:  */
+	/* Set the bits needed in PKRU:  */
 	if (init_val & PKEY_DISABLE_ACCESS)
-		new_pkru_bits |= PKRU_AD_BIT;
+		new_pkru_bits |= PKR_AD_BIT;
 	if (init_val & PKEY_DISABLE_WRITE)
-		new_pkru_bits |= PKRU_WD_BIT;
+		new_pkru_bits |= PKR_WD_BIT;
 
 	/* Shift the bits in to the correct place in PKRU for pkey: */
-	pkey_shift = pkey * PKRU_BITS_PER_PKEY;
+	pkey_shift = pkey * PKR_BITS_PER_PKEY;
 	new_pkru_bits <<= pkey_shift;
 
 	/* Get old PKRU and mask off any old bits in place: */
 	old_pkru = read_pkru();
-	old_pkru &= ~((PKRU_AD_BIT|PKRU_WD_BIT) << pkey_shift);
+	old_pkru &= ~((PKR_AD_BIT|PKR_WD_BIT) << pkey_shift);
 
 	/* Write old part along with new part: */
 	write_pkru(old_pkru | new_pkru_bits);
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 7418c367e328..e1527b4619e1 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -110,22 +110,20 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey
 	return vma_pkey(vma);
 }
 
-#define PKRU_AD_MASK(pkey)	(PKRU_AD_BIT << ((pkey) * PKRU_BITS_PER_PKEY))
-
 /*
  * Make the default PKRU value (at execve() time) as restrictive
  * as possible.  This ensures that any threads clone()'d early
  * in the process's lifetime will not accidentally get access
  * to data which is pkey-protected later on.
  */
-u32 init_pkru_value = PKRU_AD_MASK( 1) | PKRU_AD_MASK( 2) |
-		      PKRU_AD_MASK( 3) | PKRU_AD_MASK( 4) |
-		      PKRU_AD_MASK( 5) | PKRU_AD_MASK( 6) |
-		      PKRU_AD_MASK( 7) | PKRU_AD_MASK( 8) |
-		      PKRU_AD_MASK( 9) | PKRU_AD_MASK(10) |
-		      PKRU_AD_MASK(11) | PKRU_AD_MASK(12) |
-		      PKRU_AD_MASK(13) | PKRU_AD_MASK(14) |
-		      PKRU_AD_MASK(15);
+u32 init_pkru_value = PKR_AD_MASK( 1) | PKR_AD_MASK( 2) |
+		      PKR_AD_MASK( 3) | PKR_AD_MASK( 4) |
+		      PKR_AD_MASK( 5) | PKR_AD_MASK( 6) |
+		      PKR_AD_MASK( 7) | PKR_AD_MASK( 8) |
+		      PKR_AD_MASK( 9) | PKR_AD_MASK(10) |
+		      PKR_AD_MASK(11) | PKR_AD_MASK(12) |
+		      PKR_AD_MASK(13) | PKR_AD_MASK(14) |
+		      PKR_AD_MASK(15);
 
 static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
@@ -158,7 +156,7 @@ static ssize_t init_pkru_write_file(struct file *file,
 	 * up immediately if someone attempts to disable access
 	 * or writes to pkey 0.
 	 */
-	if (new_init_pkru & (PKRU_AD_BIT|PKRU_WD_BIT))
+	if (new_init_pkru & (PKR_AD_BIT|PKR_WD_BIT))
 		return -EINVAL;
 
 	WRITE_ONCE(init_pkru_value, new_init_pkru);
-- 
2.35.1

