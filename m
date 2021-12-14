Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08075473A76
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbhLNBve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhLNBv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:51:29 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5724C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 17:51:28 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id v203so42767395ybe.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 17:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+dWtLIBLgyf5m6vDOvHH1tJV2BCoBwz05I/KJmnKuE=;
        b=DvFWLj+GQaI1l+qs3mCkJtfm275uA3mlNG/rJ3MKC64CXPslooLjSW2IySb6ZbbyX4
         WakmaumR4drgF8FIOsOwjiO0bl4lCNg7l3oSyGyy0tO20GpuvyJwFYluWrSucFy4NRHJ
         8yagRjniAuIDi2AgRQHCOBsakZE0axfKbP9qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+dWtLIBLgyf5m6vDOvHH1tJV2BCoBwz05I/KJmnKuE=;
        b=xmy+NOJHUKuAqCtjI02KoG3N6LsFD03QRlyXmLDpJSkO14SvHYKuik+i930rnkWl77
         JdMqGmcIAthtCaS4cQaLmg/3BkFp8qsG0CgfCpzsedpwcX7bnKXDAKtdrgFMzeF7Jn22
         CVxNrSk4JLvhKd34UEqrGLk89WBwp+UZoH1quINF2Jcm9CVw8dnIq9/x3XIDFmUBxJ9P
         Ot5YHCTkYsFSmtwpOTAxGR1X/AjH1K91IDPEb4g9QNArEfDeutOPzjPjq9W6vAyszZTg
         l4GlDSZQva5gdQrNPZGcuV1cvWVV6b/cZE4Yu4yuIAmy46pR1F4ZjvcfkbDd6xtuzSjU
         GJRg==
X-Gm-Message-State: AOAM533eZqd4JwhLG8D8jXYn4LO550olUKxYi8Unidc1IaHDlYU9S1Rl
        hKkoBGoB3R7B18yW3jgQ9KC6CSnCfxzLb/sdYkyd
X-Google-Smtp-Source: ABdhPJxHzd4+EPUZtXUvL0GWI90tGFXbdfycif0Ag2i1gAVrb5q6B7nsd/r3q9M+hc1HPeciYyvnw+bw5t6Pw1eD/s0=
X-Received: by 2002:a5b:b90:: with SMTP id l16mr2473159ybq.632.1639446687827;
 Mon, 13 Dec 2021 17:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20211213112034.2896536-1-heiko@sntech.de>
In-Reply-To: <20211213112034.2896536-1-heiko@sntech.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 13 Dec 2021 17:51:17 -0800
Message-ID: <CAOnJCUJ9YBOrNEj-nxAWctGPSTj6yUVOkiwQEpFELuf8B6SqLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: prevent null-pointer dereference with sbi_remote_fence_i
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 3:21 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The callback used inside sbi_remote_fence_i is set at sbi probe time
> to the needed variant. Before that it is a NULL pointer.
>
> The selection between using sbi_remote_fence_i or ipi_remote_fence_i
> right now is solely done on the presence of the RISCV_SBI config option.
>
> On a multiplatform kernel, SBI will probably always be built in, but
> in the future not all machines using that kernel may have SBI
> on them, so in some cases this setup can lead to NULL pointer dereferences.
>

I didn't quite understand this. The only platforms without SBI are
M-mode Linux based platforms.
All other platforms will require SBI if the kernel is running on
supervisor mode.

They may not need SBI IPI or SBI RFENCE extensions if an alternate
mechanism(ACLINT SSWI or AIA IMSIC)
is already available in hardware. IIRC, Anup's aclint & aia series
already takes care of that.

> Also if in future one of the flush_icache_all / flush_icache_mm functions
> gets called earlier in the boot process - before sbi_init - this would
> trigger the issue.
>

sbi_init is called before setup_smp. Do you think there is a use case where
flush_icache_xxx can be called before smp initialization ?

> To prevent this, add a default __sbi_rfence_none returning an error code
> and adapt the callers to check for an error from the remote fence
> to then fall back to the other method.
>

Having said that, it is always good to have guards to avoid NULL
pointer dereferences.
However, the commit text may be updated based on the above questions.

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/kernel/sbi.c    | 10 +++++++++-
>  arch/riscv/mm/cacheflush.c | 25 +++++++++++++++++--------
>  2 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 7402a417f38e..69d0a96b97d0 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -14,11 +14,19 @@
>  unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
>  EXPORT_SYMBOL(sbi_spec_version);
>
> +static int __sbi_rfence_none(int fid, const unsigned long *hart_mask,
> +                            unsigned long start, unsigned long size,
> +                            unsigned long arg4, unsigned long arg5)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
>  static int (*__sbi_send_ipi)(const unsigned long *hart_mask) __ro_after_init;
>  static int (*__sbi_rfence)(int fid, const unsigned long *hart_mask,
>                            unsigned long start, unsigned long size,
> -                          unsigned long arg4, unsigned long arg5) __ro_after_init;
> +                          unsigned long arg4, unsigned long arg5)
> +                          __ro_after_init = __sbi_rfence_none;
>
>  struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>                         unsigned long arg1, unsigned long arg2,
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 89f81067e09e..128e23c094ea 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -16,11 +16,15 @@ static void ipi_remote_fence_i(void *info)
>
>  void flush_icache_all(void)
>  {
> +       int ret = -EINVAL;
> +
>         local_flush_icache_all();
>
>         if (IS_ENABLED(CONFIG_RISCV_SBI))
> -               sbi_remote_fence_i(NULL);
> -       else
> +               ret = sbi_remote_fence_i(NULL);
> +
> +       /* fall back to ipi_remote_fence_i if sbi failed or not available */
> +       if (ret)
>                 on_each_cpu(ipi_remote_fence_i, NULL, 1);
>  }
>  EXPORT_SYMBOL(flush_icache_all);
> @@ -66,13 +70,18 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>                  * with flush_icache_deferred().
>                  */
>                 smp_mb();
> -       } else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
> -               cpumask_t hartid_mask;
> -
> -               riscv_cpuid_to_hartid_mask(&others, &hartid_mask);
> -               sbi_remote_fence_i(cpumask_bits(&hartid_mask));
>         } else {
> -               on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
> +               int ret = -EINVAL;
> +
> +               if (IS_ENABLED(CONFIG_RISCV_SBI)) {
> +                       cpumask_t hartid_mask;
> +
> +                       riscv_cpuid_to_hartid_mask(&others, &hartid_mask);
> +                       ret = sbi_remote_fence_i(cpumask_bits(&hartid_mask));

This API is removed in sparse hartid series[1]. You may want to rebase
on top of it.

[1] https://patchwork.kernel.org/project/linux-riscv/list/?series=590195

> +               }
> +
> +               if (ret)
> +                       on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
>         }
>
>         preempt_enable();
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
