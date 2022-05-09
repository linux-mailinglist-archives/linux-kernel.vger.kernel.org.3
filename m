Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E648D51F38A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiEIEoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiEIElW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:41:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B99C128158
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 21:37:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k126so7678991wme.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 21:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ov4p0XX7tQqCu3BT1O07xpESNC6AFz/oTsF1DSF1DeY=;
        b=CIUvEXQyV6Kw6zKcKwganTJ9uL4GSu7nCc1HaR22V3NpFhh+o/R4HnNzPn0jj3j5M6
         vn/IV/XESXhwVIdYHG4JU3+9T/wWZ9nank20/BzpGqc16kNP8f7o3vJnimo0wKpXD1V5
         2LMdi50z6dz6gCkumhOzrSy+FABWc4j2i8Xl9VlKA1OFVQHNzqyYnRHgoiz9jf6DsaWe
         Pm49CVfMF28G1PN038G0Lb+MHYfsv6rkxdNb3qDmD/vUZBbFUG6ba1r9a2iEszdq3SvZ
         xZK4XRvgiLu2uTHHyoYz+VorXX7rByxY4TI7PZm1eTJ18bIEa9qW1RN7E6Xqd+Vmcp9k
         FBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ov4p0XX7tQqCu3BT1O07xpESNC6AFz/oTsF1DSF1DeY=;
        b=Ug0kqxtkk+lbod7nmSQ5ChMbAXgBY13uYkiNqHQ6Fx8/Lr4g6EE/lzDyMyCLzD7/5A
         6lXjbCko1zaUOdw7GoyYV6RbOVrpi4FTbBHHdW5eTEqpg+meyA6eATvH9v8qtxATTeUA
         bvJP4oooGOIV2YOs9zQ6Q4xvQj0IftG6mqtESP4/ySaDLf9YclVkiLnhF75B5Heb1WGn
         3U0fL5wOXCAg4E+A9dK7utHgi8VIf0FtD5t9hc5j4rkYy6OS5tmJ5TeXdqkSghk0Fcjf
         VelznwumyNOrSGPPnnAQ107B+Gm3o/N5xi1FXYcHsOw0f7nRAyI6ide+PId6dyD37vR5
         DisQ==
X-Gm-Message-State: AOAM530YBXmfjo/aYs3kdlEEMEDpsTLENeZbBGEA0o59ipp8QnhW/CZX
        QVYken+fAhuhunFey/KAP0fZo783lsV35/QA2fHbFA==
X-Google-Smtp-Source: ABdhPJwKlNzuRE3DL81XLBWis1ERv1cq+V1muXCMdHLI5gzEuRvadbetbhnukQ9XzoVFdhzjI2CaXT+vNeqj1MdG5qo=
X-Received: by 2002:a05:600c:1d08:b0:394:54ee:c994 with SMTP id
 l8-20020a05600c1d0800b0039454eec994mr13927419wms.137.1652071047349; Sun, 08
 May 2022 21:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220508160749.984-1-jszhang@kernel.org>
In-Reply-To: <20220508160749.984-1-jszhang@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 May 2022 10:07:16 +0530
Message-ID: <CAAhSdy1qri5L9pVcZO8areB=TXMSJBg2+cTNMZGQ3g+3Qhxmfg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] unified way to use static key and optimize pgtable_l4_enabled
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 8, 2022 at 9:46 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Currently, riscv has several features which may not be supported on all
> riscv platforms, for example, FPU, SV48, SV57 and so on. To support
> unified kernel Image style, we need to check whether the feature is
> suportted or not. If the check sits at hot code path, then performance
> will be impacted a lot. static key can be used to solve the issue. In
> the past, FPU support has been converted to use static key mechanism.
> I believe we will have similar cases in the future. For example, the
> SV48 support can take advantage of static key[1].
>
> patch1 is a simple W=1 warning fix.
> patch2 introduces an unified mechanism to use static key for riscv cpu
> features.
> patch3 converts has_cpu() to use the mechanism.
> patch4 uses the mechanism to optimize pgtable_l4|[l5]_enabled.
>
> [1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html

Overall, using a script to generate CPU capabilities seems a bit
over-engineered to me. We already have RISC-V ISA extension
parsing infrastructure which can be easily extended to support
static key arrays.

Regards,
Anup

>
> Since v1:
>  - Add a W=1 warning fix
>  - Fix W=1 error
>  - Based on v5.18-rcN, since SV57 support is added, so convert
>    pgtable_l5_enabled as well.
>
> Jisheng Zhang (4):
>   riscv: mm: init: make pt_ops_set_[early|late|fixmap] static
>   riscv: introduce unified static key mechanism for CPU features
>   riscv: replace has_fpu() with system_supports_fpu()
>   riscv: convert pgtable_l4|[l5]_enabled to static key
>
>  arch/riscv/Makefile                 |   3 +
>  arch/riscv/include/asm/cpufeature.h | 110 ++++++++++++++++++++++++++++
>  arch/riscv/include/asm/pgalloc.h    |  16 ++--
>  arch/riscv/include/asm/pgtable-64.h |  40 +++++-----
>  arch/riscv/include/asm/pgtable.h    |   5 +-
>  arch/riscv/include/asm/switch_to.h  |   9 +--
>  arch/riscv/kernel/cpu.c             |   4 +-
>  arch/riscv/kernel/cpufeature.c      |  29 ++++++--
>  arch/riscv/kernel/process.c         |   2 +-
>  arch/riscv/kernel/signal.c          |   4 +-
>  arch/riscv/mm/init.c                |  52 ++++++-------
>  arch/riscv/mm/kasan_init.c          |  16 ++--
>  arch/riscv/tools/Makefile           |  22 ++++++
>  arch/riscv/tools/cpucaps            |   7 ++
>  arch/riscv/tools/gen-cpucaps.awk    |  40 ++++++++++
>  15 files changed, 274 insertions(+), 85 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cpufeature.h
>  create mode 100644 arch/riscv/tools/Makefile
>  create mode 100644 arch/riscv/tools/cpucaps
>  create mode 100755 arch/riscv/tools/gen-cpucaps.awk
>
> --
> 2.34.1
>
