Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E7957C868
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiGUKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiGUJ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:59:48 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86DB820F6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g1so1467377edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x8zWIB1Jk2zC+zVLL1a5oZ4AS/1//k+cudXHvaMTMBs=;
        b=edW3k4aa7VTAEr7wdc8jVCjhirK5Irfk8qBCUEZYzkV3OrB9Eh5klc2iIHR3uoWZnP
         oIdozVUd8gHdA+uKkJkcXPSjwyC6t3R+pGAr86haOciELQsjQ+wFI/JARYogzWodUh5N
         ysZNIaIz+gVAWzwvDqaNl+//D5dwZ2JjMpBW3ncAD43CDUJSaIGNOmhioKAlDKjazGJy
         W0W3encQyf4Dk3Sx4gWlYpVtl8xxXDNaF36/jz3+VPVS2Ci1DcQ5GifTFYY4rPt1iL2G
         1VzCqDD2cE5RZWo90gjRANWeQABVDxX4vJLgkbtZ6Yp4F+vu9pN9syrHkrFqsKiazHvr
         pTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8zWIB1Jk2zC+zVLL1a5oZ4AS/1//k+cudXHvaMTMBs=;
        b=MQOrJz++YO4Oz53CUqrEgCVdpKeA8n/gzA766TL7Dz8ZBFtUujbZ4Vs3dI+Hxs8p9L
         OtJ5EnFvS6VhIb6S6Uk6ZxEzSymoJehlZFf7kmr7DR1kopq8RLRQvAIri77rta7C1ZDe
         4gvjfJibP+qDhEinf42lxKrqawRySW6DBjRJ9P+x8r5tAZygbhkAZUx6zAD93Yhz5QnC
         93LfYfEYsv8jwjY9AH5Ak9iCYpmmQZugo9uYLMLnqYsHR/EHqQNG7XP2KIcdSfV9g3+/
         dyC4BX/ytAtU38kVgg8SLuvp9D8S2J7zniOK1iy78O9X/eXIhREjsEofV0Y97/hGVN1c
         v6nA==
X-Gm-Message-State: AJIora+UXSdp8SnQwQTIfBC0lY6mmgGL/U7W37iUs3USlH9lZcyrIh5R
        fUDzKt76zMfTz+X91lo4F++oiP8FJ/aD7teNMhIPWA==
X-Google-Smtp-Source: AGRyM1vcbTyNNjymvJFxOWfYP/8b5Bg4F5Cy83gLQY0P3cKR7FwP9f4aHqEOZXNwA07/ltOSFkCxdCCmfELPDgaY4MY=
X-Received: by 2002:a05:6402:753:b0:43b:a416:3963 with SMTP id
 p19-20020a056402075300b0043ba4163963mr13574229edy.267.1658397581111; Thu, 21
 Jul 2022 02:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <20220721055728.718573-17-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-17-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:59:04 +0100
Message-ID: <CA+EHjTzc8Rxe-n3uy0TQDFTVMw0hN_GwzAZunqpOE3HGXrq2CQ@mail.gmail.com>
Subject: Re: [PATCH v5 16/17] KVM: arm64: Introduce pkvm_dump_backtrace()
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

Hi Kalesh,

On Thu, Jul 21, 2022 at 6:58 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Dumps the pKVM hypervisor backtrace from EL1 by reading the unwinded
> addresses from the shared stacktrace buffer.
>
> The nVHE hyp backtrace is dumped on hyp_panic(), before panicking the
> host.
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
>  arch/arm64/kvm/handle_exit.c | 54 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index f66c0142b335..ad568da5c7d7 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -318,6 +318,57 @@ void handle_exit_early(struct kvm_vcpu *vcpu, int exception_index)
>                 kvm_handle_guest_serror(vcpu, kvm_vcpu_get_esr(vcpu));
>  }
>
> +#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
> +DECLARE_KVM_NVHE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)],
> +                        pkvm_stacktrace);
> +
> +/*
> + * pkvm_dump_backtrace - Dump the protected nVHE HYP backtrace.
> + *
> + * @hyp_offset: hypervisor offset, used for address translation.
> + *
> + * Dumping of the pKVM HYP backtrace is done by reading the
> + * stack addresses from the shared stacktrace buffer, since the
> + * host cannot direclty access hyperviosr memory in protected

directly and hypervisor

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


> + * mode.
> + */
> +static void pkvm_dump_backtrace(unsigned long hyp_offset)
> +{
> +       unsigned long *stacktrace_entry
> +               = (unsigned long *)this_cpu_ptr_nvhe_sym(pkvm_stacktrace);
> +       unsigned long va_mask, pc;
> +
> +       va_mask = GENMASK_ULL(vabits_actual - 1, 0);
> +
> +       kvm_err("Protected nVHE HYP call trace:\n");
> +
> +       /* The stack trace is terminated by a null entry */
> +       for (; *stacktrace_entry; stacktrace_entry++) {
> +               /* Mask tags and convert to kern addr */
> +               pc = (*stacktrace_entry & va_mask) + hyp_offset;
> +               kvm_err(" [<%016lx>] %pB\n", pc, (void *)(pc + kaslr_offset()));
> +       }
> +
> +       kvm_err("---- End of Protected nVHE HYP call trace ----\n");
> +}
> +#else  /* !CONFIG_PROTECTED_NVHE_STACKTRACE */
> +static void pkvm_dump_backtrace(unsigned long hyp_offset)
> +{
> +       kvm_err("Cannot dump pKVM nVHE stacktrace: !CONFIG_PROTECTED_NVHE_STACKTRACE\n");
> +}
> +#endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
> +
> +/*
> + * kvm_nvhe_dump_backtrace - Dump KVM nVHE hypervisor backtrace.
> + *
> + * @hyp_offset: hypervisor offset, used for address translation.
> + */
> +static void kvm_nvhe_dump_backtrace(unsigned long hyp_offset)
> +{
> +       if (is_protected_kvm_enabled())
> +               pkvm_dump_backtrace(hyp_offset);
> +}
> +
>  void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
>                                               u64 elr_virt, u64 elr_phys,
>                                               u64 par, uintptr_t vcpu,
> @@ -353,6 +404,9 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
>                                 (void *)panic_addr);
>         }
>
> +       /* Dump the nVHE hypervisor backtrace */
> +       kvm_nvhe_dump_backtrace(hyp_offset);
> +
>         /*
>          * Hyp has panicked and we're going to handle that by panicking the
>          * kernel. The kernel offset will be revealed in the panic so we're
> --
> 2.37.0.170.g444d1eabd0-goog
>
