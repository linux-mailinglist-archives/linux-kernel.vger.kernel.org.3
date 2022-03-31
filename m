Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1839D4ED406
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiCaGkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiCaGkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:40:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40542257
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:38:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u3so32275730wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhsMrvk7uoSjbTi4vii+Njn16yDljzTavXJfNLTXs1o=;
        b=0ppl6HuIIj0tw0lDLORVxtX2zZnf26iCrPXAxb68pdWIbUs81VAAJysnKZeS5eg3jq
         zM1sheRcfHZDrOChqEYoG6zmardBGPyQ+ECl5K1kS/QrdwgmBWFpb2GKCKs0ufibNU0E
         i3+dSZKBudhlzaDRDgLf/KNNGutgJwNfZiZEPqGYYdScZLscVZPLDE6NUCeMjIMGBqKf
         kwVVHHLC2bP6DNKqZGocacSSO7K7zckXgSnu3RHWD2tBr617FArpzhyWgcRc20Hql/gA
         BOw1YP0ny3y7IomoeYwEyCbb9PIoKJcENTEWj4/+fUmud9dbUMP3QazF4xQxruWQWP5u
         f1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhsMrvk7uoSjbTi4vii+Njn16yDljzTavXJfNLTXs1o=;
        b=I9N0rxRrU7Wmx8MLIleof5WxA5zGbW1DMT6nfnZ387o3Y/qsAYdT+Q2QKRHKy8Kdoi
         1YeQy0A2n1GctaATftbYi3WG+ob2HYia5X3NC2ywXIrt193nj4c0Cn1CnFV6GYDELHFD
         48rhZ5Hl1sXeQt+AWiL71d0DmpsHtt9IsLdktH5eMZ7L7nmhd+IIqLJrurwe5oxjrjpk
         SVS6+Ha6+HNnyBrwn3CIyFlb/EXFFQo2UVTExa3re/Y5YzNiRPjl1VvISXHbsDAE4xC9
         lP+11ztE+ZKwDSHDaXiWe1eTdLUHYZBhiifQg1LIDJPR1qSKF/qBE8rhGPytBgmMzMuO
         nI8g==
X-Gm-Message-State: AOAM530G0sZ1yQp12Bd6QjFXKZdawRORDDD8Z5oKSbpcF7LkwHXmwpDG
        D2oQW8lT/rgHPDESqvXSYWLyeaUhc8DuPEBzLhZEPQ==
X-Google-Smtp-Source: ABdhPJwlPo2k2le77MErbra2MKKkIRFso47zu94yk0HG7fNt9Z/GkOHIkGqo3ifUCE8gI1xks+gWOFda3GWyy5NDxpc=
X-Received: by 2002:a5d:6e54:0:b0:204:635:42ba with SMTP id
 j20-20020a5d6e54000000b00204063542bamr2831853wrz.214.1648708724508; Wed, 30
 Mar 2022 23:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220331055906.3552337-1-alistair.francis@opensource.wdc.com>
In-Reply-To: <20220331055906.3552337-1-alistair.francis@opensource.wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 31 Mar 2022 12:08:31 +0530
Message-ID: <CAAhSdy2S26jCmUJES3_63jZbn=0uO78=3kob-AAf0a==4d_seA@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Ensure only ASIDLEN is used for sfence.vma
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Alistair Francis <alistair23@gmail.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
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

On Thu, Mar 31, 2022 at 11:29 AM Alistair Francis
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
> Fixes: 3f1e782998cd ("riscv: add ASID-based tlbflushing methods")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> v3:
>  - Use helper function
> v2:
>  - Pass in pre-masked value
>
>  arch/riscv/include/asm/mmu_context.h | 2 ++
>  arch/riscv/mm/context.c              | 5 +++++
>  arch/riscv/mm/tlbflush.c             | 2 +-
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
> index 7030837adc1a..94e82c9e17eb 100644
> --- a/arch/riscv/include/asm/mmu_context.h
> +++ b/arch/riscv/include/asm/mmu_context.h
> @@ -16,6 +16,8 @@
>  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>         struct task_struct *task);
>
> +unsigned long get_mm_asid(struct mm_struct *mm);
> +
>  #define activate_mm activate_mm
>  static inline void activate_mm(struct mm_struct *prev,
>                                struct mm_struct *next)
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 7acbfbd14557..14aec5bacbc1 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -302,6 +302,11 @@ static inline void flush_icache_deferred(struct mm_struct *mm, unsigned int cpu)
>  #endif
>  }
>
> +unsigned long get_mm_asid(struct mm_struct *mm)
> +{
> +       return atomic_long_read(&mm->context.id) & asid_mask;
> +}
> +
>  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>         struct task_struct *task)
>  {
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 37ed760d007c..9c89c4951bee 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -42,7 +42,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>         /* check if the tlbflush needs to be sent to other CPUs */
>         broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
>         if (static_branch_unlikely(&use_asid_allocator)) {
> -               unsigned long asid = atomic_long_read(&mm->context.id);
> +               unsigned long asid = get_mm_asid(mm);
>
>                 if (broadcast) {
>                         sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> --
> 2.35.1
>
