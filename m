Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AB54C47E1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbiBYOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241855AbiBYOrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:47:31 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2159119F2D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:46:58 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2EF563FCA5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645800416;
        bh=dOC9NztcOZs3DksWle8GHoaYwka1l2lDGqOy4HRLA/c=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=a7TdkWuIjHNp1DUZkTadiN06co1KLzD5PUhnP/fR1Iqi5cEZOpKvmG/8ZsQf5nnfn
         xnXgEHij1HpebGpSIxodauiRNbnh2UEzM12vdcOWjyfVEExnYjYrDIVzqTTfmQb4gW
         fhHCk9JFNRjRwA37NLl1ylGkt6oeDwdJrPnowu8HwHy6HCCCRnuFzHZx89JRP72c8H
         Auu9P8p40p/qLGJkx9mDZ1sW+N6+ZB6x1MGx9v9vdhouG6m+ofYH7tRPtZMQDxmHLB
         TnmV1+a/zChbn4MSQjvMJ1+O1uYSYpVNGl9sZeIXcOkYiA+GTjdA503Z5DjW6IW26h
         u2MdJS8FAX+cg==
Received: by mail-ed1-f69.google.com with SMTP id dy17-20020a05640231f100b00412897682b4so2416735edb.18
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:46:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dOC9NztcOZs3DksWle8GHoaYwka1l2lDGqOy4HRLA/c=;
        b=yUpzDhQYCtuV3VnmdH2wZ9SJxKyE3o1EAjcggv5sb1vnFnPCskq2LXG/FLZyN/UZfZ
         d/Basuz2kT7knNWTY2VcyuVVDNuf4DlU+rJuNLfwG3GgRYvUPfrQGXGcbRN9y0H8PLg2
         qn8d/wkgnazmoJhtfxzIWUAOPT4+gIeNhhYWSjOLWkU8qD2BYR97LWZn1ysiIX6wZyo1
         n6z1GGf0NrUJWWVBsNHGAflII+NOfhRJs3oLbE/xcTo6XjWOKUUJQsjjIBr9oTIVOcc4
         2+hy5KxhGMQo5/iG+P2tKzPWURRc/XsrW8qnM2J0ujL8o9sYiYrKWvkAxf/+bmzT9Iql
         XKNw==
X-Gm-Message-State: AOAM5305Tccg8LRpHFhYuQlh8bN7M9W3/0eZgvg/dbiDXdzwkkldUy+M
        KKBsd1IRhJ155Qykf1C2qbrUmgjme2ZZ/caLnuzfLL7ZpSouLMZvheIFrSczYKIYaiPbTCT5w8O
        +SIl4qhWgpeaHgupu4GhQQIAuf87g5Q/PPnAWCS/kDaE6lca2hXg9UMKTRA==
X-Received: by 2002:a05:6402:1681:b0:410:a467:833b with SMTP id a1-20020a056402168100b00410a467833bmr7405664edv.412.1645800415656;
        Fri, 25 Feb 2022 06:46:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvlwewyB2N//XCAYUAd1jRb82CxvheX5UpEL8XSe7O72Erlrj1iDVjByuM/rGopNFrx/1ZkbsXghU8iYbTi6I=
X-Received: by 2002:a05:6402:1681:b0:410:a467:833b with SMTP id
 a1-20020a056402168100b00410a467833bmr7405642edv.412.1645800415364; Fri, 25
 Feb 2022 06:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
 <CANpmjNN304EZfFN2zobxKGXbXWXAfr92nP1KvtR7j-YqSFShvQ@mail.gmail.com>
 <CA+zEjCtuwnKdi8EuyGWaYNFa7KsYcH9B1mYke6YALo+C1Nq+Dw@mail.gmail.com>
 <CAG_fn=WYmkqPX_qCVmxv1dx87JkXHGF1-a6_8K0jwWuBWzRJfA@mail.gmail.com>
 <CA+zEjCsQPVYSV7CdhKnvjujXkMXuRQd=VPok1awb20xifYmidw@mail.gmail.com> <CAG_fn=VZ3fS7ekmJknQ6sW5zC09iUT9mzWjEhyrn3NaAWfVP_Q@mail.gmail.com>
In-Reply-To: <CAG_fn=VZ3fS7ekmJknQ6sW5zC09iUT9mzWjEhyrn3NaAWfVP_Q@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Fri, 25 Feb 2022 15:46:44 +0100
Message-ID: <CA+zEjCuJw8N0dUmQNdFqDM96bzKqPDjRe4FUnOCbjhJtO0R8Hg@mail.gmail.com>
Subject: Re: [PATCH -fixes v3 0/6] Fixes KASAN and other along the way
To:     Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 3:31 PM Alexander Potapenko <glider@google.com> wro=
te:
>
>
>
> On Fri, Feb 25, 2022 at 3:15 PM Alexandre Ghiti <alexandre.ghiti@canonica=
l.com> wrote:
>>
>> On Fri, Feb 25, 2022 at 3:10 PM Alexander Potapenko <glider@google.com> =
wrote:
>> >
>> >
>> >
>> > On Fri, Feb 25, 2022 at 3:04 PM Alexandre Ghiti <alexandre.ghiti@canon=
ical.com> wrote:
>> >>
>> >> On Fri, Feb 25, 2022 at 2:06 PM Marco Elver <elver@google.com> wrote:
>> >> >
>> >> > On Fri, 25 Feb 2022 at 13:40, Alexandre Ghiti
>> >> > <alexandre.ghiti@canonical.com> wrote:
>> >> > >
>> >> > > As reported by Aleksandr, syzbot riscv is broken since commit
>> >> > > 54c5639d8f50 ("riscv: Fix asan-stack clang build"). This commit a=
ctually
>> >> > > breaks KASAN_INLINE which is not fixed in this series, that will =
come later
>> >> > > when found.
>> >> > >
>> >> > > Nevertheless, this series fixes small things that made the syzbot
>> >> > > configuration + KASAN_OUTLINE fail to boot.
>> >> > >
>> >> > > Note that even though the config at [1] boots fine with this seri=
es, I
>> >> > > was not able to boot the small config at [2] which fails because
>> >> > > kasan_poison receives a really weird address 0x4075706301000000 (=
maybe a
>> >> > > kasan person could provide some hint about what happens below in
>> >> > > do_ctors -> __asan_register_globals):
>> >> >
>> >> > asan_register_globals is responsible for poisoning redzones around
>> >> > globals. As hinted by 'do_ctors', it calls constructors, and in thi=
s
>> >> > case a compiler-generated constructor that calls
>> >> > __asan_register_globals with metadata generated by the compiler. Th=
at
>> >> > metadata contains information about global variables. Note, these
>> >> > constructors are called on initial boot, but also every time a kern=
el
>> >> > module (that has globals) is loaded.
>> >> >
>> >> > It may also be a toolchain issue, but it's hard to say. If you're
>> >> > using GCC to test, try Clang (11 or later), and vice-versa.
>> >>
>> >> I tried 3 different gcc toolchains already, but that did not fix the
>> >> issue. The only thing that worked was setting asan-globals=3D0 in
>> >> scripts/Makefile.kasan, but ok, that's not a fix.
>> >> I tried to bisect this issue but our kasan implementation has been
>> >> broken quite a few times, so it failed.
>> >>
>> >> I keep digging!
>> >>
>> >
>> > The problem does not reproduce for me with GCC 11.2.0: kernels built w=
ith both [1] and [2] are bootable.
>>
>> Do you mean you reach userspace? Because my image boots too, and fails
>> at some point:
>>
>> [    0.000150] sched_clock: 64 bits at 10MHz, resolution 100ns, wraps
>> every 4398046511100ns
>> [    0.015847] Console: colour dummy device 80x25
>> [    0.016899] printk: console [tty0] enabled
>> [    0.020326] printk: bootconsole [ns16550a0] disabled
>>
>
> In my case, QEMU successfully boots to the login prompt.
> I am running QEMU 6.2.0 (Debian 1:6.2+dfsg-2) and an image Aleksandr shar=
ed with me (guess it was built according to this instruction: https://githu=
b.com/google/syzkaller/blob/master/docs/linux/setup_linux-host_qemu-vm_risc=
v64-kernel.md)
>

Nice thanks guys! I always use the latest opensbi and not the one that
is embedded in qemu, which is the only difference between your command
line (which works) and mine (which does not work). So the issue is
probably there, I really need to investigate that now.

That means I only need to fix KASAN_INLINE and we're good.

I imagine Palmer can add your Tested-by on the series then?

Thanks again!

Alex

>>
>> It traps here.
>>
>> > FWIW here is how I run them:
>> >
>> > qemu-system-riscv64 -m 2048 -smp 1 -nographic -no-reboot \
>> >   -device virtio-rng-pci -machine virt -device \
>> >   virtio-net-pci,netdev=3Dnet0 -netdev \
>> >   user,id=3Dnet0,restrict=3Don,hostfwd=3Dtcp:127.0.0.1:12529-:22 -devi=
ce \
>> >   virtio-blk-device,drive=3Dhd0 -drive \
>> >   file=3D${IMAGE},if=3Dnone,format=3Draw,id=3Dhd0 -snapshot \
>> >   -kernel ${KERNEL_SRC_DIR}/arch/riscv/boot/Image -append "root=3D/dev=
/vda
>> >   console=3DttyS0 earlyprintk=3Dserial"
>> >
>> >
>> >>
>> >> Thanks for the tips,
>> >>
>> >> Alex
>> >
>> >
>> >
>> > --
>> > Alexander Potapenko
>> > Software Engineer
>> >
>> > Google Germany GmbH
>> > Erika-Mann-Stra=C3=9Fe, 33
>> > 80636 M=C3=BCnchen
>> >
>> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
>> > Registergericht und -nummer: Hamburg, HRB 86891
>> > Sitz der Gesellschaft: Hamburg
>> >
>> > Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise e=
rhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes weite=
r, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie mich =
bitte wissen, dass die E-Mail an die falsche Person gesendet wurde.
>> >
>> >
>> >
>> > This e-mail is confidential. If you received this communication by mis=
take, please don't forward it to anyone else, please erase all copies and a=
ttachments, and please let me know that it has gone to the wrong person.
>>
>> --
>> You received this message because you are subscribed to the Google Group=
s "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send a=
n email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msg=
id/kasan-dev/CA%2BzEjCsQPVYSV7CdhKnvjujXkMXuRQd%3DVPok1awb20xifYmidw%40mail=
.gmail.com.
>
>
>
> --
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Stra=C3=9Fe, 33
> 80636 M=C3=BCnchen
>
> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg
>
> Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherweise erha=
lten haben sollten, leiten Sie diese bitte nicht an jemand anderes weiter, =
l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie mich bit=
te wissen, dass die E-Mail an die falsche Person gesendet wurde.
>
>
>
> This e-mail is confidential. If you received this communication by mistak=
e, please don't forward it to anyone else, please erase all copies and atta=
chments, and please let me know that it has gone to the wrong person.
