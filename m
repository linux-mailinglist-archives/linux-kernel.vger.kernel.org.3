Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3A74D2D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiCIKxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiCIKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:53:36 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C73A70A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:52:36 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so2317953ooa.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 02:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fJu02Rm+819yVYZ0AGS3TauUWd+drbepJKgAxQy5Opw=;
        b=hrrGRELYPds3ayxkzyh4kk5KZImlwPKq/UgLEd5LWwdnU2zjDWWYgOI7ezK0u/UiB3
         raq5KEGFZ1zKckwNVAJRxYmX3HSkJTmkkblQHgNTaOuSV2zqi7Z0rbu6NRXV0EsGeulP
         dVNiFUz/rvCWaKsbbt/INlbAWPeh7tWmvnARwjdgqHS0h3n8mmIGvbJ5cKx3Sfqz0Esq
         rGiC9WEuS6h/O7JwqbqWykPKtJOqMLWFg+DsrSkrnMZ0pgE5/MXujxRAgLCB9mtzwRI6
         xlHo4buSp674wM2SbZBiQa/jY7oq4Payup/pxiWrRev4ZICjBEso5mxtNkNI8vHBUPzN
         zqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fJu02Rm+819yVYZ0AGS3TauUWd+drbepJKgAxQy5Opw=;
        b=pWClHVZhVEOGKBSFH3Pi+a6k91z8w3I2cA2tI1JH3jF4APl5qgzjkur0kP5mKICkA1
         1JGYPHs1scjF1qn5JGfdabaiOhS41lU6jFf5taRfd1dKK6aa9qLMfYwdPYWgazYgiCb0
         Q0fpmEKzp0P+5P8tX1LzvkCMpfXf4ps7pM7vV/CxniltEB+6qEo3xIzD4nFTWnTi7FiU
         IjIycZxnOTKnr+NySbYA72CX0JCl3kcorzriJgFGwhdHHqSmI7xfMaxzUWxllP69SLM7
         OGfKza4WEkFVA8sX9cIV1/bIo65ASDHVyu04QuD8RzIr91dCUfB0qM1a+QpKBMFKwi9Y
         /nYA==
X-Gm-Message-State: AOAM5334GrTS4lR68ZQfcUASEWTmgy4WLX0xZyc/KSPX0EWSKLmmjdGA
        iTEmgrGBIFfBw89bc6RO0zFCwlZsR1wqSIVzcmm6xg==
X-Google-Smtp-Source: ABdhPJyO/I/pfrCPAIig7Syn1uI3NrydsMfeGiioe9Mpfdq/2G1sblhIMFMkQChGK3MeQ088JnGcbm2a1rb0vZK7W74=
X-Received: by 2002:a05:6870:95a1:b0:da:b3f:2b34 with SMTP id
 k33-20020a05687095a100b000da0b3f2b34mr5052480oao.211.1646823155943; Wed, 09
 Mar 2022 02:52:35 -0800 (PST)
MIME-Version: 1.0
References: <mhng-ffd5d5c5-9894-4dec-b332-5176d508bcf9@palmer-mbp2014>
 <mhng-ef0f4bac-b55e-471e-8e3d-8ea597081b74@palmer-ri-x1c9> <CANp29Y6MvZvx4Xjwx=bxZ86D7Kubg0JPwBzP6HH8A6+Zj7YeLQ@mail.gmail.com>
In-Reply-To: <CANp29Y6MvZvx4Xjwx=bxZ86D7Kubg0JPwBzP6HH8A6+Zj7YeLQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Mar 2022 11:52:24 +0100
Message-ID: <CACT4Y+ZA7CRNfYgPmi6jHTKD9rwvaJy=nh5Gz_c-PFHq3tuziQ@mail.gmail.com>
Subject: Re: [PATCH -fixes v3 0/6] Fixes KASAN and other along the way
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexander Potapenko <glider@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Marco Elver <elver@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
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

On Wed, 9 Mar 2022 at 11:45, Aleksandr Nogikh <nogikh@google.com> wrote:
>
> I switched the riscv syzbot instance to KASAN_OUTLINE and now it is
> finally being fuzzed again!
>
> Thank you very much for the series!


But all riscv crashes are still classified as "corrupted" and thrown
away (not reported):
https://syzkaller.appspot.com/bug?id=3Dd5bc3e0c66d200d72216ab343a67c4327e4a=
3452

The problem is that risvc oopses don't contain "Call Trace:" in the
beginning of stack traces, so it's hard to make sense out of them.
arch/riscv seems to print "Call Trace:" in a wrong function, not where
all other arches print it.



> --
> Best Regards,
> Aleksandr
>
> On Fri, Mar 4, 2022 at 5:12 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Tue, 01 Mar 2022 09:39:54 PST (-0800), Palmer Dabbelt wrote:
> > > On Fri, 25 Feb 2022 07:00:23 PST (-0800), glider@google.com wrote:
> > >> On Fri, Feb 25, 2022 at 3:47 PM Alexandre Ghiti <
> > >> alexandre.ghiti@canonical.com> wrote:
> > >>
> > >>> On Fri, Feb 25, 2022 at 3:31 PM Alexander Potapenko <glider@google.=
com>
> > >>> wrote:
> > >>> >
> > >>> >
> > >>> >
> > >>> > On Fri, Feb 25, 2022 at 3:15 PM Alexandre Ghiti <
> > >>> alexandre.ghiti@canonical.com> wrote:
> > >>> >>
> > >>> >> On Fri, Feb 25, 2022 at 3:10 PM Alexander Potapenko <glider@goog=
le.com>
> > >>> wrote:
> > >>> >> >
> > >>> >> >
> > >>> >> >
> > >>> >> > On Fri, Feb 25, 2022 at 3:04 PM Alexandre Ghiti <
> > >>> alexandre.ghiti@canonical.com> wrote:
> > >>> >> >>
> > >>> >> >> On Fri, Feb 25, 2022 at 2:06 PM Marco Elver <elver@google.com=
>
> > >>> wrote:
> > >>> >> >> >
> > >>> >> >> > On Fri, 25 Feb 2022 at 13:40, Alexandre Ghiti
> > >>> >> >> > <alexandre.ghiti@canonical.com> wrote:
> > >>> >> >> > >
> > >>> >> >> > > As reported by Aleksandr, syzbot riscv is broken since co=
mmit
> > >>> >> >> > > 54c5639d8f50 ("riscv: Fix asan-stack clang build"). This =
commit
> > >>> actually
> > >>> >> >> > > breaks KASAN_INLINE which is not fixed in this series, th=
at will
> > >>> come later
> > >>> >> >> > > when found.
> > >>> >> >> > >
> > >>> >> >> > > Nevertheless, this series fixes small things that made th=
e syzbot
> > >>> >> >> > > configuration + KASAN_OUTLINE fail to boot.
> > >>> >> >> > >
> > >>> >> >> > > Note that even though the config at [1] boots fine with t=
his
> > >>> series, I
> > >>> >> >> > > was not able to boot the small config at [2] which fails =
because
> > >>> >> >> > > kasan_poison receives a really weird address 0x4075706301=
000000
> > >>> (maybe a
> > >>> >> >> > > kasan person could provide some hint about what happens b=
elow in
> > >>> >> >> > > do_ctors -> __asan_register_globals):
> > >>> >> >> >
> > >>> >> >> > asan_register_globals is responsible for poisoning redzones=
 around
> > >>> >> >> > globals. As hinted by 'do_ctors', it calls constructors, an=
d in
> > >>> this
> > >>> >> >> > case a compiler-generated constructor that calls
> > >>> >> >> > __asan_register_globals with metadata generated by the comp=
iler.
> > >>> That
> > >>> >> >> > metadata contains information about global variables. Note,=
 these
> > >>> >> >> > constructors are called on initial boot, but also every tim=
e a
> > >>> kernel
> > >>> >> >> > module (that has globals) is loaded.
> > >>> >> >> >
> > >>> >> >> > It may also be a toolchain issue, but it's hard to say. If =
you're
> > >>> >> >> > using GCC to test, try Clang (11 or later), and vice-versa.
> > >>> >> >>
> > >>> >> >> I tried 3 different gcc toolchains already, but that did not =
fix the
> > >>> >> >> issue. The only thing that worked was setting asan-globals=3D=
0 in
> > >>> >> >> scripts/Makefile.kasan, but ok, that's not a fix.
> > >>> >> >> I tried to bisect this issue but our kasan implementation has=
 been
> > >>> >> >> broken quite a few times, so it failed.
> > >>> >> >>
> > >>> >> >> I keep digging!
> > >>> >> >>
> > >>> >> >
> > >>> >> > The problem does not reproduce for me with GCC 11.2.0: kernels=
 built
> > >>> with both [1] and [2] are bootable.
> > >>> >>
> > >>> >> Do you mean you reach userspace? Because my image boots too, and=
 fails
> > >>> >> at some point:
> > >>> >>
> > >>> >> [    0.000150] sched_clock: 64 bits at 10MHz, resolution 100ns, =
wraps
> > >>> >> every 4398046511100ns
> > >>> >> [    0.015847] Console: colour dummy device 80x25
> > >>> >> [    0.016899] printk: console [tty0] enabled
> > >>> >> [    0.020326] printk: bootconsole [ns16550a0] disabled
> > >>> >>
> > >>> >
> > >>> > In my case, QEMU successfully boots to the login prompt.
> > >>> > I am running QEMU 6.2.0 (Debian 1:6.2+dfsg-2) and an image Aleksa=
ndr
> > >>> shared with me (guess it was built according to this instruction:
> > >>> https://github.com/google/syzkaller/blob/master/docs/linux/setup_li=
nux-host_qemu-vm_riscv64-kernel.md
> > >>> )
> > >>> >
> > >>>
> > >>> Nice thanks guys! I always use the latest opensbi and not the one t=
hat
> > >>> is embedded in qemu, which is the only difference between your comm=
and
> > >>> line (which works) and mine (which does not work). So the issue is
> > >>> probably there, I really need to investigate that now.
> > >>>
> > >>> Great to hear that!
> > >>
> > >>
> > >>> That means I only need to fix KASAN_INLINE and we're good.
> > >>>
> > >>> I imagine Palmer can add your Tested-by on the series then?
> > >>>
> > >> Sure :)
> > >
> > > Do you mind actually posting that (i, the Tested-by tag)?  It's less
> > > likely to get lost that way.  I intend on taking this into fixes ASAP=
,
> > > my builds have blown up for some reason (I got bounced between machin=
es,
> > > so I'm blaming that) so I need to fix that first.
> >
> > This is on fixes (with a "Tested-by: Alexander Potapenko
> > <glider@google.com>"), along with some trivial commit message fixes.
> >
> > Thanks!
> >
> > >
> > >>
> > >>>
> > >>> Thanks again!
> > >>>
> > >>> Alex
> > >>>
> > >>> >>
> > >>> >> It traps here.
> > >>> >>
> > >>> >> > FWIW here is how I run them:
> > >>> >> >
> > >>> >> > qemu-system-riscv64 -m 2048 -smp 1 -nographic -no-reboot \
> > >>> >> >   -device virtio-rng-pci -machine virt -device \
> > >>> >> >   virtio-net-pci,netdev=3Dnet0 -netdev \
> > >>> >> >   user,id=3Dnet0,restrict=3Don,hostfwd=3Dtcp:127.0.0.1:12529-:=
22 -device \
> > >>> >> >   virtio-blk-device,drive=3Dhd0 -drive \
> > >>> >> >   file=3D${IMAGE},if=3Dnone,format=3Draw,id=3Dhd0 -snapshot \
> > >>> >> >   -kernel ${KERNEL_SRC_DIR}/arch/riscv/boot/Image -append
> > >>> "root=3D/dev/vda
> > >>> >> >   console=3DttyS0 earlyprintk=3Dserial"
> > >>> >> >
> > >>> >> >
> > >>> >> >>
> > >>> >> >> Thanks for the tips,
> > >>> >> >>
> > >>> >> >> Alex
> > >>> >> >
> > >>> >> >
> > >>> >> >
> > >>> >> > --
> > >>> >> > Alexander Potapenko
> > >>> >> > Software Engineer
> > >>> >> >
> > >>> >> > Google Germany GmbH
> > >>> >> > Erika-Mann-Stra=C3=9Fe, 33
> > >>> >> > 80636 M=C3=BCnchen
> > >>> >> >
> > >>> >> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> > >>> >> > Registergericht und -nummer: Hamburg, HRB 86891
> > >>> >> > Sitz der Gesellschaft: Hamburg
> > >>> >> >
> > >>> >> > Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschliche=
rweise
> > >>> erhalten haben sollten, leiten Sie diese bitte nicht an jemand ande=
res
> > >>> weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und las=
sen Sie mich bitte
> > >>> wissen, dass die E-Mail an die falsche Person gesendet wurde.
> > >>> >> >
> > >>> >> >
> > >>> >> >
> > >>> >> > This e-mail is confidential. If you received this communicatio=
n by
> > >>> mistake, please don't forward it to anyone else, please erase all c=
opies
> > >>> and attachments, and please let me know that it has gone to the wro=
ng
> > >>> person.
> > >>> >>
> > >>> >> --
> > >>> >> You received this message because you are subscribed to the Goog=
le
> > >>> Groups "kasan-dev" group.
> > >>> >> To unsubscribe from this group and stop receiving emails from it=
, send
> > >>> an email to kasan-dev+unsubscribe@googlegroups.com.
> > >>> >> To view this discussion on the web visit
> > >>> https://groups.google.com/d/msgid/kasan-dev/CA%2BzEjCsQPVYSV7CdhKnv=
jujXkMXuRQd%3DVPok1awb20xifYmidw%40mail.gmail.com
> > >>> .
> > >>> >
> > >>> >
> > >>> >
> > >>> > --
> > >>> > Alexander Potapenko
> > >>> > Software Engineer
> > >>> >
> > >>> > Google Germany GmbH
> > >>> > Erika-Mann-Stra=C3=9Fe, 33
> > >>> > 80636 M=C3=BCnchen
> > >>> >
> > >>> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> > >>> > Registergericht und -nummer: Hamburg, HRB 86891
> > >>> > Sitz der Gesellschaft: Hamburg
> > >>> >
> > >>> > Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherwe=
ise erhalten
> > >>> haben sollten, leiten Sie diese bitte nicht an jemand anderes weite=
r,
> > >>> l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie =
mich bitte wissen,
> > >>> dass die E-Mail an die falsche Person gesendet wurde.
> > >>> >
> > >>> >
> > >>> >
> > >>> > This e-mail is confidential. If you received this communication b=
y
> > >>> mistake, please don't forward it to anyone else, please erase all c=
opies
> > >>> and attachments, and please let me know that it has gone to the wro=
ng
> > >>> person.
> > >>>
> > >>> --
> > >>> You received this message because you are subscribed to the Google =
Groups
> > >>> "kasan-dev" group.
> > >>> To unsubscribe from this group and stop receiving emails from it, s=
end an
> > >>> email to kasan-dev+unsubscribe@googlegroups.com.
> > >>> To view this discussion on the web visit
> > >>> https://groups.google.com/d/msgid/kasan-dev/CA%2BzEjCuJw8N0dUmQNdFq=
DM96bzKqPDjRe4FUnOCbjhJtO0R8Hg%40mail.gmail.com
> > >>> .
> > >>>
> > >>
> > >>
> > >> --
> > >> Alexander Potapenko
> > >> Software Engineer
> > >>
> > >> Google Germany GmbH
> > >> Erika-Mann-Stra=C3=9Fe, 33
> > >> 80636 M=C3=BCnchen
> > >>
> > >> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> > >> Registergericht und -nummer: Hamburg, HRB 86891
> > >> Sitz der Gesellschaft: Hamburg
> > >>
> > >> Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise=
 erhalten
> > >> haben sollten, leiten Sie diese bitte nicht an jemand anderes weiter=
,
> > >> l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie m=
ich bitte wissen,
> > >> dass die E-Mail an die falsche Person gesendet wurde.
> > >>
> > >>
> > >>
> > >> This e-mail is confidential. If you received this communication by m=
istake,
> > >> please don't forward it to anyone else, please erase all copies and
> > >> attachments, and please let me know that it has gone to the wrong pe=
rson.
