Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67304EC48A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbiC3MmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345451AbiC3Mlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:41:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0024412A85
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XTwBOOE7oofU7cMzRA2wOyRqnagrcWB4A15r/gLqI5o=; b=dTWHAa1Df7n6g9M1LBgaeyvlI3
        J77no9jOma2r5cEV38LRBCuI9ap0G5lw43EFiQYkSogPl4y9jkeMc1RTG7kpV6EnZG01kw0LWt5Bn
        JXrjMFQ0osnsnaLSgpLs15pt4G9BNKrZeUl/aInfTWEoBch0QULhQBX9BDg6PfnV1KwfsQi/1vPZT
        ZIgVtujPIbDii8JxlY7B5JYRpqw805E7Q5ze4wKmT7JTdiORSwbS1ddAeKAQj5bsFLAQ7j7vWxkaR
        M0SSu6VYfBrkUeLo9UDmvFvtLJu1rIHTkho6QPDUxe5AA20Lix8IVaQ6dcJjTHmDsMMtfFlZ56M66
        nT+vhZ5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZXUe-001Dfi-7E; Wed, 30 Mar 2022 12:32:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE57B9866E9; Wed, 30 Mar 2022 14:32:05 +0200 (CEST)
Date:   Wed, 30 Mar 2022 14:32:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Zhiquan Li <zhiquan1.li@intel.com>,
        Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH] x86/uaccess: restore get_user exception type to
 EX_TYPE_UACCESS
Message-ID: <20220330123205.GL8939@worktop.programming.kicks-ass.net>
References: <20220328201748.1864491-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328201748.1864491-1-tony.luck@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 01:17:48PM -0700, Tony Luck wrote:
> From: Zhiquan Li <zhiquan1.li@intel.com>
> 
> 5.17.0 kernel will crash when we inject MCE by run "einj_mem_uc copyin"
> in ras-tools with CONFIG_CC_HAS_ASM_GOTO_OUTPUT != y kernel config.
> mce: [Hardware Error]: Machine check events logged
> mce: [Hardware Error]: CPU 120: Machine Check Exception: f Bank 1: bd80000000100134
> mce: [Hardware Error]: RIP 10: {fault_in_readable+0x9f/0xd0}
> mce: [Hardware Error]: TSC 63d3fa6181b69 ADDR f921f31400 MISC 86 PPIN 11a090eb80bf0c9c
> mce: [Hardware Error]: PROCESSOR 0:606a6 TIME 1647365323 SOCKET 1 APIC 8d microcode d0002e0
> mce: [Hardware Error]: Run the above through 'mcelog --ascii'
> mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
> Kernel panic - not syncing: Fatal local machine check
> 
> In commit 99641e094d6c ("x86/uaccess: Remove .fixup usage"), the
> exception type of get_user was changed from EX_TYPE_UACCESS to
> EX_TYPE_EFAULT_REG. In case of MCE/SRAR when kernel copy data from user,
> the MCE handler identities the exception type with EX_TYPE_UACCESS to
> MCE_IN_KERNEL_RECOV. While the new type EX_TYPE_EFAULT_REG will lose
> lose the opportunity to rescue the system.

This would've been ever so much more useful if it would've explained
where this magic happens.... also *urgh*.

So basically the MCE handler is doing a extable lookup on the sly to
figure out if the instruction did a user-access ? Why isn't there a
comment along with the exception crap that explains this?

Is this really the only UACCESS I lost in all that rework?

Also, MCE handler could decode the instruction and look at register
content to determine if a userspace address was involved.

> This patch works ... but to test it I had to fake out init/Kconfig so
> that it wouldn't set CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y. So it seems that
> this is only needed when building with some old compiler version.

Did you do your testing on RHEL or something daft like that?

> With Linus' announcement about C99/C11 as new basis, is this fix
> needed? I.e. is it still valid to build the upstream kernel with a
> compiler that doesn't grok CONFIG_CC_HAS_ASM_GOTO_OUTPUT?

Sadly, yes, ASM_GOTO_OUTPUT is gcc-11, while we still support gcc-5.1 or
something ancient like that.

>  arch/x86/include/asm/extable_fixup_types.h |  1 +
>  arch/x86/include/asm/uaccess.h             | 15 +++++++++------
>  arch/x86/mm/extable.c                      |  8 ++++++++
>  3 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
> index 503622627400..329eeebba2f6 100644
> --- a/arch/x86/include/asm/extable_fixup_types.h
> +++ b/arch/x86/include/asm/extable_fixup_types.h
> @@ -30,6 +30,7 @@
>  #define EX_FLAG_CLEAR_AX		EX_DATA_FLAG(1)
>  #define EX_FLAG_CLEAR_DX		EX_DATA_FLAG(2)
>  #define EX_FLAG_CLEAR_AX_DX		EX_DATA_FLAG(3)
> +#define EX_FLAG_SET_REG		EX_DATA_FLAG(4)

That's the last available flag.. :/

Something like the below can also work, I suppose. But please, add
coherent comments to the extable code with useful references to the MCE
code that does this abuse.


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
