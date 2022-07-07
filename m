Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E2056AD3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiGGVKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiGGVKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:10:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8096120180;
        Thu,  7 Jul 2022 14:10:35 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r6so13248894edd.7;
        Thu, 07 Jul 2022 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AdpdTZYbKN8gJRPxD9Stl43hDVe6fS4mUMUUh7HWjcY=;
        b=SKnj3TB8ofA+CMXOeG+D0a5OamLrFChv+1BzL0C6Y0XX3FUN7HXK5uKaSuMxPnig7/
         dW/I5/Q0I6/1BJgGtOX4ZAw2HpqfVcYB+bz4r58KkyqjjuePSWsgTyBwCIdOerItTKUS
         DDrkAMND39MkdhcCvpwJ5czI4bq+Q1yAjnBZPpaRmrqk0WtGO3qEXSJvmqbGcZCfhiF0
         XTVauqjumpUibAy1BYEXh3EudCShmcKkfFV7wcO2cVDR9Y5I1ykYKmyx1c2hW1HGaZ1S
         08bGN+ixn0c5tX3dltg3Pbqe8iUCCgS+LrYBL+xMQyw6pUEKT1DOnm1vOaZx9f0VUTwu
         fBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AdpdTZYbKN8gJRPxD9Stl43hDVe6fS4mUMUUh7HWjcY=;
        b=mfn2gY7LS9/Aj3e/hSp1c8ymTbiSN/35F3zUW2koNE9xQOpR5Q12Lxi60Cpkwfrqrc
         vc2HKBaEfuwR/pDXUeYKpzy/LaoWMZqu4SA/W/dd8ozLlC3kjBy5D4qkZEw7F8/bVR0M
         VZA65dyF/i9d1cRFrci/ABESnrSl4wP09zeEvJP7gx2u5j/Hm/JMQpuTqticuFc4MLCg
         knKz2NgMl7qrZ1yL8vLCgCtRQU64RdasFvuTff+88tn0Kw91phQcGsJl3ujL2SpeEkmt
         9/NZHKQfG4ogWAAgEx+t1roexyEOmGQ+0p7wNeS+mY7B/+vnSJDRHXmBW7h99Vs1HUYv
         ralQ==
X-Gm-Message-State: AJIora/VhfPbnBwfFcpFRKyFDoDVc2NWo4pOAwGGFhyZ2E4PckkXFDJJ
        IMgyX2STkl7/bvvFWC2YkSaIQfUaSsAFLwqZ6AM=
X-Google-Smtp-Source: AGRyM1sHv01SRICtjQG4YzhyZUUaToGZ7H53xC8jg1hXK4ki87stazAF/soW7TT5lO5Ox15TejYUuZ56YV26wV0U/BE=
X-Received: by 2002:aa7:c9d2:0:b0:42e:1776:63e0 with SMTP id
 i18-20020aa7c9d2000000b0042e177663e0mr60934edt.185.1657228234041; Thu, 07 Jul
 2022 14:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220707125242.425242-1-21cnbao@gmail.com> <20220707125242.425242-5-21cnbao@gmail.com>
 <Ysbkbt7cvUWSShtc@hirez.programming.kicks-ass.net>
In-Reply-To: <Ysbkbt7cvUWSShtc@hirez.programming.kicks-ass.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 8 Jul 2022 09:10:23 +1200
Message-ID: <CAGsJ_4zamtJcYvsR0xhMmRATjVnuEsaDdC9SkSSQwE4h1EMOxQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: support batched/deferred tlb shootdown during
 page reclamation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LAK <linux-arm-kernel@lists.infradead.org>, x86 <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        Yicong Yang <yangyicong@hisilicon.com>, huzhanyuan@oppo.com,
        =?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>, =?UTF-8?B?6YOt5YGl?= <guojian@oppo.com>,
        real mz <realmz6@gmail.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 8, 2022 at 1:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jul 08, 2022 at 12:52:42AM +1200, Barry Song wrote:
>
> > diff --git a/arch/arm64/include/asm/tlbbatch.h b/arch/arm64/include/asm/tlbbatch.h
> > new file mode 100644
> > index 000000000000..fedb0b87b8db
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/tlbbatch.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ARCH_ARM64_TLBBATCH_H
> > +#define _ARCH_ARM64_TLBBATCH_H
> > +
> > +struct arch_tlbflush_unmap_batch {
> > +     /*
> > +      * For arm64, HW can do tlb shootdown, so we don't
> > +      * need to record cpumask for sending IPI
> > +      */
> > +};
> > +
> > +#endif /* _ARCH_ARM64_TLBBATCH_H */
> > diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> > index 412a3b9a3c25..b3ed163267ca 100644
> > --- a/arch/arm64/include/asm/tlbflush.h
> > +++ b/arch/arm64/include/asm/tlbflush.h
> > @@ -272,6 +272,19 @@ static inline void flush_tlb_page(struct vm_area_struct *vma,
> >       dsb(ish);
> >  }
> >
> > +static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
> > +                                     struct mm_struct *mm,
> > +                                     struct vm_area_struct *vma,
> > +                                     unsigned long uaddr)
> > +{
> > +     flush_tlb_page_nosync(vma, uaddr);
> > +}
>
> You're passing that vma along just to get the mm, that's quite silly and
> trivially fixed.

Yes, this was silly. will include your fix in v2.

>
>
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 412a3b9a3c25..87505ecce1f0 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -254,17 +254,23 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
>         dsb(ish);
>  }
>
> -static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
> -                                        unsigned long uaddr)
> +static inline void __flush_tlb_page_nosync(struct mm_struct *mm,
> +                                          unsigned long uaddr)
>  {
>         unsigned long addr;
>
>         dsb(ishst);
> -       addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
> +       addr = __TLBI_VADDR(uaddr, ASID(mm));
>         __tlbi(vale1is, addr);
>         __tlbi_user(vale1is, addr);
>  }
>
> +static inline void flush_tlb_page_nosync(struct vm_area_struct *vma,
> +                                        unsigned long uaddr)
> +{
> +       return __flush_tlb_page_nosync(vma->vm_mm, uaddr);
> +}
> +
>  static inline void flush_tlb_page(struct vm_area_struct *vma,
>                                   unsigned long uaddr)
>  {

Thanks
Barry
