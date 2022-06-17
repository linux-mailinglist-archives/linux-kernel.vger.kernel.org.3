Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8295254F1A1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380488AbiFQHNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380490AbiFQHNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:13:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7555414014
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1441A61F02
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F295C3411F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655450026;
        bh=JGsCs4tK5qbRzU6e76TvouliJTtVdOcvkKSP1d4FvN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rFSMzLL28gebcqUNwv6dNIfwXx6mjXTybMchpSUqCq+amHVxcnDV/9Ev3x3a/fjh2
         CLLHCLurghcHoKaBADI1u41OUendrbrjOOVRoctr302G6vZBVJ1ocNHSiSB4ieCB/X
         f3CQmLxZvKTPEPVXfYjjD34KcKDJm620KQs69qKUv0GImOqs5ab/k+NripFU+VnYpF
         nv1+AGOPgCvN+xHppS1XmTH1fMTY17cCAjdXM0lec7/vMt8PSOVyDhqW7Q6sw5GnRP
         UxJFoqJtHIWR79uCKrxo9fmEMO67miz7I0pdt58OlkfatsgmkP8bouNeD2PryfQvbC
         MTS5BestcToGw==
Received: by mail-vk1-f169.google.com with SMTP id g15so1634953vkm.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:13:46 -0700 (PDT)
X-Gm-Message-State: AJIora/RQQDlElLM0TrZnrAZy6pMSYnKFQ1/S8IspxTuBCtZcsjAyJju
        GP3kMJvMQpgE+YJVS63rAnsIsu79xyz/pgxP7RM=
X-Google-Smtp-Source: AGRyM1uDRVDa8eQB+G81iuPumuflNDu9ljX1ubP/DF7PcHOXMpglAYADvAhiMjjJUZwLamPMD/eQI6zK1yl6bM7Fx04=
X-Received: by 2002:ac5:c1c9:0:b0:35c:bd7c:2deb with SMTP id
 g9-20020ac5c1c9000000b0035cbd7c2debmr4079969vkk.2.1655450025379; Fri, 17 Jun
 2022 00:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220606123750.2884245-1-xianting.tian@linux.alibaba.com>
 <b2a45f97-0f97-6621-bb7e-11f51282c468@huawei.com> <b1098514-d185-e649-6dea-3c2f01e97ea8@linux.alibaba.com>
 <9fa53c5b-361a-a044-a08b-57458d7fcab8@linux.alibaba.com>
In-Reply-To: <9fa53c5b-361a-a044-a08b-57458d7fcab8@linux.alibaba.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 17 Jun 2022 15:13:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSjfmYS+5Q2TVb2p+5afkvv4yU12W+eiiMhgo2d8Z+2fA@mail.gmail.com>
Message-ID: <CAJF2gTSjfmYS+5Q2TVb2p+5afkvv4yU12W+eiiMhgo2d8Z+2fA@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Add fixup to support fast call of crash_kexec()
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Vitaly Wool <vitaly.wool@konsulko.com>, tongtiangen@huawei.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xianting,

On Fri, Jun 17, 2022 at 2:40 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> Hi Palmer
>
> Will you apply this patch for 5.19?
Maybe we could update tile with [PATCH v3] RISC-V: Fixup fast call of
crash_kexec() for a V4.

It's a fixup not feature, that would mislead maintainer. And add
"Reviewed-by: Kefeng Wang".

>
> thanks
>
> =E5=9C=A8 2022/6/7 =E4=B8=8A=E5=8D=889:46, Xianting Tian =E5=86=99=E9=81=
=93:
> >
> > =E5=9C=A8 2022/6/7 =E4=B8=8A=E5=8D=889:21, Kefeng Wang =E5=86=99=E9=81=
=93:
> >>
> >> On 2022/6/6 20:37, Xianting Tian wrote:
> >>> Currently, almost all archs (x86, arm64, mips...) support fast call
> >>> of crash_kexec() when "regs && kexec_should_crash()" is true. But
> >>> RISC-V not, it can only enter crash system via panic(). However panic=
()
> >>> doesn't pass the regs of the real accident scene to crash_kexec(),
> >>> it caused we can't get accurate backtrace via gdb,
> >>>     $ riscv64-linux-gnu-gdb vmlinux vmcore
> >>>     Reading symbols from vmlinux...
> >>>     [New LWP 95]
> >>>     #0  console_unlock () at kernel/printk/printk.c:2557
> >>>     2557                    if (do_cond_resched)
> >>>     (gdb) bt
> >>>     #0  console_unlock () at kernel/printk/printk.c:2557
> >>>     #1  0x0000000000000000 in ?? ()
> >>>
> >>> With the patch we can get the accurate backtrace,
> >>>     $ riscv64-linux-gnu-gdb vmlinux vmcore
> >>>     Reading symbols from vmlinux...
> >>>     [New LWP 95]
> >>>     #0  0xffffffe00063a4e0 in test_thread (data=3D<optimized out>) at
> >>> drivers/test_crash.c:81
> >>>     81             *(int *)p =3D 0xdead;
> >>>     (gdb)
> >>>     (gdb) bt
> >>>     #0  0xffffffe00064d5c0 in test_thread (data=3D<optimized out>) at
> >>> drivers/test_crash.c:81
> >>>     #1  0x0000000000000000 in ?? ()
> >>>
> >>> Test code to produce NULL address dereference in test_crash.c,
> >>>     void *p =3D NULL;
> >>>     *(int *)p =3D 0xdead;
> >>>
> >>> Fixes: 76d2a0493a17 ("RISC-V: Init and Halt Code")
> >>> Reviewed-by: Guo Ren <guoren@kernel.org>
> >>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> >>> ---
> >>> Changes from v1:
> >>> - simplify the commit message
> >>> Changes from v2:
> >>> - add fixup in title
> >>> ---
> >>>   arch/riscv/kernel/traps.c | 4 ++++
> >>>   1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> >>> index b40426509244..39d0f8bba4b4 100644
> >>> --- a/arch/riscv/kernel/traps.c
> >>> +++ b/arch/riscv/kernel/traps.c
> >>> @@ -16,6 +16,7 @@
> >>>   #include <linux/mm.h>
> >>>   #include <linux/module.h>
> >>>   #include <linux/irq.h>
> >>> +#include <linux/kexec.h>
> >>>     #include <asm/asm-prototypes.h>
> >>>   #include <asm/bug.h>
> >>> @@ -44,6 +45,9 @@ void die(struct pt_regs *regs, const char *str)
> >>>         ret =3D notify_die(DIE_OOPS, str, regs, 0, regs->cause, SIGSE=
GV);
> >>>   +    if (regs && kexec_should_crash(current))
> >>> +        crash_kexec(regs);
> >>> +
> >>
> >> It seems that the regs won't be null, right? except that,
> >
> > Autually both regs won't be null, But if it is triggered by panic() ,
> > the regs are got via riscv_crash_save_regs(), which are the regs of
> > that moment, but not the real accident scene.
> >
> >>
> >> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>
> >>>       bust_spinlocks(0);
> >>>       add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
> >>>       spin_unlock_irq(&die_lock);



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
