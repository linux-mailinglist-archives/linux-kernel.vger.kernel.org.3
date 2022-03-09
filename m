Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C1C4D2D54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiCIKqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiCIKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:46:46 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736E668F9E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:45:47 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id x4so2220007iop.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7cN9sV0/WTN4NHzm+ToLCSOMFSuq20yVNECoj1P44SQ=;
        b=eEQrO/LtoRGg3WjtdutiywG5GnqWAWdwF4m3xwgkMITHEDbr8HcKJcoJhmPMUDwkHg
         bvFMfXrseWAiD2N0l2qKFnp9RF4kkai3xrrjH8lbb0URODZ1UCiQIc4BCdqH4N8Nu6qQ
         PB4OVmmDuY7s+OCC1FT5zv88WaDiPnGOPwjBObqQgCbVbvrU+PKaG73P8bpUjo89rc2d
         GDhUU3nhlI6G1mYv/c/6ieAaBRr3+YQv8ilV8jt1WXWn1ItC/p483Usr6C2CAGE32ABf
         aqmzAt2glrU3biD8CN/KDZUcM8UjodZeVQ+61U56M0fHQnlzuXCEathAMet2XbwIk3qV
         rI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7cN9sV0/WTN4NHzm+ToLCSOMFSuq20yVNECoj1P44SQ=;
        b=8Jc1zHzyCE5yjNq8yWB08lbbfXzfD19+CHYAKWvI+BbqMwv84BVKvLDQFJhvtATFFY
         OFsyBp/CMJboxmCB3lUCnwr61Ed2PY1cT3WJqstdBR0aGG8Bqb48ZW++XMLS5GvugUZH
         pMLdnd5fBFJNJvAlo2ylYsS6k7g3F2RclJp63iX1s8VfiLPn5Mv6AegWlRbd3Rl1rceT
         9xC2qU50h+Iw8bR340r8/rwyS63z5ditekoBLUhAvbQUYrLjNM7bKAgXI1s973yCT2bv
         bEIigEVax15THHiYl8yysgUoMnySz/CWZb0wqDo29LZG7wai0u/TuOAUazNrdm+nInPH
         /kRg==
X-Gm-Message-State: AOAM531gED7XEMVzeivaDHy2hy5erRPetLpLS9jIJVvnz344BfJqfEMr
        p+ovljzW6CJU9sw+xFh50pOHevrk4PEW6PoXVKpLRg==
X-Google-Smtp-Source: ABdhPJyFisKmsnMSCtSGZ1nPgpIoEh3zAEijJjn/+1Xilumsavlvk2S/5ZwjUZy6j5aZ7GaD8IvtDhZHok8913N1t1k=
X-Received: by 2002:a05:6638:3789:b0:317:7763:46 with SMTP id
 w9-20020a056638378900b0031777630046mr19500601jal.42.1646822745978; Wed, 09
 Mar 2022 02:45:45 -0800 (PST)
MIME-Version: 1.0
References: <mhng-ffd5d5c5-9894-4dec-b332-5176d508bcf9@palmer-mbp2014> <mhng-ef0f4bac-b55e-471e-8e3d-8ea597081b74@palmer-ri-x1c9>
In-Reply-To: <mhng-ef0f4bac-b55e-471e-8e3d-8ea597081b74@palmer-ri-x1c9>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 9 Mar 2022 11:45:34 +0100
Message-ID: <CANp29Y6MvZvx4Xjwx=bxZ86D7Kubg0JPwBzP6HH8A6+Zj7YeLQ@mail.gmail.com>
Subject: Re: [PATCH -fixes v3 0/6] Fixes KASAN and other along the way
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Marco Elver <elver@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
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

I switched the riscv syzbot instance to KASAN_OUTLINE and now it is
finally being fuzzed again!

Thank you very much for the series!

--
Best Regards,
Aleksandr

On Fri, Mar 4, 2022 at 5:12 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 01 Mar 2022 09:39:54 PST (-0800), Palmer Dabbelt wrote:
> > On Fri, 25 Feb 2022 07:00:23 PST (-0800), glider@google.com wrote:
> >> On Fri, Feb 25, 2022 at 3:47 PM Alexandre Ghiti <
> >> alexandre.ghiti@canonical.com> wrote:
> >>
> >>> On Fri, Feb 25, 2022 at 3:31 PM Alexander Potapenko <glider@google.co=
m>
> >>> wrote:
> >>> >
> >>> >
> >>> >
> >>> > On Fri, Feb 25, 2022 at 3:15 PM Alexandre Ghiti <
> >>> alexandre.ghiti@canonical.com> wrote:
> >>> >>
> >>> >> On Fri, Feb 25, 2022 at 3:10 PM Alexander Potapenko <glider@google=
.com>
> >>> wrote:
> >>> >> >
> >>> >> >
> >>> >> >
> >>> >> > On Fri, Feb 25, 2022 at 3:04 PM Alexandre Ghiti <
> >>> alexandre.ghiti@canonical.com> wrote:
> >>> >> >>
> >>> >> >> On Fri, Feb 25, 2022 at 2:06 PM Marco Elver <elver@google.com>
> >>> wrote:
> >>> >> >> >
> >>> >> >> > On Fri, 25 Feb 2022 at 13:40, Alexandre Ghiti
> >>> >> >> > <alexandre.ghiti@canonical.com> wrote:
> >>> >> >> > >
> >>> >> >> > > As reported by Aleksandr, syzbot riscv is broken since comm=
it
> >>> >> >> > > 54c5639d8f50 ("riscv: Fix asan-stack clang build"). This co=
mmit
> >>> actually
> >>> >> >> > > breaks KASAN_INLINE which is not fixed in this series, that=
 will
> >>> come later
> >>> >> >> > > when found.
> >>> >> >> > >
> >>> >> >> > > Nevertheless, this series fixes small things that made the =
syzbot
> >>> >> >> > > configuration + KASAN_OUTLINE fail to boot.
> >>> >> >> > >
> >>> >> >> > > Note that even though the config at [1] boots fine with thi=
s
> >>> series, I
> >>> >> >> > > was not able to boot the small config at [2] which fails be=
cause
> >>> >> >> > > kasan_poison receives a really weird address 0x407570630100=
0000
> >>> (maybe a
> >>> >> >> > > kasan person could provide some hint about what happens bel=
ow in
> >>> >> >> > > do_ctors -> __asan_register_globals):
> >>> >> >> >
> >>> >> >> > asan_register_globals is responsible for poisoning redzones a=
round
> >>> >> >> > globals. As hinted by 'do_ctors', it calls constructors, and =
in
> >>> this
> >>> >> >> > case a compiler-generated constructor that calls
> >>> >> >> > __asan_register_globals with metadata generated by the compil=
er.
> >>> That
> >>> >> >> > metadata contains information about global variables. Note, t=
hese
> >>> >> >> > constructors are called on initial boot, but also every time =
a
> >>> kernel
> >>> >> >> > module (that has globals) is loaded.
> >>> >> >> >
> >>> >> >> > It may also be a toolchain issue, but it's hard to say. If yo=
u're
> >>> >> >> > using GCC to test, try Clang (11 or later), and vice-versa.
> >>> >> >>
> >>> >> >> I tried 3 different gcc toolchains already, but that did not fi=
x the
> >>> >> >> issue. The only thing that worked was setting asan-globals=3D0 =
in
> >>> >> >> scripts/Makefile.kasan, but ok, that's not a fix.
> >>> >> >> I tried to bisect this issue but our kasan implementation has b=
een
> >>> >> >> broken quite a few times, so it failed.
> >>> >> >>
> >>> >> >> I keep digging!
> >>> >> >>
> >>> >> >
> >>> >> > The problem does not reproduce for me with GCC 11.2.0: kernels b=
uilt
> >>> with both [1] and [2] are bootable.
> >>> >>
> >>> >> Do you mean you reach userspace? Because my image boots too, and f=
ails
> >>> >> at some point:
> >>> >>
> >>> >> [    0.000150] sched_clock: 64 bits at 10MHz, resolution 100ns, wr=
aps
> >>> >> every 4398046511100ns
> >>> >> [    0.015847] Console: colour dummy device 80x25
> >>> >> [    0.016899] printk: console [tty0] enabled
> >>> >> [    0.020326] printk: bootconsole [ns16550a0] disabled
> >>> >>
> >>> >
> >>> > In my case, QEMU successfully boots to the login prompt.
> >>> > I am running QEMU 6.2.0 (Debian 1:6.2+dfsg-2) and an image Aleksand=
r
> >>> shared with me (guess it was built according to this instruction:
> >>> https://github.com/google/syzkaller/blob/master/docs/linux/setup_linu=
x-host_qemu-vm_riscv64-kernel.md
> >>> )
> >>> >
> >>>
> >>> Nice thanks guys! I always use the latest opensbi and not the one tha=
t
> >>> is embedded in qemu, which is the only difference between your comman=
d
> >>> line (which works) and mine (which does not work). So the issue is
> >>> probably there, I really need to investigate that now.
> >>>
> >>> Great to hear that!
> >>
> >>
> >>> That means I only need to fix KASAN_INLINE and we're good.
> >>>
> >>> I imagine Palmer can add your Tested-by on the series then?
> >>>
> >> Sure :)
> >
> > Do you mind actually posting that (i, the Tested-by tag)?  It's less
> > likely to get lost that way.  I intend on taking this into fixes ASAP,
> > my builds have blown up for some reason (I got bounced between machines=
,
> > so I'm blaming that) so I need to fix that first.
>
> This is on fixes (with a "Tested-by: Alexander Potapenko
> <glider@google.com>"), along with some trivial commit message fixes.
>
> Thanks!
>
> >
> >>
> >>>
> >>> Thanks again!
> >>>
> >>> Alex
> >>>
> >>> >>
> >>> >> It traps here.
> >>> >>
> >>> >> > FWIW here is how I run them:
> >>> >> >
> >>> >> > qemu-system-riscv64 -m 2048 -smp 1 -nographic -no-reboot \
> >>> >> >   -device virtio-rng-pci -machine virt -device \
> >>> >> >   virtio-net-pci,netdev=3Dnet0 -netdev \
> >>> >> >   user,id=3Dnet0,restrict=3Don,hostfwd=3Dtcp:127.0.0.1:12529-:22=
 -device \
> >>> >> >   virtio-blk-device,drive=3Dhd0 -drive \
> >>> >> >   file=3D${IMAGE},if=3Dnone,format=3Draw,id=3Dhd0 -snapshot \
> >>> >> >   -kernel ${KERNEL_SRC_DIR}/arch/riscv/boot/Image -append
> >>> "root=3D/dev/vda
> >>> >> >   console=3DttyS0 earlyprintk=3Dserial"
> >>> >> >
> >>> >> >
> >>> >> >>
> >>> >> >> Thanks for the tips,
> >>> >> >>
> >>> >> >> Alex
> >>> >> >
> >>> >> >
> >>> >> >
> >>> >> > --
> >>> >> > Alexander Potapenko
> >>> >> > Software Engineer
> >>> >> >
> >>> >> > Google Germany GmbH
> >>> >> > Erika-Mann-Stra=C3=9Fe, 33
> >>> >> > 80636 M=C3=BCnchen
> >>> >> >
> >>> >> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> >>> >> > Registergericht und -nummer: Hamburg, HRB 86891
> >>> >> > Sitz der Gesellschaft: Hamburg
> >>> >> >
> >>> >> > Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherw=
eise
> >>> erhalten haben sollten, leiten Sie diese bitte nicht an jemand andere=
s
> >>> weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lasse=
n Sie mich bitte
> >>> wissen, dass die E-Mail an die falsche Person gesendet wurde.
> >>> >> >
> >>> >> >
> >>> >> >
> >>> >> > This e-mail is confidential. If you received this communication =
by
> >>> mistake, please don't forward it to anyone else, please erase all cop=
ies
> >>> and attachments, and please let me know that it has gone to the wrong
> >>> person.
> >>> >>
> >>> >> --
> >>> >> You received this message because you are subscribed to the Google
> >>> Groups "kasan-dev" group.
> >>> >> To unsubscribe from this group and stop receiving emails from it, =
send
> >>> an email to kasan-dev+unsubscribe@googlegroups.com.
> >>> >> To view this discussion on the web visit
> >>> https://groups.google.com/d/msgid/kasan-dev/CA%2BzEjCsQPVYSV7CdhKnvju=
jXkMXuRQd%3DVPok1awb20xifYmidw%40mail.gmail.com
> >>> .
> >>> >
> >>> >
> >>> >
> >>> > --
> >>> > Alexander Potapenko
> >>> > Software Engineer
> >>> >
> >>> > Google Germany GmbH
> >>> > Erika-Mann-Stra=C3=9Fe, 33
> >>> > 80636 M=C3=BCnchen
> >>> >
> >>> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> >>> > Registergericht und -nummer: Hamburg, HRB 86891
> >>> > Sitz der Gesellschaft: Hamburg
> >>> >
> >>> > Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweis=
e erhalten
> >>> haben sollten, leiten Sie diese bitte nicht an jemand anderes weiter,
> >>> l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie mi=
ch bitte wissen,
> >>> dass die E-Mail an die falsche Person gesendet wurde.
> >>> >
> >>> >
> >>> >
> >>> > This e-mail is confidential. If you received this communication by
> >>> mistake, please don't forward it to anyone else, please erase all cop=
ies
> >>> and attachments, and please let me know that it has gone to the wrong
> >>> person.
> >>>
> >>> --
> >>> You received this message because you are subscribed to the Google Gr=
oups
> >>> "kasan-dev" group.
> >>> To unsubscribe from this group and stop receiving emails from it, sen=
d an
> >>> email to kasan-dev+unsubscribe@googlegroups.com.
> >>> To view this discussion on the web visit
> >>> https://groups.google.com/d/msgid/kasan-dev/CA%2BzEjCuJw8N0dUmQNdFqDM=
96bzKqPDjRe4FUnOCbjhJtO0R8Hg%40mail.gmail.com
> >>> .
> >>>
> >>
> >>
> >> --
> >> Alexander Potapenko
> >> Software Engineer
> >>
> >> Google Germany GmbH
> >> Erika-Mann-Stra=C3=9Fe, 33
> >> 80636 M=C3=BCnchen
> >>
> >> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> >> Registergericht und -nummer: Hamburg, HRB 86891
> >> Sitz der Gesellschaft: Hamburg
> >>
> >> Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise e=
rhalten
> >> haben sollten, leiten Sie diese bitte nicht an jemand anderes weiter,
> >> l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie mic=
h bitte wissen,
> >> dass die E-Mail an die falsche Person gesendet wurde.
> >>
> >>
> >>
> >> This e-mail is confidential. If you received this communication by mis=
take,
> >> please don't forward it to anyone else, please erase all copies and
> >> attachments, and please let me know that it has gone to the wrong pers=
on.
