Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F42C57B6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiGTMyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGTMyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:54:49 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756FB2CE34
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:54:48 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31bf3656517so172304497b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6MykNSDF0KUYwibjFBCq3b0ORJmu6ip9JuWhi6SSOJE=;
        b=eRXP3aCEx2lmpbN1KMjrNmfySXHDiGacVKvvkNNcObLw98s9l+ev1IvPSySX8BPEph
         bgh7pAfvWTSZy2HGa06DzFO6xjSnavfj/svQNfk5g7WSrOk+entTk2uuNq8ifxl9noYI
         0tbNuJtSO2A/yfns2+zlOvOOFhcM6a1+ODv51UVstAnrcgxQQbPNE6aZRAxkVXSaUjTj
         zbKBGxCDdh3xvUMiHVcYMDJ3YzOzc/LKgPmpj8yx+lx8UwFIJRm5ARfGsS0UlFtxUIhN
         pKBf8geZpn1a8pe3VSb1eKl9YZv7P+Vs94ggCR9IZ0+HUHYF//44UcHZ1QtcVTMlhCoz
         Oydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6MykNSDF0KUYwibjFBCq3b0ORJmu6ip9JuWhi6SSOJE=;
        b=B0lZAXJPamNm2HT8Vco34+T6oN71AjPFLR0FEBELlXd06WrFOcqTDAMwLKCz/z1K2p
         YhK6zoHP3IF2AO70CrEcS8a88j2rAi8TDTqXQxI3F0JdKd+xp5taVjG+4QWcShhZJ4AH
         PevQ2dxVE+3vtIi5hsQt3WBFayZSqXhGtExRQEcNFQT47NkfPfB6CGoqUqJ4f3Lpd0Df
         ToBmojxlMHr18xCIGxnzjPAo9KAlNqJGW0OXI9E3ukAadGbXrQ9QOxVgsSOAcpQrxDUm
         HwRtZSVo5q0ZQrDEsF72aIv1FZYXYt4siuCSb81eE70bfF/9YtsX/LgFoQKGyU2HK2mK
         HM1A==
X-Gm-Message-State: AJIora83WyKXLPs6DceUn6OA2ByObs79IYCu8KPOi8/gB3WtcwBhvA2Y
        1deTu6sIGvydrgXeYXqk1UVx99lI20aF9Dvs6QfHM+khJ1PiLA==
X-Google-Smtp-Source: AGRyM1tvgZw3TvNks8earHHPypZ3GgiwZagklNOYPg68FGcg5fLePl2BPJIBtYJ9gHR4yn5Bz65QeAXHP4uFcOAmFP0=
X-Received: by 2002:a81:9148:0:b0:31e:6dd4:3efb with SMTP id
 i69-20020a819148000000b0031e6dd43efbmr2250686ywg.437.1658321687514; Wed, 20
 Jul 2022 05:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
 <20220712231328.5294-7-kirill.shutemov@linux.intel.com> <CAG_fn=W-pTCxJ6vEa6aSuAiQDxj0n0_8VgpUhp+TxYDrF8AReg@mail.gmail.com>
 <20220720005724.mwodxwm5r5gayqrm@black.fi.intel.com> <CAG_fn=X=yQrWOX43PbLR=VGRVvMgj0_e2x5Mwf0bSZ0DhTQDAQ@mail.gmail.com>
 <20220720124744.rpvns3nda7jfljgn@black.fi.intel.com>
In-Reply-To: <20220720124744.rpvns3nda7jfljgn@black.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 20 Jul 2022 14:54:11 +0200
Message-ID: <CAG_fn=X7zzwfbtbhNujGJcQ2xWik9xRpvb5jeN=b12nVFYdR=w@mail.gmail.com>
Subject: Re: [PATCHv5 06/13] x86/mm: Provide ARCH_GET_UNTAG_MASK and ARCH_ENABLE_TAGGED_ADDR
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 2:47 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Wed, Jul 20, 2022 at 10:19:36AM +0200, Alexander Potapenko wrote:
> > > > >  long do_arch_prctl_64(struct task_struct *task, int option, unsi=
gned long arg2)
> > > > >  {
> > > > >         int ret =3D 0;
> > > > > @@ -829,7 +883,11 @@ long do_arch_prctl_64(struct task_struct *ta=
sk, int option, unsigned long arg2)
> > > > >         case ARCH_MAP_VDSO_64:
> > > > >                 return prctl_map_vdso(&vdso_image_64, arg2);
> > > > >  #endif
> > > > > -
> > > > > +       case ARCH_GET_UNTAG_MASK:
> > > > > +               return put_user(task->mm->context.untag_mask,
> > > > > +                               (unsigned long __user *)arg2);
> > > >
> > > > Can we have ARCH_GET_UNTAG_MASK return the same error value (ENODEV=
 or
> > > > EINVAL) as ARCH_ENABLE_TAGGED_ADDR in the case the host doesn't
> > > > support LAM?
> > > > After all, the mask does not make much sense in this case.
> > >
> > > I'm not sure about this.
> > >
> > > As it is ARCH_GET_UNTAG_MASK returns -1UL mask if LAM is not present =
or
> > > not enabled. Applying this mask will give correct result for both.
> >
> > Is anyone going to use this mask if tagging is unsupported?
> > Tools like HWASan won't even try to proceed in that case.
>
> I can imagine the code that tries to be indifferent to whether a pointer
> has tags. It gets mask from ARCH_GET_UNTAG_MASK and applies it to the
> pointer without any conditions.

In that case there would still be just one call to ARCH_GET_UNTAG_MASK
to get the mask that will probably be applied many times.
So there's not a big difference with checking for -ENODEV and setting
that mask manually.
But your proposal with a special arch_prctl indeed looks cleaner.

> > > Why is -ENODEV better here? Looks like just more work for userspace.
> >
> > This boils down to the question of detecting LAM support I raised previ=
ously.
> > It's nice to have a syscall without side effects to check whether LAM
> > can be enabled at all (e.g. one can do the check in the parent process
> > and conditionally enable LAM in certain, but not all, child processes)
> > CPUID won't help here, because the presence of the LAM bit in CPUID
> > doesn't guarantee its support in the kernel, and every other solution
> > is more complicated than just issuing a system call.
> >
> > Note that TBI has PR_GET_TAGGED_ADDR_CTRL, which can be used to detect
> > the presence of memory tagging support.
>
> I would rather make enumeration explicit:

Ok, this would also work. Thanks!

> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/as=
m/prctl.h
> index 38164a05c23c..a31e27b95b19 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -22,5 +22,6 @@
>
>  #define ARCH_GET_UNTAG_MASK            0x4001
>  #define ARCH_ENABLE_TAGGED_ADDR                0x4002
> +#define ARCH_GET_MAX_TAG_BITS          0x4003
>
>  #endif /* _ASM_X86_PRCTL_H */
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index cfa2e42a135a..2e4df63b775f 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -911,6 +911,13 @@ long do_arch_prctl_64(struct task_struct *task, int =
option, unsigned long arg2)
>                                 (unsigned long __user *)arg2);
>         case ARCH_ENABLE_TAGGED_ADDR:
>                 return prctl_enable_tagged_addr(task->mm, arg2);
> +       case ARCH_GET_MAX_TAG_BITS:
> +               if (!cpu_feature_enabled(X86_FEATURE_LAM))
> +                       return put_user(0, (unsigned long __user *)arg2);
> +               else if (lam_u48_allowed())
> +                       return put_user(15, (unsigned long __user *)arg2)=
;
> +               else
> +                       return put_user(6, (unsigned long __user *)arg2);
>         default:
>                 ret =3D -EINVAL;
>                 break;
> --
>  Kirill A. Shutemov



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
