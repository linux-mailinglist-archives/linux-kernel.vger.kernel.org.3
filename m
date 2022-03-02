Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9804CA117
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240621AbiCBJqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiCBJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:46:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D623EF0F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:45:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D94261589
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856C9C340EF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646214358;
        bh=2JnRdqk9IpbS2csdbNfGa/teFvYHGo28QkZ62lr+Dws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qfMtk41Dv85APtPi8l9R6uufvD2N9rrV/Lk5bQgs9VzeDpGrWN4DJn5d9hgyz0Cb+
         ZGBbGCY+EqIcUJ8NZJkeE5K+gh/wGJVkQ3qwUm7pcrGM1GXL1G1yhW3emdYYZB9+59
         OpZUukkg8JdYu3aeONCpZXdLcgHzAOOSpTHoLyuVHZyV0KCBYT1NvGWTWMtrn/z7k5
         h1LhsZF6kp1Cvy0W0xf5LRINDpE28jxM3YmOg2Li4HL6VCwNXfW/5NrhOdSGRlxKa9
         fkULnNS/z09J2cSwcj+ivkjgnStoHymEJXFFBCC9AgABnZp7NTQhaLv7NSiicCY36B
         QFJHqDroqCrKw==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2dbd97f9bfcso10408847b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 01:45:58 -0800 (PST)
X-Gm-Message-State: AOAM532orE3Rp5lRIu/pCWQuXEzIc4tBzEQGyQizS6k9gzKs9cqYneBw
        XNqp1XiTORW3j3xSe7vZIlzYgJa1zP9wYs4SciE=
X-Google-Smtp-Source: ABdhPJy8nJPrKgjnbXTEDSLNhyS8V4ljopIoHhZI6FY00r4UrNDHSYwhSyKDn+3vK05t64V8Q7MFIK2OhPPoA4pswM0=
X-Received: by 2002:a81:84d5:0:b0:2d1:e85:bf04 with SMTP id
 u204-20020a8184d5000000b002d10e85bf04mr29646515ywf.465.1646214357573; Wed, 02
 Mar 2022 01:45:57 -0800 (PST)
MIME-Version: 1.0
References: <Yh5ASXVoWoMj7/Rr@Red> <Yh5AlfprVAZvJDJA@shell.armlinux.org.uk>
 <CAMj1kXGRTM99F_Q29Q4G2Q4L6WSHn2YY+_QZCXQGmw=yWPe1mQ@mail.gmail.com>
 <CAMj1kXEy6n3zZ8Z51kP=tTuOU0xCXLLfC-b6BMpdsjMoM7zGBg@mail.gmail.com>
 <Yh8tWdiWPgZLyQtx@Red> <CAMj1kXGRtdftpoqmd7HBonBBS67jO=YWzoESPAagGfQBZUDQWg@mail.gmail.com>
 <Yh8w7ldudhmbYv4N@Red>
In-Reply-To: <Yh8w7ldudhmbYv4N@Red>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 2 Mar 2022 10:45:46 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHri2_tnYhu2gE9xTUOxLY9v1=zODCo1BGfjFTKukiedA@mail.gmail.com>
Message-ID: <CAMj1kXHri2_tnYhu2gE9xTUOxLY9v1=zODCo1BGfjFTKukiedA@mail.gmail.com>
Subject: Re: boot flooded with unwind: Index not found
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 09:55, Corentin Labbe <clabbe.montjoie@gmail.com> wro=
te:
>
> Le Wed, Mar 02, 2022 at 09:44:52AM +0100, Ard Biesheuvel a =C3=A9crit :
> > On Wed, 2 Mar 2022 at 09:40, Corentin Labbe <clabbe.montjoie@gmail.com>=
 wrote:
> > >
> > > Le Tue, Mar 01, 2022 at 05:52:30PM +0100, Ard Biesheuvel a =C3=A9crit=
 :
> > > > On Tue, 1 Mar 2022 at 17:37, Ard Biesheuvel <ardb@kernel.org> wrote=
:
> > > > >
> > > > > On Tue, 1 Mar 2022 at 16:52, Russell King (Oracle)
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > >
> > > > > > On Tue, Mar 01, 2022 at 04:48:25PM +0100, Corentin Labbe wrote:
> > > > > > > Hello
> > > > > > >
> > > > > > > I booted today linux-next (20220301) and my boot is flooded w=
ith:
> > > > > > > [    0.000000] unwind: Index not found c0f0c440
> > > > > > > [    0.000000] unwind: Index not found 00000000
> > > > > > > [    0.000000] unwind: Index not found c0f0c440
> > > > > > > [    0.000000] unwind: Index not found 00000000
> > > > > > >
> > > > > > > This happen on a sun8i-a83t-bananapi-m3
> > > > > >
> > > > > > Have you enabled vmapped stacks?
> > > > > >
> > > > >
> > > > > This is probably related to
> > > > >
> > > > > 538b9265c063 ARM: unwind: track location of LR value in stack fra=
me
> > > > >
> > > > > which removes a kernel_text_address() check on frame->pc as it is
> > > > > essentially redundant, given that we won't find unwind data other=
wise.
> > > > > Unfortunately, I failed to realise that the other check carries a
> > > > > pr_warn(), which may apparently fire spuriously in some cases.
> > > > >
> > > > > The 0x0 value can easily be filtered out, but i would be interest=
ing
> > > > > where the other value originates from. We might be able to solve =
this
> > > > > with a simple .nounwind directive in a asm routine somewhere.
> > > > >
> > > > > I'll prepare a patch that disregards the 0x0 value - could you ch=
eck
> > > > > in the mean time what the address 0xcf0c440 coincides with in you=
r
> > > > > build?
> > > >
> > > > Something like the below should restore the previous behavior, whil=
e
> > > > taking the kernel_text_address() check out of the hot path.
> > > >
> > > > --- a/arch/arm/kernel/unwind.c
> > > > +++ b/arch/arm/kernel/unwind.c
> > > > @@ -400,7 +400,8 @@ int unwind_frame(struct stackframe *frame)
> > > >
> > > >         idx =3D unwind_find_idx(frame->pc);
> > > >         if (!idx) {
> > > > -               pr_warn("unwind: Index not found %08lx\n", frame->p=
c);
> > > > +               if (frame->pc && kernel_text_address(frame->pc))
> > > > +                       pr_warn("unwind: Index not found %08lx\n", =
frame->pc);
> > > >                 return -URC_FAILURE;
> > > >         }
> > >
> > > Hello
> > >
> > > This is a more detailed trace from my follow up after your patch:
> >
> > So the log below is from a kernel that has the above patch applied?
> > Could you please share the .config?
> >
>
> Yes this is a kernel with above patch applied (this board do not boot wit=
hout it).

It's not entirely clear to me how (or whether) the recent changes to
unwind.c cause this issue, but one thing that stands out in the
current code is the unguarded dereference of a value pulled of the
stack as a memory address.

It is worth noting that the only unwind entries in vmlinux that load
SP from the stack directly (as opposed to unwinding it by moving from
the frame pointer or by addition/subtraction) are the
__irq_svc/__pabt_svc/__dabt_svc entry routines, and given that the
bogus address 60000013 looks suspiciously like a PSR value (which is
stored in the vicinity of SP on the exception stack), my suspicion is
that some unwinder annotations are out of sync with the actual code.

So while the below does not fix the root cause, i.e., that the
unwinder unwinds SP incorrectly causing us to dereference a bogus
pointer, it should avoid the subsequent crash. Please give it a go.

--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -27,6 +27,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/uaccess.h>
 #include <linux/list.h>

 #include <asm/sections.h>
@@ -236,10 +237,11 @@ static int unwind_pop_register(struct
unwind_ctrl_block *ctrl,
                if (*vsp >=3D (unsigned long *)ctrl->sp_high)
                        return -URC_FAILURE;

-       /* Use READ_ONCE_NOCHECK here to avoid this memory access
-        * from being tracked by KASAN.
+       /* Use get_kernel_nofault() here to avoid this memory access
+        * from causing a fatal fault, and from being tracked by KASAN.
         */
-       ctrl->vrs[reg] =3D READ_ONCE_NOCHECK(*(*vsp));
+       if (get_kernel_nofault(ctrl->vrs[reg], *vsp))
+               return -URC_FAILURE;
        if (reg =3D=3D 14)
                ctrl->lr_addr =3D *vsp;
        (*vsp)++;
