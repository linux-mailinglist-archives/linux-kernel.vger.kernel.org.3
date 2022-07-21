Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE75757D4D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiGUUfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiGUUfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:35:33 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEE32CDD7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:35:30 -0700 (PDT)
Date:   Thu, 21 Jul 2022 21:35:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658435729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xf2R3DLEoWV9wiDF/EeEI67ekf5B8ETj3Ae3cglXYTQ=;
        b=LCKVjwVeX3h/LJlm5Q+ZVxAzI8OGSt1gtNMfTIM4zhBrh5K1BJZzOdYuc11fL+2sF8I9gW
        ugooAwV9bAtpkfjd76uA/0VU+Koxl64lmoPFPLAGjMAUCJI5gkk7aYlq12L+8GFShHbZOX
        KUWvcVNrv3UBsznTETFsyIURS6u06QQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, tabba@google.com, will@kernel.org,
        qperret@google.com, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, drjones@redhat.com,
        wangkefeng.wang@huawei.com, elver@google.com, keirf@google.com,
        yuzenghui@huawei.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, android-mm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v5 17/17] KVM: arm64: Introduce hyp_dump_backtrace()
Message-ID: <Ytm4ji93wyjRI7Jw@google.com>
References: <20220721055728.718573-1-kaleshsingh@google.com>
 <20220721055728.718573-18-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721055728.718573-18-kaleshsingh@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

Nifty series! Had the chance to take it for a spin :) Few comments
below:

On Wed, Jul 20, 2022 at 10:57:28PM -0700, Kalesh Singh wrote:
> In non-protected nVHE mode, unwinds and dumps the hypervisor backtrace
> from EL1. This is possible beacuase the host can directly access the
> hypervisor stack pages in non-proteced mode.
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
> 
> Changes in v5:
>   - Move code out from nvhe.h header to handle_exit.c, per Marc
>   - Fix stacktrace symoblization when CONFIG_RAMDOMIZE_BASE is enabled,
>     per Fuad
>   - Use regular comments instead of doc comments, per Fuad
> 
>  arch/arm64/kvm/handle_exit.c | 65 +++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index ad568da5c7d7..432b6b26f4ad 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c

[...]

> @@ -318,6 +319,56 @@ void handle_exit_early(struct kvm_vcpu *vcpu, int exception_index)
>  		kvm_handle_guest_serror(vcpu, kvm_vcpu_get_esr(vcpu));
>  }
>  
> +/*
> + * kvm_nvhe_print_backtrace_entry - Symbolizes and prints the HYP stack address
> + */
> +static void kvm_nvhe_print_backtrace_entry(unsigned long addr,
> +						  unsigned long hyp_offset)
> +{
> +	unsigned long va_mask = GENMASK_ULL(vabits_actual - 1, 0);
> +
> +	/* Mask tags and convert to kern addr */
> +	addr = (addr & va_mask) + hyp_offset;
> +	kvm_err(" [<%016lx>] %pB\n", addr, (void *)(addr + kaslr_offset()));
> +}

It is a bit odd to see this get churned from the last patch. Is it
possible to introduce the helper earlier on? In fact, the non-protected
patch should come first to layer the series better.

Also, it seems to me that there isn't much need for the indirection if
the pKVM unwinder is made to work around the below function signature:

<snip>

> +/*
> + * hyp_dump_backtrace_entry - Dump an entry of the non-protected nVHE HYP stacktrace
> + *
> + * @arg    : the hypervisor offset, used for address translation
> + * @where  : the program counter corresponding to the stack frame
> + */
> +static bool hyp_dump_backtrace_entry(void *arg, unsigned long where)
> +{
> +	kvm_nvhe_print_backtrace_entry(where, (unsigned long)arg);
> +
> +	return true;
> +}

</snip>

> +/*
> + * hyp_dump_backtrace - Dump the non-proteced nVHE HYP backtrace.
> + *
> + * @hyp_offset: hypervisor offset, used for address translation.
> + *
> + * The host can directly access HYP stack pages in non-protected
> + * mode, so the unwinding is done directly from EL1. This removes
> + * the need for shared buffers between host and hypervisor for
> + * the stacktrace.
> + */
> +static void hyp_dump_backtrace(unsigned long hyp_offset)
> +{
> +	struct kvm_nvhe_stacktrace_info *stacktrace_info;
> +	struct unwind_state state;
> +
> +	stacktrace_info = this_cpu_ptr_nvhe_sym(kvm_stacktrace_info);
> +
> +	kvm_nvhe_unwind_init(&state, stacktrace_info->fp, stacktrace_info->pc);
> +
> +	kvm_err("Non-protected nVHE HYP call trace:\n");

I don't see the value in discerning non-protected vs. protected in the
preamble, as panic() will dump the kernel commandline which presumably
would have a `kvm-arm.mode=protected` in the case of pKVM.

<nit>

Not entirely your problem, but we should really use a consistent name
for that thing we have living at EL2. Hyp or nVHE (but not both) would
be appropriate.

</nit>

> +	unwind(&state, hyp_dump_backtrace_entry, (void *)hyp_offset);
> +	kvm_err("---- End of Non-protected nVHE HYP call trace ----\n");

Maybe:

kvm_err("---[ end ${NAME_FOR_EL2} trace ]---");

(more closely matches the pattern of the arm64 stacktrace)

--
Thanks,
Oliver
