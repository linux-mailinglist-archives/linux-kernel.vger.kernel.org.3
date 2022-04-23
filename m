Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1357E50C639
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 03:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiDWBwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 21:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiDWBwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 21:52:08 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73C456C0D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 18:49:12 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id w20so11287343ybi.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 18:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EXzY+UzgBA4CY//ySgkNNk++mmPT2Q7lGPNdGhvpS3k=;
        b=KQjOWOuGdM2d8vnXhq62QM4DYVCKd+WiOQ5XcRXxeDej1fuhlOfKyLkXXmvh5v6qd0
         k22F7HjbfBdDj2nGswhBmz6ipOnP7fcHVUpSI1MUusXUjdPAjntnr9bpwiIh/avOImuz
         Tv7jzaxvtnvenIYxTpUroNFypfhzA0hHYntzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EXzY+UzgBA4CY//ySgkNNk++mmPT2Q7lGPNdGhvpS3k=;
        b=qV9mbzWpm1j5yxOZ1+3mhwvQQIoMNNU4WxsNEIWiaBbRi7kZkLsx1gTr1IRCnfb3+o
         4q4Uv1SI/xxAhMUbTwY6OJzbZBgrkYb0VrKZhwCfry65+TbrDw44Y4ikC3zSedYKC22I
         x4wzuPXFOH5s+ipbRwuGc3vg6q+HOh4D5Vfl/WQiBRqQTekyzNjPx+IvuDQ6YptTcSEJ
         h1GsPrTvvnYpUY7LVq2nu8D00PtwfeL9slurJlp80e6k8aIyQf74m1AoJllommE1ycce
         aasIF9ggcG+PrjJyOW8hd+aE5DVH8dqcDOpwT+5GR2jWLuD9wCCfyomk0rC82SMFxjRr
         9wnw==
X-Gm-Message-State: AOAM530z6HOkcrtb6fXyAJz+Cq/+L/SWrb/CEk+EJhd955IQ56atChTE
        K0fv+grcgHQL8gjJ1+mpBmjx+YDw32nCzQqbAYf6
X-Google-Smtp-Source: ABdhPJxiVqXIABuDkaacxe8g2z9oY63ATrv3RWNbgC6ZqrWg3gx+2hRc+pki0UDz6nLSiqkK5aJvkH+pVIR8k+KsbCM=
X-Received: by 2002:a25:a0c9:0:b0:647:36b4:d149 with SMTP id
 i9-20020a25a0c9000000b0064736b4d149mr1617034ybm.405.1650678551920; Fri, 22
 Apr 2022 18:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220420112408.155561-1-apatel@ventanamicro.com>
 <3fa5215b-84c3-5e4c-cb53-6c05d05e4350@canonical.com> <CAOnJCUJrN4frY_OdQzO-yr5CrDLvj=ge9KY2d=XnGvAF-uQNvQ@mail.gmail.com>
In-Reply-To: <CAOnJCUJrN4frY_OdQzO-yr5CrDLvj=ge9KY2d=XnGvAF-uQNvQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 22 Apr 2022 18:49:01 -0700
Message-ID: <CAOnJCUK5q0k1qKD0fM4NtbP6KAGcaBBknkCKLBXxcC=EPGVu1Q@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: Increase range and default value of NR_CPUS
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 5:16 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Thu, Apr 21, 2022 at 12:05 AM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> >
> >
> > On 4/20/22 13:24, Anup Patel wrote:
> > > Currently, the range and default value of NR_CPUS is too restrictive
> > > for high-end RISC-V systems with large number of HARTs. The latest
> > > QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
> > > restrictive for QEMU as well. Other major architectures (such as
> > > ARM64, x86_64, MIPS, etc) have a much higher range and default
> > > value of NR_CPUS.
> > >
> > > This patch increases NR_CPUS range to 2-512 and default value to
> > > XLEN (i.e. 32 for RV32 and 64 for RV64).
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> >
>
> This works upto 207 harts in upstream Qemu + OpenSBI. Beyond that,
> firmware size becomes > 2MB and PMP protection
> kicks in for the kernel boot address (0x80200000)
>

Just wanted to clarify that this is as per the current configuration
in OpenSBI. The boot address
is configured to be 0x80000000 for the generic platform. Thus, it can
support a maximum of 207 harts.

If anybody wishes to boot more than that, the boot address should be
changed to a valid DRAM address such that
it doesn't step on kernel/DT or other resident boot loaders (e.g. U-Boot).

It should be changed per platform (if supporting more than 128 harts)
rather than changing
to a common address for all platforms.

> Here is the OpenSBI boot prints for 256 harts with some hacks around
> sanitize_domain to disable sbi_domain_check_addr
>
> Platform Name             : riscv-virtio,qemu
> Platform Features         : medeleg
> Platform HART Count       : 208
> Platform IPI Device       : aclint-mswi
> Platform Timer Device     : aclint-mtimer @ 10000000Hz
> Platform Console Device   : uart8250
> Platform HSM Device       : ---
> Platform Reboot Device    : sifive_test
> Platform Shutdown Device  : sifive_test
> Firmware Base             : 0x80000000
> Firmware Size             : 2052 KB ---------->>> Firmware size is
> greater than 2MB where
> Runtime SBI Version       : 0.3
>
> Domain0 Name              : root
> Domain0 Boot HART         : 122
> Domain0 HARTs             :
> 0*,1*,2*,3*,4*,5*,6*,7*,8*,9*,10*,11*,12*,13*,14*,15*,16*,17*,18*,19*,20*=
,21*,22*,23*,24*,25*,26*,27*,28*,29*,30*,31*,32*,33*,34*,35*,36*,37*,38*,39=
*,40*,41*,42*,43*,44*,45*,46*,47*,48*,49*,50*,51*,52*,53*,54*,55*,56*,57*,5=
8*,59*,60*,61*,62*,63*,64*,65*,66*,67*,68*,69*,70*,71*,72*,73*,74*,75*,76*,=
77*,78*,79*,80*,81*,82*,83*,84*,85*,86*,87*,88*,89*,90*,91*,92*,93*,94*,95*=
,96*,97*,98*,99*,100*,101*,102*,103*,104*,105*,106*,107*,108*,109*,110*,111=
*,112*,113*,114*,115*,116*,117*,118*,119*,120*,121*,122*,123*,124*,125*,126=
*,127*,128*,129*,130*,131*,132*,133*,134*,135*,136*,137*,138*,139*,140*,141=
*,142*,143*,144*,145*,146*,147*,148*,149*,150*,151*,152*,153*,154*,155*,156=
*,157*,158*,159*,160*,161*,162*,163*,164*,165*,166*,167*,168*,169*,170*,171=
*,172*,173*,174*,175*,176*,177*,178*,179*,180*,181*,182*,183*,184*,185*,186=
*,187*,188*,189*,190*,191*,192*,193*,194*,195*,196*,197*,198*,199*,200*,201=
*,202*,203*,204*,205*,206*,207*
> Domain0 Region00          : 0x0000000002000000-0x000000000200ffff (I)
> Domain0 Region01          : 0x0000000080000000-0x00000000803fffff ()
> Domain0 Region02          : 0x0000000000000000-0xffffffffffffffff (R,W,X)
> Domain0 Next Address      : 0x0000000080200000
> Domain0 Next Arg1         : 0x00000000bf000000
> Domain0 Next Mode         : S-mode
> Domain0 SysReset          : yes
>
> Boot HART ID              : 122
> Boot HART Domain          : root
> Boot HART ISA             : rv64imafdcsuh
> Boot HART Features        : scounteren,mcounteren,time
> Boot HART PMP Count       : 16
> Boot HART PMP Granularity : 4
> Boot HART PMP Address Bits: 54
> Boot HART MHPM Count      : 0
> Boot HART MIDELEG         : 0x0000000000001666
> Boot HART MEDELEG         : 0x0000000000f0b509
>
>
> > Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >
> > > ---
> > > Changes since v2:
> > >   - Rebased on Linux-5.18-rc3
> > >   - Use a different range when SBI v0.1 is enabled
> > > Changes since v1:
> > >   - Updated NR_CPUS range to 2-512 which reflects maximum number of
> > >     CPUs supported by QEMU virt machine.
> > > ---
> > >   arch/riscv/Kconfig | 9 ++++++---
> > >   1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 00fd9c548f26..1823f281069f 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -275,10 +275,13 @@ config SMP
> > >         If you don't know what to do here, say N.
> > >
> > >   config NR_CPUS
> > > -     int "Maximum number of CPUs (2-32)"
> > > -     range 2 32
> > > +     int "Maximum number of CPUs (2-512)"
> > >       depends on SMP
> > > -     default "8"
> > > +     range 2 512 if !SBI_V01
> > > +     range 2 32 if SBI_V01 && 32BIT
> > > +     range 2 64 if SBI_V01 && 64BIT
> > > +     default "32" if 32BIT
> > > +     default "64" if 64BIT
> > >
> > >   config HOTPLUG_CPU
> > >       bool "Support for hot-pluggable CPUs"
>
>
>
> --
> Regards,
> Atish



--=20
Regards,
Atish
