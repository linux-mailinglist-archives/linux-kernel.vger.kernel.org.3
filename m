Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A2A49C53E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiAZI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:29:01 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:35802 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbiAZI27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:28:59 -0500
Received: by mail-ua1-f42.google.com with SMTP id m90so42138713uam.2;
        Wed, 26 Jan 2022 00:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ed2si8RhKLaGz8C9MuLECJIsE/v5RcDpMHVTl4zgGc=;
        b=DNLWF85/ouu2jA9Yls8umC98rNhhyoMfETu9JW86RVCIBQ0Gxaa0c5wrVN+YE1gI8u
         75trojHHrPkLFWT+uWT3BC1CTzL7ff616rhIYcuGR6m1RpyK3rYIQpYB+ShkLkJSbpHr
         Kr70iW2JVwJ2oaRAFtDqOh0qo8ZwYY3VWfEXLGbXUxc5ZntDqeP3znU73riCfbiKl5US
         NJKFsm7+RUMp5aiqnWZgan31QLvOb8R809ONHrmao5dnxuZgYTRmw+UOicFtNn4X3Ljn
         H4PuLw085yS5ytWXaKXYY3kbZTc/XJz2RwQRFP1Kszlm8hvy83XS5a39XVRbETrZ8a0h
         IV5g==
X-Gm-Message-State: AOAM5335xmT6hsR1L4AMCYVrRm8d7j3GQcVH0FD5Ib8jQiXk5YDxruNo
        qGZu9cqUdAGa4m6aq+iEMf0H0tkPSY0dMFTp
X-Google-Smtp-Source: ABdhPJwxLNUyzxDWEaBy+rlLaeiXPgr0nxJkAp88AK0r/LFhAJFLRu7aUoTk1PWYb/wWpqzB7nFa9A==
X-Received: by 2002:a67:d194:: with SMTP id w20mr4621713vsi.39.1643185738651;
        Wed, 26 Jan 2022 00:28:58 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id c128sm1909974vsc.5.2022.01.26.00.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 00:28:58 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id w21so41991451uan.7;
        Wed, 26 Jan 2022 00:28:57 -0800 (PST)
X-Received: by 2002:a05:6102:a04:: with SMTP id t4mr3799826vsa.77.1643185737329;
 Wed, 26 Jan 2022 00:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20220120090918.2646626-1-atishp@rivosinc.com> <20220120090918.2646626-7-atishp@rivosinc.com>
 <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com> <CAOnJCUKJmHv2Rs3=FR3LjiZqvM5uxcVeZ3D5xRSbEeDFCeS9=Q@mail.gmail.com>
In-Reply-To: <CAOnJCUKJmHv2Rs3=FR3LjiZqvM5uxcVeZ3D5xRSbEeDFCeS9=Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jan 2022 09:28:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW+ZO0=Qc8NCWujZUq=L-LZJpcd7oZo4MxRFYMmcURXVQ@mail.gmail.com>
Message-ID: <CAMuHMdW+ZO0=Qc8NCWujZUq=L-LZJpcd7oZo4MxRFYMmcURXVQ@mail.gmail.com>
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

On Wed, Jan 26, 2022 at 3:21 AM Atish Patra <atishp@atishpatra.org> wrote:
> On Tue, Jan 25, 2022 at 2:26 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
> > On 20 Jan 2022, at 09:09, Atish Patra <atishp@rivosinc.com> wrote:
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

> I am yet to reproduce it on my end.
> @Geert Uytterhoeven: can you please try the below diff on your end.

Unfortunately it doesn't fix the issue for me.

/me debugging...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
