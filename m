Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1C4880E5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 03:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiAHCY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 21:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiAHCYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 21:24:24 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A085EC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 18:24:23 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d201so21769844ybc.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 18:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QROqgPW59BmcvlO26kw/MeYQfypRFjouqTufbGjALHk=;
        b=FZATxcc7mOnkcgbLCbKdkEj0rbX6avAvHEXE4Il3SPKEFIRJ+WPL51JijNz4IUDwUo
         /70F9R5DidMxgWPt5pIN1MKNes2dV9BjA/8+kkooVvmeP/jFJ6toPLH1HrBNDDnUD2/h
         QpYQWUlVpyQTb1B+Q2EDsrhmrYLrfVCC67MxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QROqgPW59BmcvlO26kw/MeYQfypRFjouqTufbGjALHk=;
        b=kpn4+N2X6j97CkqJXvZ2db0VTeydN4HR8xeaeWfeitnxkDMKTaosaqFZpHt9OxG3fU
         jppp1SVUST9gN8u6Wxn+xME6d7j9Twa0slfxJwpocFTWGa7fxYv9NMGa0Z8PgV/5SDXm
         vBsDmq0SwXr/EF1lc6DBJtdswZ32Fv+XajxPNAnWdRlKKhc2OTZgbUT5kBa8wiRxdu1L
         HRU95JLDZjyKCvrpqQbSDByV2NLDsgia3nFu6BE+HoPs9JNEsk4/FkkzRwuJoX0ybNbj
         He2SAZhmmQ4xYY1jp4P7+eViStZG0V6I8j9rAeaEZCaVjK6ZTPj1Ma6T084GuKw0xALr
         ZRCQ==
X-Gm-Message-State: AOAM532WBkY1U7FlYznpMqc1rQr2D5Xgntas7b5K5vWDEAYzltR5YgQr
        2JZgk6ZuFwKd9LYif+yQYxbw/5YdVfULBf1jkw9e
X-Google-Smtp-Source: ABdhPJzmlMAHa9+09iIXNJube0f30s+fSJGYHVyUNzBRhM1K9SIardeIOp+GRLW2iSehiv5zDlHXWWgur6iC5+YRkHQ=
X-Received: by 2002:a25:9191:: with SMTP id w17mr1876051ybl.10.1641608662771;
 Fri, 07 Jan 2022 18:24:22 -0800 (PST)
MIME-Version: 1.0
References: <20211224211632.1698523-1-atishp@rivosinc.com> <mhng-791652b4-53f0-48e4-a640-f4c418c9926b@palmer-ri-x1c9>
In-Reply-To: <mhng-791652b4-53f0-48e4-a640-f4c418c9926b@palmer-ri-x1c9>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 7 Jan 2022 18:24:12 -0800
Message-ID: <CAOnJCULirV30g6ti7QvY40=p_W9+-XG+nAbxiZ4qDZLo28RJ6A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Provide a fraemework for RISC-V ISA extensions
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 1:58 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 24 Dec 2021 13:16:30 PST (-0800), atishp@atishpatra.org wrote:
> > This series implements a generic framework to parse multi-letter ISA
> > extensions. It introduces a new DT node that can be under /cpus or
> > individual cpu depends on the platforms with homogeneous or heterogeneous
> > harts. This version of the series only allows adds support for homogeneous
> > harts as there are no platforms with heterogeneous harts yet. However,
> > the DT binding allows both.
> >
> > The patch also indicates the user space about the available ISA extensions
> > via /proc/cpuinfo.
> >
> > Here is the example output of /proc/cpuinfo:
> > (with debug patches in Qemu and Linux kernel)
> >
> > / # cat /proc/cpuinfo
> > processor     : 0
> > hart          : 0
> > isa           : rv64imafdcsu
> > isa-ext               : sstc,sscofpmf
> > mmu           : sv48
>
> IMO this is the wrong way to go.  I get that the ISA string is very
> complicated to parse, but we've tried to come up with other
> representations of this we've ended up having that interface break when
> the ISA string rules eventually change.  We should just stick to the ISA
> string for these interfaces, as that's at least something everyone can
> agree on because they're defined by the spec.
>

Fair enough.

> That said, we should add the spec versions into this interface.  At
> least the user spec version is relevant here, but given that we're
> passing through some other priv-level details we might as well pass that
> though too.
>

Tsukasa already has a version that extends the isa string parsing for
multi-letter extensions
and versions parsing. We just need to add the ISA bitmap support on top of it.

I will coordinate with Tsukasa to have a complete framework based on
string parsing.
It would be good to have this series asap as all other series  (perf,
svpbmt) will rely on it.

> > processor     : 1
> > hart          : 1
> > isa           : rv64imafdcsu
> > isa-ext               : sstc,sscofpmf
> > mmu           : sv48
> >
> > processor     : 2
> > hart          : 2
> > isa           : rv64imafdcsu
> > isa-ext               : sstc,sscofpmf
> > mmu           : sv48
> >
> > processor     : 3
> > hart          : 3
> > isa           : rv64imafdcsu
> > isa-ext               : sstc,sscofpmf
> > mmu           : sv48
> >
> > Anybody adding support for any new multi-letter extensions should add an
> > entry to the riscv_isa_ext_id and the isa extension array.
> > E.g. The patch[1] adds the support for sscofpmf extension.
> >
> > [1] https://github.com/atishp04/linux/commit/a23157264118d6fd905fd08d8717c7df03078bb1
> >
> > Atish Patra (2):
> > RISC-V: Provide a framework for parsing multi-letter ISA extensions
> > dt-bindings: riscv: Add DT binding for RISC-V ISA extensions
> >
> > .../devicetree/bindings/riscv/cpus.yaml       |  9 +++
> > arch/riscv/include/asm/hwcap.h                | 31 ++++++++++
> > arch/riscv/kernel/cpu.c                       | 16 +++++
> > arch/riscv/kernel/cpufeature.c                | 58 ++++++++++++++++++-
> > 4 files changed, 113 insertions(+), 1 deletion(-)



--
Regards,
Atish
