Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA91148DDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiAMSyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbiAMSys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:54:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AFBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:54:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D119B80934
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 18:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CDBC36AE9;
        Thu, 13 Jan 2022 18:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642100086;
        bh=rCUdRaTSb8GfdnHOsKtSKTzULAtvOQFjNg2WYEzRTwk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LesfkV1xdZr+v4Suvf2d4cWgd5ueBU20g7FQTLIxF+Kf0GqlHRXsxNbdfnO+jZ/Os
         /owO2w1SvI7AOykzq7dQobZKAKzOzOKEz+m5jsk2VjRqIy1Nk6daRY6IcE9ef7if4g
         DaQQvgoZE6r40ZeTkv96Pcp57Yq7BeKpfGkbByClxGjzzzIoL1cP1vDIqretb3Xmps
         08Pa6g8eP2r2UwQkFwbd3+OnceUiNLMM3Dn9lc4lFE8EFPPI9ojlNhryZ3x1guzTdH
         gRZGiods3/ing3HXFYwOjqGx/Dm1neCosdOXYliE0UpP5UOEt1g58uPRYne0SMSrC9
         xFqQXNWVCN9hg==
Message-ID: <73020277-d49f-7aae-22db-945e040a31a2@kernel.org>
Date:   Thu, 13 Jan 2022 10:54:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] x86/entry_32: Fix segment exceptions
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        kernel test robot <oliver.sang@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, lkp@intel.com
References: <20220106083523.GB32167@xsang-OptiPlex-9020>
 <Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net>
 <Yd4u2rVVSdpEpwwM@google.com>
 <Yd6zrbFBzSn3ducx@hirez.programming.kicks-ass.net> <Yd724f1Uv1GTZ+46@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <Yd724f1Uv1GTZ+46@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/22 07:42, Borislav Petkov wrote:
> On Wed, Jan 12, 2022 at 11:55:41AM +0100, Peter Zijlstra wrote:
>> Full and proper patch below. Boris, if you could merge in x86/core that
>> branch should then be ready for a pull req.
> 
> I've got this as the final version. Scream if something's wrong.

AAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHH!!!!!!!!!!!


> 
> ---
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue, 11 Jan 2022 12:11:14 +0100
> Subject: [PATCH] x86/entry_32: Fix segment exceptions
> 
> The LKP robot reported that commit in Fixes: caused a failure. Turns out
> the ldt_gdt_32 selftest turns into an infinite loop trying to clear the
> segment.
> 
> As discovered by Sean, what happens is that PARANOID_EXIT_TO_KERNEL_MODE
> in the handle_exception_return path overwrites the entry stack data with
> the task stack data, restoring the "bad" segment value.
> 
> Instead of having the exception retry the instruction, have it emulate
> the full instruction. Replace EX_TYPE_POP_ZERO with EX_TYPE_POP_REG
> which will do the equivalent of: POP %reg; MOV $imm, %reg.
> 
> In order to encode the segment registers, add them as registers 8-11 for
> 32-bit.
> 
> By setting regs->[defg]s the (nested) RESTORE_REGS will pop this value
> at the end of the exception handler and by increasing regs->sp, it will
> have skipped the stack slot.
> 
> This was debugged by Sean Christopherson <seanjc@google.com>.
> 
>   [ bp: Add EX_REG_GS too. ]
> 
> Fixes: aa93e2ad7464 ("x86/entry_32: Remove .fixup usage")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Link: https://lore.kernel.org/r/Yd1l0gInc4zRcnt/@hirez.programming.kicks-ass.net
> ---
>   arch/x86/entry/entry_32.S                  | 13 +++++++++----
>   arch/x86/include/asm/extable_fixup_types.h | 11 ++++++++++-
>   arch/x86/lib/insn-eval.c                   |  5 +++++
>   arch/x86/mm/extable.c                      | 17 +++--------------
>   4 files changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index e0a95d8a6553..a7ec22b1d06c 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -268,11 +268,16 @@
>   1:	popl	%ds
>   2:	popl	%es
>   3:	popl	%fs
> -	addl	$(4 + \pop), %esp	/* pop the unused "gs" slot */
> +4:	addl	$(4 + \pop), %esp	/* pop the unused "gs" slot */
>   	IRET_FRAME
> -	_ASM_EXTABLE_TYPE(1b, 1b, EX_TYPE_POP_ZERO)
> -	_ASM_EXTABLE_TYPE(2b, 2b, EX_TYPE_POP_ZERO)
> -	_ASM_EXTABLE_TYPE(3b, 3b, EX_TYPE_POP_ZERO)
> +
> +	/*
> +	 * There is no _ASM_EXTABLE_TYPE_REG() for ASM, however since this is
> +	 * ASM the registers are known and we can trivially hard-code them.
> +	 */
> +	_ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_POP_ZERO|EX_REG_DS)
> +	_ASM_EXTABLE_TYPE(2b, 3b, EX_TYPE_POP_ZERO|EX_REG_ES)
> +	_ASM_EXTABLE_TYPE(3b, 4b, EX_TYPE_POP_ZERO|EX_REG_FS)

Aside from POP_ZERO being a bit mystifying to a naive reader...

>   .endm
>   
>   .macro RESTORE_ALL_NMI cr3_reg:req pop=0
> diff --git a/arch/x86/include/asm/extable_fixup_types.h b/arch/x86/include/asm/extable_fixup_types.h
> index b5ab333e064a..503622627400 100644
> --- a/arch/x86/include/asm/extable_fixup_types.h
> +++ b/arch/x86/include/asm/extable_fixup_types.h
> @@ -16,9 +16,16 @@
>   #define EX_DATA_FLAG_SHIFT		12
>   #define EX_DATA_IMM_SHIFT		16
>   
> +#define EX_DATA_REG(reg)		((reg) << EX_DATA_REG_SHIFT)
>   #define EX_DATA_FLAG(flag)		((flag) << EX_DATA_FLAG_SHIFT)
>   #define EX_DATA_IMM(imm)		((imm) << EX_DATA_IMM_SHIFT)
>   
> +/* segment regs */
> +#define EX_REG_DS			EX_DATA_REG(8)
> +#define EX_REG_ES			EX_DATA_REG(9)
> +#define EX_REG_FS			EX_DATA_REG(10)

These three seem likely to work

> +#define EX_REG_GS			EX_DATA_REG(11)

But not this one.

> +
>   /* flags */
>   #define EX_FLAG_CLEAR_AX		EX_DATA_FLAG(1)
>   #define EX_FLAG_CLEAR_DX		EX_DATA_FLAG(2)
> @@ -41,7 +48,9 @@
>   #define	EX_TYPE_RDMSR_IN_MCE		13
>   #define	EX_TYPE_DEFAULT_MCE_SAFE	14
>   #define	EX_TYPE_FAULT_MCE_SAFE		15
> -#define	EX_TYPE_POP_ZERO		16
> +
> +#define	EX_TYPE_POP_REG			16 /* sp += sizeof(long) */
> +#define EX_TYPE_POP_ZERO		(EX_TYPE_POP_REG | EX_DATA_IMM(0))
>   
>   #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
>   #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_DATA_IMM(-EFAULT))
> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> index 7760d228041b..c8a962c2e653 100644
> --- a/arch/x86/lib/insn-eval.c
> +++ b/arch/x86/lib/insn-eval.c
> @@ -430,6 +430,11 @@ static const int pt_regoff[] = {
>   	offsetof(struct pt_regs, r13),
>   	offsetof(struct pt_regs, r14),
>   	offsetof(struct pt_regs, r15),
> +#else
> +	offsetof(struct pt_regs, ds),
> +	offsetof(struct pt_regs, es),
> +	offsetof(struct pt_regs, fs),
> +	offsetof(struct pt_regs, gs),

See the comment in asm/ptrace.h over gs :)

Fortunately nothing uses EX_REG_GS.  Maybe just remove all the gs bits 
and leave the rest alone?
