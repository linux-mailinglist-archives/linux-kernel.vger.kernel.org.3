Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4A9527DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbiEPGvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240654AbiEPGvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:51:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7703633F
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6CADB80E17
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE69C385B8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652683874;
        bh=VnhplqP5C1OGrCIayDVu5lClsqFPYcrnV6QF9ztKEzI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rlCBtdsyM1BLOb6pklLk17Li+O4g9Sjs4+g2dOgvnhrrR2V3279c4/CNyFEqjBE7I
         jiHUg7zeXv4A6zC5a0B43hA+WriVHB6peH3CHzbVw/drmh8pXSXNGHEJkTMtzahs0w
         nour/DbCXZ5mmJaelC/946rdADD/JVKchXyUYr+iWr51Dng3BkOTHgMPG+w1Cx+SSu
         vT/K0IWkEQpnK46jVD6cEfaRMjJfP7E+Ulg5DfNxmYA7ep3RCc9DaLQAOvtO+uWBqr
         TBLfhjZsfjGyS6pvI2rivKts2a89BneaWVxymQUpK/Qb727vWoU6Pfp1iV9NQPPZOR
         zyo4WLSVUOmEw==
Received: by mail-vs1-f48.google.com with SMTP id a127so14521058vsa.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:51:14 -0700 (PDT)
X-Gm-Message-State: AOAM533YiOoygqmefm1Vph4hqqKtkRpQk/i/xMtsMw4S61qOqUZIVBXE
        c6LOEwKpcPIomHgNxJ0r5D5UQutlr+nMFv0eq7c=
X-Google-Smtp-Source: ABdhPJzE0ghTRETFmmFWpTrlU6Xx8/k8CZMycNU4BOY6FtbZ6KEMJI6pw0TcqX4NszTl0oN6BxWhztxrBibIAQzmJ1M=
X-Received: by 2002:a05:6102:390b:b0:32d:5fc3:bd2c with SMTP id
 e11-20020a056102390b00b0032d5fc3bd2cmr5076830vsu.51.1652683873645; Sun, 15
 May 2022 23:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220515131407.946832-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20220515131407.946832-1-xianting.tian@linux.alibaba.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 16 May 2022 14:51:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS6StTP2QgEW65w79UaYLx2LEYLC8HF_VzFkgzRpfvXyw@mail.gmail.com>
Message-ID: <CAJF2gTS6StTP2QgEW65w79UaYLx2LEYLC8HF_VzFkgzRpfvXyw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Add fast call path of crash_kexec()
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        rmk+kernel@armlinux.org.uk,
        "Eric W. Biederman" <ebiederm@xmission.com>, tongtiangen@huawei.co,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great Job, I think it's a fixup, we should add Fix: and Cc: stable@kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Sun, May 15, 2022 at 9:14 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
>
> Currently, almost all archs (x86, arm64, mips...) support fast call
> of crash_kexec() when "regs && kexec_should_crash()" is true. But
> RISC-V not, it can only enter crash system via panic(). However panic()
> doesn't pass the regs of the real accident scene to crash_kexec(),
> it caused we can't get accurate backtrace via gdb,
>         $ riscv64-linux-gnu-gdb vmlinux vmcore
>         Reading symbols from vmlinux...
>         [New LWP 95]
>         #0  console_unlock () at kernel/printk/printk.c:2557
>         2557                    if (do_cond_resched)
>         (gdb) bt
>         #0  console_unlock () at kernel/printk/printk.c:2557
>         #1  0x0000000000000000 in ?? ()
>
> With the patch we can get the accurate backtrace,
>         $ riscv64-linux-gnu-gdb vmlinux vmcore
>         Reading symbols from vmlinux...
>         [New LWP 95]
>         #0  0xffffffe00063a4e0 in test_thread (data=<optimized out>) at drivers/virtio/virtio_mmio.c:806
>         806             *(int *)p = 0xdead;
>         (gdb)
>         (gdb) bt
>         #0  0xffffffe00063a4e0 in test_thread (data=<optimized out>) at drivers/virtio/virtio_mmio.c:806
>         #1  0x0000000000000000 in ?? ()
>
> Test code to produce NULL address dereference,
>         +extern int panic_on_oops;
>         +static struct task_struct *k;
>         +static int test_thread(void *data) {
>         +
>         +       void *p = NULL;
>         +
>         +       while (!panic_on_oops)
>         +               msleep(2000);
>         +
>         +       *(int *)p = 0xdead;
>         +
>         +       return 0;
>         +}
>         +
>          static int __init virtio_mmio_init(void)
>          {
>         +       k = kthread_run(test_thread, NULL, "test_thread");
>         +       if (IS_ERR(k))
>         +               pr_err("Couldn't create test kthread\n");
>         +
>                 return platform_driver_register(&virtio_mmio_driver);
>          }
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>  arch/riscv/kernel/traps.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index fe92e119e6a3..e666ebfa2a64 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -16,6 +16,7 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/irq.h>
> +#include <linux/kexec.h>
>
>  #include <asm/asm-prototypes.h>
>  #include <asm/bug.h>
> @@ -44,6 +45,9 @@ void die(struct pt_regs *regs, const char *str)
>
>         ret = notify_die(DIE_OOPS, str, regs, 0, regs->cause, SIGSEGV);
>
> +       if (regs && kexec_should_crash(current))
> +               crash_kexec(regs);
> +
>         bust_spinlocks(0);
>         add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
>         spin_unlock_irq(&die_lock);
> --
> 2.17.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
