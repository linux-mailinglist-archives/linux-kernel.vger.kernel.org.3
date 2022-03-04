Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC864CDF97
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiCDVGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCDVGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:06:37 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F44DF497
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646427949; x=1677963949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y39UWfeG5t/f8koENMZSdik7oyaXSsbs1Bgp7FvTwlY=;
  b=QmEzqadHZSkha2QtZRjuMC7q8Z2di6L/1bqE7vPcqSrUffeqxsTFiumw
   WYXoBGNEBDYp97GRP0T9lO6/Ow8yCCv6ls0BMRXArfOdVCqPRTyiFnMpk
   PMrVRbLheKQVx8vK2QJYfNqobEqMJj+8ma54O7fulirxcEFbArB8lUGAj
   vKN/2ctWBlvk5EjeynLA5igi68va318iU0Z5okkLmCFTuroYCGZw0TSSs
   CPuCcOaDig29g69YtjVCRLUvmEzgEbKAWEzDsy0P5baY+XMw+0HysR/f/
   oTbWuWcnZVPmIaTngNb3hTdMsjoY5ZijLdAKNuGuCOcZN8Nv1FLY/+o5I
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="252891284"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="252891284"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 13:05:48 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="810884761"
Received: from fushengl-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.64.239])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 13:05:48 -0800
From:   ira.weiny@intel.com
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH] pkeys: Make pkey unsigned in arch_set_user_pkey_access()
Date:   Fri,  4 Mar 2022 13:05:43 -0800
Message-Id: <20220304210543.3490880-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The WARN_ON check in arch_set_user_pkey_access() in the x86 architecture
fails to check for an invalid negative value.

A simple check for less than 0 would fix this issue however, in the call
stack below arch_set_user_pkey_access() the pkey should never be
negative on any architecture.  It is always best to use correct types
when possible.  x86 only supports 16 keys while ppc supports 32, u8 is
therefore large enough for all current architectures and likely those in
the future.

Change the type of the pkey passed to arch_set_user_pkey_access() to u8.

To: Dave Hansen <dave.hansen@linux.intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/powerpc/include/asm/pkeys.h | 4 ++--
 arch/powerpc/mm/book3s64/pkeys.c | 2 +-
 arch/x86/include/asm/pkeys.h     | 4 ++--
 arch/x86/kernel/fpu/xstate.c     | 2 +-
 include/linux/pkeys.h            | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 59a2c7dbc78f..e70615a1da9b 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -143,9 +143,9 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 	return __arch_override_mprotect_pkey(vma, prot, pkey);
 }
 
-extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+extern int __arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
 				       unsigned long init_val);
-static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+static inline int arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
 					    unsigned long init_val)
 {
 	if (!mmu_has_feature(MMU_FTR_PKEY))
diff --git a/arch/powerpc/mm/book3s64/pkeys.c b/arch/powerpc/mm/book3s64/pkeys.c
index 753e62ba67af..c048467669df 100644
--- a/arch/powerpc/mm/book3s64/pkeys.c
+++ b/arch/powerpc/mm/book3s64/pkeys.c
@@ -333,7 +333,7 @@ static inline void init_iamr(int pkey, u8 init_bits)
  * Set the access rights in AMR IAMR and UAMOR registers for @pkey to that
  * specified in @init_val.
  */
-int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+int __arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
 				unsigned long init_val)
 {
 	u64 new_amr_bits = 0x0ul;
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 5292e6dfe2a7..48efb81f6cc6 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -9,7 +9,7 @@
  */
 #define arch_max_pkey() (cpu_feature_enabled(X86_FEATURE_OSPKE) ? 16 : 1)
 
-extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+extern int arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
 		unsigned long init_val);
 
 static inline bool arch_pkeys_enabled(void)
@@ -115,7 +115,7 @@ int mm_pkey_free(struct mm_struct *mm, int pkey)
 	return 0;
 }
 
-extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+extern int arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
 		unsigned long init_val);
 
 static inline int vma_pkey(struct vm_area_struct *vma)
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 7c7824ae7862..db511bec57e5 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1068,7 +1068,7 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
  * This will go out and modify PKRU register to set the access
  * rights for @pkey to @init_val.
  */
-int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+int arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
 			      unsigned long init_val)
 {
 	u32 old_pkru, new_pkru_bits = 0;
diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
index 86be8bf27b41..aa40ed2fb0fc 100644
--- a/include/linux/pkeys.h
+++ b/include/linux/pkeys.h
@@ -35,7 +35,7 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 	return -EINVAL;
 }
 
-static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+static inline int arch_set_user_pkey_access(struct task_struct *tsk, u8 pkey,
 			unsigned long init_val)
 {
 	return 0;
-- 
2.35.1

