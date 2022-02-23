Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04B44C19C0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbiBWRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243408AbiBWRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:17:59 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5B0403FD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:17:30 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C09B53F33A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645636649;
        bh=/ozkhea4bGdkwQyqdllwEcc/DZs+W0S+IsF9ZSOsgS8=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=PxCrqJKH0HKewqV56ON2CC7/q3TNwme2faSvaAICigvW8ibhBBS91O0IKy7SLTPh9
         x/iTwTAssYn7lJFB0esuHs25NtqiQaB0heknBFql2fcuylojBq6xSuUDM8Bn4w6P3B
         SLb29JCHqRV9hX30wcR+MxBeOaqa5aeBlrG53wCqEmgAVeDu3w7QWsnNw5DnPIdF1O
         7jNoyCF+ffrPIhOBHt8x/efflis0o+qR09qAw6lmVWe4tSu+8sk+7QnEDFSmbVWpdk
         v0Lo3veGKWaiM/z4Nt7zE3EVsU8InnLNuuSwUrhDwxwJKoYRxT3WKPqGEg3HRd06aP
         cyq5yNQ5WOKbA==
Received: by mail-ed1-f70.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so13795601edh.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ozkhea4bGdkwQyqdllwEcc/DZs+W0S+IsF9ZSOsgS8=;
        b=WCRugaVLRIYW1U49eNGHmr24T81SiJjxlRk7ZVqaKnUw+2JMWyZCIcpzysxHHbQOcr
         4CuqK6OCprQ64BpCrqnhhbLBSk0OECEBNsVBWiPK8cqGxYuoY2aLfpBWAJd8UIKjQVSM
         80q5zfeOPURgr1PKMwzU3HlE7jJPYC1E9dstcNe8h+GNL0sMcFTG+xgXN11lCSaeiPoJ
         GHQOh0HuZwdfYIpytTcOV9qc2UOlf8AEKepZfinMQqMthR4I0v80CC3kDwfVLSZFlASN
         mN4b95ZZxAzb2OdRVWL5U0i93NweaTrpCCPw4mO0/jSZwvOCANEjbuoq+tKiPwCkDEMY
         Pncg==
X-Gm-Message-State: AOAM533EwvAZ34xhdUCT/pCVac8tYNGkLZgAoKkHPL8xOeZnQ5DVeG0S
        WVa9cDoBtEjj3/h3a4AO0nqq4vtFgKYFAtv+Zv8ZmEknSvVGckuQkAhzrn881KeHkk7BCcjQ+vv
        GacJx2VU475k2U9714Q/QpqX1jSBbuc8wZkhR31Wxu7M3uWLLzR2UGnpbIg==
X-Received: by 2002:a17:906:71d5:b0:6a7:fd56:e9ad with SMTP id i21-20020a17090671d500b006a7fd56e9admr538251ejk.178.1645636647500;
        Wed, 23 Feb 2022 09:17:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhQA7b1Bb9csDMI6vP1pWciNvkPbJXaIyGDNBoG0eroJtRI2MW0usYZXj0+NIsR6fmRaZcQ2C5SUg2GBSfpxA=
X-Received: by 2002:a17:906:71d5:b0:6a7:fd56:e9ad with SMTP id
 i21-20020a17090671d500b006a7fd56e9admr538234ejk.178.1645636647224; Wed, 23
 Feb 2022 09:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20220221161232.2168364-1-alexandre.ghiti@canonical.com>
 <20220221161232.2168364-5-alexandre.ghiti@canonical.com> <CANp29Y7M=wSLBE8m0-CHKtYPkqgcxNiUPEyRNv-VHeR5O2BTYQ@mail.gmail.com>
 <CA+zEjCt02Cx1Q1yDGN9V6Wvgx0+jvcqft6U56M3wsidkW5sMjg@mail.gmail.com>
In-Reply-To: <CA+zEjCt02Cx1Q1yDGN9V6Wvgx0+jvcqft6U56M3wsidkW5sMjg@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Wed, 23 Feb 2022 18:17:16 +0100
Message-ID: <CA+zEjCsDPqg1YwS_z4pCnP4GvwYd6Dhr6xwz51G4B8qvsUHqKQ@mail.gmail.com>
Subject: Re: [PATCH -fixes v2 4/4] riscv: Fix config KASAN && DEBUG_VIRTUAL
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 2:10 PM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> Hi Aleksandr,
>
> On Tue, Feb 22, 2022 at 11:28 AM Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > Hi Alexandre,
> >
> > Thanks for the series!
> >
> > However, I still haven't managed to boot the kernel. What I did:
> > 1) Checked out the riscv/fixes branch (this is the one we're using on
> > syzbot). The latest commit was
> > 6df2a016c0c8a3d0933ef33dd192ea6606b115e3.
> > 2) Applied all 4 patches.
> > 3) Used the config from the cover letter:
> > https://gist.github.com/a-nogikh/279c85c2d24f47efcc3e865c08844138
> > 4) Built with `make -j32 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-`
> > 5) Ran with `qemu-system-riscv64 -m 2048 -smp 1 -nographic -no-reboot
> > -device virtio-rng-pci -machine virt -device
> > virtio-net-pci,netdev=net0 -netdev
> > user,id=net0,restrict=on,hostfwd=tcp:127.0.0.1:12529-:22 -device
> > virtio-blk-device,drive=hd0 -drive
> > file=~/kernel-image/riscv64,if=none,format=raw,id=hd0 -snapshot
> > -kernel ~/linux-riscv/arch/riscv/boot/Image -append "root=/dev/vda
> > console=ttyS0 earlyprintk=serial"` (this is similar to how syzkaller
> > runs qemu).
> >
> > Can you please hint at what I'm doing differently?
>
> A short summary of what I found to keep you updated:
>
> I compared your command line and mine, the differences are that I use
> "smp=4" and I add "earlycon" to the kernel command line. When added to
> your command line, that allows it to boot. I understand why it helps
> but I can't explain what's wrong...Anyway, I fixed a warning that I
> had missed and that allows me to remove the "smp=4" and "earlycon".
>
> But this is not over yet...Your command line still does not allow to
> reach userspace, it fails with the following stacktrace:
>
> [   11.537817][    T1] Unable to handle kernel paging request at
> virtual address fffff5eeffffc800
> [   11.539450][    T1] Oops [#1]
> [   11.539909][    T1] Modules linked in:
> [   11.540451][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 5.17.0-rc1-00007-ga68b89289e26-dirty #28
> [   11.541364][    T1] Hardware name: riscv-virtio,qemu (DT)
> [   11.542032][    T1] epc : kasan_check_range+0x96/0x13e
> [   11.542654][    T1]  ra : memset+0x1e/0x4c
> [   11.543388][    T1] epc : ffffffff8046c312 ra : ffffffff8046ca16 sp
> : ffffaf8007337b70
> [   11.544037][    T1]  gp : ffffffff85866c80 tp : ffffaf80073d8000 t0
> : 0000000000046000
> [   11.544637][    T1]  t1 : fffff5eeffffc9ff t2 : 0000000000000000 s0
> : ffffaf8007337ba0
> [   11.545409][    T1]  s1 : 0000000000001000 a0 : fffff5eeffffca00 a1
> : 0000000000001000
> [   11.546072][    T1]  a2 : 0000000000000001 a3 : ffffffff8039ef24 a4
> : ffffaf7ffffe4000
> [   11.546707][    T1]  a5 : fffff5eeffffc800 a6 : 0000004000000000 a7
> : ffffaf7ffffe4fff
> [   11.547541][    T1]  s2 : ffffaf7ffffe4000 s3 : 0000000000000000 s4
> : ffffffff8467faa8
> [   11.548277][    T1]  s5 : 0000000000000000 s6 : ffffffff85869840 s7
> : 0000000000000000
> [   11.548950][    T1]  s8 : 0000000000001000 s9 : ffffaf805a54a048
> s10: ffffffff8588d420
> [   11.549705][    T1]  s11: ffffaf7ffffe4000 t3 : 0000000000000000 t4
> : 0000000000000040
> [   11.550465][    T1]  t5 : fffff5eeffffca00 t6 : 0000000000000002
> [   11.551131][    T1] status: 0000000000000120 badaddr:
> fffff5eeffffc800 cause: 000000000000000d
> [   11.551961][    T1] [<ffffffff8039ef24>] pcpu_alloc+0x84a/0x125c
> [   11.552928][    T1] [<ffffffff8039f994>] __alloc_percpu+0x28/0x34
> [   11.553555][    T1] [<ffffffff83286954>] ip_rt_init+0x15a/0x35c
> [   11.554128][    T1] [<ffffffff83286d24>] ip_init+0x18/0x30
> [   11.554642][    T1] [<ffffffff8328844a>] inet_init+0x2a6/0x550
> [   11.555428][    T1] [<ffffffff80003220>] do_one_initcall+0x132/0x7e4
> [   11.556049][    T1] [<ffffffff83201f7a>] kernel_init_freeable+0x510/0x5b4
> [   11.556771][    T1] [<ffffffff831424e4>] kernel_init+0x28/0x21c
> [   11.557344][    T1] [<ffffffff800056a0>] ret_from_exception+0x0/0x14
> [   11.585469][    T1] ---[ end trace 0000000000000000 ]---
>
> 0xfffff5eeffffc800 is a KASAN address that points to the very end of
> vmalloc address range, which is weird since KASAN_VMALLOC is not
> enabled.
> Moreover my command line does not trigger the above bug, and I'm
> trying to understand why:

When I read this email I saw that I did not use the same qemu version:
I have a locally built version that disables sv48, which is the one
that works so the problem came from the sv48 support.

In a nutshell, the issue comes from the fact that kasan inner regions
are not aligned on PGDIR_SIZE when sv48 (which is 4-level page table)
is on, and then when populating the kasan linear mapping region, that
clears the kasan vmalloc region which is in the same PGD: the fix is
to copy its content before initializing the linear mapping entries.
This issue only happens when KASAN_VMALLOC is disabled. I had fixed
this already for kasan_shallow_populate_pud, but missed
kasan_populate_pud.

Tomorrow I'll push the v3. It still does not fix the issue I describe
in the cover letter though, so still more work to do. At least, I was
able to reach userspace with your *exact* qemu command :)

Alex


>
> /home/alex/work/qemu/build/riscv64-softmmu/qemu-system-riscv64 -M virt
> -bios /home/alex/work/opensbi/build/platform/generic/firmware/fw_dynamic.bin
> -kernel /home/alex/work/kernel-build/riscv_rv64_kernel/arch/riscv/boot/Image
> -netdev user,id=net0 -device virtio-net-device,netdev=net0 -drive
> file=/home/alex/work/kernel-build/rootfs.ext2,format=raw,id=hd0
> -device virtio-blk-device,drive=hd0 -nographic -smp 4 -m 16G -s
> -append "rootwait earlycon root=/dev/vda ro earlyprintk=serial"
>
> I'm looking into all of this and will get back with a v3 soon :)
>
> Thanks,
>
> Alex
>
>
>
>
>
>
> >
> > A simple config with KASAN, KASAN_OUTLINE and DEBUG_VIRTUAL now indeed
> > leads to a booting kernel, which was not the case before.
> > make defconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> > ./scripts/config -e KASAN -e KASAN_OUTLINE -e DEBUG_VIRTUAL
> > make olddefconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> >
> > --
> > Best Regards,
> > Aleksandr
> >
> > On Mon, Feb 21, 2022 at 5:17 PM Alexandre Ghiti
> > <alexandre.ghiti@canonical.com> wrote:
> > >
> > > __virt_to_phys function is called very early in the boot process (ie
> > > kasan_early_init) so it should not be instrumented by KASAN otherwise it
> > > bugs.
> > >
> > > Fix this by declaring phys_addr.c as non-kasan instrumentable.
> > >
> > > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > > ---
> > >  arch/riscv/mm/Makefile | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> > > index 7ebaef10ea1b..ac7a25298a04 100644
> > > --- a/arch/riscv/mm/Makefile
> > > +++ b/arch/riscv/mm/Makefile
> > > @@ -24,6 +24,9 @@ obj-$(CONFIG_KASAN)   += kasan_init.o
> > >  ifdef CONFIG_KASAN
> > >  KASAN_SANITIZE_kasan_init.o := n
> > >  KASAN_SANITIZE_init.o := n
> > > +ifdef CONFIG_DEBUG_VIRTUAL
> > > +KASAN_SANITIZE_physaddr.o := n
> > > +endif
> > >  endif
> > >
> > >  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
> > > --
> > > 2.32.0
> > >
