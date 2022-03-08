Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901DB4D24A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 00:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiCHXKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 18:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCHXKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 18:10:31 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFFF6E4FA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 15:09:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id b5so429860wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 15:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1f5gPcrqfy750U/J52Wg+Mj+0/UcxsK3pfUKBKWLDR0=;
        b=rY724zyNQvt0W7k77uJ6mdsljpHhmPedp6A01Ybgi4ape+kd29m4bzWSt+PlFv6VGk
         5F64VH7NbTfh9lbiAtg/QqctdXYwNeto4qq8ILBsk1UjKlgBgsCMQeBPoPLONRLpHghE
         cWdsR0etuAIMnRL3KlwUvfLr789Koi+WEO7RwGW0jHeOJ70GUKcFjnSzplqBRUYBRhT6
         QP8IEuX2CtkcOTNnpXBR5MGZ0IWr8YG+CglWc/j5+G1oi8Hir+ky5riHmAiBgpzzzCL3
         WDmeIljWzrU1rFQ9e3oINeWI9gqLxDH39hU6jNdl97UeioJbJwXvtYXCCKepzEEDLGHC
         BVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1f5gPcrqfy750U/J52Wg+Mj+0/UcxsK3pfUKBKWLDR0=;
        b=bEOhlMhYpST0fnIumWxAU8tdw6za2naxeuhAbQ/0ywMFoCtoMc9XPW0rL0prEzVrIP
         w312e++lnMIqpFc7PO7poMv8VE9BnfOCYGyDblb52k6wBB0/DgvvLHk7FcqgsawMztER
         nYBsFNUk5Q1/dV3xpQJKN3F8POM+/Eq4GgwLC9fG/7zKhExnXgw35VYr/1C19WGsvfGM
         JLAveIiOtbvVOWHgMNO9++kEdKUocPHaIbgpHzxfkOqFSZucBkEem0Lm+ep8kT1ae6Te
         28qCeBHm/q7HvpCGVn61K8mZUwOK9AalA1O4ffyhcUubuMiFTrarsbhNQ8sVdXQFVfOC
         rrLg==
X-Gm-Message-State: AOAM530g5hz0m0cBa66a5H773VmVd86DGyrnTiSmiNpDG7RITG6cozl+
        cIRthINXyLMqO5BcnL5DT7PDLt/mSm5tQYvD/5HvZw==
X-Google-Smtp-Source: ABdhPJwNHy+VN+JXLWCDADBmqbJunnYlm8shlOKM3wtyDi3l0Nvo++c+lLHsCuWeoJlsi7IJiccAZFbP2qFwzcnxW0Q=
X-Received: by 2002:adf:eb86:0:b0:1e6:8c92:af6b with SMTP id
 t6-20020adfeb86000000b001e68c92af6bmr13872277wrn.116.1646780969857; Tue, 08
 Mar 2022 15:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20220307184935.1704614-1-kaleshsingh@google.com>
 <20220307184935.1704614-2-kaleshsingh@google.com> <CAE-0n52LmVRkrSNN=eJf+TYYnmesVjFv99nnetYvRWshm82rOg@mail.gmail.com>
In-Reply-To: <CAE-0n52LmVRkrSNN=eJf+TYYnmesVjFv99nnetYvRWshm82rOg@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 8 Mar 2022 15:09:18 -0800
Message-ID: <CAC_TJvc6LYp95BXQc0DSBBBAZpYpixa+NyHKMLFWsBADD5Ubhg@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] KVM: arm64: Introduce hyp_alloc_private_va_range()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Scull <ascull@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Mar 8, 2022 at 12:21 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
HI Stephen. Thanks for the review.

> Quoting Kalesh Singh (2022-03-07 10:48:59)
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index bc2aba953299..ccb2847ee2f4 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -457,22 +457,17 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> >         return 0;
> >  }
> >
> > -static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> > -                                       unsigned long *haddr,
> > -                                       enum kvm_pgtable_prot prot)
> > +
> > +/**
> > + * hyp_alloc_private_va_range - Allocates a private VA range.
> > + * @size:      The size of the VA range to reserve.
> > + *
> > + * The private VA range is allocated below io_map_base and
> > + * aligned based on the order of @size.
>
> Add what it returns?
>
> Return: Start address of allocated VA range or some error value... (I don't
> understand this part).
>
> It may also be a good idea to write out what VA is in the description:
>
> The private virtual address (VA) range is allocated below io_map_base
>

Ack

> > + */
> > +unsigned long hyp_alloc_private_va_range(size_t size)
> >  {
> >         unsigned long base;
> > -       int ret = 0;
> > -
> > -       if (!kvm_host_owns_hyp_mappings()) {
> > -               base = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
> > -                                        phys_addr, size, prot);
> > -               if (IS_ERR_OR_NULL((void *)base))
> > -                       return PTR_ERR((void *)base);
> > -               *haddr = base;
> > -
> > -               return 0;
> > -       }
> >
> >         mutex_lock(&kvm_hyp_pgd_mutex);
> >
> > @@ -484,29 +479,53 @@ static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> >          *
> >          * The allocated size is always a multiple of PAGE_SIZE.
> >          */
> > -       size = PAGE_ALIGN(size + offset_in_page(phys_addr));
> > -       base = io_map_base - size;
> > +       base = io_map_base - PAGE_ALIGN(size);
> > +
> > +       /* Align the allocation based on the order of its size */
> > +       base = ALIGN_DOWN(base, PAGE_SIZE << get_order(size));
> >
> >         /*
> >          * Verify that BIT(VA_BITS - 1) hasn't been flipped by
> >          * allocating the new area, as it would indicate we've
> >          * overflowed the idmap/IO address range.
> >          */
> > -       if ((base ^ io_map_base) & BIT(VA_BITS - 1))
> > -               ret = -ENOMEM;
> > +       if (!base || (base ^ io_map_base) & BIT(VA_BITS - 1))
> > +               base = (unsigned long)ERR_PTR(-ENOMEM);
>
> It looks odd to use an error pointer casted to unsigned long to return
> from an address allocation function. Why not pass a pointer for base
> like the function was written before and return an int from this
> function with 0 for success and negative error value?Otherwise some
> sort of define should made like DMA_MAPPING_ERROR and that can be used
> to indicate to the caller that the allocation failed, or a simple zero
> may work?

I wanted to keep consistent between the pkvm and traditional nvhe
code. I will refactor both *alloc_private_va_range() functions to take
a pointer and return an int error if that's preferred. There would
still be a case of this kind of cast in
__pkvm_create_private_mapping() which does return an unsigned long
address or ERR_PTR(...). It looks like it was made to return the
address to facilitate use as a hypercall (@Quentin CMIW).

>
> >         else
> >                 io_map_base = base;
> >
> >         mutex_unlock(&kvm_hyp_pgd_mutex);
> >
> > -       if (ret)
> > -               goto out;
> > +       return base;
> > +}
> > +
> > +static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t size,
> > +                                       unsigned long *haddr,
> > +                                       enum kvm_pgtable_prot prot)
> > +{
> > +       unsigned long addr;
> > +       int ret = 0;
> > +
> > +       if (!kvm_host_owns_hyp_mappings()) {
> > +               addr = kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
> > +                                        phys_addr, size, prot);
> > +               if (IS_ERR((void *)addr))
>
> IS_ERR_VALUE()?

Good idea, will remove the extra cast.

>
> > +                       return PTR_ERR((void *)addr);
> > +               *haddr = addr;
> > +
> > +               return 0;
> > +       }
> > +
> > +       size += offset_in_page(phys_addr);
> > +       addr = hyp_alloc_private_va_range(size);
> > +       if (IS_ERR((void *)addr))
>
> IS_ERR_VALUE()?

Ack

>
> > +               return PTR_ERR((void *)addr);
> >
> > -       ret = __create_hyp_mappings(base, size, phys_addr, prot);
> > +       ret = __create_hyp_mappings(addr, size, phys_addr, prot);
> >         if (ret)
> >                 goto out;
> >
> > -       *haddr = base + offset_in_page(phys_addr);
> > +       *haddr = addr + offset_in_page(phys_addr);
> >  out:
> >         return ret;
>
> Would be simpler to remove the goto, or return early.
>
>         if (!ret)
>                 *haddr = addr + offset_in_page(phys_addr);
>
>         return ret;

Agreed, I'll remove the goto in the next version.

Thanks,
Kalesh
>
> >  }
