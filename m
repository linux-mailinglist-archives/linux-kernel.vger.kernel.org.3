Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0F149F5BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243447AbiA1Izm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:55:42 -0500
Received: from mail-vs1-f54.google.com ([209.85.217.54]:46835 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiA1Izl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:55:41 -0500
Received: by mail-vs1-f54.google.com with SMTP id u14so2164229vsg.13;
        Fri, 28 Jan 2022 00:55:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uy2MrDkccIj156ALaICyk+fvYR4qhgIfiYRgdsCeDKk=;
        b=DBF/s0H3OlBr/RVXCVw7KWjgDNdi0fY2a4gi/La2oZqYBCtvPqeP6CJXMSsOpI3X5i
         7MpeJXw1tvJcg1178txTmnFuYsPuJU7uq6SaQbal7JENdkDkKsj8iw6T1hOgnQv8ka2d
         tXeLREhT30I8T4QEHt1EgPyuxmcjxYknVL1JkBBt1L/EfH2imEtQx9e6iGWTCaaB/cSS
         RaM3btBABb8Z7TgF2yfSkd4TjGeqtszm4DIg53ShSgnEwbmGsrua9okHKZZxRilRI/Lf
         n2LDdxfELE5c3sBhlGxX0x52nQiU87Bazmhh7bJpHL5bycW8GNBUQZV/8u3P0T6HJZBH
         ukOQ==
X-Gm-Message-State: AOAM531+CqWX/27iaHEHR3fycJVO19vKRIoEHcq+UsF2lidbbw5AMpZ/
        kOMp5p1e6r01jpjVDBEC64SF8Vfya9lQDDF5
X-Google-Smtp-Source: ABdhPJzYlhJecRr1rupI2SCCDWtvHAJG4AYAJDiOe4M7Dt5ET7YXI60M6blE1vrbxpRGtleZ+bddew==
X-Received: by 2002:a67:cb87:: with SMTP id h7mr3518145vsl.67.1643360141032;
        Fri, 28 Jan 2022 00:55:41 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id r11sm2073140uaw.7.2022.01.28.00.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 00:55:40 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id v62so2171505vsv.4;
        Fri, 28 Jan 2022 00:55:39 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr3329515vse.38.1643360139371;
 Fri, 28 Jan 2022 00:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20220120090918.2646626-1-atishp@rivosinc.com> <20220120090918.2646626-7-atishp@rivosinc.com>
 <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com> <CAOnJCUKJmHv2Rs3=FR3LjiZqvM5uxcVeZ3D5xRSbEeDFCeS9=Q@mail.gmail.com>
 <CAMuHMdW+ZO0=Qc8NCWujZUq=L-LZJpcd7oZo4MxRFYMmcURXVQ@mail.gmail.com>
 <CAMuHMdXq7OQJL6H7=JRnDTR6p+AD0o2Ctjn806XZQZ9PYjvepg@mail.gmail.com>
 <CAOnJCU+AVS5Js4ZXmUubTqwU5Ye-9_z8onEE1mwhvCsOXchFBg@mail.gmail.com>
 <CAMuHMdWsX-Pg3B1=KRf9hz1JrPAbydBrANTXg4q5CFJCqHJAoA@mail.gmail.com>
 <CAOnJCU+U0xmw-_yTEUo9ZXO5pvoJ6VCGu+jjU-Sa2MnhcAha6Q@mail.gmail.com> <CAMuHMdXLjjgD7j_5cm8qdL63m1SoB90O9j7YMYYrpXaH79hwJQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXLjjgD7j_5cm8qdL63m1SoB90O9j7YMYYrpXaH79hwJQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Jan 2022 09:55:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWgReJmBsZtY7mamnD7FkxaVX0uV2NgJNO1cFcUf8u3HA@mail.gmail.com>
Message-ID: <CAMuHMdWgReJmBsZtY7mamnD7FkxaVX0uV2NgJNO1cFcUf8u3HA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Atish Patra <atishp@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 9:39 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Jan 28, 2022 at 1:13 AM Atish Patra <atishp@atishpatra.org> wrote:
> > On Thu, Jan 27, 2022 at 12:48 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> What about shifting hmask and adjusting hbase if a hartid is
> >> lower than the current hbase?
> >
> > That will probably work for current systems but it will fail when we have hartid > 64.
> > The below logic as it assumes that the hartids are in order. We can have a situation
> > where a two consecutive cpuid belong to hartids that require two invocations of sbi call
> > because the number of harts exceeds BITS_PER_LONG.
>
> If the number of harts exceeds BITS_PER_LONG, you always need multiple
> calls, right?
>
> I think the below (gmail-whitespace-damaged diff) should work:
>
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -249,7 +249,7 @@ static void __sbi_set_timer_v02(uint64_t stime_value)
>
>  static int __sbi_send_ipi_v02(const struct cpumask *cpu_mask)
>  {
> -       unsigned long hartid, cpuid, hmask = 0, hbase = 0;
> +       unsigned long hartid, cpuid, hmask = 0, hbase = 0, htop = 0;
>         struct sbiret ret = {0};
>         int result;
>
> @@ -258,16 +258,27 @@ static int __sbi_send_ipi_v02(const struct
> cpumask *cpu_mask)
>
>         for_each_cpu(cpuid, cpu_mask) {
>                 hartid = cpuid_to_hartid_map(cpuid);
> -               if (hmask &&
> -                   (hartid < hbase || hartid >= hbase + BITS_PER_LONG)) {

Oops, I actually sent the diff against the simpler solution below,
not against the current code, but I guess you get the idea.
I can send a proper patch when agreed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
