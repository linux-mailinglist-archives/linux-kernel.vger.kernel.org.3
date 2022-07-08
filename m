Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D1D56B56F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbiGHJ2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbiGHJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:28:34 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB411446
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:28:33 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id z12so15270435qki.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 02:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8P8vfH9HKefblWeEsLpHl1JryF7MgcGtCA94wYmgSRA=;
        b=Uoqg6QwyC/ESTi8l7zHuyO831bTd4zXVVNiY3nFlym9hNFCZkpnuQYgQfVZ/egoDbV
         W6BOxFQYqUCh4lJgI90WaFQvrsRmVPhFP/ZSjYinm1fwPp3XpAzXg9TxvptLlXUtkCDB
         5Q7FUTlO7qdyTDnhEA1buxsB0T1BK3VLug4TmmvFOCQ2USHMGCyz+isWBKaZWuj76wD5
         AOjyCcNdROMenEL3NELMtSEiowCOGi9QpSy4khyvvOIY0MZ0noAj4XWNUzE4SURvCkfB
         aAKZ7gaph1Tj1YY1nOxNhPPZ1UI5MYaaHnwJ/CUCpKJX4gVInvrzIwausjhAtMm4pWlY
         mFAg==
X-Gm-Message-State: AJIora/DRgtFs/P1hGWC0Gth/ttHY3uqNr0FTAVZC04PEAr24yzskDUA
        R7xJcEygUJqZqpzfh62UcNr3KajVoRaLrQ==
X-Google-Smtp-Source: AGRyM1u1fRZzAllqG9/NIwRNn+VO1IkqnmZ1DXO3NDSb19sFbg5RK3gSZBnWXa3tXek8/FEm4ZKZJw==
X-Received: by 2002:a05:620a:4914:b0:6af:3011:585f with SMTP id ed20-20020a05620a491400b006af3011585fmr1471984qkb.245.1657272512815;
        Fri, 08 Jul 2022 02:28:32 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id ff27-20020a05622a4d9b00b0031cc5db5aebsm19008691qtb.85.2022.07.08.02.28.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 02:28:32 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31bf3656517so192749587b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 02:28:31 -0700 (PDT)
X-Received: by 2002:a0d:dd09:0:b0:31c:e3b9:7442 with SMTP id
 g9-20020a0ddd09000000b0031ce3b97442mr2831959ywe.47.1657272511310; Fri, 08 Jul
 2022 02:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220707220436.4105443-1-mail@conchuod.ie> <20220707220436.4105443-3-mail@conchuod.ie>
 <20220708082443.azoqvuj7afrg7ox7@bogus> <473e6b17-465b-3d14-b04d-01b187390e66@microchip.com>
 <20220708092100.c6mgmnt7e2k7u634@bogus>
In-Reply-To: <20220708092100.c6mgmnt7e2k7u634@bogus>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 8 Jul 2022 11:28:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXUjmG9n3BuRAz_irkmHQbp=7SYxe5VEfOhMdT4D2JfwQ@mail.gmail.com>
Message-ID: <CAMuHMdXUjmG9n3BuRAz_irkmHQbp=7SYxe5VEfOhMdT4D2JfwQ@mail.gmail.com>
Subject: Re: [RFC 2/4] arch-topology: add a default implementation of store_cpu_topology()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Conor Dooley <Conor.Dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daire.McNamara@microchip.com,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berthing <kernel@esmil.dk>, hahnjo@hahnjo.de,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>, changbin.du@intel.com,
        Heiko Stuebner <heiko@sntech.de>, philipp.tomsich@vrull.eu,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Brice.Goglin@inria.fr
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Fri, Jul 8, 2022 at 11:22 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Fri, Jul 08, 2022 at 08:35:57AM +0000, Conor.Dooley@microchip.com wrote:
> > On 08/07/2022 09:24, Sudeep Holla wrote:
> > > On Thu, Jul 07, 2022 at 11:04:35PM +0100, Conor Dooley wrote:
> > >> From: Conor Dooley <conor.dooley@microchip.com>
> > >>
> > >> RISC-V & arm64 both use an almost identical method of filling in
> > >> default vales for arch topology. Create a weakly defined default
> > >> implementation with the intent of migrating both archs to use it.
> > >>
> > >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > >> ---
> > >>   drivers/base/arch_topology.c  | 19 +++++++++++++++++++
> > >>   include/linux/arch_topology.h |  1 +
> > >>   2 files changed, 20 insertions(+)
> > >>
> > >> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > >> index 441e14ac33a4..07e84c6ac5c2 100644
> > >> --- a/drivers/base/arch_topology.c
> > >> +++ b/drivers/base/arch_topology.c
> > >> @@ -765,6 +765,25 @@ void update_siblings_masks(unsigned int cpuid)
> > >>    }
> > >>   }
> > >>
> > >> +void __weak store_cpu_topology(unsigned int cpuid)
> >
> > Does using __weak here make sense to you?
> >
>
> I don't want any weak definition and arch to override as we know only
> arm64 and RISC-V are the only users and they are aligned to have same
> implementation. So weak definition doesn't make sense to me.
>
> > >
> > > I prefer to have this as default implementation. So just get the risc-v
> > > one pushed to upstream first(for v5.20) and get all the backports if required.
> > > Next cycle(i.e. v5.21), you can move both RISC-V and arm64.
> > >
> >
> > Yeah, that was my intention. I meant to label patch 1/4 as "PATCH"
> > and (2,3,4)/4 as RFC but forgot. I talked with Palmer about doing
> > the risc-v impl. and then migrate both on IRC & he seemed happy with
> > it.
> >
>
> Ah OK, good.
>
> > If you're okay with patch 1/4, I'll resubmit it as a standalone v2.
> >
>
> That would be great, thanks. You can most the code to move to generic from
> both arm64 and risc-v once we have this in v5.20-rc1

Why not ignore risc-v for now, and move the arm64 implementation to
the generic code for v5.20, so every arch will have it at once?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
