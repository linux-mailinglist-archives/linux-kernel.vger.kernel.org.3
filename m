Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442D559B1FE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 07:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiHUFGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 01:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUFGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 01:06:00 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038CD21243
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:05:58 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3378303138bso175258217b3.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 22:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YiU2Xvn2qxDx9JAzC0b5NS7/wFofs8hu2IbnTOy6ugY=;
        b=cvrZKJm6lX5T7VOULFvC4tncfPdAOgTG4FICCxxW5E3YU+2y4BVl8xcDRrX4Dyy/oH
         7p8ZV/CuBGMU95sb16qkfnyPomela9a1pT3fY+qgnOBZr6LsfNa5eK2xgiQ7hY5oE1yS
         ssJ4vuROb3SpO7vxJzsODH1RqStl/wFQ/HdbcE/CMdjkAE2Qrh1uFgwHqDjvJbEItAYN
         DD/YHEdpDt98vmM18MQVxDu7akRg0XWGepIHXGWdJLQoycnMAMGkdF5s68Q8jgVIe1x0
         vgBZ/623vmU/ZAQZY5nQHIs1lpADp1es7qj9QRckQtNbeVUPu1/FfKWxCK6utYmbAJxn
         sWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YiU2Xvn2qxDx9JAzC0b5NS7/wFofs8hu2IbnTOy6ugY=;
        b=QXsX1vZ3DZTujQr+tpIHQZuvYP10bpsTh9VgmTe4I33Duj9L0EEsUkklOaRuGQ8TNJ
         DIcsNyD3VjGoMLnlpuWQBPtNXdpiojIw/PsZ2VoVlBd7FE9HVNtyEY6XZA2hL5zdUJRk
         8AR/JrHkGGiPY1Jf9V8NXirrZFoHrZf81vPxD4m8Yfm0+apryhgN141nvqw4AVb7doOg
         hLyePEPzu0k6MxRSehbC7M8U6/iSrIZy2LoaC1CF/pEq0/WXYg3S9UGeZs/Kswp4zsqH
         3k+Q/Lhs68zAPHcj4Y8ac17yf+Kz39gUQv0cSckfYPIHv7cUtW8MHOE4FR2M9ljYs8Py
         NP3Q==
X-Gm-Message-State: ACgBeo230IwOfoZ9xnaOFPo+CLWCjZMZDPrXIZotW0nLZ3YUE9iG5XqN
        x4O6buoUt9JpfL00IQ/ST69RaYH27y/3xrsk+gDZ9A==
X-Google-Smtp-Source: AA6agR6k2S6F3dSjpvLw8Ek//0O+/wxHapE1H+nW/O/u/R2Lqcs8BdM9Q4bL1vkb7w/VG8B6BMiYqrN0Z8EkUCplu9A=
X-Received: by 2002:a5b:104:0:b0:68e:c5d0:d042 with SMTP id
 4-20020a5b0104000000b0068ec5d0d042mr14426842ybx.315.1661058357078; Sat, 20
 Aug 2022 22:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220821013926.8968-1-tjytimi@163.com>
In-Reply-To: <20220821013926.8968-1-tjytimi@163.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 21 Aug 2022 10:35:45 +0530
Message-ID: <CAAhSdy1Qxwn=Eax6ECEkdRe=mQeL+J0TPCpOc1LMbN1y8-p4UQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] riscv: make update_mmu_cache to support asid
To:     Jinyu Tang <tjytimi@163.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alexandre.ghiti@canonical.com,
        guoren@kernel.org, akpm@linux-foundation.org, heiko@sntech.de,
        panqinglin2020@iscas.ac.cn, unnanyong@huawei.com,
        tongtiangen@huawei.com, anshuman.khandual@arm.com,
        atishp@rivosinc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, falcon@tinylab.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 7:09 AM Jinyu Tang <tjytimi@163.com> wrote:
>
> The `update_mmu_cache` function in riscv flush tlb cache without asid
> information now, which will flush tlbs in other tasks' address space
> even if processor support asid. So add a new function
> `flush_tlb_local_one_page` to flush local one page whether processor
> supports asid or not. If asid is supported, this function will use it.
>
> Signed-off-by: Jinyu Tang <tjytimi@163.com>

This is already covered by PATCH6 of the IPI improvement series.
https://www.spinics.net/lists/kernel/msg4481428.html

Regards,
Anup

> ---
>  arch/riscv/include/asm/pgtable.h  |  2 +-
>  arch/riscv/include/asm/tlbflush.h |  2 ++
>  arch/riscv/mm/tlbflush.c          | 11 +++++++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 7ec936910a96..09ccefa6b6c7 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -415,7 +415,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>          * Relying on flush_tlb_fix_spurious_fault would suffice, but
>          * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
>          */
> -       local_flush_tlb_page(address);
> +       flush_tlb_local_one_page(vma, address);
>  }
>
>  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 801019381dea..120aeb1c6ecf 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -30,6 +30,7 @@ static inline void local_flush_tlb_page(unsigned long addr)
>  #if defined(CONFIG_SMP) && defined(CONFIG_MMU)
>  void flush_tlb_all(void);
>  void flush_tlb_mm(struct mm_struct *mm);
> +void flush_tlb_local_one_page(struct vm_area_struct *vma, unsigned long addr);
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>                      unsigned long end);
> @@ -42,6 +43,7 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>
>  #define flush_tlb_all() local_flush_tlb_all()
>  #define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
> +#define flush_tlb_local_one_page(vma, addr) local_flush_tlb_page(addr)
>
>  static inline void flush_tlb_range(struct vm_area_struct *vma,
>                 unsigned long start, unsigned long end)
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 37ed760d007c..a2634ce55626 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -64,6 +64,17 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>         put_cpu();
>  }
>
> +void flush_tlb_local_one_page(struct vm_area_struct *vma, unsigned long addr)
> +{
> +       if (static_branch_unlikely(&use_asid_allocator)) {
> +               unsigned long asid = atomic_long_read(&vma->vm_mm->context.id);
> +
> +               local_flush_tlb_page_asid(addr, asid);
> +       } else {
> +               local_flush_tlb_page(addr);
> +       }
> +}
> +
>  void flush_tlb_mm(struct mm_struct *mm)
>  {
>         __sbi_tlb_flush_range(mm, 0, -1, PAGE_SIZE);
> --
> 2.30.2
>
