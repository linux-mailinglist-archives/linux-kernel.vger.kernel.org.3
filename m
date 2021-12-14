Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697B5473A92
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhLNCKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhLNCKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:10:33 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7ABC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 18:10:33 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id g17so42733618ybe.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 18:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAXZoZ3EFDtBL37QoL2ndUIo48v0GNpHWK6/yjRwd2s=;
        b=VOTTyUATYC3+c3QtXef2Qo4WgjoSSjv3noSRdCUaOZisjTXXz+5qkNO27kB2+RdHO9
         XFfXD8KdDvVBIfJrGXVZ0RVyqbgUOlErL6GVFzkcnlRNue5sJ9Si69j3z+TyXpAw3zzq
         Avmh7KYiXOkBi2PHFOFlIHEMvjTYxTxWc6cMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAXZoZ3EFDtBL37QoL2ndUIo48v0GNpHWK6/yjRwd2s=;
        b=x5RC6zDxJP154tQuRdArNFCV4RaSQKjHFWm31u++ZE4ICbIwCmChlgJ3rmSG1qa8of
         3uP/JLdZ2pNUAlD/jGqtzw+P1FIx3yS8cpS6OYuPVq0cZZeHxI4d5SOZ/AYpBpZfFr8r
         P4i35/KhyajfHPNQi3/WiKW1z+5m6wHCYh69rrsp4laGE5OezK7y1u4yov95js7esqRI
         QTmb+CbKFU26IjkmIHhY8gj392GIi605pIyzMjlMJQcrCSH78H/sKI/OT1w6w1O6EYIp
         1j1Ay50QbeJPo/Mklz0L+/4MxiSJzTMtMYaczORUWWeoiaDgxXWlvX/NAF6GI3zBgrkz
         jGLg==
X-Gm-Message-State: AOAM5302s6yKDTM09uZPEvq+VFlFPFmZv6H4CI7KYPd7x7U+gXJgBqjo
        xPjY2jEr4c6kFbM0J9OVQEs2+BBiQcCRPgtSCqJFZCcdzRvAt94=
X-Google-Smtp-Source: ABdhPJzOutjL1vlk/mUNkO/y8VX2nocICwAi15va+e2zQF6T0XtuSBvkrxps3ca837moS2DfgfxS2FZtTFJO4ZrHi14=
X-Received: by 2002:a05:6902:568:: with SMTP id a8mr2874193ybt.472.1639447832415;
 Mon, 13 Dec 2021 18:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20211213112034.2896536-1-heiko@sntech.de> <20211213112034.2896536-2-heiko@sntech.de>
In-Reply-To: <20211213112034.2896536-2-heiko@sntech.de>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 13 Dec 2021 18:10:21 -0800
Message-ID: <CAOnJCULdeHn4GmrP8PLsWS43g=HYjUwiA2txisEqgzSmuCoA7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: provide default implementations for
 __sbi_set_timer and __sbi_send_ipi
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
> The mentioned function pointers get called from different sbi functions
> which may get called from other areas of the kernel without fully
> checking if the sbi initialization was done.

SBI initialization happens in sbi_init which is called from setup_arch.
setup_smp happens after that. Thus, there won't be an IPI issued
before SMP is set up.

For __sbi_set_timer, the first time it will be called from this path.
time_init->timer_probe->riscv_timer_init_dt

time_init is called from start_kernel after setup_arch. In fact,
setup_arch is called very early
in the start_kernel.

Is there any other scenario where these SBI functions can be invoked
before SBI is initialized ?

>
> So similarly to sbi_remote_fence_i, provide empty functions for them
> to prevent any null-pointer dereferences in the future.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/kernel/sbi.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 69d0a96b97d0..6a21345c6712 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -14,6 +14,13 @@
>  unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
>  EXPORT_SYMBOL(sbi_spec_version);
>
> +static void __sbi_set_timer_none(uint64_t stime_value) {}
> +
> +static int __sbi_send_ipi_none(const unsigned long *hart_mask)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  static int __sbi_rfence_none(int fid, const unsigned long *hart_mask,
>                              unsigned long start, unsigned long size,
>                              unsigned long arg4, unsigned long arg5)
> @@ -21,8 +28,9 @@ static int __sbi_rfence_none(int fid, const unsigned long *hart_mask,
>         return -EOPNOTSUPP;
>  }
>
> -static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
> -static int (*__sbi_send_ipi)(const unsigned long *hart_mask) __ro_after_init;
> +static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init = __sbi_set_timer_none;
> +static int (*__sbi_send_ipi)(const unsigned long *hart_mask)
> +                           __ro_after_init = __sbi_send_ipi_none;
>  static int (*__sbi_rfence)(int fid, const unsigned long *hart_mask,
>                            unsigned long start, unsigned long size,
>                            unsigned long arg4, unsigned long arg5)
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
