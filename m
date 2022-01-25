Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE93B49BCD7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiAYUSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiAYUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:17:56 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A5DC061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:17:55 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c10so65209482ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xH4919BBQDatXV47ZV39NtXvgYYtXrd/TsEbvbZr80k=;
        b=MfklnOCQVmnZ1DGtZ/7lH8SHjstb5OvkICRH3LZOqLvcVDHKV0C4/qab9nARYCxi07
         SkqgzSsp4w8mfq9ydwKA+Pq4fo943Kkwmo7LEUszNU5r+EGEZe9b7JQskqSHPiwQ9xjS
         6+3mmdc2jub7xRbVt6HrtXDQmbjJj3kJkwuzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xH4919BBQDatXV47ZV39NtXvgYYtXrd/TsEbvbZr80k=;
        b=inqguAS72/gTDkqPiDefRZAMl5WR5Aa5flUUhhBEEeiW91Yqy8n2r1PwTl32B/itzV
         CDOmsQ4cmQJ18J0GNvbRqPqz4R8E/lhJZBY5keen/6lxJoH0996/+lw7kFoEbykOZvZD
         v4ZMqhrEyYNpSuoc4Jv4MGdJvXmGWD1pec86uIcAeuUEKZZbrSRJZQVNL3zF3GjmJBnZ
         u6lYCMnnfcKlSOQShdJAJJceCY5GIgMI8ZaWlMWrhetpUnZRgCd0kZrYpvr7wKlGzQAM
         9sMGd4sXrVRg8A+u9+6u9TtMQt7nciRTjW/aRdLVeimoJijqK2/tLtifMJeGIfyQkvIG
         VSxA==
X-Gm-Message-State: AOAM531SmUuOVJaKRiYjURotGPD34BrdJ5f+DObjNYfvESTf7zxgrpw9
        o8YJ4yUnkSF5937BnYUZJu04ECoMu+mIjHEsJkJd
X-Google-Smtp-Source: ABdhPJz4ErEQdG2kZzS4RU3R+TozqNSpTkyZlNySmm+OUFhQWBU6G++H14erGITpDeyTZi30ICVtSwClulYTDTDEhuI=
X-Received: by 2002:a25:ac9a:: with SMTP id x26mr4798915ybi.713.1643141875109;
 Tue, 25 Jan 2022 12:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20220120090918.2646626-1-atishp@rivosinc.com> <20220120090918.2646626-7-atishp@rivosinc.com>
 <CAMuHMdXJoREF7jZaYWrDUjJqKUSCd82qDVaMEo7VO38ok8J-AA@mail.gmail.com>
In-Reply-To: <CAMuHMdXJoREF7jZaYWrDUjJqKUSCd82qDVaMEo7VO38ok8J-AA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 25 Jan 2022 12:17:44 -0800
Message-ID: <CAOnJCULjqeL9Q27n=g19ALbOivzid6pc_gYv6JUF4iP=64kJ-Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, Jan 25, 2022 at 12:12 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Atish,
>
> On Thu, Jan 20, 2022 at 10:12 AM Atish Patra <atishp@rivosinc.com> wrote:
> > Currently, SBI APIs accept a hartmask that is generated from struct
> > cpumask. Cpumask data structure can hold upto NR_CPUs value. Thus, it
> > is not the correct data structure for hartids as it can be higher
> > than NR_CPUs for platforms with sparse or discontguous hartids.
> >
> > Remove all association between hartid mask and struct cpumask.
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org> (For Linux RISC-V changes)
> > Acked-by: Anup Patel <anup@brainfault.org> (For KVM RISC-V changes)
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
>
> Thanks for your patch, which is now commit 26fb751ca37846c9 ("RISC-V:
> Do not use cpumask data structure for hartid bitmap") in v5.17-rc1.
>
> I am having an issue with random userspace SEGVs on Starlight Beta
> (which needs out-of-tree patches).  It doesn't always manifest
> itself immediately, so it took a while to bisect, but I suspect the
> above commit to be the culprit.
>

I have never seen one before during my testing. How frequently do you see them?
Does it happen while running anything or just idle user space results
in SEGVs randomly.

Do you have a trace that I can look into ?

> So far the Icicle looks unaffected.
>
> Do you have a clue?
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Regards,
Atish
