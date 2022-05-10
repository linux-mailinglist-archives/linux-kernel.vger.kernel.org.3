Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29D9520E91
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiEJHiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbiEJHXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:23:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7BE2A2F64
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:19:28 -0700 (PDT)
Received: from mail-yb1-f176.google.com ([209.85.219.176]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1McGtA-1oMZVK2YCi-00chkz for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022
 09:19:26 +0200
Received: by mail-yb1-f176.google.com with SMTP id y76so29117775ybe.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 00:19:26 -0700 (PDT)
X-Gm-Message-State: AOAM531j0TDz7FVCWWMghVhjpobxBI/x0N+Xl6GODTtAMJQusGvNRxwd
        PpBe2xWc87asteU8ab0MN1nEGXjI9Rixj+XAmQU=
X-Google-Smtp-Source: ABdhPJza4f0QhmQzTg58jggkDu1vDGQMJs7cvbYtkMs5nxfP9mAAZBo3PvjTDeok3vcEVeaushFvqJrbb0bhcjB/e7w=
X-Received: by 2002:a25:cdc7:0:b0:648:f57d:c0ed with SMTP id
 d190-20020a25cdc7000000b00648f57dc0edmr16568783ybf.480.1652167165347; Tue, 10
 May 2022 00:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220506192957.24889-1-nick.hawkins@hpe.com>
In-Reply-To: <20220506192957.24889-1-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 May 2022 09:19:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
Message-ID: <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:OkaZ/VeV6oj2o7zYpYg+2p7jXbvXRdKVjj3PfMMgohbSezc6Aqh
 sAMcd4xoSGQgXzflOuB4GGUAtOG60Qwcpn8r1shyNLsWoGxPXm3k7u0T2lwNjtPY4nJqIFL
 9vdBeNIm4CseBNIZ/SqUc654B+MwyFWDUNalAaoUlcLeGU8GBM1GUVSXs5qLT1qV5/Tv/aD
 6AYebLwxlrSJMfxVrMXvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:erJObXgwuAs=:io1B8OlgqAF6c4V6ewAwoG
 tYlywWWdHDzV0ue9VkUO1a8heDv1Q8sELy2ehKAS0tvFjVAcqE8kFcJu/5X/hRACCh4yxDLkf
 ZiMNWpChTYCqcwZTxki6aEAw3VZzfUvfiPUHMipDsz1nlwFAfY5tMT61j8B9bOmX3iCn/Nlo2
 bF/kAvla3AT00FhOrrYi3XUHf2KKwbQ1XedDdxk1xpRXKR06b176YBSUmMSJpOKaVdPby7jkZ
 z+dNbe4Jh/akUI5fxNBei4RNjxsbjGsQHDTNuj0rVmI/I89bl5iZP2lqiJECj/faa8gE9H/+P
 GtCDb/iXHYUtqvu79cKV3bwDfaaAqKKfM96mbSIN+8H0P53CJm3e3Do2AeoShEms/TGyU8VDZ
 yq4kmAkgj83SYNdKnHnUmxT+E28fgroj2YyA9hjIja+mXsVKFx50hm90ERJsHu2493MfoMh+R
 OdEZDknykQSzM4sdJYzLFi3G7wy0FUmGdiVURqskwZx/KuTaWjn5pV7yAUyYjAzB2py6D7ymt
 CBGT5oOMiGSDd4gZhDfORgLQxaIANE0620Mb1BMNn2Rv+W0SVKzplbt1cP8V3LW0BbfgPsQDV
 DszzOns0CyhEt4HXspl+F6O4JOOmS1m6LT98ILQsOSk1KV0aXBkG/sNHNwS/6Aem6dt/CFXWw
 Sjq8D7nRbajI9c7WMJJdsRPoVLFSx1gp9lxXXeVTDD3GBSSuP3zx9CTiJbHeizf6lef2Lbs+b
 uloj5kDXJoJHUazdjdHVCSFMgJUYvtFv5k7tpp1zxL1Dh35D22wZzn5HawFz/MG+nPGRC/qtP
 bJtimYtqrot7m8Ci6qLFWV/hEEbljdi4zjLyMp5wxoKEjJxN6U=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 9:29 PM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> Enable the workaround for the 764319 Cortex A-9 erratum.
> CP14 read accesses to the DBGPRSR and DBGOSLSR registers generate an
> unexpected Undefined Instruction exception when the DBGSWENABLE external
> pin is set to 0, even when the CP14 accesses are performed from a
> privileged mode. The work around catches the exception in a way
> the kernel does not stop execution with the use of undef_hook. This
> has been found to effect the HPE GXP SoC.
>
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  arch/arm/Kconfig                | 11 +++++++++++
>  arch/arm/kernel/hw_breakpoint.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 13f77eec7c40..6944adfb0fae 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -974,6 +974,17 @@ config ARM_ERRATA_764369
>           relevant cache maintenance functions and sets a specific bit
>           in the diagnostic control register of the SCU.
>
> +config ARM_ERRATA_764319
> +       bool "ARM errata: Read to DBGPRSR and DBGOSLSR may generate Undefined instruction"
> +       depends on CPU_V7
> +       help
> +         This option enables the workaround for the 764319 Cortex A-9 erratum.
> +         CP14 read accesses to the DBGPRSR and DBGOSLSR registers generate an
> +         unexpected Undefined Instruction exception when the DBGSWENABLE
> +         external pin is set to 0, even when the CP14 accesses are performed
> +         from a privileged mode. This work around catches the exception in a
> +         way the kernel does not stop execution.
> +
>  config ARM_ERRATA_775420
>         bool "ARM errata: A data cache maintenance operation which aborts, might lead to deadlock"
>         depends on CPU_V7
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index b1423fb130ea..c41a8436a796 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -941,6 +941,23 @@ static int hw_breakpoint_pending(unsigned long addr, unsigned int fsr,
>         return ret;
>  }
>
> +#ifdef CONFIG_ARM_ERRATA_764319
> +int oslsr_fault;
> +
> +static int debug_oslsr_trap(struct pt_regs *regs, unsigned int instr)
> +{
> +       oslsr_fault = 1;
> +       instruction_pointer(regs) += 4;
> +       return 0;
> +}
> +
> +static struct undef_hook debug_oslsr_hook = {
> +       .instr_mask  = 0xffffffff,
> +       .instr_val = 0xee115e91,
> +       .fn = debug_oslsr_trap,
> +};
> +#endif
> +

Hi Nick,

This seems a bit more complex than necessary. Can't you just use a custom
inline asm with an ex_table entry to catch the fault? Have a look at
__get_user_asm() for an example.

       Arnd
