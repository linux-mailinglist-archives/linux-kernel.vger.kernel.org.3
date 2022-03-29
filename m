Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1B4EA9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 10:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiC2Ixw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 04:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiC2Ixf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 04:53:35 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C0065D11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:51:52 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 12so18350310oix.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R1lsy9bMwR3ErUveqedAk8smNA0HigoGBjxLcyNF7Hk=;
        b=rbrvbYiedyRBSdRYe6ZGpIj7XvntHQia/rB4xtJJLFMus5eHqW8Pemvzxfr7NXac3+
         JMagcc+W0AMpYApVy0+MqLkvwibf2VVZpVXknche0g03NNv8sC8YGGdNshJ1aeGD77Vq
         +NUWztvMoJTf0Essh7f73pRj5H7P9WnWHuDIvQsYVAGDITzwiCixYW/cSEru53TjZ0uy
         9LwegnaV7o/2eVro98LRwh5SbzGJfPzrHl/3oY0n4GZr/fNy/fW3o39UrP7PGtNZ8+Po
         Y11i0R1NhlQOcMom/HNueNTgjCC0DqT2Wm5JQAvSRD1NFwVqYJD/GePT68iWk1buWSjB
         qByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R1lsy9bMwR3ErUveqedAk8smNA0HigoGBjxLcyNF7Hk=;
        b=DyF5CtTb58klR94UPHSki79fTmr5t1sVa2ona0le3riimHWwM9hGaTkQa0Al9OpqKW
         WZo/5ba4wiLcS/s47G9axS3sQa5F7R0vqXVgDA98mdH/ZxwV8cM3Ff98VW4z7tzA0U+/
         vGVeyAl4sQEdJUKYvVIUwKx5ju3PpdsiWL6e5jM6qFr5xQF8iRlT8lbCVd8K0DMeiRf+
         OsP0Sl/2vD/b8PfDo+3x01GII57wCrHAqJcnqoBD1Y518yDbgNMbX8FOCDXbAFPEAbC5
         /KBeR5bCszehrTgiG9zEkw1xkx6c01ffn58PpxhXKjw7urtT5H8Mqm7yT+aKmmXT4D8B
         ZFXA==
X-Gm-Message-State: AOAM5306p5d5tHBU7SlLBK9sx57jmPgDgUvdheqRbBf4l937RahjLnSG
        ePLQQPWybnAw4JXKUGDz4b62CDBKF/Rw46f7qqqlIQ==
X-Google-Smtp-Source: ABdhPJy/th1u/rMCaWZtzYowW7LJ1M2NUGV8icqQ2gVGgJiqN6PQR2SlsJkh6eQ+HBd+YiFyvJrCKH5iVJxXzxXwfpc=
X-Received: by 2002:aca:180b:0:b0:2f7:23ae:8cd1 with SMTP id
 h11-20020aca180b000000b002f723ae8cd1mr1592160oih.146.1648543911401; Tue, 29
 Mar 2022 01:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220314200148.2695206-1-kaleshsingh@google.com> <20220314200148.2695206-9-kaleshsingh@google.com>
In-Reply-To: <20220314200148.2695206-9-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 29 Mar 2022 09:51:15 +0100
Message-ID: <CA+EHjTx-c8e1oHh-A=6aaSxHxdrsuhtsjrwosjFLsWP9Zizmhw@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] KVM: arm64: Symbolize the nVHE HYP backtrace
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        surenb@google.com, kernel-team@android.com,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Scull <ascull@google.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Mon, Mar 14, 2022 at 8:07 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Reintroduce the __kvm_nvhe_ symbols in kallsyms, ignoring the local
> symbols in this namespace. The local symbols are not informative and
> can cause aliasing issues when symbolizing the addresses.
>
> With the necessary symbols now in kallsyms we can symbolize nVHE
> stacktrace addresses using the %pB print format specifier.
>
> Example call trace:
>
> [   98.916444][  T426] kvm [426]: nVHE hyp panic at: [<ffffffc0096156fc>] __kvm_nvhe_overflow_stack+0x8/0x34!
> [   98.918360][  T426] nVHE HYP call trace:
> [   98.918692][  T426] kvm [426]: [<ffffffc009615aac>] __kvm_nvhe_cpu_prepare_nvhe_panic_info+0x4c/0x68
> [   98.919545][  T426] kvm [426]: [<ffffffc0096159a4>] __kvm_nvhe_hyp_panic+0x2c/0xe8
> [   98.920107][  T426] kvm [426]: [<ffffffc009615ad8>] __kvm_nvhe_hyp_panic_bad_stack+0x10/0x10
> [   98.920665][  T426] kvm [426]: [<ffffffc009610a4c>] __kvm_nvhe___kvm_hyp_host_vector+0x24c/0x794
> [   98.921292][  T426] kvm [426]: [<ffffffc009615718>] __kvm_nvhe_overflow_stack+0x24/0x34
> . . .
>
> [   98.973382][  T426] kvm [426]: [<ffffffc009615718>] __kvm_nvhe_overflow_stack+0x24/0x34
> [   98.973816][  T426] kvm [426]: [<ffffffc0096152f4>] __kvm_nvhe___kvm_vcpu_run+0x38/0x438
> [   98.974255][  T426] kvm [426]: [<ffffffc009616f80>] __kvm_nvhe_handle___kvm_vcpu_run+0x1c4/0x364
> [   98.974719][  T426] kvm [426]: [<ffffffc009616928>] __kvm_nvhe_handle_trap+0xa8/0x130
> [   98.975152][  T426] kvm [426]: [<ffffffc009610064>] __kvm_nvhe___host_exit+0x64/0x64
> [   98.975588][  T426] ---- end of nVHE HYP call trace ----
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad



> ---
>
> Changes in v2:
>   - Fix printk warnings - %p expects (void *)
>
>
>  arch/arm64/kvm/handle_exit.c | 13 +++++--------
>  scripts/kallsyms.c           |  2 +-
>  2 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index ff69dff33700..3a5c32017c6b 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -296,13 +296,8 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
>         u64 elr_in_kimg = __phys_to_kimg(elr_phys);
>         u64 hyp_offset = elr_in_kimg - kaslr_offset() - elr_virt;
>         u64 mode = spsr & PSR_MODE_MASK;
> +       u64 panic_addr = elr_virt + hyp_offset;
>
> -       /*
> -        * The nVHE hyp symbols are not included by kallsyms to avoid issues
> -        * with aliasing. That means that the symbols cannot be printed with the
> -        * "%pS" format specifier, so fall back to the vmlinux address if
> -        * there's no better option.
> -        */
>         if (mode != PSR_MODE_EL2t && mode != PSR_MODE_EL2h) {
>                 kvm_err("Invalid host exception to nVHE hyp!\n");
>         } else if (ESR_ELx_EC(esr) == ESR_ELx_EC_BRK64 &&
> @@ -322,9 +317,11 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr, u64 spsr,
>                 if (file)
>                         kvm_err("nVHE hyp BUG at: %s:%u!\n", file, line);
>                 else
> -                       kvm_err("nVHE hyp BUG at: %016llx!\n", elr_virt + hyp_offset);
> +                       kvm_err("nVHE hyp BUG at: [<%016llx>] %pB!\n", panic_addr,
> +                                       (void *)panic_addr);
>         } else {
> -               kvm_err("nVHE hyp panic at: %016llx!\n", elr_virt + hyp_offset);
> +               kvm_err("nVHE hyp panic at: [<%016llx>] %pB!\n", panic_addr,
> +                               (void *)panic_addr);
>         }
>
>         kvm_nvhe_dump_backtrace(hyp_offset);
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 54ad86d13784..19aba43d9da4 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -111,7 +111,7 @@ static bool is_ignored_symbol(const char *name, char type)
>                 ".LASANPC",             /* s390 kasan local symbols */
>                 "__crc_",               /* modversions */
>                 "__efistub_",           /* arm64 EFI stub namespace */
> -               "__kvm_nvhe_",          /* arm64 non-VHE KVM namespace */
> +               "__kvm_nvhe_$",         /* arm64 local symbols in non-VHE KVM namespace */
>                 "__AArch64ADRPThunk_",  /* arm64 lld */
>                 "__ARMV5PILongThunk_",  /* arm lld */
>                 "__ARMV7PILongThunk_",
> --
> 2.35.1.723.g4982287a31-goog
>
