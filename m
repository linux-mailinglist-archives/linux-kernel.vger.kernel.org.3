Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D9449BCBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiAYUNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:13:18 -0500
Received: from mail-vk1-f169.google.com ([209.85.221.169]:37451 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiAYUMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:12:43 -0500
Received: by mail-vk1-f169.google.com with SMTP id v192so13108075vkv.4;
        Tue, 25 Jan 2022 12:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cqbsPNZ64vIJQYyE3XbIMBM01AmRJigHSuPYUkGB7E=;
        b=2cTOSUtH0nuvQ35Lea6dJqBpOCAQJlyDCB3FnF5O3fSv765Lj7/eO6B+AQHZFGhDYU
         ATZd3z+YqHRMp4cr9s4MfL/SK8UtkjjGUuq2XY3FQvDpVgp2QMOQn7/AOFHPMJcaCA+F
         lt/ntFeHtb+Byd5CCtFeGCVgAMP77SlTby95tC5hfjb35keDuo2xyJW4ColYQuLnPeI2
         2K0IkyPEzCEe/cjeoLQiQZtGZ1D2piKPn5QyIYiJjSwFemc9R5VFly/afzFa4wplazB0
         67H8nePS5w9UnfRUIMMfeld40qa6tZicH7xxQa1sW31KD70sHiLS8PIN1cbK7KNgWhaS
         S7bQ==
X-Gm-Message-State: AOAM532Vu41EQQtb2nmmXvXMHXdlU2o2rHZtejbe0Sw4SAd0XY5qpN2p
        2jausvD85xu7BuRFotCuF3NzvsjR97KQaHm0
X-Google-Smtp-Source: ABdhPJyGI8hnAKqtNw2OqJoN4MwPWLXeZD5TNXRUsGPzwsTHt6NROtt+tkC0XVbJIKIAoLNX6c5K8w==
X-Received: by 2002:a05:6122:588:: with SMTP id i8mr2124559vko.41.1643141562489;
        Tue, 25 Jan 2022 12:12:42 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id d202sm1125006vkd.38.2022.01.25.12.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 12:12:42 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id r15so39566043uao.3;
        Tue, 25 Jan 2022 12:12:41 -0800 (PST)
X-Received: by 2002:a67:a401:: with SMTP id n1mr4458394vse.38.1643141561680;
 Tue, 25 Jan 2022 12:12:41 -0800 (PST)
MIME-Version: 1.0
References: <20220120090918.2646626-1-atishp@rivosinc.com> <20220120090918.2646626-7-atishp@rivosinc.com>
In-Reply-To: <20220120090918.2646626-7-atishp@rivosinc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jan 2022 21:12:30 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJoREF7jZaYWrDUjJqKUSCd82qDVaMEo7VO38ok8J-AA@mail.gmail.com>
Message-ID: <CAMuHMdXJoREF7jZaYWrDUjJqKUSCd82qDVaMEo7VO38ok8J-AA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
To:     Atish Patra <atishp@rivosinc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
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

On Thu, Jan 20, 2022 at 10:12 AM Atish Patra <atishp@rivosinc.com> wrote:
> Currently, SBI APIs accept a hartmask that is generated from struct
> cpumask. Cpumask data structure can hold upto NR_CPUs value. Thus, it
> is not the correct data structure for hartids as it can be higher
> than NR_CPUs for platforms with sparse or discontguous hartids.
>
> Remove all association between hartid mask and struct cpumask.
>
> Reviewed-by: Anup Patel <anup@brainfault.org> (For Linux RISC-V changes)
> Acked-by: Anup Patel <anup@brainfault.org> (For KVM RISC-V changes)
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Thanks for your patch, which is now commit 26fb751ca37846c9 ("RISC-V:
Do not use cpumask data structure for hartid bitmap") in v5.17-rc1.

I am having an issue with random userspace SEGVs on Starlight Beta
(which needs out-of-tree patches).  It doesn't always manifest
itself immediately, so it took a while to bisect, but I suspect the
above commit to be the culprit.

So far the Icicle looks unaffected.

Do you have a clue?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
