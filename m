Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096F6472C92
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbhLMMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhLMMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:49:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8101C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:49:48 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so13978403wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXQYwOotvNt7nBs8RK2HcYpypTegYe76SWSdNP6SpOk=;
        b=Mwej99eKLJ2T6KE0qNHvTltiVl/qRpIrX2iSvi/ELOdMV/Xn0oR6keuB1RI5uqgbXd
         BAFu5sSboKOqGyLqZnPcMggy6S1veMWQfmIQGrwDx8PY64lEoM/WP8L4bl3SQG2kJuJ4
         bzXipTGMdUfoJtsXwbUhclcAKPHNIECs3HNG22wa0VC1/DCac3/cHjeaJi3oLJk0QAOj
         qasAldeQI1xT2p4Hv3Inm87QmC5lbOl3r04G9GL1n8eqmTWz4A/VgSBgnSIegmwkasAo
         B/wvUD7BY+uYg/Dkn9qdz1+1SjGnpi3iRU3aUspLZd+8c4E2z8INIQ6HWRsr+eIju1op
         J8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXQYwOotvNt7nBs8RK2HcYpypTegYe76SWSdNP6SpOk=;
        b=CYMVOyyAbRfGeUDh3W9kTzZg/Tm2bMB+DtgUPRsWJHe67moplxkjr+CWGdNlkQ/vHp
         LlTF2vfZgtPGwJ7VS65dnixCQc9SQvZfj1MteIH4u5nEmRlcH0BMZUyRBEmeLMmZus/Q
         iAVuaAlOeTN5LoksXB7xPLm2YcnQ5RXvk6Nb76dY6/ewgy52HD6fn/KgaFBG+C52HbDC
         Q5ceb8HTQHsTYcylp6w3IqWokToV8ffldGe5pUMyvJLeKo8qzZvFi20J6sfxhKugjzZ6
         tI6SPpC4u8RnKJlOkylpjS6i669VqhOrcey09D0aZrUyv5ZqibjI/Cqu7HcoPTDWLYkf
         /Axw==
X-Gm-Message-State: AOAM530BKlE3hmc1/+OBEsjAxuA7IcE5EJBVbEh8GuEEKfnj/2mlyMCK
        IQ/g/loOnNE9WuLTECP7dpBnrqQJC3ACH2ZV5NwBOA==
X-Google-Smtp-Source: ABdhPJx2Fvi9nAN/wxCPzg1bi9wODMYYJfN+Mji5z+NXA+F9wK2XSoVAsNeYsLL8OavLElsE/D2dsnGOJDc8LVYnGGg=
X-Received: by 2002:a7b:c7cd:: with SMTP id z13mr37985073wmk.59.1639399787309;
 Mon, 13 Dec 2021 04:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20211204002038.113653-1-atishp@atishpatra.org> <20211204002038.113653-3-atishp@atishpatra.org>
In-Reply-To: <20211204002038.113653-3-atishp@atishpatra.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 13 Dec 2021 18:19:35 +0530
Message-ID: <CAAhSdy3ySJN5NCkUpromH1zQQqfaDPQHmEiMGYEUY5snAd-jFQ@mail.gmail.com>
Subject: Re: [RFC 2/6] RISC-V: Do not print the SBI version during HSM
 extension boot print
To:     Atish Patra <atishp@atishpatra.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Anup Patel <anup.patel@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ingo Molnar <mingo@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        kvm-riscv@lists.infradead.org, KVM General <kvm@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vincent Chen <vincent.chen@sifive.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 4, 2021 at 5:50 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> From: Atish Patra <atishp@rivosinc.com>
>
> The HSM extension information log also prints the SBI version v0.2. This
> is misleading as the underlying firmware SBI version may be different
> from v0.2.
>
> Remove the unncessary printing of SBI version.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/cpu_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/cpu_ops.c b/arch/riscv/kernel/cpu_ops.c
> index 1985884fe829..3f5a38b03044 100644
> --- a/arch/riscv/kernel/cpu_ops.c
> +++ b/arch/riscv/kernel/cpu_ops.c
> @@ -38,7 +38,7 @@ void __init cpu_set_ops(int cpuid)
>  #if IS_ENABLED(CONFIG_RISCV_SBI)
>         if (sbi_probe_extension(SBI_EXT_HSM) > 0) {
>                 if (!cpuid)
> -                       pr_info("SBI v0.2 HSM extension detected\n");
> +                       pr_info("SBI HSM extension detected\n");
>                 cpu_ops[cpuid] = &cpu_ops_sbi;
>         } else
>  #endif
> --
> 2.33.1
>
