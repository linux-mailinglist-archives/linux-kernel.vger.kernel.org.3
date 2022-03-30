Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B574EBC31
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243866AbiC3Hyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiC3HyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:54:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07936201B2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:52:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i4so9176194wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghHV0zTkwP6Ex+XA+hsxUv5AW9dRVc+dHJyFR6M/CLc=;
        b=MsUahD2sxOxVEYlWECPO8kAt9VWOJpDQrtlreD3+bqkhw6vqNTK7bkZs6OOon1C6qX
         GpbFyKlDNhAqt8EU07FcYzmKQCKWU8+dLr7J2vWKm07zQpKdZWWdJsUKMjmFwO7z3kgO
         ljbjsPLVmaqLtD2DX1UFh9cXZZ3nXDr8NqkLOpvAbNesPZlas4vzAyG4MqMRk8iTnZEt
         Cp9dEq/u/8ZXj0C9UnfxccSpro0iLZKhgkpdWEzBo/MGugutUi4WcBZkJHaTGc0yW17O
         7v8SPsemPb5HX/KxdDLzvzO3EMoTD8wyuMik9aADy6vTeF4jsF0AwzoZO1OmKEIxd0Ur
         L4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghHV0zTkwP6Ex+XA+hsxUv5AW9dRVc+dHJyFR6M/CLc=;
        b=vU6UjEGwhHplZjNUXET9HJ0iD2usHgRdTUIMTWacS2ft4ozQCs/GYN78zMPDbSQVVd
         nYGrzm+sge8x7wnjUy26uZ4ZAKihtRK2Xw2z6kgu61kh9njmeUiVqzTS22xLgO5E2Dxr
         GWEffgtyhi9iFhigqgtFNVlbGKeQqaU60b06QwO0BFaokKycZho4cR6Qf3xkzi1tBkBB
         oj1cUh81TNl7l76ZZE9hg6YnTObfbbOcPMKXAj1gntjm345nWHRO6uETmdxyphHH7jLt
         tfesUCqeGuyqPbiLSZCkzZtpFGZcWyUSxaIGfqV5xm8YCILpc3EuiYi7JZVFPjvZ0iHE
         cumA==
X-Gm-Message-State: AOAM5310ZiDoufJbKsk66xjW+MiLyamIzWQX3rs2mAI44kY3g0pGWQax
        3+QfGs9bgsoFiXRNMq6puUAsCvqvA1tt7gRdSKnWTA==
X-Google-Smtp-Source: ABdhPJzepy5AOyGRMOgIpV3fZQiTxXLPOoyrx2VNjPNO79OjwG8bFdpXPMisRjuyVZgy6iL646iokaYe4dVaM6pp8hA=
X-Received: by 2002:adf:db86:0:b0:205:bccf:8cbf with SMTP id
 u6-20020adfdb86000000b00205bccf8cbfmr19955087wri.346.1648626753267; Wed, 30
 Mar 2022 00:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220330073347.3898802-1-alistair.francis@opensource.wdc.com>
In-Reply-To: <20220330073347.3898802-1-alistair.francis@opensource.wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 30 Mar 2022 13:22:21 +0530
Message-ID: <CAAhSdy1dSM4e_EwN8znKgkiOiV56JM=44SGpYBMBsKPp1Vxd1A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Ensure only ASIDLEN is used for sfence.vma
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 1:04 PM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> When we set the value of context.id using __new_context() we set both
> the asid and the current_version with this return statement in
> __new_context():
>
>     return asid | ver;
>
> This means that when local_flush_tlb_all_asid() is called with the asid
> specified from context.id we can write the incorrect value.
>
> We get away with this as hardware ignores the extra bits, as the RISC-V
> specification states:
>
> "bits SXLEN-1:ASIDMAX of the value held in rs2 are reserved for future
> standard use. Until their use is defined by a standard extension, they
> should be zeroed by software and ignored by current implementations."
>
> but it is still a bug and worth addressing as we are incorrectly setting
> extra bits.
>
> This patch uses asid_mask when calling sfence.vma to ensure the asid is
> always the correct len (ASIDLEN). This is similar to what we do in
> arch/riscv/mm/context.c.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Instead of fixing various local_flush_tlb_xyz() functions, I suggest fixing the
__sbi_tlb_flush_range() in tlbflush.c which passes incorrect ASID.
(Refer line 45, "unsigned long asid = atomic_long_read(&mm->context.id);")

Also, please add the "Fixes: " tag.

Regards,
Anup

> ---
>  arch/riscv/mm/context.c  | 2 +-
>  arch/riscv/mm/tlbflush.c | 4 ++--
>  include/linux/mm_types.h | 2 ++
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 7acbfbd14557..4329fe54176b 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -22,7 +22,7 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>
>  static unsigned long asid_bits;
>  static unsigned long num_asids;
> -static unsigned long asid_mask;
> +unsigned long asid_mask;
>
>  static atomic_long_t current_version;
>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 37ed760d007c..4469615aa07f 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -10,7 +10,7 @@ static inline void local_flush_tlb_all_asid(unsigned long asid)
>  {
>         __asm__ __volatile__ ("sfence.vma x0, %0"
>                         :
> -                       : "r" (asid)
> +                       : "r" (asid & asid_mask)
>                         : "memory");
>  }
>
> @@ -19,7 +19,7 @@ static inline void local_flush_tlb_page_asid(unsigned long addr,
>  {
>         __asm__ __volatile__ ("sfence.vma %0, %1"
>                         :
> -                       : "r" (addr), "r" (asid)
> +                       : "r" (addr), "r" (asid & asid_mask)
>                         : "memory");
>  }
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 8834e38c06a4..5fa7cc0af853 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -666,6 +666,8 @@ struct mm_struct {
>
>  extern struct mm_struct init_mm;
>
> +extern unsigned long asid_mask;
> +
>  /* Pointer magic because the dynamic array size confuses some compilers. */
>  static inline void mm_init_cpumask(struct mm_struct *mm)
>  {
> --
> 2.35.1
>
