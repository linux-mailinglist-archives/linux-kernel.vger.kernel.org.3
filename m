Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB8153BC97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbiFBQc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiFBQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:32:20 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C78102F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:32:18 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ff90e0937aso57079217b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rS5gS+fn8mZ9FxTmxazll5DMWWGBqtfoZzI/ultI6rI=;
        b=Xt8YQow8U2MnL3XlWTSeeLF/7QQQ8PzHRBuXmrtlX/go27tiz+R+uWa9AeAmTU+lAZ
         w42l25Z5rhPozysff08XV5UkWieSgPTwwOZevPXQCWZsWNpBb2nc7hA3NBEaRXHwpr8O
         TZ2qmhuN/IsMUnidz1swvsvNzknbdzRAnUKmF8NzQ8jG8MG6Sgpwt5feIWR3L3s7yfZH
         9YGg2VT2FB55vCYzpQLHlEwOkNdxfZK/nmmd8pmDv3ZI68+UK/oJastE5Ev760eUfk4+
         NSXdVzMcOBfvVvzXArQsyjMGFgngRTp+kA2GYCBYIZeTGKQJRAv8UJg330sYtrKF4oYd
         32tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rS5gS+fn8mZ9FxTmxazll5DMWWGBqtfoZzI/ultI6rI=;
        b=5XkpDGwl4ELUA+5ACPI2ewuxrZ0DTgApPeSWbm0/cm0NC78jw3Gswml5SDHMIOigEQ
         V33E88vLOjB/5Wjc+zjpywh0+JUDxuTKFsQ5FhcLo0hXIY6M70qdi99pYbQ9yUfzu02N
         BaoqXvAE3AQ9vV4LeZJwVk9uPfknHLFWJf4/sfmyMYbyc1rEyCuLe/6e+anReTLmZaVI
         jrgwya6kMGc8MVvco/4N2zFeBK0rda1WC5SyDclBDoWBA0HHg6drf2mLPNDYsq6ao+Ko
         XfEafSNunjaaqaaBq/blGHGB+s2qD5vXhMe5BehBnWUIi6+0Dv7gasvGhoPCf/qeOsHS
         MbVg==
X-Gm-Message-State: AOAM531+7vd5TEJM7KLpavdj3Xst4hFYyCyWACC4qaIV6JtVdwBXe6Im
        3foefMtkgw97d8CX2tBQRkiO8FikuUf0ZO/mlkBsLw==
X-Google-Smtp-Source: ABdhPJz5r0n7rO8qC8FvUdDsf+kN20ePFUa060Hsv6JqvH//cpu+cYddcJdJw8uEDLDdrcs/9X0O3s+REUKffh4FMGk=
X-Received: by 2002:a81:920e:0:b0:30c:201e:b3d1 with SMTP id
 j14-20020a81920e000000b0030c201eb3d1mr6623178ywg.374.1654187538043; Thu, 02
 Jun 2022 09:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220602141032.169907-1-christoph.muellner@vrull.io> <cc1a2594-3596-a8e6-077d-183e69e3f4e7@infradead.org>
In-Reply-To: <cc1a2594-3596-a8e6-077d-183e69e3f4e7@infradead.org>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date:   Thu, 2 Jun 2022 18:32:06 +0200
Message-ID: <CAEg0e7jER4EssW53Rm_dnxj3uHxQvmu2c9ntPWT9ObbdSFOWzg@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: Add Zawrs support for spinlocks
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Muellner <christoph.muellner@vrull.io>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Aaron Durbin <adurbin@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, Jun 2, 2022 at 6:24 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 6/2/22 07:10, Christoph Muellner wrote:
> > The current RISC-V code uses the generic ticket lock implementation,
> > that calls the macros smp_cond_load_relaxed() and smp_cond_load_acquire().
> > Currently, RISC-V uses the generic implementation of these macros.
> > This patch introduces a RISC-V specific implementation, of these
> > macros, that peels off the first loop iteration and modifies the waiting
> > loop such, that it is possible to use the WRS instruction of the Zawrs
> > ISA extension to stall the CPU.
> >
> > The resulting implementation of smp_cond_load_*() will only work for
> > 32-bit or 64-bit types for RV64 and 32-bit types for RV32.
> > This is caused by the restrictions of the LR instruction (RISC-V only
> > has LR.W and LR.D). Compiler assertions guard this new restriction.
> >
> > This patch uses the existing RISC-V ISA extension framework
> > to detect the presents of Zawrs at run-time.
> > If available a NOP instruction will be replaced by WRS.
> > A similar patch could add support for the PAUSE instruction of
> > the Zihintpause ISA extension.
> >
> > The whole mechanism is gated by Kconfig setting, which defaults to Y.
> >
> > The Zawrs specification can be found here:
> > https://github.com/riscv/riscv-zawrs/blob/main/zawrs.adoc
> >
> > Note, that the Zawrs extension is not frozen or ratified yet.
> > Therefore this patch is an RFC and not intended to get merged.
> >
> > Signed-off-by: Christoph Muellner <christoph.muellner@vrull.io>
> > ---
> >  arch/riscv/Kconfig                   | 10 +++
> >  arch/riscv/include/asm/barrier.h     | 97 ++++++++++++++++++++++++++++
> >  arch/riscv/include/asm/errata_list.h | 12 +++-
> >  arch/riscv/include/asm/hwcap.h       |  3 +-
> >  arch/riscv/kernel/cpu.c              |  1 +
> >  arch/riscv/kernel/cpufeature.c       | 13 ++++
> >  6 files changed, 133 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 905e550e0fd3..054872317d4a 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -358,6 +358,16 @@ config RISCV_ISA_C
> >
> >          If you don't know what to do here, say Y.
> >
> > +config RISCV_ISA_ZAWRS
> > +     bool "Zawrs extension support"
> > +     select RISCV_ALTERNATIVE
> > +     default y
> > +     help
> > +        Adds support to dynamically detect the presence of the Zawrs extension
> > +        (wait for reservation set) and enable its usage.
> > +
> > +        If you don't know what to do here, say Y.
> > +
>
> With this patch, it is possible to enable XIP_KERNEL and
> RISCV_ISA_ZAWRS at the same time.  That causes a kconfig warning:
>
> WARNING: unmet direct dependencies detected for RISCV_ALTERNATIVE
>   Depends on [n]: !XIP_KERNEL [=y]
>   Selected by [y]:
>   - RISCV_ISA_ZAWRS [=y]
>   - RISCV_ISA_SVPBMT [=y] && 64BIT [=y] && MMU [=y]
>
> because RISCV_ALTERNATIVE depends on !XIP_KERNEL:
>
> config RISCV_ALTERNATIVE
>         bool
>         depends on !XIP_KERNEL

I will add a "depends on !XIP_KERNEL" to RISCV_ISA_ZAWRS.

Thanks!

>
>
> >  config RISCV_ISA_SVPBMT
> >       bool "SVPBMT extension support"
> >       depends on 64BIT && MMU
>
>
> --
> ~Randy
