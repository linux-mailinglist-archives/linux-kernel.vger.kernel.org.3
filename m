Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385A057E58C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiGVR2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiGVR2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:28:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3007B37D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:28:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h8so7424709wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwlo3BqFTDCGoeQJZWI9pHBVdatv5K3XsvNJ8Oj1ml0=;
        b=EvrScfvXzo/TRQoNEGgStFwBfwgOXLAWI14neyWBoektfW3yQaQaUzJpfRCq2CSE8W
         eC7GoUHSUfnidEnJkSl+J3F7RZOYOHW9MPCzeQrlMWCCjPuIftWDJhS6Gvr8jFiP6A28
         A1eJ0Ccw5PjBaXUFVN7egE0wEozabHciz42onTJgCN4386Td3elkdLV1HpAqyCAx2lFH
         pKEvmNRV6gplzqZXvBW+DxTxSHVoaul2LwwHR0ZjmJb7+A8EuTLZ7snpMVJa35SE+alg
         QEtEfxm4xbQXV08ULk1GvbAjnrVS2cttW+/TOmIYJXmhQ5GIHmfYnLns3gfCcIHOUynn
         nIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwlo3BqFTDCGoeQJZWI9pHBVdatv5K3XsvNJ8Oj1ml0=;
        b=cWkWOJUUyXtvVYObJPqwOiI/bbQnUBxoc+x0A9rNL/9xHXQE4MOobdMSvh/lVT+0VY
         4MRA5rNyvH0cGj0HtTlt0LuC/hKdcoJliEoz3TjWLJsmlSfUwQO4L4R2OQ//lm4KHmN5
         WmEx3GeBALu2RAOmQbDrLszE2UEqP/ne1ZhjVoGT1oQMhQMLrd1iHCQmmwmf4y+uwHXX
         Y60YmqHGIotlGBfM+iVC3QfnyqIkvWxC+8/bQo0FvMFQGJFD+/bl62SUxgyJb3mkHk1d
         LEBztMiy/ETADiGbDKv3bJiYEnemj9uW4PhdiN+G89INtWeygvkeRQtnwcqveA7k0mmF
         1m3Q==
X-Gm-Message-State: AJIora8G4IrZUzpFnRLU81fGi/fFUDmC5tL3anWFFUPRvMp87Gn7GCGX
        KQmif699l0A3D75meqtZEUPq5DXqmwGTTj09KvNuKQ==
X-Google-Smtp-Source: AGRyM1u4ikPl/LtayDssTs6DxZSbbt9+bh3MqXwxRj6V6FITNQSGqxV7Y7eunshdDHKNYuaCM56/nHqbH6WDzqJYZxs=
X-Received: by 2002:a05:6000:1e04:b0:21d:7ec3:fe5a with SMTP id
 bj4-20020a0560001e0400b0021d7ec3fe5amr693779wrb.116.1658510910254; Fri, 22
 Jul 2022 10:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com>
 <20220721055728.718573-13-kaleshsingh@google.com> <YtrDU9TRjNWCTPVg@google.com>
In-Reply-To: <YtrDU9TRjNWCTPVg@google.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Fri, 22 Jul 2022 10:28:19 -0700
Message-ID: <CAC_TJvcdc=gRG5fYr16gQikHLedtH=RyasXvgNsMufUNtBEXRg@mail.gmail.com>
Subject: Re: [PATCH v5 12/17] KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Fuad Tabba <tabba@google.com>, Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>, android-mm@google.com,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 8:33 AM Oliver Upton <oliver.upton@linux.dev> wrote:
>
> Hi Kalesh,
>
> On Wed, Jul 20, 2022 at 10:57:23PM -0700, Kalesh Singh wrote:
> > In protected nVHE mode, the host cannot access private owned hypervisor
> > memory. Also the hypervisor aims to remains simple to reduce the attack
> > surface and does not provide any printk support.
> >
> > For the above reasons, the approach taken to provide hypervisor stacktraces
> > in protected mode is:
> >    1) Unwind and save the hyp stack addresses in EL2 to a shared buffer
> >       with the host (done in this patch).
> >    2) Delegate the dumping and symbolization of the addresses to the
> >       host in EL1 (later patch in the series).
> >
> > On hyp_panic(), the hypervisor prepares the stacktrace before returning to
> > the host.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
>
> Tried reworking this a bit and here is what I arrived at, WDYT?
> Untested, of course :)

Hi Oliver,

I think what you have is a lot cleaner. :) I'll incorporate it for the
next spin.

Thanks,
Kalesh

>
> --
> Thanks,
> Oliver
>
> diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
> index 3078501f8e22..05d7e03e0a8c 100644
> --- a/arch/arm64/include/asm/stacktrace/nvhe.h
> +++ b/arch/arm64/include/asm/stacktrace/nvhe.h
> @@ -21,6 +21,23 @@
>
>  #include <asm/stacktrace/common.h>
>
> +/*
> + * kvm_nvhe_unwind_init - Start an unwind from the given nVHE HYP fp and pc
> + *
> + * @state : unwind_state to initialize
> + * @fp    : frame pointer at which to start the unwinding.
> + * @pc    : program counter at which to start the unwinding.
> + */
> +static inline void kvm_nvhe_unwind_init(struct unwind_state *state,
> +                                       unsigned long fp,
> +                                       unsigned long pc)
> +{
> +       unwind_init_common(state, NULL);
> +
> +       state->fp = fp;
> +       state->pc = pc;
> +}
> +
>  static inline bool on_accessible_stack(const struct task_struct *tsk,
>                                        unsigned long sp, unsigned long size,
>                                        struct stack_info *info)
> diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> index 96c8b93320eb..644276fb02af 100644
> --- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> +++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> @@ -11,4 +11,69 @@ DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
>
>  #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
>  DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
> +
> +/*
> + * pkvm_save_backtrace_entry - Saves a protected nVHE HYP stacktrace entry
> + *
> + * @arg    : the index of the entry in the stacktrace buffer
> + * @where  : the program counter corresponding to the stack frame
> + *
> + * Save the return address of a stack frame to the shared stacktrace buffer.
> + * The host can access this shared buffer from EL1 to dump the backtrace.
> + */
> +static bool pkvm_save_backtrace_entry(void *arg, unsigned long where)
> +{
> +       unsigned long *stacktrace = this_cpu_ptr(pkvm_stacktrace);
> +       int *idx = (int *)arg;
> +
> +       /*
> +        * Need 2 free slots: 1 for current entry and 1 for the
> +        * delimiter.
> +        */
> +       if (*idx > ARRAY_SIZE(pkvm_stacktrace) - 2)
> +               return false;
> +
> +       stacktrace[*idx] = where;
> +       stacktrace[++*idx] = 0UL;
> +
> +       return true;
> +}
> +
> +/*
> + * pkvm_save_backtrace - Saves the protected nVHE HYP stacktrace
> + *
> + * @fp : frame pointer at which to start the unwinding.
> + * @pc : program counter at which to start the unwinding.
> + *
> + * Save the unwinded stack addresses to the shared stacktrace buffer.
> + * The host can access this shared buffer from EL1 to dump the backtrace.
> + */
> +static void pkvm_save_backtrace(unsigned long fp, unsigned long pc)
> +{
> +       struct unwind_state state;
> +       int idx = 0;
> +
> +       kvm_nvhe_unwind_init(&state, fp, pc);
> +
> +       unwind(&state, pkvm_save_backtrace_entry, &idx);
> +}
> +#else /* !CONFIG_PROTECTED_NVHE_STACKTRACE */
> +static void pkvm_save_backtrace(unsigned long fp, unsigned long pc)
> +{
> +}
>  #endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
> +
> +/*
> + * kvm_nvhe_prepare_backtrace - prepare to dump the nVHE backtrace
> + *
> + * @fp : frame pointer at which to start the unwinding.
> + * @pc : program counter at which to start the unwinding.
> + *
> + * Saves the information needed by the host to dump the nVHE hypervisor
> + * backtrace.
> + */
> +void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)
> +{
> +       if (is_protected_kvm_enabled())
> +               pkvm_save_backtrace(fp, pc);
> +}
> diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
> index 6db801db8f27..64e13445d0d9 100644
> --- a/arch/arm64/kvm/hyp/nvhe/switch.c
> +++ b/arch/arm64/kvm/hyp/nvhe/switch.c
> @@ -34,6 +34,8 @@ DEFINE_PER_CPU(struct kvm_host_data, kvm_host_data);
>  DEFINE_PER_CPU(struct kvm_cpu_context, kvm_hyp_ctxt);
>  DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
>
> +extern void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
> +
>  static void __activate_traps(struct kvm_vcpu *vcpu)
>  {
>         u64 val;
> @@ -375,6 +377,10 @@ asmlinkage void __noreturn hyp_panic(void)
>                 __sysreg_restore_state_nvhe(host_ctxt);
>         }
>
> +       /* Prepare to dump kvm nvhe hyp stacktrace */
> +       kvm_nvhe_prepare_backtrace((unsigned long)__builtin_frame_address(0),
> +                                  _THIS_IP_);
> +
>         __hyp_do_panic(host_ctxt, spsr, elr, par);
>         unreachable();
>  }
