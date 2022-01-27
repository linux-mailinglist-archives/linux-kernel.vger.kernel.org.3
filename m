Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFAB49DEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbiA0KDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:03:23 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:46919 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiA0KDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:03:22 -0500
Received: by mail-ua1-f49.google.com with SMTP id c36so3653710uae.13;
        Thu, 27 Jan 2022 02:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lAMLR34jNozPdnmP0r/qrkgc/xZXHX189n9STko6+vo=;
        b=MbfagxMwL8aKgT7Ejq/quMCpzAFV4VOA+v2TpZE8NiCQq8WKheIgiJqHaWaWAXcmQR
         NJFm+9+Mafr8an+fNc8eyho072h2lXh1+Haiew4vurqz1De2CUY3A4N2IR9ZuMQcXGQb
         plre3FALOKVQ6FQjGqlK2SD7ercnE6jp77DXQQtuGhkM+rB5S/OUI8cYHTsRtcASNLTo
         G+6q/yQv8eei57Xo36JwPkj6huJefcshc0bHFUUOMRhEYY3Vdd6n30ATnnRirQtq9EBt
         6F+/6GqUDxV6wJNKHUoHftRYm6uRxWAAaJMeYnnTZhSI0rlce4HAVwSCGE79qrNJJzza
         FlZg==
X-Gm-Message-State: AOAM532V4Cb6UIOVQDofsfLJCGuKAuNX8lzgQ5f36m4bBN+aYPqqN5ID
        vlNGJs2uIKWGrPY7Md+Zmb239yn/GQPtLQ==
X-Google-Smtp-Source: ABdhPJxA9vc9Q4WuJcTc/3+L585wUNOoGZIaXWDB/SuETXK2//XrCmwZJtconOyuVG8am7JQeyHq2Q==
X-Received: by 2002:ab0:3c48:: with SMTP id u8mr1415022uaw.120.1643277801395;
        Thu, 27 Jan 2022 02:03:21 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id w7sm511879vsi.0.2022.01.27.02.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:03:20 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id w206so1481083vkd.10;
        Thu, 27 Jan 2022 02:03:20 -0800 (PST)
X-Received: by 2002:a05:6122:c8f:: with SMTP id ba15mr1132842vkb.39.1643277799973;
 Thu, 27 Jan 2022 02:03:19 -0800 (PST)
MIME-Version: 1.0
References: <20220120090918.2646626-1-atishp@rivosinc.com> <20220120090918.2646626-7-atishp@rivosinc.com>
 <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com> <CAOnJCUKJmHv2Rs3=FR3LjiZqvM5uxcVeZ3D5xRSbEeDFCeS9=Q@mail.gmail.com>
 <CAMuHMdW+ZO0=Qc8NCWujZUq=L-LZJpcd7oZo4MxRFYMmcURXVQ@mail.gmail.com>
 <CAMuHMdXq7OQJL6H7=JRnDTR6p+AD0o2Ctjn806XZQZ9PYjvepg@mail.gmail.com>
 <CAOnJCU+AVS5Js4ZXmUubTqwU5Ye-9_z8onEE1mwhvCsOXchFBg@mail.gmail.com> <CAMuHMdWsX-Pg3B1=KRf9hz1JrPAbydBrANTXg4q5CFJCqHJAoA@mail.gmail.com>
In-Reply-To: <CAMuHMdWsX-Pg3B1=KRf9hz1JrPAbydBrANTXg4q5CFJCqHJAoA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Jan 2022 11:03:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXyjSrXNCAO8V8pajXW5ts29p==p2J1HnPPoo3-8osKbA@mail.gmail.com>
Message-ID: <CAMuHMdXyjSrXNCAO8V8pajXW5ts29p==p2J1HnPPoo3-8osKbA@mail.gmail.com>
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

On Thu, Jan 27, 2022 at 9:48 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Jan 27, 2022 at 2:02 AM Atish Patra <atishp@atishpatra.org> wrote:
 > Ahh yes. hmask will be incorrect if the bootcpu(cpu 0) is a higher
> > hartid and it is trying to do a remote tlb flush/IPI
> > to lower the hartid. We should generate the hartid array before the loop.
> >
> > Can you try this diff ? It seems to work for me during multiple boot
> > cycle on the unleashed.
> >
> > You can find the patch here as well
> > https://github.com/atishp04/linux/commits/v5.17-rc1
>
> Thanks, that fixes the issue for me.
>
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c

> > @@ -345,13 +368,21 @@ static int __sbi_rfence_v02(int fid, const
> > struct cpumask *cpu_mask,
> >       unsigned long arg4, unsigned long arg5)
> >  {
> >   unsigned long hartid, cpuid, hmask = 0, hbase = 0;
> > - int result;
> > + int result, index = 0, max_index = 0;
> > + unsigned long hartid_arr[NR_CPUS] = {0};
>
> That's up to 256 bytes on the stack. And more if the maximum
> number of cores is increased.

I.e. 4 KiB with the proposed increase to 256 CPUs, as mentioned in
https://lore.kernel.org/all/CAAhSdy2xTW0FkwvS2dExOb7q1dVruFfTP_Vh_jWju+yi7thCeA@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
