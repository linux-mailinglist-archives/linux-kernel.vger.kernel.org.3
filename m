Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B213D4FC78B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350443AbiDKWVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 18:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350450AbiDKWV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 18:21:27 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921BC616E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:19:10 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p65so11744967ybp.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9meaVk2eU1Ub1J/lh8wpOzsDGLcFnkv//kNBJa8QEk=;
        b=B7UMhev78NYH9YuneasYHK3IzX9KrUAa7GGU2PEGUPfHn5SIGyfMYdkalMGitGaDW+
         9zVhjvWnNRDTOFmmEDfHWrVhYgaFTSqRVXav13yTykadccac6yTPeY3Ag/fzLUT2n3mx
         +iPa75DAlbyb5saxZcXHPjAHg+xHtZTpokeRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9meaVk2eU1Ub1J/lh8wpOzsDGLcFnkv//kNBJa8QEk=;
        b=Rq9pv7TguIJbXrKu0bug7498hd6cSRsyL2nsWk5isXOmzMfDNXvplw1SDM0CwAGtOI
         fIE1w8eh3W7G5BDxJXJtTW/sLPmW/oYm+0J2WoDqyWQn4ChrcmWSvYi/8RDAcPAs3R1h
         qNtk53LFadzjHpMRwJ453j7Vnd9EcT8MgiU7nwhpb42sOTP6QXFP3SJIyw0wWH4NeC1d
         wleGUoyDp8DV9UPSHYn889v2lKYET+BHNbG45qoRquLcFL6bELjvEwXd+oWxOaSVQahb
         vI5lNqW+tl+sYuT1iS4sGOGojEcYDnTkVW8sPEjKGhfUv5UgSyFcJhe+JbvLGKmx5IDu
         KXRQ==
X-Gm-Message-State: AOAM532haD+Mt4nIfkBGqd8vYitMm+doLPYvDF2YsecOFFP9P/kydZml
        mJ/DUJJa9ReKXPwSRNxIy36wj+TUs2mep/iKoR0o
X-Google-Smtp-Source: ABdhPJz3ewEbsMRLR8QG8tn8aHMoHRDhURqXevWUL4e9Co13fWrYNcAp15z54+WjrA5pEnSP9/rc0a1KOOjfae6qbuI=
X-Received: by 2002:a25:7102:0:b0:63d:91db:c29d with SMTP id
 m2-20020a257102000000b0063d91dbc29dmr23903612ybc.405.1649715549799; Mon, 11
 Apr 2022 15:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-9cbb2a46-8bcb-4bfe-b927-0ed469dbd3a6@palmer-mbp2014>
 <cd8d6641-4a29-7deb-49ae-a80baab0344f@canonical.com> <CAK9=C2Xh_DQ3ybj7nAE-LNrSc9sPy0H8jq_FU09io+wE_yypRg@mail.gmail.com>
 <b907f6c8-968b-7e1e-bc83-1d54c7e0b448@canonical.com> <CAAhSdy1ovEziSSu6x2kESYTbimDLXCHmmOqMLyGKzsj1DHLrLg@mail.gmail.com>
In-Reply-To: <CAAhSdy1ovEziSSu6x2kESYTbimDLXCHmmOqMLyGKzsj1DHLrLg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 11 Apr 2022 15:18:59 -0700
Message-ID: <CAOnJCUJWVERXCW02LfMBBMQNSPgNoNHExm8PeaUnongXgHkBAA@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Increase range and default value of NR_CPUS
To:     Anup Patel <anup@brainfault.org>
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 9:45 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Fri, Apr 8, 2022 at 10:08 PM Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 4/6/22 12:10, Anup Patel wrote:
> > > On Wed, Apr 6, 2022 at 3:25 PM Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> On 3/31/22 21:42, Palmer Dabbelt wrote:
> > >>> On Sat, 19 Mar 2022 05:12:06 PDT (-0700), apatel@ventanamicro.com wrote:
> > >>>> Currently, the range and default value of NR_CPUS is too restrictive
> > >>>> for high-end RISC-V systems with large number of HARTs. The latest
> > >>>> QEMU virt machine supports upto 512 CPUs so the current NR_CPUS is
> > >>>> restrictive for QEMU as well. Other major architectures (such as
> > >>>> ARM64, x86_64, MIPS, etc) have a much higher range and default
> > >>>> value of NR_CPUS.
> > >>>>
> > >>>> This patch increases NR_CPUS range to 2-512 and default value to
> > >>>> XLEN (i.e. 32 for RV32 and 64 for RV64).
> > >>>>
> > >>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > >>>> ---
> > >>>> Changes since v1:
> > >>>>   - Updated NR_CPUS range to 2-512 which reflects maximum number of
> > >>>>     CPUs supported by QEMU virt machine.
> > >>>> ---
> > >>>>   arch/riscv/Kconfig | 7 ++++---
> > >>>>   1 file changed, 4 insertions(+), 3 deletions(-)
> > >>>>
> > >>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > >>>> index 5adcbd9b5e88..423ac17f598c 100644
> > >>>> --- a/arch/riscv/Kconfig
> > >>>> +++ b/arch/riscv/Kconfig
> > >>>> @@ -274,10 +274,11 @@ config SMP
> > >>>>         If you don't know what to do here, say N.
> > >>>>
> > >>>>   config NR_CPUS
> > >>>> -    int "Maximum number of CPUs (2-32)"
> > >>>> -    range 2 32
> > >>>> +    int "Maximum number of CPUs (2-512)"
> > >>>> +    range 2 512
> > >>
> > >> For SBI_V01=y there seems to be a hard constraint to XLEN bits.
> > >> See __sbi_v01_cpumask_to_hartmask() in rch/riscv/kernel/sbi.c.
> > >>
> > >> So shouldn't this be something like:
> > >>
> > >> range 2 512 !SBI_V01
> > >> range 2 32 SBI_V01 && 32BIT
> > >> range 2 64 SBI_V01 && 64BIT
> > >
> > > This is just making it unnecessarily complicated for supporting
> > > SBI v0.1
> > >
> > > How about removing SBI v0.1 support and the spin-wait CPU
> > > operations from arch/riscv ?
> >
> > The SBI v0.1 specification was only a draft. Only the v1.0 version has
> > ever been ratified.
> >
> > It would be good to remove this legacy code from Linux and U-Boot.
> >
> > By the way, why does upstream OpenSBI claim to be conformant to SBI v0.3
> > and not to v1.0?
>
> The ratification process for SBI v1.0 was in early stages when OpenSBI v1.0
> was being released so we decided to keep the SBI v0.3 spec version. The
> next OpenSBI v1.1 release (due in June 2022) will change to SBI v1.0
>

Yes. We are in the final stages of the official ratification of SBI
v1.0. Once that ratified version is released,
OpenSBI will be upgraded to support that.

> Regards,
> Anup
>
> >
> > include/sbi/sbi_ecall.h:16:
> >
> > #define SBI_ECALL_VERSION_MAJOR 0
> > #define SBI_ECALL_VERSION_MINOR 3
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > >>
> > >>>>       depends on SMP
> > >>>> -    default "8"
> > >>>> +    default "32" if 32BIT
> > >>>> +    default "64" if 64BIT
> > >>>>
> > >>>>   config HOTPLUG_CPU
> > >>>>       bool "Support for hot-pluggable CPUs"
> > >>>
> > >>> I'm getting all sorts of boot issues with more than 32 CPUs, even on the
> > >>> latest QEMU master.  I'm not opposed to increasing the CPU count in
> > >>> theory, but if we're going to have a setting that goes up to a huge
> > >>> number it needs to at least boot.  I've got 64 host threads, so it
> > >>> shouldn't just be a scheduling thing.
> > >>
> > >> Currently high performing hardware for RISC-V is missing. So it makes
> > >> sense to build software via QEMU on x86_64 or arm64 with as many
> > >> hardware threads as available (128 is not uncommon).
> > >>
> > >> OpenSBI currently is limited to 128 threads:
> > >> include/sbi/sbi_hartmask.h:22:
> > >> #define SBI_HARTMASK_MAX_BITS 128
> > >> This is just an arbitrary value we can be modified.
> > >
> > > Yes, this limit will be gradually increased with some improvements
> > > to optimize runtime memory used by OpenSBI.
> > >
> > >>
> > >> U-Boot v2022.04 qemu-riscv64_smode_defconfig has a value of
> > >> CONFIG_SYS_MALLOC_F_LEN that is to low. This leads to a boot failure for
> > >> more than 16 harts. A patch to correct this is pending:
> > >> [PATCH v2 1/1] riscv: alloc space exhausted
> > >> https://lore.kernel.org/u-boot/CAN5B=eKt=tFLZ2z3aNHJqsnJzpdA0oikcrC2i1_=ZDD=f+M0jA@mail.gmail.com/T/#t
> > >>
> > >> With QEMU 7.0 and the U-Boot fix booting into a 5.17 defconfig kernel
> > >> with 64 virtual cores worked fine for me.
> > >
> > > Thanks for trying this patch.
> > >
> > > Regards,
> > > Anup
> > >
> > >>
> > >> Best regards
> > >>
> > >> Heinrich
> > >>
> > >>>
> > >>> If there was some hardware that actually boots on these I'd be happy to
> > >>> take it, but given that it's just QEMU I'd prefer to sort out the bugs
> > >>> first.  It's probably just latent bugs somewhere, but allowing users to
> > >>> turn on configs we know don't work just seems like the wrong way to go.
> > >>>



-- 
Regards,
Atish
