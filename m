Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F124C91FF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiCARlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236645AbiCARkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:40:51 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6F436B41
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:39:55 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z15so14901718pfe.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=W4+GVkOQautzlTAwXMD1MQXzOa874amFJWoTUzo/RMw=;
        b=Qp4DFDQQ2fuMeWYZio5rlXtJndl0RtNg7Msq0QSGvjdLXMry4Zw3nqbZlLCABBpaee
         gNi2KbNAKiZQbuJ1CrWxJ/IXAruP+iJN/raBUYE+Hc2+j85+g2JHdnXrv8jdto+hQLhZ
         j71iC550AXG7YGg6/AHAgVtihOL4Fx6/aS3wlw6OMngYnnc6seeaIYIvn5XgRypjmnaE
         wMq6QQvnrxulrG+PLrYB4ywRCQZfQUGDBZ2gGC8Oq/XL3d/rqlgCvr9nj1L4lszOCznO
         ZvjCw4Pwwga9MHNMem2E/AVjaUvYsETqKpZ4s9vBsn3k/EGz66esUQJRBZBvF8uW9aTY
         gPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=W4+GVkOQautzlTAwXMD1MQXzOa874amFJWoTUzo/RMw=;
        b=jOzT+qvzQzR6HiLM/zBSyrtoPv/ZmyoHOWvLxZGv9jQHFEp+uGogVQGMSqU7DtsVdr
         re1pU+UdowjjNOHmKa5Mj1/98XBAGJvO0gcStIrDcxB3dQdCY2AnuW8/VeSuHKqS4wK1
         4fh3e4eU+GdHCtHoYlwalSojVrv22fAg9yCZDIkPF8NkvALkNK+wP35mYh2gcZ8gMoBv
         YUbHRbjDZZkgPs1sleNFqOQUr4bNKEFx1mOqrXcDNJs2v6RgXHK2LczRCggdl7tRLaX1
         Mv6nB0aNG5zGg0PCw7xCh1SkuRzkfM/d7gSk80mzs1rSi34G9i3yxr3QMsSBbqAsD1xu
         Ln3Q==
X-Gm-Message-State: AOAM53073FxClUGWO4q+9MHEl06A6NRpBksetk0jiHOJmM7RiSAspwCS
        6I+wNpnDJRN1kwgBQ4VxsA4n+g==
X-Google-Smtp-Source: ABdhPJw4ujAgqleyGeJ9YEOI/fZ+Fzu5tSZFA6mqHP6VhHTwO9GktsrbgUZsqC5FVgxtQRqEAfkVnw==
X-Received: by 2002:a63:d1e:0:b0:372:c1cd:9e16 with SMTP id c30-20020a630d1e000000b00372c1cd9e16mr22534900pgl.421.1646156394767;
        Tue, 01 Mar 2022 09:39:54 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p128-20020a622986000000b004e1366dd88esm16677413pfp.160.2022.03.01.09.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 09:39:54 -0800 (PST)
Date:   Tue, 01 Mar 2022 09:39:54 -0800 (PST)
X-Google-Original-Date: Tue, 01 Mar 2022 09:39:36 PST (-0800)
Subject:     Re: [PATCH -fixes v3 0/6] Fixes KASAN and other along the way
In-Reply-To: <CAG_fn=WTJF24TH6ENGD-3S0B_AV4=-39=2ry-uDguZ8Q7f=z=Q@mail.gmail.com>
CC:     alexandre.ghiti@canonical.com, elver@google.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ryabinin.a.a@gmail.com,
        andreyknvl@gmail.com, dvyukov@google.com, nogikh@google.com,
        nickhu@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     glider@google.com
Message-ID: <mhng-ffd5d5c5-9894-4dec-b332-5176d508bcf9@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 07:00:23 PST (-0800), glider@google.com wrote:
> On Fri, Feb 25, 2022 at 3:47 PM Alexandre Ghiti <
> alexandre.ghiti@canonical.com> wrote:
>
>> On Fri, Feb 25, 2022 at 3:31 PM Alexander Potapenko <glider@google.com>
>> wrote:
>> >
>> >
>> >
>> > On Fri, Feb 25, 2022 at 3:15 PM Alexandre Ghiti <
>> alexandre.ghiti@canonical.com> wrote:
>> >>
>> >> On Fri, Feb 25, 2022 at 3:10 PM Alexander Potapenko <glider@google.com>
>> wrote:
>> >> >
>> >> >
>> >> >
>> >> > On Fri, Feb 25, 2022 at 3:04 PM Alexandre Ghiti <
>> alexandre.ghiti@canonical.com> wrote:
>> >> >>
>> >> >> On Fri, Feb 25, 2022 at 2:06 PM Marco Elver <elver@google.com>
>> wrote:
>> >> >> >
>> >> >> > On Fri, 25 Feb 2022 at 13:40, Alexandre Ghiti
>> >> >> > <alexandre.ghiti@canonical.com> wrote:
>> >> >> > >
>> >> >> > > As reported by Aleksandr, syzbot riscv is broken since commit
>> >> >> > > 54c5639d8f50 ("riscv: Fix asan-stack clang build"). This commit
>> actually
>> >> >> > > breaks KASAN_INLINE which is not fixed in this series, that will
>> come later
>> >> >> > > when found.
>> >> >> > >
>> >> >> > > Nevertheless, this series fixes small things that made the syzbot
>> >> >> > > configuration + KASAN_OUTLINE fail to boot.
>> >> >> > >
>> >> >> > > Note that even though the config at [1] boots fine with this
>> series, I
>> >> >> > > was not able to boot the small config at [2] which fails because
>> >> >> > > kasan_poison receives a really weird address 0x4075706301000000
>> (maybe a
>> >> >> > > kasan person could provide some hint about what happens below in
>> >> >> > > do_ctors -> __asan_register_globals):
>> >> >> >
>> >> >> > asan_register_globals is responsible for poisoning redzones around
>> >> >> > globals. As hinted by 'do_ctors', it calls constructors, and in
>> this
>> >> >> > case a compiler-generated constructor that calls
>> >> >> > __asan_register_globals with metadata generated by the compiler.
>> That
>> >> >> > metadata contains information about global variables. Note, these
>> >> >> > constructors are called on initial boot, but also every time a
>> kernel
>> >> >> > module (that has globals) is loaded.
>> >> >> >
>> >> >> > It may also be a toolchain issue, but it's hard to say. If you're
>> >> >> > using GCC to test, try Clang (11 or later), and vice-versa.
>> >> >>
>> >> >> I tried 3 different gcc toolchains already, but that did not fix the
>> >> >> issue. The only thing that worked was setting asan-globals=0 in
>> >> >> scripts/Makefile.kasan, but ok, that's not a fix.
>> >> >> I tried to bisect this issue but our kasan implementation has been
>> >> >> broken quite a few times, so it failed.
>> >> >>
>> >> >> I keep digging!
>> >> >>
>> >> >
>> >> > The problem does not reproduce for me with GCC 11.2.0: kernels built
>> with both [1] and [2] are bootable.
>> >>
>> >> Do you mean you reach userspace? Because my image boots too, and fails
>> >> at some point:
>> >>
>> >> [    0.000150] sched_clock: 64 bits at 10MHz, resolution 100ns, wraps
>> >> every 4398046511100ns
>> >> [    0.015847] Console: colour dummy device 80x25
>> >> [    0.016899] printk: console [tty0] enabled
>> >> [    0.020326] printk: bootconsole [ns16550a0] disabled
>> >>
>> >
>> > In my case, QEMU successfully boots to the login prompt.
>> > I am running QEMU 6.2.0 (Debian 1:6.2+dfsg-2) and an image Aleksandr
>> shared with me (guess it was built according to this instruction:
>> https://github.com/google/syzkaller/blob/master/docs/linux/setup_linux-host_qemu-vm_riscv64-kernel.md
>> )
>> >
>>
>> Nice thanks guys! I always use the latest opensbi and not the one that
>> is embedded in qemu, which is the only difference between your command
>> line (which works) and mine (which does not work). So the issue is
>> probably there, I really need to investigate that now.
>>
>> Great to hear that!
>
>
>> That means I only need to fix KASAN_INLINE and we're good.
>>
>> I imagine Palmer can add your Tested-by on the series then?
>>
> Sure :)

Do you mind actually posting that (i, the Tested-by tag)?  It's less 
likely to get lost that way.  I intend on taking this into fixes ASAP, 
my builds have blown up for some reason (I got bounced between machines, 
so I'm blaming that) so I need to fix that first.

>
>>
>> Thanks again!
>>
>> Alex
>>
>> >>
>> >> It traps here.
>> >>
>> >> > FWIW here is how I run them:
>> >> >
>> >> > qemu-system-riscv64 -m 2048 -smp 1 -nographic -no-reboot \
>> >> >   -device virtio-rng-pci -machine virt -device \
>> >> >   virtio-net-pci,netdev=net0 -netdev \
>> >> >   user,id=net0,restrict=on,hostfwd=tcp:127.0.0.1:12529-:22 -device \
>> >> >   virtio-blk-device,drive=hd0 -drive \
>> >> >   file=${IMAGE},if=none,format=raw,id=hd0 -snapshot \
>> >> >   -kernel ${KERNEL_SRC_DIR}/arch/riscv/boot/Image -append
>> "root=/dev/vda
>> >> >   console=ttyS0 earlyprintk=serial"
>> >> >
>> >> >
>> >> >>
>> >> >> Thanks for the tips,
>> >> >>
>> >> >> Alex
>> >> >
>> >> >
>> >> >
>> >> > --
>> >> > Alexander Potapenko
>> >> > Software Engineer
>> >> >
>> >> > Google Germany GmbH
>> >> > Erika-Mann-Straße, 33
>> >> > 80636 München
>> >> >
>> >> > Geschäftsführer: Paul Manicle, Liana Sebastian
>> >> > Registergericht und -nummer: Hamburg, HRB 86891
>> >> > Sitz der Gesellschaft: Hamburg
>> >> >
>> >> > Diese E-Mail ist vertraulich. Falls Sie diese fälschlicherweise
>> erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
>> weiter, löschen Sie alle Kopien und Anhänge davon und lassen Sie mich bitte
>> wissen, dass die E-Mail an die falsche Person gesendet wurde.
>> >> >
>> >> >
>> >> >
>> >> > This e-mail is confidential. If you received this communication by
>> mistake, please don't forward it to anyone else, please erase all copies
>> and attachments, and please let me know that it has gone to the wrong
>> person.
>> >>
>> >> --
>> >> You received this message because you are subscribed to the Google
>> Groups "kasan-dev" group.
>> >> To unsubscribe from this group and stop receiving emails from it, send
>> an email to kasan-dev+unsubscribe@googlegroups.com.
>> >> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/kasan-dev/CA%2BzEjCsQPVYSV7CdhKnvjujXkMXuRQd%3DVPok1awb20xifYmidw%40mail.gmail.com
>> .
>> >
>> >
>> >
>> > --
>> > Alexander Potapenko
>> > Software Engineer
>> >
>> > Google Germany GmbH
>> > Erika-Mann-Straße, 33
>> > 80636 München
>> >
>> > Geschäftsführer: Paul Manicle, Liana Sebastian
>> > Registergericht und -nummer: Hamburg, HRB 86891
>> > Sitz der Gesellschaft: Hamburg
>> >
>> > Diese E-Mail ist vertraulich. Falls Sie diese fälschlicherweise erhalten
>> haben sollten, leiten Sie diese bitte nicht an jemand anderes weiter,
>> löschen Sie alle Kopien und Anhänge davon und lassen Sie mich bitte wissen,
>> dass die E-Mail an die falsche Person gesendet wurde.
>> >
>> >
>> >
>> > This e-mail is confidential. If you received this communication by
>> mistake, please don't forward it to anyone else, please erase all copies
>> and attachments, and please let me know that it has gone to the wrong
>> person.
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "kasan-dev" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to kasan-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/kasan-dev/CA%2BzEjCuJw8N0dUmQNdFqDM96bzKqPDjRe4FUnOCbjhJtO0R8Hg%40mail.gmail.com
>> .
>>
>
>
> -- 
> Alexander Potapenko
> Software Engineer
>
> Google Germany GmbH
> Erika-Mann-Straße, 33
> 80636 München
>
> Geschäftsführer: Paul Manicle, Liana Sebastian
> Registergericht und -nummer: Hamburg, HRB 86891
> Sitz der Gesellschaft: Hamburg
>
> Diese E-Mail ist vertraulich. Falls Sie diese fälschlicherweise erhalten
> haben sollten, leiten Sie diese bitte nicht an jemand anderes weiter,
> löschen Sie alle Kopien und Anhänge davon und lassen Sie mich bitte wissen,
> dass die E-Mail an die falsche Person gesendet wurde.
>
>
>
> This e-mail is confidential. If you received this communication by mistake,
> please don't forward it to anyone else, please erase all copies and
> attachments, and please let me know that it has gone to the wrong person.
