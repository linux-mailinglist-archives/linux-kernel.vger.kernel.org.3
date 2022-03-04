Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4C74CCC7D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 05:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbiCDENP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 23:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiCDENM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:13:12 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA117FD25
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 20:12:21 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so9628031pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 20:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id;
        bh=+d5M5Lb/1zkG36m0uGpnpPesPt+KsHy1eBe0GK/XMwc=;
        b=CkkA0/mouPXvKxUd3YxzJ5m4xo9WUwlpAqWfyuwr/cbcBOjnHVzlZDM/xlZ0d0ENSM
         C7Fau+6H4rDje2AS8qTyaRNBj0uG3HGJYm6En5wqXqUSJdhdyMT5DxkioaTFUj+N3BuN
         smwMX2GXVkvuLQdPCkswKlU4EIfzUgIfUWeyC9hQon88WOEvS959J1CK3ax4iKdMdLep
         dLCJk9yemy28QBa4T4aw5o5v+rrvInjenaF5XCOnXy0IavdHPXL9lNgc8COhqKe+xseg
         pazVacQhjHalPdfpGCt5KxRDVsn2ZVRB2lXWGaAAZyKrXJwyBO9EJISn5anl8gbJjOOK
         YAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
        bh=+d5M5Lb/1zkG36m0uGpnpPesPt+KsHy1eBe0GK/XMwc=;
        b=p4NPjfr2MsdoZ7X+An2RhxXgWOpyNlOcEpo+Cc0G9b1tOgtOd2CmZ//VpivR94mSZz
         EwDAeWQmDFDLGnVlnCfuLu+/xuSBJaXplrqSbA6sd+C06Vuh2KwV+RBAmB2adfAWC6BQ
         pnOayfJjKVzBHmIUgBw8MldMmMIITu7abC7W3AvpDVqCvYSsaRDAgXX9v3Dh4aVXzffD
         PLiG6oVowQvvKKxuWfu2UXjuszlyNGi7QZKS4vGG03PbQcn5JzrOK8am/GeZuw1UfE1Y
         0vEqRaeXgj+XPPXlQ7UjBMXvzHO+VS2rqrJ6UcdRGaPnMViFTipRYMq1WkDEZCGNh8Az
         1fCw==
X-Gm-Message-State: AOAM530IYU1AYzyX6UV4tXBNdTR1DG24Gq35mbZFw+3C1pphiPAaYx3o
        /cET9hPE6fqINlKOSOVNZwO3Dg==
X-Google-Smtp-Source: ABdhPJwk/aE9ZV2E0IeEwWLejVf0b7LnvK5v9Cia+nWX3T1a9QlOU8bJXE16cd5hnokM5m6R/5MLXw==
X-Received: by 2002:a17:90a:7385:b0:1b9:6492:c107 with SMTP id j5-20020a17090a738500b001b96492c107mr8682494pjg.103.1646367140345;
        Thu, 03 Mar 2022 20:12:20 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id z7-20020a056a00240700b004e1cde37bc1sm4075952pfh.84.2022.03.03.20.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 20:12:19 -0800 (PST)
Date:   Thu, 03 Mar 2022 20:12:19 -0800 (PST)
X-Google-Original-Date: Thu, 03 Mar 2022 20:03:24 PST (-0800)
Subject:     Re: [PATCH -fixes v3 0/6] Fixes KASAN and other along the way
In-Reply-To: <mhng-ffd5d5c5-9894-4dec-b332-5176d508bcf9@palmer-mbp2014>
CC:     elver@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ryabinin.a.a@gmail.com,
        andreyknvl@gmail.com, dvyukov@google.com, nogikh@google.com,
        nickhu@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     glider@google.com, alexandre.ghiti@canonical.com
Message-ID: <mhng-ef0f4bac-b55e-471e-8e3d-8ea597081b74@palmer-ri-x1c9>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Mar 2022 09:39:54 PST (-0800), Palmer Dabbelt wrote:
> On Fri, 25 Feb 2022 07:00:23 PST (-0800), glider@google.com wrote:
>> On Fri, Feb 25, 2022 at 3:47 PM Alexandre Ghiti <
>> alexandre.ghiti@canonical.com> wrote:
>>
>>> On Fri, Feb 25, 2022 at 3:31 PM Alexander Potapenko <glider@google.com>
>>> wrote:
>>> >
>>> >
>>> >
>>> > On Fri, Feb 25, 2022 at 3:15 PM Alexandre Ghiti <
>>> alexandre.ghiti@canonical.com> wrote:
>>> >>
>>> >> On Fri, Feb 25, 2022 at 3:10 PM Alexander Potapenko <glider@google.com>
>>> wrote:
>>> >> >
>>> >> >
>>> >> >
>>> >> > On Fri, Feb 25, 2022 at 3:04 PM Alexandre Ghiti <
>>> alexandre.ghiti@canonical.com> wrote:
>>> >> >>
>>> >> >> On Fri, Feb 25, 2022 at 2:06 PM Marco Elver <elver@google.com>
>>> wrote:
>>> >> >> >
>>> >> >> > On Fri, 25 Feb 2022 at 13:40, Alexandre Ghiti
>>> >> >> > <alexandre.ghiti@canonical.com> wrote:
>>> >> >> > >
>>> >> >> > > As reported by Aleksandr, syzbot riscv is broken since commit
>>> >> >> > > 54c5639d8f50 ("riscv: Fix asan-stack clang build"). This commit
>>> actually
>>> >> >> > > breaks KASAN_INLINE which is not fixed in this series, that will
>>> come later
>>> >> >> > > when found.
>>> >> >> > >
>>> >> >> > > Nevertheless, this series fixes small things that made the syzbot
>>> >> >> > > configuration + KASAN_OUTLINE fail to boot.
>>> >> >> > >
>>> >> >> > > Note that even though the config at [1] boots fine with this
>>> series, I
>>> >> >> > > was not able to boot the small config at [2] which fails because
>>> >> >> > > kasan_poison receives a really weird address 0x4075706301000000
>>> (maybe a
>>> >> >> > > kasan person could provide some hint about what happens below in
>>> >> >> > > do_ctors -> __asan_register_globals):
>>> >> >> >
>>> >> >> > asan_register_globals is responsible for poisoning redzones around
>>> >> >> > globals. As hinted by 'do_ctors', it calls constructors, and in
>>> this
>>> >> >> > case a compiler-generated constructor that calls
>>> >> >> > __asan_register_globals with metadata generated by the compiler.
>>> That
>>> >> >> > metadata contains information about global variables. Note, these
>>> >> >> > constructors are called on initial boot, but also every time a
>>> kernel
>>> >> >> > module (that has globals) is loaded.
>>> >> >> >
>>> >> >> > It may also be a toolchain issue, but it's hard to say. If you're
>>> >> >> > using GCC to test, try Clang (11 or later), and vice-versa.
>>> >> >>
>>> >> >> I tried 3 different gcc toolchains already, but that did not fix the
>>> >> >> issue. The only thing that worked was setting asan-globals=0 in
>>> >> >> scripts/Makefile.kasan, but ok, that's not a fix.
>>> >> >> I tried to bisect this issue but our kasan implementation has been
>>> >> >> broken quite a few times, so it failed.
>>> >> >>
>>> >> >> I keep digging!
>>> >> >>
>>> >> >
>>> >> > The problem does not reproduce for me with GCC 11.2.0: kernels built
>>> with both [1] and [2] are bootable.
>>> >>
>>> >> Do you mean you reach userspace? Because my image boots too, and fails
>>> >> at some point:
>>> >>
>>> >> [    0.000150] sched_clock: 64 bits at 10MHz, resolution 100ns, wraps
>>> >> every 4398046511100ns
>>> >> [    0.015847] Console: colour dummy device 80x25
>>> >> [    0.016899] printk: console [tty0] enabled
>>> >> [    0.020326] printk: bootconsole [ns16550a0] disabled
>>> >>
>>> >
>>> > In my case, QEMU successfully boots to the login prompt.
>>> > I am running QEMU 6.2.0 (Debian 1:6.2+dfsg-2) and an image Aleksandr
>>> shared with me (guess it was built according to this instruction:
>>> https://github.com/google/syzkaller/blob/master/docs/linux/setup_linux-host_qemu-vm_riscv64-kernel.md
>>> )
>>> >
>>>
>>> Nice thanks guys! I always use the latest opensbi and not the one that
>>> is embedded in qemu, which is the only difference between your command
>>> line (which works) and mine (which does not work). So the issue is
>>> probably there, I really need to investigate that now.
>>>
>>> Great to hear that!
>>
>>
>>> That means I only need to fix KASAN_INLINE and we're good.
>>>
>>> I imagine Palmer can add your Tested-by on the series then?
>>>
>> Sure :)
>
> Do you mind actually posting that (i, the Tested-by tag)?  It's less
> likely to get lost that way.  I intend on taking this into fixes ASAP,
> my builds have blown up for some reason (I got bounced between machines,
> so I'm blaming that) so I need to fix that first.

This is on fixes (with a "Tested-by: Alexander Potapenko 
<glider@google.com>"), along with some trivial commit message fixes.

Thanks!

>
>>
>>>
>>> Thanks again!
>>>
>>> Alex
>>>
>>> >>
>>> >> It traps here.
>>> >>
>>> >> > FWIW here is how I run them:
>>> >> >
>>> >> > qemu-system-riscv64 -m 2048 -smp 1 -nographic -no-reboot \
>>> >> >   -device virtio-rng-pci -machine virt -device \
>>> >> >   virtio-net-pci,netdev=net0 -netdev \
>>> >> >   user,id=net0,restrict=on,hostfwd=tcp:127.0.0.1:12529-:22 -device \
>>> >> >   virtio-blk-device,drive=hd0 -drive \
>>> >> >   file=${IMAGE},if=none,format=raw,id=hd0 -snapshot \
>>> >> >   -kernel ${KERNEL_SRC_DIR}/arch/riscv/boot/Image -append
>>> "root=/dev/vda
>>> >> >   console=ttyS0 earlyprintk=serial"
>>> >> >
>>> >> >
>>> >> >>
>>> >> >> Thanks for the tips,
>>> >> >>
>>> >> >> Alex
>>> >> >
>>> >> >
>>> >> >
>>> >> > --
>>> >> > Alexander Potapenko
>>> >> > Software Engineer
>>> >> >
>>> >> > Google Germany GmbH
>>> >> > Erika-Mann-Straße, 33
>>> >> > 80636 München
>>> >> >
>>> >> > Geschäftsführer: Paul Manicle, Liana Sebastian
>>> >> > Registergericht und -nummer: Hamburg, HRB 86891
>>> >> > Sitz der Gesellschaft: Hamburg
>>> >> >
>>> >> > Diese E-Mail ist vertraulich. Falls Sie diese fälschlicherweise
>>> erhalten haben sollten, leiten Sie diese bitte nicht an jemand anderes
>>> weiter, löschen Sie alle Kopien und Anhänge davon und lassen Sie mich bitte
>>> wissen, dass die E-Mail an die falsche Person gesendet wurde.
>>> >> >
>>> >> >
>>> >> >
>>> >> > This e-mail is confidential. If you received this communication by
>>> mistake, please don't forward it to anyone else, please erase all copies
>>> and attachments, and please let me know that it has gone to the wrong
>>> person.
>>> >>
>>> >> --
>>> >> You received this message because you are subscribed to the Google
>>> Groups "kasan-dev" group.
>>> >> To unsubscribe from this group and stop receiving emails from it, send
>>> an email to kasan-dev+unsubscribe@googlegroups.com.
>>> >> To view this discussion on the web visit
>>> https://groups.google.com/d/msgid/kasan-dev/CA%2BzEjCsQPVYSV7CdhKnvjujXkMXuRQd%3DVPok1awb20xifYmidw%40mail.gmail.com
>>> .
>>> >
>>> >
>>> >
>>> > --
>>> > Alexander Potapenko
>>> > Software Engineer
>>> >
>>> > Google Germany GmbH
>>> > Erika-Mann-Straße, 33
>>> > 80636 München
>>> >
>>> > Geschäftsführer: Paul Manicle, Liana Sebastian
>>> > Registergericht und -nummer: Hamburg, HRB 86891
>>> > Sitz der Gesellschaft: Hamburg
>>> >
>>> > Diese E-Mail ist vertraulich. Falls Sie diese fälschlicherweise erhalten
>>> haben sollten, leiten Sie diese bitte nicht an jemand anderes weiter,
>>> löschen Sie alle Kopien und Anhänge davon und lassen Sie mich bitte wissen,
>>> dass die E-Mail an die falsche Person gesendet wurde.
>>> >
>>> >
>>> >
>>> > This e-mail is confidential. If you received this communication by
>>> mistake, please don't forward it to anyone else, please erase all copies
>>> and attachments, and please let me know that it has gone to the wrong
>>> person.
>>>
>>> --
>>> You received this message because you are subscribed to the Google Groups
>>> "kasan-dev" group.
>>> To unsubscribe from this group and stop receiving emails from it, send an
>>> email to kasan-dev+unsubscribe@googlegroups.com.
>>> To view this discussion on the web visit
>>> https://groups.google.com/d/msgid/kasan-dev/CA%2BzEjCuJw8N0dUmQNdFqDM96bzKqPDjRe4FUnOCbjhJtO0R8Hg%40mail.gmail.com
>>> .
>>>
>>
>>
>> --
>> Alexander Potapenko
>> Software Engineer
>>
>> Google Germany GmbH
>> Erika-Mann-Straße, 33
>> 80636 München
>>
>> Geschäftsführer: Paul Manicle, Liana Sebastian
>> Registergericht und -nummer: Hamburg, HRB 86891
>> Sitz der Gesellschaft: Hamburg
>>
>> Diese E-Mail ist vertraulich. Falls Sie diese fälschlicherweise erhalten
>> haben sollten, leiten Sie diese bitte nicht an jemand anderes weiter,
>> löschen Sie alle Kopien und Anhänge davon und lassen Sie mich bitte wissen,
>> dass die E-Mail an die falsche Person gesendet wurde.
>>
>>
>>
>> This e-mail is confidential. If you received this communication by mistake,
>> please don't forward it to anyone else, please erase all copies and
>> attachments, and please let me know that it has gone to the wrong person.
