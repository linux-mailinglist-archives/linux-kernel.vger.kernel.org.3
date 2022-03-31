Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EF24ED9BE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiCaMlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiCaMlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:41:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA4512342E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648730369; x=1680266369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XmKh8J683Gqq7Cv+e+C+E2cSptIDor3+WScPG5+BZ1c=;
  b=i5OvNX4/nPF0CyNxVFCcEfkAJRFtCWASwO7BI8uSS+4zWcWsbGMK1A/7
   SabKC8zKtZDDuQmPUlKjc8pDwfiQ1ZakB35WoUkQZI1p/KehzABY2+Mc1
   +0VmhmwayyWt/j1jf5JLjihMssmmDIR3iqgp7jF7jXfJObF/EoTtnNGEy
   x1C1z0yiU/5JfqRMhOf3DDLaCKBKqo35R0MornDQfgQcpYii2jRTSp4ZX
   6er1PHf7O/WLPD6qVckzckV4NcjMkUmmkCQY7pdbtx4YRNoX05c+F0TOR
   vq/Nvy3KByRqzPKRJmYpX8mh+s4VxOIrj9nRv2bwxj6DT8hAjiXpqdvkp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="346266746"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="346266746"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 05:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="566447221"
Received: from linux-youquan.bj.intel.com (HELO localhost) ([10.238.155.175])
  by orsmga008.jf.intel.com with ESMTP; 31 Mar 2022 05:39:26 -0700
Date:   Thu, 31 Mar 2022 19:31:25 +0800
From:   Youquan Song <youquan.song@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Zhiquan Li <zhiquan1.li@intel.com>,
        Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH] x86/uaccess: restore get_user exception type to
 EX_TYPE_UACCESS
Message-ID: <20220331113125.GA2628@linux-youquan.bj.intel.com>
References: <20220328201748.1864491-1-tony.luck@intel.com>
 <20220330123205.GL8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330123205.GL8939@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Did you do your testing on RHEL or something daft like that?
Tested on RHEL8.x
 
> Something like the below can also work, I suppose. But please, add
> coherent comments to the extable code with useful references to the MCE
> code that does this abuse.
Here is the full fix patch depending on your suggestion. Thanks a lot!

From 3d2e44dac774d49417002136ee3b007638a85191 Mon Sep 17 00:00:00 2001
From: Zhiquan Li <zhiquan1.li@intel.com>
Date: Wed, 30 Mar 2022 21:11:06 +0800
Subject: [PATCH v2] x86/uaccess: identify get_user with new type
 EX_TYPE_UA_IMM_REG

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
the opportunity to rescue the system.

To fix it we have to add a new exception type for get_user,
EX_TYPE_UA_IMM_REG, but we do not want to miss the operation that make
reg = -EFAULT in function ex_handler_imm_reg(), so we so add a new
compound type EX_TYPE_UFAULT_REG to figure out this case, it will not
break anything. Then MCE handler can identify is as a recoverable case.

Changes v1 -> v2:
* Abandoned the solution that restoring get_user exception type to
  EX_TYPE_UACCESS and adding new flag EX_FLAG_SET_REG to set
  reg := imm additionally.

Fixes: 99641e094d6c ("x86/uaccess: Remove .fixup usage")
Cc: <stable@vger.kernel.org> # v5.17+
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/extable_fixup_types.h | 3 +++
 arch/x86/include/asm/uaccess.h             | 6 +++---
 arch/x86/kernel/cpu/mce/severity.c         | 1 +
 arch/x86/mm/extable.c                      | 1 +
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
index 503622627400..759283acb246 100644
--- a/arch/x86/include/asm/extable_fixup_types.h
+++ b/arch/x86/include/asm/extable_fixup_types.h
@@ -64,4 +64,7 @@
 #define	EX_TYPE_UCOPY_LEN4		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(4))
 #define	EX_TYPE_UCOPY_LEN8		(EX_TYPE_UCOPY_LEN | EX_DATA_IMM(8))
 
+#define	EX_TYPE_UA_IMM_REG		20 /* reg := (long)imm */
+#define	EX_TYPE_UFAULT_REG		(EX_TYPE_UA_IMM_REG | EX_DATA_IMM(-EFAULT))
+
 #endif
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index ac96f9b2d64b..2b3a4bb609fe 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -352,10 +352,10 @@ do {									\
 		     "1:	movl %[lowbits],%%eax\n"		\
 		     "2:	movl %[highbits],%%edx\n"		\
 		     "3:\n"						\
-		     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_EFAULT_REG |	\
+		     _ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_UFAULT_REG |	\
 					   EX_FLAG_CLEAR_AX_DX,		\
 					   %[errout])			\
-		     _ASM_EXTABLE_TYPE_REG(2b, 3b, EX_TYPE_EFAULT_REG |	\
+		     _ASM_EXTABLE_TYPE_REG(2b, 3b, EX_TYPE_UFAULT_REG |	\
 					   EX_FLAG_CLEAR_AX_DX,		\
 					   %[errout])			\
 		     : [errout] "=r" (retval),				\
@@ -399,7 +399,7 @@ do {									\
 	asm volatile("\n"						\
 		     "1:	mov"itype" %[umem],%[output]\n"		\
 		     "2:\n"						\
-		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG | \
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_UFAULT_REG | \
 					   EX_FLAG_CLEAR_AX,		\
 					   %[errout])			\
 		     : [errout] "=r" (err),				\
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 7aa2bda93cbb..a20bb930b322 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -286,6 +286,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	switch (fixup_type) {
 	case EX_TYPE_UACCESS:
 	case EX_TYPE_COPY:
+	case EX_TYPE_UA_IMM_REG:
 		if (!copy_user)
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index dba2197c05c3..b9bc0e7cb73e 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -210,6 +210,7 @@ int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
 		regs->sp += sizeof(long);
 		fallthrough;
 	case EX_TYPE_IMM_REG:
+	case EX_TYPE_UA_IMM_REG:
 		return ex_handler_imm_reg(e, regs, reg, imm);
 	case EX_TYPE_FAULT_SGX:
 		return ex_handler_sgx(e, regs, trapnr);
-- 
2.25.1
