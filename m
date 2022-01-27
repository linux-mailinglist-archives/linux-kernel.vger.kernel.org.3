Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EBD49DCEB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbiA0ItH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:49:07 -0500
Received: from mail-vk1-f175.google.com ([209.85.221.175]:46074 "EHLO
        mail-vk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiA0ItG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:49:06 -0500
Received: by mail-vk1-f175.google.com with SMTP id l14so141097vko.12;
        Thu, 27 Jan 2022 00:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tiYQ03BGYl3eFh9sLWDt0ZrzOmKrMYMSVnNiMqCKOig=;
        b=fZKhogag9IJbYfJdAGv5duwrEPS4E62orY5keAKMpaigo1xnm6h8vOVlu7kR84LN9x
         mz6mYCEeZ8qCHsVORSSqwQba+r5n2R56m2KA3eQR7JB3snuzz3resOHocS2IoiyiD+CF
         SXMoTWTJzPSB04oy4zmwLbC4EddGm4CyXYAmammFlGD0XWvtH7SwxydkDbh0MXwV4N/4
         7FG2nRzRlP7BoBYUCYtTl/G5U2F8IEQ5YqnsYb2/hcuf8nXk6RolFX3wgZkQ5YzmI0u6
         9wxcDMn3AbmrOn1+Qz1Ni5P2eYy4z4Dqlvt3eMwxVW3BtkZihcY6BSREm/J4xQfZWlay
         Fwyw==
X-Gm-Message-State: AOAM5300W/WX5N1PiohGf2VA21CcO/6vZ72tA+GOEld2vKNerwoePo4Q
        q+393X9wHSwPwioERGpOTO0BE4YYyhI8HA==
X-Google-Smtp-Source: ABdhPJxPz/7J0B75duZNmdReK2b40PrRAARYgVJ4+g+uE3L1MTmkxGVJrriSGxrJKskDKD6PE0q32g==
X-Received: by 2002:a05:6122:551:: with SMTP id y17mr819651vko.37.1643273345862;
        Thu, 27 Jan 2022 00:49:05 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id n18sm456039vkq.7.2022.01.27.00.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 00:49:05 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id l14so141061vko.12;
        Thu, 27 Jan 2022 00:49:04 -0800 (PST)
X-Received: by 2002:a1f:5d84:: with SMTP id r126mr1015757vkb.33.1643273344756;
 Thu, 27 Jan 2022 00:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20220120090918.2646626-1-atishp@rivosinc.com> <20220120090918.2646626-7-atishp@rivosinc.com>
 <1AA3005C-E9C8-4E4B-900D-DD48B37CEA41@jrtc27.com> <CAOnJCUKJmHv2Rs3=FR3LjiZqvM5uxcVeZ3D5xRSbEeDFCeS9=Q@mail.gmail.com>
 <CAMuHMdW+ZO0=Qc8NCWujZUq=L-LZJpcd7oZo4MxRFYMmcURXVQ@mail.gmail.com>
 <CAMuHMdXq7OQJL6H7=JRnDTR6p+AD0o2Ctjn806XZQZ9PYjvepg@mail.gmail.com>
 <CAOnJCU+AVS5Js4ZXmUubTqwU5Ye-9_z8onEE1mwhvCsOXchFBg@mail.gmail.com> <CAMuHMdWsX-Pg3B1=KRf9hz1JrPAbydBrANTXg4q5CFJCqHJAoA@mail.gmail.com>
In-Reply-To: <CAMuHMdWsX-Pg3B1=KRf9hz1JrPAbydBrANTXg4q5CFJCqHJAoA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Jan 2022 09:48:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4VPY4KTV+0zwxUqgObGk9gj=D-aMNsTTvAFqV+67zwg@mail.gmail.com>
Message-ID: <CAMuHMdX4VPY4KTV+0zwxUqgObGk9gj=D-aMNsTTvAFqV+67zwg@mail.gmail.com>
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

On Thu, Jan 27, 2022 at 9:48 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Jan 27, 2022 at 2:02 AM Atish Patra <atishp@atishpatra.org> wrote:
> > On Wed, Jan 26, 2022 at 1:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, Jan 26, 2022 at 9:28 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Wed, Jan 26, 2022 at 3:21 AM Atish Patra <atishp@atishpatra.org> wrote:
> > > > > On Tue, Jan 25, 2022 at 2:26 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
> > > > > > On 20 Jan 2022, at 09:09, Atish Patra <atishp@rivosinc.com> wrote:
> > > > > > > Currently, SBI APIs accept a hartmask that is generated from struct
> > > > > > > cpumask. Cpumask data structure can hold upto NR_CPUs value. Thus, it
> > > > > > > is not the correct data structure for hartids as it can be higher
> > > > > > > than NR_CPUs for platforms with sparse or discontguous hartids.
> > > > > > >
> > > > > > > Remove all association between hartid mask and struct cpumask.
> > > > > > >
> > > > > > > Reviewed-by: Anup Patel <anup@brainfault.org> (For Linux RISC-V changes)
> > > > > > > Acked-by: Anup Patel <anup@brainfault.org> (For KVM RISC-V changes)
> > > > > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > >
> > > > > I am yet to reproduce it on my end.
> > > > > @Geert Uytterhoeven: can you please try the below diff on your end.
> > > >
> > > > Unfortunately it doesn't fix the issue for me.
> > > >
> > > > /me debugging...
> > >
> > > Found it: after this commit, the SBI_EXT_RFENCE_REMOTE_FENCE_I and
> > > SBI_EXT_RFENCE_REMOTE_SFENCE_VMA ecalls are now called with
> > > hmask = 0x8000000000000001 and hbase = 1 instead of hmask = 3 and
> > > hbase = 0.
> > >
> > > cpuid 1 maps to  hartid 0
> > > cpuid 0 maps to hartid 1
> > >
> > >     __sbi_rfence_v02:364: cpuid 1 hartid 0
> > >     __sbi_rfence_v02:377: hartid 0 hbase 1
> > >     hmask |= 1UL << (hartid - hbase);
> > >
> > > oops
> > >
> > >     __sbi_rfence_v02_call:303: SBI_EXT_RFENCE_REMOTE_FENCE_I hmask
> > > 8000000000000001 hbase 1
> > >
> >
> > Ahh yes. hmask will be incorrect if the bootcpu(cpu 0) is a higher
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

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
