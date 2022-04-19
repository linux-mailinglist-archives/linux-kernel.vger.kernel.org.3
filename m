Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F0A506207
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 04:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbiDSCYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 22:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbiDSCYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 22:24:48 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50252C114
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:22:06 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w4so20516857wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 19:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n+VD1ZLkqdIRZk14tkWWBvFTuLPHtENe5xxNWUW39oc=;
        b=Ed89L1TbCOHX0GMewIVyqVWOHKCwpZFh6Xboc1pomP5SRDGBMLlWHTE2CQyILMFqpF
         Vtv9jDZNsrHIU592acO7LeV0XpwY/UnF6tXS9lRZzWtSV2doVXSdUFWUa6OOzGVgvgGq
         2/vacyYGKcySeT6hLAslemI33GnQwtOFeceIpRvwSfBVjGFxvhy2J5n2eaXoQAgohQun
         vKCw0fe5gY2JHUrbRATR41VIwQDYUTxtBbO3mt4gb4ySRlsTWik58f+e0Bt6OlMXoXCr
         Ew40jqusTkSv8EMI0a2bYezSy9FjY7QBP0YdhEDi4ZxyCgXr+6WFc+gqhAeINrM9B73n
         cP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n+VD1ZLkqdIRZk14tkWWBvFTuLPHtENe5xxNWUW39oc=;
        b=Fx97cHNVg31nEdM8L782653NXiuGV2r+Ww4mN5mk5TDySRU4HYnGBRdgrtmfIo0Iy6
         /FxZ/4uPYRj0iyq+iCSnX2TNQjsZqxWW6HdjiIURvb31FgymPWqs385y/f3NfloWcEUS
         ndvOBRbVpMlLYqxqB3UGRT1x9g72VtMIBIcDfDLi3xCskOYhk4YHzg9dYuVYC4Imu4Nx
         AISVedRA6mH6b2Y+6d4cKCcdekWd9IeiLF2S+dDWy5L2fLmFns+vy7yjIc2OtRF+Bs52
         nN44sNmmnKrXYqZCPJksupVCPGmCeqnv0S+vEL0D9P8xzn0kCY+UuvEcmB+bpFiLkgaz
         Khjw==
X-Gm-Message-State: AOAM5338YBXVe0fbiXOyMEimSQxN5Q/oqdzm8mdl8ZufWE2mK0TPK9iq
        XiGpH3PfCsT4ZA5TjamhYviO3OlP/nWdBCwA2F3Cwg==
X-Google-Smtp-Source: ABdhPJxDZsRjY1yyiT9xyWlpyKGcb/9NBMknXlqpDTDxx0KSq1BjuaoOenMyQwXm9jUUi8hrDt7biKcLIlxbeJ3LqtE=
X-Received: by 2002:a5d:528b:0:b0:203:d928:834c with SMTP id
 c11-20020a5d528b000000b00203d928834cmr10226506wrv.500.1650334925196; Mon, 18
 Apr 2022 19:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220408200349.1529080-1-kaleshsingh@google.com>
 <20220408200349.1529080-2-kaleshsingh@google.com> <87bkx8cdt4.wl-maz@kernel.org>
In-Reply-To: <87bkx8cdt4.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Apr 2022 19:21:54 -0700
Message-ID: <CAC_TJvd7wqad6SGKfG5+2tOHEjCcJttsG01supYEd_4sezP7pg@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] KVM: arm64: Introduce hyp_alloc_private_va_range()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Changbin Du <changbin.du@intel.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Apr 10, 2022 at 11:52 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 08 Apr 2022 21:03:24 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > hyp_alloc_private_va_range() can be used to reserve private VA ranges
> > in the nVHE hypervisor. Allocations are aligned based on the order of
> > the requested size.
> >
> > This will be used to implement stack guard pages for KVM nVHE hyperviso=
r
> > (nVHE Hyp mode / not pKVM), in a subsequent patch in the series.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > Tested-by: Fuad Tabba <tabba@google.com>
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> > ---
> >
> > Changes in v7:
> >   - Add Fuad's Reviewed-by and Tested-by tags.
> >
> > Changes in v6:
> >   - Update kernel-doc for hyp_alloc_private_va_range()
> >     and add return description, per Stephen
> >   - Update hyp_alloc_private_va_range() to return an int error code,
> >     per Stephen
> >   - Replace IS_ERR() checks with IS_ERR_VALUE() check, per Stephen
> >   - Clean up goto, per Stephen
> >
> > Changes in v5:
> >   - Align private allocations based on the order of their size, per Mar=
c
> >
> > Changes in v4:
> >   - Handle null ptr in hyp_alloc_private_va_range() and replace
> >     IS_ERR_OR_NULL checks in callers with IS_ERR checks, per Fuad
> >   - Fix kernel-doc comments format, per Fuad
> >
> > Changes in v3:
> >   - Handle null ptr in IS_ERR_OR_NULL checks, per Mark
> >
> >
> >  arch/arm64/include/asm/kvm_mmu.h |  1 +
> >  arch/arm64/kvm/mmu.c             | 66 +++++++++++++++++++++-----------
> >  2 files changed, 45 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/=
kvm_mmu.h
> > index 74735a864eee..a50cbb5ba402 100644
> > --- a/arch/arm64/include/asm/kvm_mmu.h
> > +++ b/arch/arm64/include/asm/kvm_mmu.h
> > @@ -154,6 +154,7 @@ static __always_inline unsigned long __kern_hyp_va(=
unsigned long v)
> >  int kvm_share_hyp(void *from, void *to);
> >  void kvm_unshare_hyp(void *from, void *to);
> >  int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot pr=
ot);
> > +int hyp_alloc_private_va_range(size_t size, unsigned long *haddr);
> >  int create_hyp_io_mappings(phys_addr_t phys_addr, size_t size,
> >                          void __iomem **kaddr,
> >                          void __iomem **haddr);
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 0d19259454d8..3d3efea4e991 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -457,23 +457,22 @@ int create_hyp_mappings(void *from, void *to, enu=
m kvm_pgtable_prot prot)
> >       return 0;
> >  }
> >
> > -static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t =
size,
> > -                                     unsigned long *haddr,
> > -                                     enum kvm_pgtable_prot prot)
> > +
> > +/**
> > + * hyp_alloc_private_va_range - Allocates a private VA range.
> > + * @size:    The size of the VA range to reserve.
> > + * @haddr:   The hypervisor virtual start address of the allocation.
> > + *
> > + * The private virtual address (VA) range is allocated below io_map_ba=
se
> > + * and aligned based on the order of @size.
> > + *
> > + * Return: 0 on success or negative error code on failure.
> > + */
> > +int hyp_alloc_private_va_range(size_t size, unsigned long *haddr)
> >  {
> >       unsigned long base;
> >       int ret =3D 0;
> >
> > -     if (!kvm_host_owns_hyp_mappings()) {
> > -             base =3D kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
> > -                                      phys_addr, size, prot);
> > -             if (IS_ERR_OR_NULL((void *)base))
> > -                     return PTR_ERR((void *)base);
> > -             *haddr =3D base;
> > -
> > -             return 0;
> > -     }
> > -
> >       mutex_lock(&kvm_hyp_pgd_mutex);
> >
> >       /*
> > @@ -484,30 +483,53 @@ static int __create_hyp_private_mapping(phys_addr=
_t phys_addr, size_t size,
> >        *
> >        * The allocated size is always a multiple of PAGE_SIZE.
> >        */
> > -     size =3D PAGE_ALIGN(size + offset_in_page(phys_addr));
> > -     base =3D io_map_base - size;
> > +     base =3D io_map_base - PAGE_ALIGN(size);
> > +
> > +     /* Align the allocation based on the order of its size */
> > +     base =3D ALIGN_DOWN(base, PAGE_SIZE << get_order(size));
> >
> >       /*
> >        * Verify that BIT(VA_BITS - 1) hasn't been flipped by
> >        * allocating the new area, as it would indicate we've
> >        * overflowed the idmap/IO address range.
> >        */
> > -     if ((base ^ io_map_base) & BIT(VA_BITS - 1))
> > +     if (!base || (base ^ io_map_base) & BIT(VA_BITS - 1))
>
> I don't get this '!base' check. Why isn't it encompassed by the
> 'VA_BITS - 1' flip check?

Hi Marc, You're right. The flip check handles this as well. I=E2=80=99ll dr=
op
in the next version.

>
> >               ret =3D -ENOMEM;
> >       else
> > -             io_map_base =3D base;
> > +             *haddr =3D io_map_base =3D base;
> >
> >       mutex_unlock(&kvm_hyp_pgd_mutex);
> >
> > +     return ret;
> > +}
> > +
> > +static int __create_hyp_private_mapping(phys_addr_t phys_addr, size_t =
size,
> > +                                     unsigned long *haddr,
> > +                                     enum kvm_pgtable_prot prot)
> > +{
> > +     unsigned long addr;
> > +     int ret =3D 0;
> > +
> > +     if (!kvm_host_owns_hyp_mappings()) {
> > +             addr =3D kvm_call_hyp_nvhe(__pkvm_create_private_mapping,
> > +                                      phys_addr, size, prot);
> > +             if (IS_ERR_VALUE(addr))
> > +                     return addr;
> > +             *haddr =3D addr;
> > +
> > +             return 0;
> > +     }
> > +
> > +     size +=3D offset_in_page(phys_addr);
>
> This hardly makes any sense on its own. I get it that it is still
> doing the right thing as hyp_alloc_private_va_range() will fix it up,
> but I'd rather you keep the PAGE_ALIGN() here, even if it ends up
> being duplicated.

Ack

Thanks,
Kalesh

>
> > +     ret =3D hyp_alloc_private_va_range(size, &addr);
> >       if (ret)
> > -             goto out;
> > +             return ret;
> >
> > -     ret =3D __create_hyp_mappings(base, size, phys_addr, prot);
> > +     ret =3D __create_hyp_mappings(addr, size, phys_addr, prot);
> >       if (ret)
> > -             goto out;
> > +             return ret;
> >
> > -     *haddr =3D base + offset_in_page(phys_addr);
> > -out:
> > +     *haddr =3D addr + offset_in_page(phys_addr);
> >       return ret;
> >  }
> >
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
