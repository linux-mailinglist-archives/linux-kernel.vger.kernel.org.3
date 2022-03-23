Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131644E57C1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbiCWRo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243035AbiCWRoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:44:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A430384EEE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:42:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u26so2720122eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXItiXCQz5Vw2Hrps28AyoQxpxOIY3YlmmRg+b0brOE=;
        b=Ad5P83rtyjFJkIHpTwqdisAfJ/ztomVrkyAP+/G5xcG7X7fSZdTAaNlkX1NuUaO62v
         6aGCEicDllFaaP4wKxcjPdZ8/eBjrIcBioriIOWrBPlQXjDgDH3HATEcmEq4pjmYmyuL
         sNPU+M67PiW55rp6J4ntdoUUQq3sdqTdfGCWVfLFYxhpAQWUXVy4wevJiFkU2IMHO6Xl
         JPn1R6Jk+K+BjwjAF55y5ojrOPrvDZxddQtL6CQMHjNSNskYTkA8hejsHn2YnvwD/rz0
         mzsS1QCUXyKXqlpj49Xo/tbAm5QXBY6vtamYRPwNdpX+LKjs8TCuwOUPC003HsbCgdXZ
         Y9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXItiXCQz5Vw2Hrps28AyoQxpxOIY3YlmmRg+b0brOE=;
        b=EwIViC0CoVwMvthRPXvfmUF97lW8h5DIknBOsZMMUP7kdTg5gd0IFw8a3QXKSZ/Csg
         j5w1TDWrx7CZZkqt75MQnlXg0+eg2s/Jy5zUZRQWzIiBSwpPrxheQP3B+0Z5VDr0y0sZ
         FVCirDeCHAT/0xgPtKMmdiCeZfFN+7M6Iq2OMBYV2Xgs+XOjjWxZS3k5A/GXdQ96fWug
         ydtAYQ8ivxb0g8419BJpgkio3RYg37TXgF1gwTHb+CmqIeYZ8DkGbAo2KWBP+dcWroc4
         hskWu/IkSucv4614+cp+BL3Fag14L7piVso9gPxQDk2/RPMImlmZgMYEupQZs/qMC8Ns
         UWWg==
X-Gm-Message-State: AOAM532dmwImBHSiSKVdghFpIyD+SNJRxTpkziOdleBcF4rl2zg6qzpT
        p8dBjxV4O1p+LcTu92+kAM8qjyT2PO2Z1GoIHV80Wg==
X-Google-Smtp-Source: ABdhPJy6cLr1ddZfcfPHFBk/SvkOJjbyy8M1sRFi3dxI2xQMUYKnKZHJSoBfOoqSYj8bhYV5u6Fc1RkjdJy1KyGB1XQ=
X-Received: by 2002:aa7:dbd0:0:b0:416:633c:a0cc with SMTP id
 v16-20020aa7dbd0000000b00416633ca0ccmr1530996edt.349.1648057373156; Wed, 23
 Mar 2022 10:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220322144447.3563146-1-tongtiangen@huawei.com> <20220322144447.3563146-3-tongtiangen@huawei.com>
In-Reply-To: <20220322144447.3563146-3-tongtiangen@huawei.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 23 Mar 2022 13:42:16 -0400
Message-ID: <CA+CK2bAa96oE0FbtJUjAJ=vpuzQsW3R60K9SUhca6mZ3BL1f8w@mail.gmail.com>
Subject: Re: [PATCH -next v2 2/4] mm: page_table_check: add hooks to public helpers
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:25 AM Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> Move ptep_clear() to the include/linux/pgtable.h and add page table check
> relate hooks to some helpers, it's prepare for support page table check
> feature on new architecture.
>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  arch/x86/include/asm/pgtable.h | 10 ----------
>  include/linux/pgtable.h        | 27 +++++++++++++++++++--------
>  2 files changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 8cd6514e3052..8c85f2eabbaa 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1077,16 +1077,6 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>         return pte;
>  }
>
> -#define __HAVE_ARCH_PTEP_CLEAR
> -static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
> -                             pte_t *ptep)
> -{
> -       if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK))
> -               ptep_get_and_clear(mm, addr, ptep);
> -       else
> -               pte_clear(mm, addr, ptep);
> -}
> -
>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>                                       unsigned long addr, pte_t *ptep)
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index f4f4077b97aa..d27fd0ed84a9 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -12,6 +12,7 @@
>  #include <linux/bug.h>
>  #include <linux/errno.h>
>  #include <asm-generic/pgtable_uffd.h>
> +#include <linux/page_table_check.h>
>
>  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLDED) - \
>         defined(__PAGETABLE_PMD_FOLDED) != CONFIG_PGTABLE_LEVELS
> @@ -259,14 +260,6 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #endif
>
> -#ifndef __HAVE_ARCH_PTEP_CLEAR
> -static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
> -                             pte_t *ptep)
> -{
> -       pte_clear(mm, addr, ptep);
> -}
> -#endif
> -
>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>                                        unsigned long address,
> @@ -274,10 +267,23 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  {
>         pte_t pte = *ptep;
>         pte_clear(mm, address, ptep);
> +       page_table_check_pte_clear(mm, address, pte);
>         return pte;
>  }
>  #endif
>
> +#ifndef __HAVE_ARCH_PTEP_CLEAR
> +static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
> +                             pte_t *ptep)
> +{
> +#ifdef CONFIG_PAGE_TABLE_CHECK
> +       ptep_get_and_clear(mm, addr, ptep);
> +#else
> +       pte_clear(mm, addr, ptep);
> +#endif

I have a preference to use if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK))
instead of #ifdef. The end result is the same. Otherwise it looks
good.

Thanks,
Pasha
