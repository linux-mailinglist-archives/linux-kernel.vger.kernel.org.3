Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6737A4E6755
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351975AbiCXQ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352088AbiCXQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:56:06 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916C1B82EE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:53:42 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id j15so3544931ila.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YpLkW0tRBoZ4kAOuJruK4ALvjxQUbEEcnwwvWAs5ZKQ=;
        b=gKiiT/5ml+uDas3/ormhNERqVygNz1eO82WRRsS7x200RVGPKxFkflR45sjv42gbqh
         Y4YZBHpALfVOS604+XIMwA0K0QDJCHwMvy7KEGjIFLbDi9UjZ812yqAiTJ03qRvCGIdy
         mADezNXcnMukEDuvEa0kWN2O4UmdSJd7EsICwd/KTDNbRxEr7N1p8v+NRe6rtyJojkGY
         PNWtIH/H4e7C2W7U+a5A1JmB6/Hsj4w09PF7eEzVpyGvacJW/tUhWoXDxoAKRarupcnT
         jhjwJmixHNTDG616UqtzaEyqX1V440fsz6XCz1atT2iY4WK9NDgFpfjWClPbYVxXdMtO
         YGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YpLkW0tRBoZ4kAOuJruK4ALvjxQUbEEcnwwvWAs5ZKQ=;
        b=nu9qoeEps0kvIvn3zhheF/GtVbCS2KkSOsk+btIXS/3iQYsmBushCmZUmgwKfYQTXj
         YTyj9sxXbU2mAym06WiLXaM7u0RtkVw2eu9ATB7FsWJVf+NLNKsF0cCibRmx5vnTBaCI
         HEzYeMBBUpkGp2P3Y+HA4/CqWHD9gmSC6uf5JItxtYIYPNWt9nnZ7V3PCYPiu0lzCPY3
         Fw4bG60mjeT34k/scy7RieojscJfLjhuajgGSS5e6AWdm83WNvZXHxTWZnCZ1xGjFzRA
         4pdz/Gq5Tpqeh1lDLZQyoCspJ8DnuGr5+5hjXMAcugTttyo3KOWGC1LTD536xuG063VT
         E68w==
X-Gm-Message-State: AOAM533pgaC4ERHU/ZM9xwYfOBy9FAEzonZVkS5bcN5sOs63iBrwKBlP
        EPJ+/AkZC091DbUa3FM5Zy19ffI573Wc1q7hjArFVQ==
X-Google-Smtp-Source: ABdhPJyDVX3lqbOCYJVq9pBb9eWl+LteWD4o7CPvAwn3OSZtG7UXL7y/c+AU+jZEeGFY+HJXDwptGhp8dIC/vxGMT9k=
X-Received: by 2002:a05:6e02:1be1:b0:2c7:a99f:c67f with SMTP id
 y1-20020a056e021be100b002c7a99fc67fmr3197474ilv.44.1648140821733; Thu, 24 Mar
 2022 09:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-ffd5d5c5-9894-4dec-b332-5176d508bcf9@palmer-mbp2014>
 <mhng-ef0f4bac-b55e-471e-8e3d-8ea597081b74@palmer-ri-x1c9>
 <CANp29Y6MvZvx4Xjwx=bxZ86D7Kubg0JPwBzP6HH8A6+Zj7YeLQ@mail.gmail.com>
 <CACT4Y+ZA7CRNfYgPmi6jHTKD9rwvaJy=nh5Gz_c-PFHq3tuziQ@mail.gmail.com> <CA+zEjCsCHhaQ4nEC8VEbCyQt3aG0E78S6PoCgzJA5qkoGC10ZA@mail.gmail.com>
In-Reply-To: <CA+zEjCsCHhaQ4nEC8VEbCyQt3aG0E78S6PoCgzJA5qkoGC10ZA@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 24 Mar 2022 17:53:30 +0100
Message-ID: <CANp29Y57fAHjy_Xm4_XvAMXvjvkPPipXsq-KD4ccEXwxHSRhHw@mail.gmail.com>
Subject: Re: [PATCH -fixes v3 0/6] Fixes KASAN and other along the way
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexander Potapenko <glider@google.com>,
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

https://pastebin.com/pN4rUjSi))))On Thu, Mar 10, 2022 at 9:42 AM
Alexandre Ghiti <alexandre.ghiti@canonical.com> wrote:
>
> Hi,
>
> On Wed, Mar 9, 2022 at 11:52 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, 9 Mar 2022 at 11:45, Aleksandr Nogikh <nogikh@google.com> wrote=
:
> > >
> > > I switched the riscv syzbot instance to KASAN_OUTLINE and now it is
> > > finally being fuzzed again!
> > >
> > > Thank you very much for the series!
> >
> >
> > But all riscv crashes are still classified as "corrupted" and thrown
> > away (not reported):
> > https://syzkaller.appspot.com/bug?id=3Dd5bc3e0c66d200d72216ab343a67c432=
7e4a3452
> >
> > The problem is that risvc oopses don't contain "Call Trace:" in the
> > beginning of stack traces, so it's hard to make sense out of them.
> > arch/riscv seems to print "Call Trace:" in a wrong function, not where
> > all other arches print it.
> >
>
> Does the following diff fix this issue?
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index 201ee206fb57..348ca19ccbf8 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -109,12 +109,12 @@ static bool print_trace_address(void *arg,
> unsigned long pc)
>  noinline void dump_backtrace(struct pt_regs *regs, struct task_struct *t=
ask,
>                     const char *loglvl)
>  {
> +       pr_cont("%sCall Trace:\n", loglvl);
>         walk_stackframe(task, regs, print_trace_address, (void *)loglvl);
>  }
>
>  void show_stack(struct task_struct *task, unsigned long *sp, const
> char *loglvl)
>  {
> -       pr_cont("%sCall Trace:\n", loglvl);
>         dump_backtrace(NULL, task, loglvl);
>  }
>
> Thanks,
>
> Alex

I wouldn't say that all riscv crashes are ending up in the "corrupted
report" bucket, but for some classes of errors there are definitely
differences from other architectures and they prevent syzkaller from
making sense out of those reports. At the moment everything seems to
be working fine at least with "WARNING:", "KASAN:" and "kernel
panic:".

I've run syzkaller with and without the small patch. From what I
observed, it definitely helps with the "BUG: soft lockup in" class of
reports. Previously they were declared corrupted, now syzkaller parses
them normally.

There's still a problem with "INFO: rcu_preempt detected stalls on
CPUs/tasks", which might be a bit more complicated than just the Call
Trace printing location.

Here's an example of such a report from x86: https://pastebin.com/KMEE5YRf
There goes a header with the  "rcu: INFO: rcu_preempt detected stalls
on CPUs/tasks:" title
(https://elixir.bootlin.com/linux/v5.17/source/kernel/rcu/tree_stall.h#L520=
),
then backtrace for one CPU
(https://elixir.bootlin.com/linux/v5.17/source/kernel/rcu/tree_stall.h#L331=
),
then there goes another error message about starving kthread
(https://elixir.bootlin.com/linux/v5.17/source/kernel/rcu/tree_stall.h#L442=
),
then there go two kthread-related traces.

And here's a report from riscv: https://pastebin.com/pN4rUjSi
There's de facto no backtrace between "rcu: INFO: rcu_preempt detected
stalls on CPUs/tasks:" and "rcu: RCU grace-period kthread stack
dump:".


>
> >
> >
> > > --
> > > Best Regards,
> > > Aleksandr
> > >
> > > On Fri, Mar 4, 2022 at 5:12 AM Palmer Dabbelt <palmer@dabbelt.com> wr=
ote:
> > > >
> > > > On Tue, 01 Mar 2022 09:39:54 PST (-0800), Palmer Dabbelt wrote:
> > > > > On Fri, 25 Feb 2022 07:00:23 PST (-0800), glider@google.com wrote=
:
> > > > >> On Fri, Feb 25, 2022 at 3:47 PM Alexandre Ghiti <
> > > > >> alexandre.ghiti@canonical.com> wrote:
> > > > >>
> > > > >>> On Fri, Feb 25, 2022 at 3:31 PM Alexander Potapenko <glider@goo=
gle.com>
> > > > >>> wrote:
> > > > >>> >
> > > > >>> >
> > > > >>> >
> > > > >>> > On Fri, Feb 25, 2022 at 3:15 PM Alexandre Ghiti <
> > > > >>> alexandre.ghiti@canonical.com> wrote:
> > > > >>> >>
> > > > >>> >> On Fri, Feb 25, 2022 at 3:10 PM Alexander Potapenko <glider@=
google.com>
> > > > >>> wrote:
> > > > >>> >> >
> > > > >>> >> >
> > > > >>> >> >
> > > > >>> >> > On Fri, Feb 25, 2022 at 3:04 PM Alexandre Ghiti <
> > > > >>> alexandre.ghiti@canonical.com> wrote:
> > > > >>> >> >>
> > > > >>> >> >> On Fri, Feb 25, 2022 at 2:06 PM Marco Elver <elver@google=
.com>
> > > > >>> wrote:
> > > > >>> >> >> >
> > > > >>> >> >> > On Fri, 25 Feb 2022 at 13:40, Alexandre Ghiti
> > > > >>> >> >> > <alexandre.ghiti@canonical.com> wrote:
> > > > >>> >> >> > >
> > > > >>> >> >> > > As reported by Aleksandr, syzbot riscv is broken sinc=
e commit
> > > > >>> >> >> > > 54c5639d8f50 ("riscv: Fix asan-stack clang build"). T=
his commit
> > > > >>> actually
> > > > >>> >> >> > > breaks KASAN_INLINE which is not fixed in this series=
, that will
> > > > >>> come later
> > > > >>> >> >> > > when found.
> > > > >>> >> >> > >
> > > > >>> >> >> > > Nevertheless, this series fixes small things that mad=
e the syzbot
> > > > >>> >> >> > > configuration + KASAN_OUTLINE fail to boot.
> > > > >>> >> >> > >
> > > > >>> >> >> > > Note that even though the config at [1] boots fine wi=
th this
> > > > >>> series, I
> > > > >>> >> >> > > was not able to boot the small config at [2] which fa=
ils because
> > > > >>> >> >> > > kasan_poison receives a really weird address 0x407570=
6301000000
> > > > >>> (maybe a
> > > > >>> >> >> > > kasan person could provide some hint about what happe=
ns below in
> > > > >>> >> >> > > do_ctors -> __asan_register_globals):
> > > > >>> >> >> >
> > > > >>> >> >> > asan_register_globals is responsible for poisoning redz=
ones around
> > > > >>> >> >> > globals. As hinted by 'do_ctors', it calls constructors=
, and in
> > > > >>> this
> > > > >>> >> >> > case a compiler-generated constructor that calls
> > > > >>> >> >> > __asan_register_globals with metadata generated by the =
compiler.
> > > > >>> That
> > > > >>> >> >> > metadata contains information about global variables. N=
ote, these
> > > > >>> >> >> > constructors are called on initial boot, but also every=
 time a
> > > > >>> kernel
> > > > >>> >> >> > module (that has globals) is loaded.
> > > > >>> >> >> >
> > > > >>> >> >> > It may also be a toolchain issue, but it's hard to say.=
 If you're
> > > > >>> >> >> > using GCC to test, try Clang (11 or later), and vice-ve=
rsa.
> > > > >>> >> >>
> > > > >>> >> >> I tried 3 different gcc toolchains already, but that did =
not fix the
> > > > >>> >> >> issue. The only thing that worked was setting asan-global=
s=3D0 in
> > > > >>> >> >> scripts/Makefile.kasan, but ok, that's not a fix.
> > > > >>> >> >> I tried to bisect this issue but our kasan implementation=
 has been
> > > > >>> >> >> broken quite a few times, so it failed.
> > > > >>> >> >>
> > > > >>> >> >> I keep digging!
> > > > >>> >> >>
> > > > >>> >> >
> > > > >>> >> > The problem does not reproduce for me with GCC 11.2.0: ker=
nels built
> > > > >>> with both [1] and [2] are bootable.
> > > > >>> >>
> > > > >>> >> Do you mean you reach userspace? Because my image boots too,=
 and fails
> > > > >>> >> at some point:
> > > > >>> >>
> > > > >>> >> [    0.000150] sched_clock: 64 bits at 10MHz, resolution 100=
ns, wraps
> > > > >>> >> every 4398046511100ns
> > > > >>> >> [    0.015847] Console: colour dummy device 80x25
> > > > >>> >> [    0.016899] printk: console [tty0] enabled
> > > > >>> >> [    0.020326] printk: bootconsole [ns16550a0] disabled
> > > > >>> >>
> > > > >>> >
> > > > >>> > In my case, QEMU successfully boots to the login prompt.
> > > > >>> > I am running QEMU 6.2.0 (Debian 1:6.2+dfsg-2) and an image Al=
eksandr
> > > > >>> shared with me (guess it was built according to this instructio=
n:
> > > > >>> https://github.com/google/syzkaller/blob/master/docs/linux/setu=
p_linux-host_qemu-vm_riscv64-kernel.md
> > > > >>> )
> > > > >>> >
> > > > >>>
> > > > >>> Nice thanks guys! I always use the latest opensbi and not the o=
ne that
> > > > >>> is embedded in qemu, which is the only difference between your =
command
> > > > >>> line (which works) and mine (which does not work). So the issue=
 is
> > > > >>> probably there, I really need to investigate that now.
> > > > >>>
> > > > >>> Great to hear that!
> > > > >>
> > > > >>
> > > > >>> That means I only need to fix KASAN_INLINE and we're good.
> > > > >>>
> > > > >>> I imagine Palmer can add your Tested-by on the series then?
> > > > >>>
> > > > >> Sure :)
> > > > >
> > > > > Do you mind actually posting that (i, the Tested-by tag)?  It's l=
ess
> > > > > likely to get lost that way.  I intend on taking this into fixes =
ASAP,
> > > > > my builds have blown up for some reason (I got bounced between ma=
chines,
> > > > > so I'm blaming that) so I need to fix that first.
> > > >
> > > > This is on fixes (with a "Tested-by: Alexander Potapenko
> > > > <glider@google.com>"), along with some trivial commit message fixes=
.
> > > >
> > > > Thanks!
> > > >
> > > > >
> > > > >>
> > > > >>>
> > > > >>> Thanks again!
> > > > >>>
> > > > >>> Alex
> > > > >>>
> > > > >>> >>
> > > > >>> >> It traps here.
> > > > >>> >>
> > > > >>> >> > FWIW here is how I run them:
> > > > >>> >> >
> > > > >>> >> > qemu-system-riscv64 -m 2048 -smp 1 -nographic -no-reboot \
> > > > >>> >> >   -device virtio-rng-pci -machine virt -device \
> > > > >>> >> >   virtio-net-pci,netdev=3Dnet0 -netdev \
> > > > >>> >> >   user,id=3Dnet0,restrict=3Don,hostfwd=3Dtcp:127.0.0.1:125=
29-:22 -device \
> > > > >>> >> >   virtio-blk-device,drive=3Dhd0 -drive \
> > > > >>> >> >   file=3D${IMAGE},if=3Dnone,format=3Draw,id=3Dhd0 -snapsho=
t \
> > > > >>> >> >   -kernel ${KERNEL_SRC_DIR}/arch/riscv/boot/Image -append
> > > > >>> "root=3D/dev/vda
> > > > >>> >> >   console=3DttyS0 earlyprintk=3Dserial"
> > > > >>> >> >
> > > > >>> >> >
> > > > >>> >> >>
> > > > >>> >> >> Thanks for the tips,
> > > > >>> >> >>
> > > > >>> >> >> Alex
> > > > >>> >> >
> > > > >>> >> >
> > > > >>> >> >
> > > > >>> >> > --
> > > > >>> >> > Alexander Potapenko
> > > > >>> >> > Software Engineer
> > > > >>> >> >
> > > > >>> >> > Google Germany GmbH
> > > > >>> >> > Erika-Mann-Stra=C3=9Fe, 33
> > > > >>> >> > 80636 M=C3=BCnchen
> > > > >>> >> >
> > > > >>> >> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> > > > >>> >> > Registergericht und -nummer: Hamburg, HRB 86891
> > > > >>> >> > Sitz der Gesellschaft: Hamburg
> > > > >>> >> >
> > > > >>> >> > Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschl=
icherweise
> > > > >>> erhalten haben sollten, leiten Sie diese bitte nicht an jemand =
anderes
> > > > >>> weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und=
 lassen Sie mich bitte
> > > > >>> wissen, dass die E-Mail an die falsche Person gesendet wurde.
> > > > >>> >> >
> > > > >>> >> >
> > > > >>> >> >
> > > > >>> >> > This e-mail is confidential. If you received this communic=
ation by
> > > > >>> mistake, please don't forward it to anyone else, please erase a=
ll copies
> > > > >>> and attachments, and please let me know that it has gone to the=
 wrong
> > > > >>> person.
> > > > >>> >>
> > > > >>> >> --
> > > > >>> >> You received this message because you are subscribed to the =
Google
> > > > >>> Groups "kasan-dev" group.
> > > > >>> >> To unsubscribe from this group and stop receiving emails fro=
m it, send
> > > > >>> an email to kasan-dev+unsubscribe@googlegroups.com.
> > > > >>> >> To view this discussion on the web visit
> > > > >>> https://groups.google.com/d/msgid/kasan-dev/CA%2BzEjCsQPVYSV7Cd=
hKnvjujXkMXuRQd%3DVPok1awb20xifYmidw%40mail.gmail.com
> > > > >>> .
> > > > >>> >
> > > > >>> >
> > > > >>> >
> > > > >>> > --
> > > > >>> > Alexander Potapenko
> > > > >>> > Software Engineer
> > > > >>> >
> > > > >>> > Google Germany GmbH
> > > > >>> > Erika-Mann-Stra=C3=9Fe, 33
> > > > >>> > 80636 M=C3=BCnchen
> > > > >>> >
> > > > >>> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> > > > >>> > Registergericht und -nummer: Hamburg, HRB 86891
> > > > >>> > Sitz der Gesellschaft: Hamburg
> > > > >>> >
> > > > >>> > Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlich=
erweise erhalten
> > > > >>> haben sollten, leiten Sie diese bitte nicht an jemand anderes w=
eiter,
> > > > >>> l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen =
Sie mich bitte wissen,
> > > > >>> dass die E-Mail an die falsche Person gesendet wurde.
> > > > >>> >
> > > > >>> >
> > > > >>> >
> > > > >>> > This e-mail is confidential. If you received this communicati=
on by
> > > > >>> mistake, please don't forward it to anyone else, please erase a=
ll copies
> > > > >>> and attachments, and please let me know that it has gone to the=
 wrong
> > > > >>> person.
> > > > >>>
> > > > >>> --
> > > > >>> You received this message because you are subscribed to the Goo=
gle Groups
> > > > >>> "kasan-dev" group.
> > > > >>> To unsubscribe from this group and stop receiving emails from i=
t, send an
> > > > >>> email to kasan-dev+unsubscribe@googlegroups.com.
> > > > >>> To view this discussion on the web visit
> > > > >>> https://groups.google.com/d/msgid/kasan-dev/CA%2BzEjCuJw8N0dUmQ=
NdFqDM96bzKqPDjRe4FUnOCbjhJtO0R8Hg%40mail.gmail.com
> > > > >>> .
> > > > >>>
> > > > >>
> > > > >>
> > > > >> --
> > > > >> Alexander Potapenko
> > > > >> Software Engineer
> > > > >>
> > > > >> Google Germany GmbH
> > > > >> Erika-Mann-Stra=C3=9Fe, 33
> > > > >> 80636 M=C3=BCnchen
> > > > >>
> > > > >> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> > > > >> Registergericht und -nummer: Hamburg, HRB 86891
> > > > >> Sitz der Gesellschaft: Hamburg
> > > > >>
> > > > >> Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherw=
eise erhalten
> > > > >> haben sollten, leiten Sie diese bitte nicht an jemand anderes we=
iter,
> > > > >> l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen S=
ie mich bitte wissen,
> > > > >> dass die E-Mail an die falsche Person gesendet wurde.
> > > > >>
> > > > >>
> > > > >>
> > > > >> This e-mail is confidential. If you received this communication =
by mistake,
> > > > >> please don't forward it to anyone else, please erase all copies =
and
> > > > >> attachments, and please let me know that it has gone to the wron=
g person.
