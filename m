Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EC14D501A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244502AbiCJRVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244487AbiCJRVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:21:39 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBE41986E6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932838; x=1678468838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=93jFsX4NWL0obNPFh5T/xV2MAM630r0feBd5fmn2ZFc=;
  b=XUQl6A3r4OUljL0x5FGnppaLm3T2Yg0ShfIZJag1LVCZ6X9N0Ko3NZY6
   6hE2Z/nvyy28SXz4/0+PX0sAqG2bda0mhDTG35G82GEsoKtqrs+UMTiqj
   TkCWwSJmtLySXMQOuUkl+lINr9Ry1yGWosquUVCIl4WHdlppLGwc9Ifvf
   8z81jUvO/uCkT9p/45UW0d0su1T+Pp+qVVTSS512Y4RDwkHo1dJQF9ZX8
   s60OAPp25UYyRFCxx7wBCuEgQBySB41jz7j74gzI0SM8dQwhs8nSyztzX
   fttn0Z8xCP9ZhERDW4eMvqetXfPC52JtDtoAg1uwWKVb6Onp+7QkT8/CU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="280050663"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="280050663"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="611815891"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:37 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 05/45] x86/fpu: Refactor arch_set_user_pkey_access()
Date:   Thu, 10 Mar 2022 09:19:39 -0800
Message-Id: <20220310172019.850939-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Update for V8:
	From Rick Edgecombe
		Change pkey type to u8
	Replace the code Peter provided in update_pkey_reg() for
	Thomas' pkey_update_pkval()
		-- https://lore.kernel.org/lkml/20200717085442.GX10769@hirez.programming.kicks-ass.net/
---
 arch/x86/include/asm/pkeys.h |  2 ++
 arch/x86/kernel/fpu/xstate.c | 22 ++++------------------
 arch/x86/mm/pkeys.c          | 16 ++++++++++++++++
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 1d5f14aff5f6..26616cbe19e2 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -131,4 +131,6 @@ static inline int vma_pkey(struct vm_area_struct *vma)
 	return (vma->vm_flags & vma_pkey_mask) >> VM_PKEY_SHIFT;
 }
 
+u32 pkey_update_pkval(u32 pkval, u8 pkey, u32 accessbits);
+
 #endif /*_ASM_X86_PKEYS_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d090867c9de3..c8a8dadd9f87 100644
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
index e1527b4619e1..7c90b2188c5f 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -193,3 +193,19 @@ static __init int setup_init_pkru(char *opt)
 	return 1;
 }
 __setup("init_pkru=", setup_init_pkru);
+
+/*
+ * Kernel users use the same flags as user space:
+ *     PKEY_DISABLE_ACCESS
+ *     PKEY_DISABLE_WRITE
+ */
+u32 pkey_update_pkval(u32 pkval, u8 pkey, u32 accessbits)
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
2.35.1

