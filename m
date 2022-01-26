Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F6149C5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiAZJKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:10:32 -0500
Received: from mail-vk1-f179.google.com ([209.85.221.179]:45670 "EHLO
        mail-vk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiAZJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:10:31 -0500
Received: by mail-vk1-f179.google.com with SMTP id w5so13943647vke.12;
        Wed, 26 Jan 2022 01:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WmTPz9PmKhTaX5wyRQ+ebsEt337fwh+gbpdxl24qCZk=;
        b=WmDWUQei11K4/7cwiar6+FUOlb6WTQ28QyOxLMvcdeTdc0QhJlIKn0gNKXXOefzv8P
         igexK/5T5u4dYYc6vLqt208wExX/rIeEjFplIYMANzdgyFJo0igs2wevu3iGCUsC3wfu
         E+y8CXk0I1c8+uJfbU7Q5QenGYVP8EpIxwWhPkc/yhbQyS0yz3sIFIj7hh7xjPOLwCzn
         wL60Xct99nbHgTvrEpfMLhXrXw2BlU9cNPQ9cHmkwYiCwdpVPgrhxhlswRXjMNoWZT+i
         Bk9p708O6vFnoAv872zgEK8ZLb9yzZdeEWr4a6B0OkO1YoxWVXMfw/Di3Og0OveEzjG1
         qC+Q==
X-Gm-Message-State: AOAM533I2WJ0zZawYbIgkRwAYDZww7NEkBKrPRmEciuaAIMYvnWzPJ/n
        JbVD5iWIo7Y6Kkfis6I7LLYEUDjUBw14p+5x
X-Google-Smtp-Source: ABdhPJwfzoQiPYoRW8K63d7iN7AjmxjyWBrndOQiT36Tg6/6oUDgxgUCN8d16D+3BcsMUxt9yqjF7g==
X-Received: by 2002:a1f:3183:: with SMTP id x125mr9393049vkx.28.1643188230397;
        Wed, 26 Jan 2022 01:10:30 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id u184sm3753070vke.49.2022.01.26.01.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 01:10:29 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id n15so40656911uaq.5;
        Wed, 26 Jan 2022 01:10:29 -0800 (PST)
X-Received: by 2002:a67:b009:: with SMTP id z9mr5917064vse.57.1643188229085;
 Wed, 26 Jan 2022 01:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20220120090918.2646626-1-atishp@rivosinc.com> <20220120090918.2646626-7-atishp@rivosinc.com>
 <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com> <CAOnJCUKJmHv2Rs3=FR3LjiZqvM5uxcVeZ3D5xRSbEeDFCeS9=Q@mail.gmail.com>
 <CAMuHMdW+ZO0=Qc8NCWujZUq=L-LZJpcd7oZo4MxRFYMmcURXVQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW+ZO0=Qc8NCWujZUq=L-LZJpcd7oZo4MxRFYMmcURXVQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jan 2022 10:10:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXq7OQJL6H7=JRnDTR6p+AD0o2Ctjn806XZQZ9PYjvepg@mail.gmail.com>
Message-ID: <CAMuHMdXq7OQJL6H7=JRnDTR6p+AD0o2Ctjn806XZQZ9PYjvepg@mail.gmail.com>
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

Hi Atish,

On Wed, Jan 26, 2022 at 9:28 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Jan 26, 2022 at 3:21 AM Atish Patra <atishp@atishpatra.org> wrote:
> > On Tue, Jan 25, 2022 at 2:26 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
> > > On 20 Jan 2022, at 09:09, Atish Patra <atishp@rivosinc.com> wrote:
> > > > Currently, SBI APIs accept a hartmask that is generated from struct
> > > > cpumask. Cpumask data structure can hold upto NR_CPUs value. Thus, it
> > > > is not the correct data structure for hartids as it can be higher
> > > > than NR_CPUs for platforms with sparse or discontguous hartids.
> > > >
> > > > Remove all association between hartid mask and struct cpumask.
> > > >
> > > > Reviewed-by: Anup Patel <anup@brainfault.org> (For Linux RISC-V changes)
> > > > Acked-by: Anup Patel <anup@brainfault.org> (For KVM RISC-V changes)
> > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
>
> > I am yet to reproduce it on my end.
> > @Geert Uytterhoeven: can you please try the below diff on your end.
>
> Unfortunately it doesn't fix the issue for me.
>
> /me debugging...

Found it: after this commit, the SBI_EXT_RFENCE_REMOTE_FENCE_I and
SBI_EXT_RFENCE_REMOTE_SFENCE_VMA ecalls are now called with
hmask = 0x8000000000000001 and hbase = 1 instead of hmask = 3 and
hbase = 0.

cpuid 1 maps to  hartid 0
cpuid 0 maps to hartid 1

    __sbi_rfence_v02:364: cpuid 1 hartid 0
    __sbi_rfence_v02:377: hartid 0 hbase 1
    hmask |= 1UL << (hartid - hbase);

oops

    __sbi_rfence_v02_call:303: SBI_EXT_RFENCE_REMOTE_FENCE_I hmask
8000000000000001 hbase 1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
