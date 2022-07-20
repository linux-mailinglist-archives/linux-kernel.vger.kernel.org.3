Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D9157B2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbiGTIUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbiGTIUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:20:17 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4790363F3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:20:14 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j67so8298847ybb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J0M63ZbgDC7xQ5EwBxC6IcpLq6pCXZViuh69dP2t4M4=;
        b=grv6cjZ1OLCbVvxLWw/8kFDTJlSRkm9ybJEqphSyPWnZeLDuEqdr3GrBvDGof30V7E
         N+e0zxzbkxvL4S202GcKPwGLrPDatCiscatboB9DaMc1tqDiEcub9H+KNZU9/UERNW/3
         u9U8R8Sl8O4GMu37Ux+bkD5jYlTEiOhlvUmr6uucfTsGYPngGe0ivN2nfrUoqDefl19h
         ik8weOj8635dTfoyNAzc2jriOWAgpvDE0Jvil0V9eFnDn2YejdSmrXdxk+UaGFs4Vx7g
         LGiAU443ow+tHu5BFnLuHl/kCyAfZJK/eSHeYbbXd03tQj5NoU+MidGoOL4lTD1mAPc2
         bduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J0M63ZbgDC7xQ5EwBxC6IcpLq6pCXZViuh69dP2t4M4=;
        b=eMnDOpisOeyadtqPR6XmvVp33y3/43fqqWkqQyqmUd3nGIQftMe0skZJV4mktp2AV9
         yEaBe/oo9F5gzlLlBamsIBgC5PWm2efDT5he4Izv7HGeTWxUYSOT4ydZ++mZHAGOFuEW
         liNi6gneZQqj5J5Di/pG6fBx7C99zz8Rpjg0QtjladLBUpUZdU8oKkIUN5dpjqAYcErz
         owUc4REZkEES6YXj0I3vMwmAgCQDlY0hQjA0b8YkKaBTpaBvV7vpdSpU/4LeANhdNHfj
         tNBzttAiTmI3pKCQw2bX7Lo0FBj8FWUPHNscD+hqhPbihXSwv4IHXRz5eBkpBOduSljt
         Bjjw==
X-Gm-Message-State: AJIora8h1s8PSvb8K9i53TKQrsFJNX0sVgx405SUFiuQr3tUu+KeyMI/
        oCH/KYly1qAQltZd3CvXbCmcyCaD6FJbCpd6BH/+XQ==
X-Google-Smtp-Source: AGRyM1txbe9fP0TCW8vkpS0DylAxl0pyGSHgCt2clQXUA3ZsUmqZ2G9C/cx/GKTb5b36/jML+lPfm0g24Zl8qdtn+Yg=
X-Received: by 2002:a25:d64a:0:b0:66f:7d56:913d with SMTP id
 n71-20020a25d64a000000b0066f7d56913dmr38735369ybg.199.1658305213152; Wed, 20
 Jul 2022 01:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
 <20220712231328.5294-7-kirill.shutemov@linux.intel.com> <CAG_fn=W-pTCxJ6vEa6aSuAiQDxj0n0_8VgpUhp+TxYDrF8AReg@mail.gmail.com>
 <20220720005724.mwodxwm5r5gayqrm@black.fi.intel.com>
In-Reply-To: <20220720005724.mwodxwm5r5gayqrm@black.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 20 Jul 2022 10:19:36 +0200
Message-ID: <CAG_fn=X=yQrWOX43PbLR=VGRVvMgj0_e2x5Mwf0bSZ0DhTQDAQ@mail.gmail.com>
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

On Wed, Jul 20, 2022 at 2:57 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> On Mon, Jul 18, 2022 at 07:47:44PM +0200, Alexander Potapenko wrote:
> > On Wed, Jul 13, 2022 at 1:13 AM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > Add a couple of arch_prctl() handles:
> > >
> > >  - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required numb=
er
> > >    of tag bits. It is rounded up to the nearest LAM mode that can
> > >    provide it. For now only LAM_U57 is supported, with 6 tag bits.
> > >
> > >  - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
> > >    bits located in the address.
> > >
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > ---
> > >  arch/x86/include/uapi/asm/prctl.h |  3 ++
> > >  arch/x86/kernel/process_64.c      | 60 +++++++++++++++++++++++++++++=
+-
> > >  2 files changed, 62 insertions(+), 1 deletion(-)
> >
> >
> > > +
> > > +static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned l=
ong nr_bits)
> > > +{
> > > +       int ret =3D 0;
> > > +
> > > +       if (!cpu_feature_enabled(X86_FEATURE_LAM))
> > > +               return -ENODEV;
> >
> > Hm, I used to think ENODEV is specific to devices, and -EINVAL is more
> > appropriate here.
> > On the other hand, e.g. prctl(PR_SET_SPECULATION_CTRL) can also return =
ENODEV...
>
> I'm fine either way. Although there are way too many -EINVALs around, so
> it does not communicate much to user.
>
> > >  long do_arch_prctl_64(struct task_struct *task, int option, unsigned=
 long arg2)
> > >  {
> > >         int ret =3D 0;
> > > @@ -829,7 +883,11 @@ long do_arch_prctl_64(struct task_struct *task, =
int option, unsigned long arg2)
> > >         case ARCH_MAP_VDSO_64:
> > >                 return prctl_map_vdso(&vdso_image_64, arg2);
> > >  #endif
> > > -
> > > +       case ARCH_GET_UNTAG_MASK:
> > > +               return put_user(task->mm->context.untag_mask,
> > > +                               (unsigned long __user *)arg2);
> >
> > Can we have ARCH_GET_UNTAG_MASK return the same error value (ENODEV or
> > EINVAL) as ARCH_ENABLE_TAGGED_ADDR in the case the host doesn't
> > support LAM?
> > After all, the mask does not make much sense in this case.
>
> I'm not sure about this.
>
> As it is ARCH_GET_UNTAG_MASK returns -1UL mask if LAM is not present or
> not enabled. Applying this mask will give correct result for both.

Is anyone going to use this mask if tagging is unsupported?
Tools like HWASan won't even try to proceed in that case.

> Why is -ENODEV better here? Looks like just more work for userspace.

This boils down to the question of detecting LAM support I raised previousl=
y.
It's nice to have a syscall without side effects to check whether LAM
can be enabled at all (e.g. one can do the check in the parent process
and conditionally enable LAM in certain, but not all, child processes)
CPUID won't help here, because the presence of the LAM bit in CPUID
doesn't guarantee its support in the kernel, and every other solution
is more complicated than just issuing a system call.

Note that TBI has PR_GET_TAGGED_ADDR_CTRL, which can be used to detect
the presence of memory tagging support.

>
> >
> > > +       case ARCH_ENABLE_TAGGED_ADDR:
> > > +               return prctl_enable_tagged_addr(task->mm, arg2);
> > >         default:
> > >                 ret =3D -EINVAL;
> > >                 break;
> > > --
> > > 2.35.1
> > >
> >
> >
> > --
> > Alexander Potapenko
> > Software Engineer
> >
> > Google Germany GmbH
> > Erika-Mann-Stra=C3=9Fe, 33
> > 80636 M=C3=BCnchen
> >
> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> > Registergericht und -nummer: Hamburg, HRB 86891
> > Sitz der Gesellschaft: Hamburg
>
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
