Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D334C4732
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241679AbiBYOQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiBYOQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:16:16 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23051FEFB3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:15:43 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EC06A3F1C9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645798540;
        bh=BHkRiN2+iHrNe9IyAVbFKEoIknvTuRWbCd0yRYKLYmo=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KCQANUMQsObTG+GbgLbnt2cJmMPPKRgMruMl2Pz/REJOQ/nynESepR1gr/sjrm7sN
         eQmlFunI1xRM7y+hBbKUFKW7ay87gAGz3pIDPgs3Jb6hqy2A/tK6Bn2oQU4/e5iAEr
         NjllcPbhBg+9HU0f7vN1pUMK1xXGFAgBJgwlNfhSs2LGlxX/kEzQnYPvHB655bt1L/
         3gmPS1qnTFSEnjU+GiiWL9S0DHbWMQTwsBPPdAVu4ubUUm/rqfdluWvj3+KMDaMhfa
         4Wdx/2D9QGLqyiILxXEIgDocIJCzs16DK4WbdiVLzVQdaWMjR9oTSB4AmMQipK8BlR
         ky60ap3trSoQQ==
Received: by mail-ej1-f72.google.com with SMTP id kw5-20020a170907770500b006ba314a753eso2699382ejc.21
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:15:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BHkRiN2+iHrNe9IyAVbFKEoIknvTuRWbCd0yRYKLYmo=;
        b=hz1t8MA6VC9c0XpmoczfJxHQJbDd9FN9X7I+AKcIvzYitDi3mmTMLsmfA6BA8iBrfZ
         ecIRrz9CpdBxgsdotIRA5bwkw+QuomVX1vY4cEp7LL5t2vZx+UeIoOq04apl1xLu7Frz
         pdFvZtkbSl/KRpFnxoAyCneF+Km0KR2e+/t/Q+SUdKAYr/FHE3ZS4JHXy0ORyrDxTGFq
         ghMxJmJEk1wguBO12JpkOANwaS06QDpPUp2U6llFKt1L8gtbCaj7paqeYQZSJCdWujjW
         QsXTR1ffEz/lSLTiXXVzCBtgsqvr4qD/q/xa2UQG4I0vThdiyREwztt3MprzVhFQBDPV
         97Ag==
X-Gm-Message-State: AOAM533o9SYk0qH1GhQGf9bkB/hL+hoqdRKXzqjvYcnPb5wp2gFT2l5v
        eMEBhQ/r1AXGlhgAzC/KFAO6o4PGxrb+s8RAl/TxE/vULqzuoATbeEyDIg3JhPSIMMOYsr9a12R
        iAvZ3uhtzd9QQPyGAnB0LkEDjYxQAdqdav//Y2S4vOZaZqWgj0HOZoYkm2Q==
X-Received: by 2002:a17:906:d9db:b0:6ce:8bfb:53c9 with SMTP id qk27-20020a170906d9db00b006ce8bfb53c9mr6213782ejb.10.1645798540436;
        Fri, 25 Feb 2022 06:15:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymJbl8jCEi+Pf3yaoLS65OCZyC1VufCGOWEPB5OWn9bDdSBu6B+8GVapqE9Us3WHEqglHOBn9EhFSQ0IofhjI=
X-Received: by 2002:a17:906:d9db:b0:6ce:8bfb:53c9 with SMTP id
 qk27-20020a170906d9db00b006ce8bfb53c9mr6213767ejb.10.1645798540184; Fri, 25
 Feb 2022 06:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
 <CANpmjNN304EZfFN2zobxKGXbXWXAfr92nP1KvtR7j-YqSFShvQ@mail.gmail.com>
 <CA+zEjCtuwnKdi8EuyGWaYNFa7KsYcH9B1mYke6YALo+C1Nq+Dw@mail.gmail.com> <CAG_fn=WYmkqPX_qCVmxv1dx87JkXHGF1-a6_8K0jwWuBWzRJfA@mail.gmail.com>
In-Reply-To: <CAG_fn=WYmkqPX_qCVmxv1dx87JkXHGF1-a6_8K0jwWuBWzRJfA@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Fri, 25 Feb 2022 15:15:29 +0100
Message-ID: <CA+zEjCsQPVYSV7CdhKnvjujXkMXuRQd=VPok1awb20xifYmidw@mail.gmail.com>
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

On Fri, Feb 25, 2022 at 3:10 PM Alexander Potapenko <glider@google.com> wro=
te:
>
>
>
> On Fri, Feb 25, 2022 at 3:04 PM Alexandre Ghiti <alexandre.ghiti@canonica=
l.com> wrote:
>>
>> On Fri, Feb 25, 2022 at 2:06 PM Marco Elver <elver@google.com> wrote:
>> >
>> > On Fri, 25 Feb 2022 at 13:40, Alexandre Ghiti
>> > <alexandre.ghiti@canonical.com> wrote:
>> > >
>> > > As reported by Aleksandr, syzbot riscv is broken since commit
>> > > 54c5639d8f50 ("riscv: Fix asan-stack clang build"). This commit actu=
ally
>> > > breaks KASAN_INLINE which is not fixed in this series, that will com=
e later
>> > > when found.
>> > >
>> > > Nevertheless, this series fixes small things that made the syzbot
>> > > configuration + KASAN_OUTLINE fail to boot.
>> > >
>> > > Note that even though the config at [1] boots fine with this series,=
 I
>> > > was not able to boot the small config at [2] which fails because
>> > > kasan_poison receives a really weird address 0x4075706301000000 (may=
be a
>> > > kasan person could provide some hint about what happens below in
>> > > do_ctors -> __asan_register_globals):
>> >
>> > asan_register_globals is responsible for poisoning redzones around
>> > globals. As hinted by 'do_ctors', it calls constructors, and in this
>> > case a compiler-generated constructor that calls
>> > __asan_register_globals with metadata generated by the compiler. That
>> > metadata contains information about global variables. Note, these
>> > constructors are called on initial boot, but also every time a kernel
>> > module (that has globals) is loaded.
>> >
>> > It may also be a toolchain issue, but it's hard to say. If you're
>> > using GCC to test, try Clang (11 or later), and vice-versa.
>>
>> I tried 3 different gcc toolchains already, but that did not fix the
>> issue. The only thing that worked was setting asan-globals=3D0 in
>> scripts/Makefile.kasan, but ok, that's not a fix.
>> I tried to bisect this issue but our kasan implementation has been
>> broken quite a few times, so it failed.
>>
>> I keep digging!
>>
>
> The problem does not reproduce for me with GCC 11.2.0: kernels built with=
 both [1] and [2] are bootable.

Do you mean you reach userspace? Because my image boots too, and fails
at some point:

[    0.000150] sched_clock: 64 bits at 10MHz, resolution 100ns, wraps
every 4398046511100ns
[    0.015847] Console: colour dummy device 80x25
[    0.016899] printk: console [tty0] enabled
[    0.020326] printk: bootconsole [ns16550a0] disabled

It traps here.

> FWIW here is how I run them:
>
> qemu-system-riscv64 -m 2048 -smp 1 -nographic -no-reboot \
>   -device virtio-rng-pci -machine virt -device \
>   virtio-net-pci,netdev=3Dnet0 -netdev \
>   user,id=3Dnet0,restrict=3Don,hostfwd=3Dtcp:127.0.0.1:12529-:22 -device =
\
>   virtio-blk-device,drive=3Dhd0 -drive \
>   file=3D${IMAGE},if=3Dnone,format=3Draw,id=3Dhd0 -snapshot \
>   -kernel ${KERNEL_SRC_DIR}/arch/riscv/boot/Image -append "root=3D/dev/vd=
a
>   console=3DttyS0 earlyprintk=3Dserial"
>
>
>>
>> Thanks for the tips,
>>
>> Alex
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
