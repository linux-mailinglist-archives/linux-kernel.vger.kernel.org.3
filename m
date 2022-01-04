Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7F5483BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 07:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiADGCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 01:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiADGCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 01:02:50 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73332C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 22:02:50 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z9so33125407qtj.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 22:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R9xOcdJ9jsoPz2tvG+BeAI+ARFs+OK9o9uEdkNZeypM=;
        b=Etky2OKKurzIIcHnGt0A2/qFXQMp3axtzkSWRepiyszuya4AQMi1dVZZ1SdDC1Y7eX
         4K0lrZ/GNN48Z/zlYwwVt3BzxP0dyJWEoALltmp2YwZMik2/MNmL1l5SkY4IGRl729e7
         2QKnr5fHd/rv4GWs65i572PFXx5CmIhhWnqKJXalxQ5WUYXHG7V4cMx52i5XWwYo9X0A
         Rdj121fYMG23EwWxNekW5UJFc26WhriTzidPUzJ19PakIsAMW4apnhB1ktlaviYkySst
         Fv32nl/DWlLtSeNx7jUu8hmRT9XvFfS7MG3+b0bCx13KHBMafixK9RQwJHTaRQGbTOWr
         AJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R9xOcdJ9jsoPz2tvG+BeAI+ARFs+OK9o9uEdkNZeypM=;
        b=2i96No/s7mZEd7nu2LbbJyM6lS8pEFwBMhyB/D7YV4/OqJ3nz3AD4+ksglUZmYUB2A
         709HvcdG1DNehEjenaHfDhQxJIcdDyv9475czpK4Dcs4otH+dCWnEP8oGAgwpEWJySVh
         q3vK027aj+nOolvt9ouB0qQmILl6qEejlJdM99IFijbX4xiWyfKgCySTeyx/pPN5kaBG
         4jnQsO91qGM+TqV6aj5795DoOYB8DfsT+kRKmeTP+VF1tis0kdkg6uam5EAdaivFi+Tv
         /zVrcTln+hHI0RHrSo5CxiXWrOqxSPFotHhnSK2/Gb/G2CFsQRl8KN0iIHQdLx/o5Uzc
         MIOg==
X-Gm-Message-State: AOAM530LEg5ufhJYrLD6xKFbnJ2AzOaz3A19CysD6CF/Oxqg6Ap6mL9c
        wJI8bj220Sb2ERjvIURa3q/KhMWbHeYfPtnJWZfD9g==
X-Google-Smtp-Source: ABdhPJy8+J7d1E6sU57uVMYFz7sfmc5oTAihswSyJAiTVCsoOmHVLQMrndd5Aig7YBNNJb9CA8Bv0AJ7c24kZIkfpSs=
X-Received: by 2002:ac8:5842:: with SMTP id h2mr42804080qth.244.1641276169581;
 Mon, 03 Jan 2022 22:02:49 -0800 (PST)
MIME-Version: 1.0
References: <8612e69a10235e67fac8a55864e77a4ab8f771ac.1636362169.git.greentime.hu@sifive.com>
 <mhng-591e217f-9290-464e-ab17-91fd84bed22b@palmer-ri-x1c9>
In-Reply-To: <mhng-591e217f-9290-464e-ab17-91fd84bed22b@palmer-ri-x1c9>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Tue, 4 Jan 2022 14:02:39 +0800
Message-ID: <CAHCEehK-oQqsi0fivFfKMUcHrzVoLEGHd29=UKFuGFCBAqCJXw@mail.gmail.com>
Subject: Re: [PATCH v9 07/17] riscv: Reset vector register
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:29=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Tue, 09 Nov 2021 01:48:19 PST (-0800), greentime.hu@sifive.com wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Reset vector registers at boot-time and disable vector instructions
> > execution for kernel mode.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > Co-developed-by: Han-Kuan Chen <hankuan.chen@sifive.com>
> > Signed-off-by: Han-Kuan Chen <hankuan.chen@sifive.com>
> > Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  arch/riscv/kernel/entry.S |  6 +++---
> >  arch/riscv/kernel/head.S  | 22 ++++++++++++++++++++--
> >  2 files changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 98f502654edd..ad0fa80ada81 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -77,10 +77,10 @@ _save_context:
> >        * Disable user-mode memory access as it should only be set in th=
e
> >        * actual user copy routines.
> >        *
> > -      * Disable the FPU to detect illegal usage of floating point in k=
ernel
> > -      * space.
> > +      * Disable the FPU/Vector to detect illegal usage of floating poi=
nt
> > +      * or vector in kernel space.
> >        */
> > -     li t0, SR_SUM | SR_FS
> > +     li t0, SR_SUM | SR_FS | SR_VS
> >
> >       REG_L s0, TASK_TI_USER_SP(tp)
> >       csrrc s1, CSR_STATUS, t0
> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> > index 52c5ff9804c5..551afe1de85e 100644
> > --- a/arch/riscv/kernel/head.S
> > +++ b/arch/riscv/kernel/head.S
> > @@ -242,10 +242,10 @@ pmp_done:
> >  .option pop
> >
> >       /*
> > -      * Disable FPU to detect illegal usage of
> > +      * Disable FPU & VECTOR to detect illegal usage of
> >        * floating point in kernel space
>
> Presumably that should be "floating point or vector", like the other
> one?

Thank you, Palmer. I'll update this and I also found another issue in
secondary_start_sbi.
We should also disable vector there.

> >        */
> > -     li t0, SR_FS
> > +     li t0, SR_FS | SR_VS
> >       csrc CSR_STATUS, t0
> >
> >  #ifdef CONFIG_SMP
> > @@ -433,6 +433,24 @@ ENTRY(reset_regs)
> >       csrw    fcsr, 0
> >       /* note that the caller must clear SR_FS */
> >  #endif /* CONFIG_FPU */
> > +
> > +#ifdef CONFIG_VECTOR
> > +     csrr    t0, CSR_MISA
> > +     li      t1, (COMPAT_HWCAP_ISA_V >> 16)
> > +     slli    t1, t1, 16
>
> Why?  Shouldn't the "li" pseudo handle generating that constant fine?
> It generates the expected lui for me.

That's right.
I'll update the code here to
 #ifdef CONFIG_VECTOR
        csrr    t0, CSR_MISA
        li      t1, COMPAT_HWCAP_ISA_V
        and     t0, t0, t1
        beqz    t0, .Lreset_regs_done


> > +     and     t0, t0, t1
> > +     beqz    t0, .Lreset_regs_done
> > +
> > +     li      t1, SR_VS
> > +     csrs    CSR_STATUS, t1
> > +     vsetvli t1, x0, e8, m8
> > +     vmv.v.i v0, 0
> > +     vmv.v.i v8, 0
> > +     vmv.v.i v16, 0
> > +     vmv.v.i v24, 0
>
> I don't see anything resetting vcsr here, which is explicitly required
> by ISA manual.
>
> Otherwise this looks OK to me: I wasn't actually sure this was guaranteed
> to hit every bit in the vector register file, but IIUC it does -- VLMAX
> has a defined value, VLEN is a constant, and this form of vsetvli is
> defined to set vl to VLMAX.  Probably worth a comment, though.
>

/*
 * Clear vector registers and reset vcsr
 * VLMAX has a defined value, VLEN is a constant,
 * and this form of vsetvli is defined to set vl to VLMAX.
 */
li      t1, SR_VS
csrs    CSR_STATUS, t1
csrs    CSR_VCSR, x0
vsetvli t1, x0, e8, m8
vmv.v.i v0, 0
vmv.v.i v8, 0
vmv.v.i v16, 0
vmv.v.i v24, 0


> > +     /* note that the caller must clear SR_VS */
> > +#endif /* CONFIG_VECTOR */
> > +
> >  .Lreset_regs_done:
> >       ret
> >  END(reset_regs)
>
> With those minor bits fixed,
>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
