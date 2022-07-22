Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40FF57DB84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 09:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiGVHvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 03:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiGVHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 03:51:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A114315A1C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:51:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27D5AB826E7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6431C385A2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 07:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658476286;
        bh=hteyvn0yaPK0/2NRgzXD5OW+6qZL0byNi3OkzsX0uAo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Plax3rlzJiMmzpB6iCmEXJOLiz1IPvdRO43uG5cjEa1GxxHIlTcmaQS00VPFdUrl0
         K8jOjpp1OuC76WpQ9zmLPW4WbPKKYK4dubUlkICjfULKU/hqOjF8jkKk3Cu4HUII1I
         /bIzTPzcFRyzxpwaK/IjG9GurGBYxJiZa/K7p4w4T/XPlwMrm7yMKM2rD9Byu5DriT
         V1Aj2v2I2Y/HfK4Ff9eeYG+yIjOStKiodKRGXD8yFP7+qDnLi5ug+D8ktpvyW0VfvH
         3liLaG8uOedx0l+W6yzd62XXnmTnZA2YYvi/bqjaaab5UnPCw40ZO6P8645BO/vsel
         qLi02lzHsemWw==
Received: by mail-lf1-f47.google.com with SMTP id z25so6441187lfr.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:51:26 -0700 (PDT)
X-Gm-Message-State: AJIora9cAOQkSKSCA6me5YhYCnsPILAuOoqQBph+MaBRjEvdjpuaMDhs
        WCz/PCMgoIIuB07mNrLNJbAXDoGmj+tKDdPOPU8=
X-Google-Smtp-Source: AGRyM1ulyx/y0eJ3gMB2WigTyNk+sRot7MzH9LBTdkd6YkOvurOggIitYqJPWWUU2qS5qF8F4OYRyUlPT9BKgH1CkHk=
X-Received: by 2002:a05:6512:1191:b0:48a:2269:e87 with SMTP id
 g17-20020a056512119100b0048a22690e87mr826633lfr.122.1658476284840; Fri, 22
 Jul 2022 00:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220717101323.370245-1-xianting.tian@linux.alibaba.com>
 <20220717101323.370245-5-xianting.tian@linux.alibaba.com> <7405851.EvYhyI6sBW@diego>
In-Reply-To: <7405851.EvYhyI6sBW@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 22 Jul 2022 15:51:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSYp4-2VLq4HmvcdDWq3ygkHiXpDfTyocYStxGpejx7jg@mail.gmail.com>
Message-ID: <CAJF2gTSYp4-2VLq4HmvcdDWq3ygkHiXpDfTyocYStxGpejx7jg@mail.gmail.com>
Subject: Re: [PATCH 4/5] riscv: Add modules to virtual kernel memory layout dump
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 3:24 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Sonntag, 17. Juli 2022, 12:13:22 CEST schrieb Xianting Tian:
> > Modules always live before the kernel, MODULES_END is fixed but
> > MODULES_VADDR isn't fixed, it depends on the kernel size.
> > Let's add it to virtual kernel memory layout dump.
> >
> > As MODULES is only defined for CONFIG_64BIT, so we dump it when
> > CONFIG_64BIT=3Dy.
> >
> > eg,
> > MODULES_VADDR - MODULES_END
> > 0xffffffff01133000 - 0xffffffff80000000
> >
> > Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>
> I'm still not sure if it would be better to define MODULES_* constants
> even on 32bit (with their VMALLOC_START etc values) and prevent
> needing the CONFIG_64BIT ifdef, but that's for others to decide :-)
There is no MODULES_VADDR for 32-bit, because it reuses vmalloc area.

We should print MODULES_VADDR here to make people clear to know.

Reviewed-by: Guo Ren <guoren@kernel.org>

>
> The below also looks good, so
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
> > ---
> >  arch/riscv/mm/init.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index d466ec670e1f..2c4a64e97aec 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -135,6 +135,10 @@ static void __init print_vm_layout(void)
> >               (unsigned long)VMEMMAP_END);
> >       print_ml("vmalloc", (unsigned long)VMALLOC_START,
> >               (unsigned long)VMALLOC_END);
> > +#ifdef CONFIG_64BIT
> > +     print_ml("modules", (unsigned long)MODULES_VADDR,
> > +             (unsigned long)MODULES_END);
> > +#endif
> >       print_ml("lowmem", (unsigned long)PAGE_OFFSET,
> >               (unsigned long)high_memory);
> >       if (IS_ENABLED(CONFIG_64BIT)) {
> >
>
>
>
>


--=20
Best Regards
 Guo Ren
