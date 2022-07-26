Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929E6580ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238180AbiGZIZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiGZIZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:25:05 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2CA2F654
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:25:04 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31e7055a61dso134402977b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u20KlUAmw1kDfZJYPrtgWu0maTb4gYVBZ+IbRF1JvEE=;
        b=mt0xWT9AaEmPRaO9nj0ITVI3ErFd3h7ew6KYgFqujT/YEWTewblOLAD5bpd/2wnkWS
         1LmJNJZTi2ZpbO61MEVpsUVMuQ9y5AQEdQZjQCaMyXex7alUGtxRdsZh+TRaMKtbczBC
         r20L1q+eE/xyq4J+JMG4HGkpO2JWBoi+AkliI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u20KlUAmw1kDfZJYPrtgWu0maTb4gYVBZ+IbRF1JvEE=;
        b=K46R1X7hfzHMV4N84N6bOLTQX5dFg4jcLIzI2RJUoWi1gOd76pwRJES8h3qr/7PcVz
         lh4xO3AQpHOOcLRZqPq36CT5VDEsQd8nFkUfRcq9cXZGsVq7pYUTeCIxI3FGj3TgdtDz
         Cd9fi2WkOQKlLjJ061WO8naHlp/mIhTRZr/VJKtoMgZqAhnGe2UXFXhD/P/a6ZQg+kCt
         NwInxAT3wBzmu1v7bQ9gKNjb5GTN3HNVXHG7OcREOrjqEkU0dChBc6ax+vahoqVfWWKV
         TQaPYFDB+6Dw/Mp4xSXF+sNeBOYB88aZfdo+rCoMbJVYW/bpqmDiqwMo6GRkIVVpiJbA
         4NTQ==
X-Gm-Message-State: AJIora9WNEfL+xu3Ul4PQk4OU7so0PQmTwoL2x76gO1CvKGh5UuLvoso
        3Jn6B/9ADAMdhgw0Wf3jXkt9G/Q+TfSpCrQOqUFv
X-Google-Smtp-Source: AGRyM1u5aIwACT1nstyxr3rIFFS4rT25rmUqxDVLJlgqKvpU+mYyCXdwhhmbjTMWnum3s80jeaI1rEteNWRMjzykZz4=
X-Received: by 2002:a81:1e95:0:b0:31f:3665:6ed0 with SMTP id
 e143-20020a811e95000000b0031f36656ed0mr4484057ywe.400.1658823903339; Tue, 26
 Jul 2022 01:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220715175155.3567243-1-mail@conchuod.ie> <20220715175155.3567243-3-mail@conchuod.ie>
In-Reply-To: <20220715175155.3567243-3-mail@conchuod.ie>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 26 Jul 2022 01:24:52 -0700
Message-ID: <CAOnJCUKm9Hg2LCuCsrg27zr0i8_RyJcW=EDKa+OSBvJOno6_yA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] riscv: topology: fix default topology reporting
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Brice Goglin <Brice.Goglin@inria.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:53 AM Conor Dooley <mail@conchuod.ie> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> RISC-V has no sane defaults to fall back on where there is no cpu-map
> in the devicetree.
> Without sane defaults, the package, core and thread IDs are all set to
> -1. This causes user-visible inaccuracies for tools like hwloc/lstopo
> which rely on the sysfs cpu topology files to detect a system's
> topology.
>
> On a PolarFire SoC, which should have 4 harts with a thread each,
> lstopo currently reports:
>
> Machine (793MB total)
>   Package L#0
>     NUMANode L#0 (P#0 793MB)
>     Core L#0
>       L1d L#0 (32KB) + L1i L#0 (32KB) + PU L#0 (P#0)
>       L1d L#1 (32KB) + L1i L#1 (32KB) + PU L#1 (P#1)
>       L1d L#2 (32KB) + L1i L#2 (32KB) + PU L#2 (P#2)
>       L1d L#3 (32KB) + L1i L#3 (32KB) + PU L#3 (P#3)
>
> Adding calls to store_cpu_topology() in {boot,smp} hart bringup code
> results in the correct topolgy being reported:
>
> Machine (793MB total)
>   Package L#0
>     NUMANode L#0 (P#0 793MB)
>     L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
>     L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
>     L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
>     L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
>
> CC: stable@vger.kernel.org
> Fixes: 03f11f03dbfe ("RISC-V: Parse cpu topology during boot.")
> Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
> Link: https://github.com/open-mpi/hwloc/issues/536
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/riscv/Kconfig          | 2 +-
>  arch/riscv/kernel/smpboot.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 205c1e2f539c..7ffac8818060 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -52,7 +52,7 @@ config RISCV
>         select COMMON_CLK
>         select CPU_PM if CPU_IDLE
>         select EDAC_SUPPORT
> -       select GENERIC_ARCH_TOPOLOGY if SMP
> +       select GENERIC_ARCH_TOPOLOGY
>         select GENERIC_ATOMIC64 if !64BIT
>         select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>         select GENERIC_EARLY_IOREMAP
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index f1e4948a4b52..b4d5524b1077 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -49,6 +49,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>         unsigned int curr_cpuid;
>
>         curr_cpuid = smp_processor_id();
> +       store_cpu_topology(curr_cpuid);
>         numa_store_cpu_info(curr_cpuid);
>         numa_add_cpu(curr_cpuid);
>
> @@ -161,9 +162,9 @@ asmlinkage __visible void smp_callin(void)
>         mmgrab(mm);
>         current->active_mm = mm;
>
> +       store_cpu_topology(curr_cpuid);
>         notify_cpu_starting(curr_cpuid);
>         numa_add_cpu(curr_cpuid);
> -       update_siblings_masks(curr_cpuid);
>         set_cpu_online(curr_cpuid, 1);
>
>         /*
> --
> 2.37.1
>

LGTM.
Reviewed-by: Atish Patra <atishp@rivosinc.com>
-- 
Regards,
Atish
