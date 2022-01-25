Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C449BD82
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiAYUxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:53:03 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:44666 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiAYUwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:52:36 -0500
Received: by mail-ua1-f41.google.com with SMTP id f24so39598794uab.11;
        Tue, 25 Jan 2022 12:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PK+VsfalNcqPlg+OdOK8H00toRP5nx8q9De4RBT+0k=;
        b=Reu64PYpW3KbPGhPhwo/dKW1CYihMs4xN2NBUQWp7kh0Avq4qSYMc8b8oDgCU/JYRz
         HWMptWd6nXIYCQncpuw+AubC18yA30rcOzbzTyvT8UBUADBrr2G2LBCuH64YQ7mCdun6
         Q9SBBAsYDSUZkEhebJ2fZgSgKQ8hjka1biIeThFA2LxdSL/KnEfjFo0yNQn7p8muEQX4
         BydhCEPXM0rSyBLUgIFw5fFGwZhCcYB5Bk+i1DcWXxyWTGO7lyV7bZgFRPsoWsVlLJwD
         DOaOTcI/ytMFDWuq2tRqG2vyyfYlrbvVcLHjCbSiIoBWBbi9ey7DYkE/kNu9glE+agII
         baYA==
X-Gm-Message-State: AOAM533liyUcLzDeE+zAS7/jdAN8SU5rOLNJkCBIBBidQaTYxv1sp8t7
        7FXNmJMy1NWr/pZi6kw83XGXVee66PQ5IY5V
X-Google-Smtp-Source: ABdhPJwkl1T2wViviMS3wn0U+Fof7ovoNAy0RDi5fJI5qpXMnWQyN+31WMPAt8zcHhHpID/v3iZa+A==
X-Received: by 2002:a67:f5d7:: with SMTP id t23mr5614975vso.28.1643143955927;
        Tue, 25 Jan 2022 12:52:35 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id n10sm3146930vso.34.2022.01.25.12.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 12:52:35 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id 2so39751644uax.10;
        Tue, 25 Jan 2022 12:52:35 -0800 (PST)
X-Received: by 2002:a9f:3d89:: with SMTP id c9mr8620407uai.78.1643143955031;
 Tue, 25 Jan 2022 12:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20220120090918.2646626-1-atishp@rivosinc.com> <20220120090918.2646626-7-atishp@rivosinc.com>
 <CAMuHMdXJoREF7jZaYWrDUjJqKUSCd82qDVaMEo7VO38ok8J-AA@mail.gmail.com> <CAOnJCULjqeL9Q27n=g19ALbOivzid6pc_gYv6JUF4iP=64kJ-Q@mail.gmail.com>
In-Reply-To: <CAOnJCULjqeL9Q27n=g19ALbOivzid6pc_gYv6JUF4iP=64kJ-Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jan 2022 21:52:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWBF0XXXQLfAH81F=BczjsDeQFU454_A2C_-qLPKJGpiQ@mail.gmail.com>
Message-ID: <CAMuHMdWBF0XXXQLfAH81F=BczjsDeQFU454_A2C_-qLPKJGpiQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Tue, Jan 25, 2022 at 9:17 PM Atish Patra <atishp@atishpatra.org> wrote:
> On Tue, Jan 25, 2022 at 12:12 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Thu, Jan 20, 2022 at 10:12 AM Atish Patra <atishp@rivosinc.com> wrote:
> > > Currently, SBI APIs accept a hartmask that is generated from struct
> > > cpumask. Cpumask data structure can hold upto NR_CPUs value. Thus, it
> > > is not the correct data structure for hartids as it can be higher
> > > than NR_CPUs for platforms with sparse or discontguous hartids.
> > >
> > > Remove all association between hartid mask and struct cpumask.
> > >
> > > Reviewed-by: Anup Patel <anup@brainfault.org> (For Linux RISC-V changes)
> > > Acked-by: Anup Patel <anup@brainfault.org> (For KVM RISC-V changes)
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> >
> > Thanks for your patch, which is now commit 26fb751ca37846c9 ("RISC-V:
> > Do not use cpumask data structure for hartid bitmap") in v5.17-rc1.
> >
> > I am having an issue with random userspace SEGVs on Starlight Beta
> > (which needs out-of-tree patches).  It doesn't always manifest
> > itself immediately, so it took a while to bisect, but I suspect the
> > above commit to be the culprit.
>
> I have never seen one before during my testing. How frequently do you see them?
> Does it happen while running anything or just idle user space results
> in SEGVs randomly.

Sometimes they happen during startup (lots of failures from systemd),
sometimes they happen later, during interactive work.
Sometimes while idle, and something runs in the background (e.g. mandb).

> Do you have a trace that I can look into ?

# apt update
[  807.499050] apt[258]: unhandled signal 11 code 0x1 at
0xffffff8300060020 in libapt-pkg.so.6.0.0[3fa49ac000+174000]
[  807.509548] CPU: 0 PID: 258 Comm: apt Not tainted
5.16.0-starlight-11192-g26fb751ca378-dirty #153
[  807.518674] Hardware name: BeagleV Starlight Beta (DT)
[  807.524077] epc : 0000003fa4a47a0a ra : 0000003fa4a479fc sp :
0000003fcb4b39b0
[  807.531383]  gp : 0000002adcef4800 tp : 0000003fa43287b0 t0 :
0000000000000001
[  807.538603]  t1 : 0000000000000009 t2 : 00000000000003ff s0 :
0000000000000000
[  807.545887]  s1 : 0000002adcf3cb60 a0 : 0000000000000003 a1 :
0000000000000000
[  807.553167]  a2 : 0000003fcb4b3a30 a3 : 0000000000000000 a4 :
0000002adcf3cc1c
[  807.560390]  a5 : 0007000300060000 a6 : 0000000000000003 a7 :
1999999999999999
[  807.567654]  s2 : 0000003fcb4b3a28 s3 : 0000000000000002 s4 :
0000003fcb4b3a30
[  807.575039]  s5 : 0000003fa4baa810 s6 : 0000000000000010 s7 :
0000002adcf19a40
[  807.582363]  s8 : 0000003fcb4b4010 s9 : 0000003fa4baa810 s10:
0000003fcb4b3e90
[  807.589606]  s11: 0000003fa4b2a528 t3 : 0000000000000000 t4 :
0000003fa47906a0
[  807.596891]  t5 : 0000000000000005 t6 : ffffffffffffffff
[  807.602302] status: 0000000200004020 badaddr: ffffff8300060020
cause: 000000000000000d

(-dirty due to Starlight DTS and driver updates)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
