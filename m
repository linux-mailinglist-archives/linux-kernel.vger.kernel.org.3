Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7411A58975C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 07:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbiHDFgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 01:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiHDFgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 01:36:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6E04D176
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 22:36:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x39so19714973lfu.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 22:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=dwToIWTIAZs3lOqbZfyuTvqStRDyOPRIuqWffIxZVLs=;
        b=Bv0kuu79QynXtlL6xYsnEk1zDgzDROPAnos4WjY8EBYwqkEfJPJ+FOAwN5nQ+MBeLG
         svTJFxz1xEIGwATYt/RBYurwR6sm5IIRGsx8uBKtYA9Vb5b58iMqR+u/nkoPECElQORL
         DPbtAr9i8t+mxflbkOt4Xsw4lXGpwzohoSmyx0jNXac1FIHATjYnRNCOjSAIx3NydFHq
         QdFK5nh/1ee8MNU1AZ1ugMKyYOQ5k33/FXE1N92J+RSWDWCvhogMoDrc5M6F/H4i4dTU
         sQA3M2e432Lq5HbihniUyiA/sXJzJWO8y1+qlRKv4pS7pnQd5J5jYKs6rybpp7GdEC6h
         JzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=dwToIWTIAZs3lOqbZfyuTvqStRDyOPRIuqWffIxZVLs=;
        b=tgGqwn07JgRSnGvE7fiYybOhtPANxfCuakKlHoz8uxvHJ3M3rzItwdpcbtGSBtd9/D
         /CDJnD1aEukOV0Mu3FIY7fGfSFGwj/GB6a3rCdmpa7Ppj38ZUlclUHasA2aP8AQxoF73
         zRmtKspt0tZodgzUQemSkpfmR0lkVKFNKhZ/N4AXWECxCdHP4G8jmiiqLExMbJOUp7ul
         eU+Ub3RFLDHiN0OYPAjxKkLW0qBT5xEn0Bx3joWFNDqmkfUEIDTZlGiTfU1bu3uzz1eR
         b0gKIxqOgaVSdln9PNTW1/ZYFAml1myDQy82RkFThBZWm1lNHtnZh7XnHumv5ofeelzs
         5DiQ==
X-Gm-Message-State: ACgBeo3UzM8jnegVWTkOzAWvN3OsHTXbppVtTzzaic47Jm0Hp8VRC2St
        GjOeoi5jwqxyXfFEyOlr9a1ktTQPdOV6Afk9aeFiqA==
X-Google-Smtp-Source: AA6agR6G7YUcW5wAUYigbUaXEJm2ytrXb2s3k6xmb3ND7ZV6vqdL/8BPuYUXeFIGmYhf8orzcbMeHcQfY2DzuNk8C7Y=
X-Received: by 2002:a05:6512:6c8:b0:48a:f375:9ecc with SMTP id
 u8-20020a05651206c800b0048af3759eccmr130541lff.206.1659591369051; Wed, 03 Aug
 2022 22:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d0437b05dffdd1de@google.com> <CACT4Y+Y8DOKJtwhRsyNT7G26C3Fx_oeibpXn43Ks0RtYYdZG3g@mail.gmail.com>
 <36f4745f-0e47-4f49-8f4e-ff7544f163d8n@googlegroups.com> <CACT4Y+Zy7wLdeRCa+ZH-swo9ut=U6pEk4rP461QE1m-gT6s-uQ@mail.gmail.com>
 <a55430c3-a0bc-4af6-b7e2-20f2e0d091b2n@googlegroups.com> <CACT4Y+ar18tcxx0tOthV0JBrmWsLXtXAjXVFX4sac5k1UGJ7Lw@mail.gmail.com>
 <CACT4Y+ZAazG7UjKE1ZHq72bh4Ve1r3_Hw+zcONYoO1J959sukw@mail.gmail.com>
 <f2bcc414-aa96-cfcb-4df8-fe66cf47068f@ghiti.fr> <CACT4Y+bP+U2Co67SJG4qri=qHqCk38cq_JwGmo7m0s-8hCF8ww@mail.gmail.com>
 <CA+zEjCv+7k-Lu-rhOgXOVptzF9GpLt1K_1GHKnciMrTyenyT9g@mail.gmail.com>
In-Reply-To: <CA+zEjCv+7k-Lu-rhOgXOVptzF9GpLt1K_1GHKnciMrTyenyT9g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Aug 2022 07:35:57 +0200
Message-ID: <CACT4Y+Yi1NqFq4aXj96rG_hSb8wof2ty1Yiiw2ygDxHuTW5yxQ@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes test error: lost connection to test machine
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+2c5da6a0a16a0c4f34aa@syzkaller.appspotmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
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

On Tue, 31 May 2022 at 16:10, Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
> On Sat, May 28, 2022 at 10:31 AM Dmitry Vyukov <dvyukov@google.com> wrote=
:
>>
>> On Sat, 28 May 2022 at 10:09, Alexandre Ghiti <alex@ghiti.fr> wrote:
>> >
>> > On 5/27/22 19:12, Dmitry Vyukov wrote:
>> > > On Fri, 27 May 2022 at 19:04, Dmitry Vyukov <dvyukov@google.com> wro=
te:
>> > >> On Fri, 27 May 2022 at 16:01, Alexandre Ghiti
>> > >> <alexandre.ghiti@canonical.com> wrote:
>> > >>> On Friday, May 27, 2022 at 3:55:24 PM UTC+2 Dmitry Vyukov wrote:
>> > >>>> On Fri, 27 May 2022 at 15:50, Alexandre Ghiti
>> > >>>> <alexand...@canonical.com> wrote:
>> > >>>>> On Friday, May 27, 2022 at 3:02:01 PM UTC+2 Dmitry Vyukov wrote:
>> > >>>>>> On Fri, 27 May 2022 at 14:55, syzbot
>> > >>>>>> <syzbot+2c5da6...@syzkaller.appspotmail.com> wrote:
>> > >>>>>>> Hello,
>> > >>>>>>>
>> > >>>>>>> syzbot found the following issue on:
>> > >>>>>>>
>> > >>>>>>> HEAD commit: c932edeaf6d6 riscv: dts: microchip: fix gpio1 reg=
 property..
>> > >>>>>>> git tree: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/=
linux.git fixes
>> > >>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14=
18add5f00000
>> > >>>>>>> kernel config: https://syzkaller.appspot.com/x/.config?x=3Daa6=
b5702bdf14a17
>> > >>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2c5d=
a6a0a16a0c4f34aa
>> > >>>>>>> compiler: riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110, GNU ld (GNU Binutils for Debian) 2.35.2
>> > >>>>>>> userspace arch: riscv64
>> > >>>>>>>
>> > >>>>>>> IMPORTANT: if you fix the issue, please add the following tag =
to the commit:
>> > >>>>>>> Reported-by: syzbot+2c5da6...@syzkaller.appspotmail.com
>> > >>>>>> The CONFIG_KASAN_VMALLOC allows riscv kernel to boot, but now G=
o
>> > >>>>>> processes started crashing with:
>> > >>>>>>
>> > >>>>>> 1970/01/01 00:06:55 fuzzer started
>> > >>>>>> runtime: lfstack.push invalid packing: node=3D0xffffff5908a940 =
cnt=3D0x1
>> > >>>>>> packed=3D0xffff5908a9400001 -> node=3D0xffff5908a940
>> > >>>>>> fatal error: lfstack.push
>> > >>>>>> runtime stack:
>> > >>>>>> runtime.throw({0x30884c, 0xc})
>> > >>>>>> /usr/local/go/src/runtime/panic.go:1198 +0x60
>> > >>>>>> runtime.(*lfstack).push(0xdb3850, 0xffffff5908a940)
>> > >>>>>> /usr/local/go/src/runtime/lfstack.go:30 +0x1a8
>> > >>>>>>
>> > >>>>>> Go runtime tries to shove some data into the upper 16 bits of p=
ointers
>> > >>>>>> assuming they are unused.
>> > >>>>>> However, the original pointer node=3D0xffffff5908a940 suggest r=
iscv now
>> > >>>>>> has 56-bit users-space address space?
>> > >>>>>
>> > >>>>> Yes, sv57 was merged recently.
>> > >>>>>
>> > >>>>>> Documentation/riscv/vm-layout.rst claims 48-bit pointers:
>> > >>>>>> "
>> > >>>>>> The RISC-V privileged architecture document states that the 64b=
it addresses
>> > >>>>>> "must have bits 63=E2=80=9348 all equal to bit 47, or else a pa=
ge-fault exception will
>> > >>>>>> occur.":
>> > >>>>>
>> > >>>>> Thanks for pointing that, I extracted that from the specificatio=
n before sv57 was specified, I'll fix that.
>> > >>>>>
>> > >>>>> The current kernel code will use sv57 as it is supported and adv=
ertised by qemu, and to my knowledge, you can't downgrade to sv48 unless by=
 re-compiling qemu using the following:
>> > >>>>>
>> > >>>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> > >>>>> index 6dbe9b541f..a64b50ed75 100644
>> > >>>>> --- a/target/riscv/csr.c
>> > >>>>> +++ b/target/riscv/csr.c
>> > >>>>> @@ -637,7 +637,7 @@ static const char valid_vm_1_10_64[16] =3D {
>> > >>>>> [VM_1_10_MBARE] =3D 1,
>> > >>>>> [VM_1_10_SV39] =3D 1,
>> > >>>>> [VM_1_10_SV48] =3D 1,
>> > >>>>> - [VM_1_10_SV57] =3D 1
>> > >>>>> + [VM_1_10_SV57] =3D 0
>> > >>>>> };
>> > >>>>>
>> > >>>>> /* Machine Information Registers */
>> > >>>>>
>> > >>>>>> ...
>> > >>>>>> 0000000000000000 | 0 | 0000003fffffffff | 256 GB |
>> > >>>>>> user-space virtual memory, different per mm
>> > >>>>>> "
>> > >>>> There is no kernel config to force SV48/39, right?
>> > >>>
>> > >>> No, we rely on what the hardware advertises, if it supports sv57, =
we'll go for sv57, if not, we'll try sv48...etc. I had some patches to forc=
e the downgrade by using the device tree but they never got merged though.
>> > >> +original CC list
>> > >>
>> > >> FTR sent Go runtime change to support SV57:
>> > >> https://go-review.googlesource.com/c/go/+/409055
>> > >
>> > >
>> > > Is CONFIG_CMDLINE broken on riscv?
>> > > I am running with:
>> > >
>> > > CONFIG_CMDLINE=3D"earlyprintk=3Dserial net.ifnames=3D0
>> > > sysctl.kernel.hung_task_all_cpu_backtrace=3D1 ima_policy=3Dtcb
>> > > nf-conntrack-ftp.ports=3D20000 nf-conntrack-tftp.ports=3D20000
>> > > nf-conntrack-sip.ports=3D20000 nf-conntrack-irc.ports=3D20000
>> > > nf-conntrack-sane.ports=3D20000 binder.debug_mask=3D0
>> > > rcupdate.rcu_expedited=3D1 no_hash_pointers page_owner=3Don
>> > > sysctl.vm.nr_hugepages=3D4 sysctl.vm.nr_overcommit_hugepages=3D4
>> > > secretmem.enable=3D1 sysctl.max_rcu_stall_to_panic=3D1
>> > > msr.allow_writes=3Doff dummy_hcd.num=3D2 smp.csd_lock_timeout=3D3000=
00
>> > > watchdog_thresh=3D165 workqueue.watchdog_thresh=3D420
>> > > sysctl.net.core.netdev_unregister_timeout_secs=3D420 panic_on_warn=
=3D1"
>> >
>> >
>> > This command line is 608-character long, but we are still stuck with t=
he
>> > default COMMAND_LINE_SIZE to 512, I imagine that it is the problem. I
>> > had proposed a patch last year to bump that to 1024, but it never got
>> > merged
>> > https://lore.kernel.org/lkml/CAEn-LTqTXCEC=3DbXTvGyo8SNL0JMWRKtiSwQB7R=
=3DPc4uhxZUruA@mail.gmail.com/T/#m4b45019dc0f5573f2a50c1f6007c5109fa35efff
>>
>>
>> risc-v maintainers, please merge it now.
>> I would even suggest 2048:
>>
>> git grep "define COMMAND_LINE_SIZE" arch/
>> arch/alpha/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE   256
>> arch/arc/include/asm/setup.h:#define COMMAND_LINE_SIZE 256
>> arch/arm/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE 1024
>> arch/arm64/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE   2048
>> arch/ia64/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE    2048
>> arch/m68k/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE 256
>> arch/microblaze/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE      =
256
>> arch/mips/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE    4096
>> arch/parisc/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE  1024
>> arch/powerpc/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE 2048
>> arch/s390/include/asm/setup.h:#define COMMAND_LINE_SIZE CONFIG_COMMAND_L=
INE_SIZE
>> arch/sparc/include/uapi/asm/setup.h:# define COMMAND_LINE_SIZE 2048
>> arch/sparc/include/uapi/asm/setup.h:# define COMMAND_LINE_SIZE 256
>> arch/um/include/asm/setup.h:#define COMMAND_LINE_SIZE 4096
>> arch/x86/include/asm/setup.h:#define COMMAND_LINE_SIZE 2048
>> arch/xtensa/include/uapi/asm/setup.h:#define COMMAND_LINE_SIZE  256
>>
>>
>> It's also interesting how the kernel handles overflow. Imagine one
>> adds that_critical_security_feature=3D1 to the end of an existing long
>> line.
>
>
> Your comment rang a bell and I searched in my old patchsets: I had submit=
ted a patch [1] to output a warning in case of an overflow and to correctly=
 truncate the command line to avoid such issues: it was taken with another =
series [2] which was actually never merged...My bad on this one, I followed=
 my patch in the series but not the series itself.
>
> I'll try to re-submit it because I agree the current behaviour is really =
wrong.
>
> [1] https://lore.kernel.org/lkml/ee702ff7-f43c-745c-4157-b1cba53bb0b2@ghi=
ti.fr/T/
> [2] https://lore.kernel.org/linux-devicetree/c3d52a6e1423d9d27c59ad7ab945=
929b09f74866.1617375802.git.christophe.leroy@csgroup.eu/T/


FTR I've merged the Go fix for SV57:
https://go-review.googlesource.com/c/go/+/409055
but it will only appear in Go 1.20.

And we still have the command line length issue for reviving syzbot testing=
.
