Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645EB51F326
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbiEID71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbiEID4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:56:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD6A1AF28
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:52:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so7526025wme.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 20:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l12WE5mp9PhO1IPRjTjpwmDGOQ7wb/4a5m9y3nBGeOA=;
        b=pvxaieywYUVpcXk0gT3Q+TKVFmt3IoMc62S6eEy129dttwYSJqT9gWsXPzLeg+zFPI
         PLe7o1fK9XGaF1Qesmimu/v+hehti1bDynbD4bKR/jpI1CYfNzYt6QF2rR7GxoW4FJ9t
         0kHZGsLEq7+bVTe4bIW5WVDYJL3zfzvAl63bDcfyCH/k73KZYhfI5iQeSZkRXci8yJCi
         mS1IfKYGnAxTSiGDmgemHWf/sStPKQ4nK5xMhXbQTNxlK0z2CaBgcTbNJJ3WQ/p4E6hh
         QjQGB47vH+kz7OiQHuN41JmNpw6cK7sULCd4ksimYRZehABS2BXGakngjKeoHtaH4av5
         AklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l12WE5mp9PhO1IPRjTjpwmDGOQ7wb/4a5m9y3nBGeOA=;
        b=ru5QqPtDYYJl/5a7sSgpdtoSjHHuLsYfZ4Bh7L/n3e6lWy5xeR5o0mD/FKbc7kvPRE
         vhegORkaioleG1//KdZ7TPbAvhPg6rnbFQ1xwCMVvjFYFTG7PNayrOHtNbe4I/VhbwOe
         YttMeldXTkqdpV8c6EYFGO9hL4Y6FU6cwEuI0J9yb/rAGDqx1gB4ShYPXqHQ9i0mWvI6
         HaSJhpahcUOEOswLCI/bmwY/5G+akzL7ZiTkElW/psmbnxy4Hv1tC5PTfUU1vNEi+l8R
         38hv3iD+IHPe3Ms01v/pljPhjiLsaw5Yi0ZAXDDDpZUuVCtdgPY79eWG/Do9zNkEM0dH
         FawQ==
X-Gm-Message-State: AOAM533O2ElYSHm6i5JI01wTHBIAc/8YWxszkpdViwVvt4/Yn/E8ZVy1
        6BWTVmm1grHTaumFUAa0xoIlbsLlw7XF1TLTEv8sgg==
X-Google-Smtp-Source: ABdhPJwC1APi3CYSHkdsQEXeqQMbYX056D1XGJXeGfizpAHDTp/Hd2oR5snXTCoQWjC29wCqNqBAMXzIclLr3fpNcSY=
X-Received: by 2002:a05:600c:4fd5:b0:394:55ae:32c7 with SMTP id
 o21-20020a05600c4fd500b0039455ae32c7mr20677459wmq.73.1652068323237; Sun, 08
 May 2022 20:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220508160749.984-1-jszhang@kernel.org> <20220508160749.984-2-jszhang@kernel.org>
In-Reply-To: <20220508160749.984-2-jszhang@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 May 2022 09:21:52 +0530
Message-ID: <CAAhSdy2-L+eSE5P+-TG94exgTsDp8wPiuhD23fZQ88nukoNj-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] riscv: mm: init: make pt_ops_set_[early|late|fixmap]
 static
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 8, 2022 at 9:46 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> These three functions are only used in init.c, so make them static.
> Fix W=1 warnings like below:
>
> arch/riscv/mm/init.c:721:13: warning: no previous prototype for function
> 'pt_ops_set_early' [-Wmissing-prototypes]
>    void __init pt_ops_set_early(void)
>                ^
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/mm/init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 05ed641a1134..5f3f26dd9f21 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -849,7 +849,7 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
>   * MMU is not enabled, the page tables are allocated directly using
>   * early_pmd/pud/p4d and the address returned is the physical one.
>   */
> -void __init pt_ops_set_early(void)
> +static void __init pt_ops_set_early(void)
>  {
>         pt_ops.alloc_pte = alloc_pte_early;
>         pt_ops.get_pte_virt = get_pte_virt_early;
> @@ -871,7 +871,7 @@ void __init pt_ops_set_early(void)
>   * Note that this is called with MMU disabled, hence kernel_mapping_pa_to_va,
>   * but it will be used as described above.
>   */
> -void __init pt_ops_set_fixmap(void)
> +static void __init pt_ops_set_fixmap(void)
>  {
>         pt_ops.alloc_pte = kernel_mapping_pa_to_va((uintptr_t)alloc_pte_fixmap);
>         pt_ops.get_pte_virt = kernel_mapping_pa_to_va((uintptr_t)get_pte_virt_fixmap);
> @@ -889,7 +889,7 @@ void __init pt_ops_set_fixmap(void)
>   * MMU is enabled and page table setup is complete, so from now, we can use
>   * generic page allocation functions to setup page table.
>   */
> -void __init pt_ops_set_late(void)
> +static void __init pt_ops_set_late(void)
>  {
>         pt_ops.alloc_pte = alloc_pte_late;
>         pt_ops.get_pte_virt = get_pte_virt_late;
> --
> 2.34.1
>
