Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E134EA147
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344407AbiC1UTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbiC1UTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:19:36 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB48866601
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648498674; x=1680034674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=13AnzCLQQNpFk6sF3TPzOBQwQLrZXNVCBQWgv9FSbnQ=;
  b=UvzGooJq8oTB4ydHN2CTcpCKlACu80FeUdNsPkhNQ6PXl88w5BLbCd1B
   mYY8pFcZAcCKvtYDL/fEP01odIBmQXwLkh386txvfKhRDHMPqbIanMLe+
   Hil4wF2lKVeKYXPrit3AWXD5ChTDXZdc24bnWnNwpzTQ+ItLQrYOEWesR
   /J5KTKUNkClpJP6tLYtBPWhZR2qnzEIM5v2FrI/tAZqxozXnLeDXGNQ2b
   WA9pC2e5ceCSSQGP1P7LSJTDM7e8pyyzC1j50tiLDlzkUKcDp7cvQGUbK
   MNRBs0ssk3xLpJSWgl8wXnpvs83cLZMlEF4ytMvyjtn/OvyG3/gNZsi8d
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="319795127"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="319795127"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 13:17:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="518390589"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 13:17:54 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Zhiquan Li <zhiquan1.li@intel.com>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/uaccess: restore get_user exception type to EX_TYPE_UACCESS
Date:   Mon, 28 Mar 2022 13:17:48 -0700
Message-Id: <20220328201748.1864491-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiquan Li <zhiquan1.li@intel.com>

5.17.0 kernel will crash when we inject MCE by run "einj_mem_uc copyin"
in ras-tools with CONFIG_CC_HAS_ASM_GOTO_OUTPUT != y kernel config.
mce: [Hardware Error]: Machine check events logged
mce: [Hardware Error]: CPU 120: Machine Check Exception: f Bank 1: bd80000000100134
mce: [Hardware Error]: RIP 10: {fault_in_readable+0x9f/0xd0}
mce: [Hardware Error]: TSC 63d3fa6181b69 ADDR f921f31400 MISC 86 PPIN 11a090eb80bf0c9c
mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1647365323 SOCKET 1 APIC 8d microcode d0002e0
mce: [Hardware Error]: Run the above through 'mcelog --ascii'
mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
Kernel panic - not syncing: Fatal local machine check

In commit 99641e094d6c ("x86/uaccess: Remove .fixup usage"), the
exception type of get_user was changed from EX_TYPE_UACCESS to
EX_TYPE_EFAULT_REG. In case of MCE/SRAR when kernel copy data from user,
the MCE handler identities the exception type with EX_TYPE_UACCESS to
MCE_IN_KERNEL_RECOV. While the new type EX_TYPE_EFAULT_REG will lose
lose the opportunity to rescue the system.

To fix it we have to restore get_user exception type to EX_TYPE_UACCESS,
but we do not want to miss the operation that make reg = -EFAULT in
function ex_handler_imm_reg(), so we so add a new flag EX_FLAG_SET_REG
to identify this case, it will not break anything.

Fixes: 99641e094d6c ("x86/uaccess: Remove .fixup usage")
Cc: <stable@vger.kernel.org> # v5.17+
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

This patch works ... but to test it I had to fake out init/Kconfig so
that it wouldn't set CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y. So it seems that
this is only needed when building with some old compiler version.

With Linus' announcement about C99/C11 as new basis, is this fix
needed? I.e. is it still valid to build the upstream kernel with a
compiler that doesn't grok CONFIG_CC_HAS_ASM_GOTO_OUTPUT?

 arch/x86/include/asm/extable_fixup_types.h |  1 +
 arch/x86/include/asm/uaccess.h             | 15 +++++++++------
 arch/x86/mm/extable.c                      |  8 ++++++++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 503622627400..329eeebba2f6 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -30,6 +30,7 @@
 #define EX_FLAG_CLEAR_AX		EX_DATA_FLAG(1)
 #define EX_FLAG_CLEAR_DX		EX_DATA_FLAG(2)
 #define EX_FLAG_CLEAR_AX_DX		EX_DATA_FLAG(3)
+#define EX_FLAG_SET_REG		EX_DATA_FLAG(4)
 
 /* types */
 #define	EX_TYPE_NONE			 0
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index f78e2b3501a1..277f7c87ad81 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -325,11 +325,13 @@ do {									\
 		     "1:	movl %[lowbits],%%eax\n"		\
 		     "2:	movl %[highbits],%%edx\n"		\
 		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_EFAULT_REG |	\
-					   EX_FLAG_CLEAR_AX_DX,		\
+		     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_UACCESS |	\
+					   EX_DATA_IMM(-EFAULT) | \
+					   EX_FLAG_CLEAR_AX_DX | EX_FLAG_SET_REG,	\
 					   %[errout])			\
-		     _ASM_EXTABLE_TYPE_REG(2b, 3b, EX_TYPE_EFAULT_REG |	\
-					   EX_FLAG_CLEAR_AX_DX,		\
+		     _ASM_EXTABLE_TYPE_REG(2b, 3b, EX_TYPE_UACCESS |	\
+					   EX_DATA_IMM(-EFAULT) | \
+					   EX_FLAG_CLEAR_AX_DX | EX_FLAG_SET_REG,	\
 					   %[errout])			\
 		     : [errout] "=r" (retval),				\
 		       [output] "=&A"(x)				\
@@ -372,8 +374,9 @@ do {									\
 	asm volatile("\n"						\
 		     "1:	mov"itype" %[umem],%[output]\n"		\
 		     "2:\n"						\
-		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG | \
-					   EX_FLAG_CLEAR_AX,		\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_UACCESS |	\
+					   EX_DATA_IMM(-EFAULT) | \
+					   EX_FLAG_CLEAR_AX | EX_FLAG_SET_REG,		\
 					   %[errout])			\
 		     : [errout] "=r" (err),				\
 		       [output] "=a" (x)				\
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index dba2197c05c3..aac599781879 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -183,6 +183,14 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 	case EX_TYPE_FAULT_MCE_SAFE:
 		return ex_handler_fault(e, regs, trapnr);
 	case EX_TYPE_UACCESS:
+		/*
+		 * In the user access case, we might need err reg = -EFAULT, like:
+		 * _ASM_EXTABLE_TYPE_REG(from, to, EX_TYPE_UACCESS | \
+		 *                            EX_DATA_IMM(-EFAULT) | \
+		 *                            EX_FLAG_SET_REG, reg)
+		 */
+		if (e->data & EX_FLAG_SET_REG)
+			*pt_regs_nr(regs, reg) = (long)imm;
 		return ex_handler_uaccess(e, regs, trapnr);
 	case EX_TYPE_COPY:
 		return ex_handler_copy(e, regs, trapnr);
-- 
2.35.1

