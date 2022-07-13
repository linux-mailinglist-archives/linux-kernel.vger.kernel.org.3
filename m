Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8698A572A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 02:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiGMA7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 20:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiGMA7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 20:59:37 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4235C7490
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 17:59:36 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31c89653790so97961927b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 17:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqN1QHBzvti+0lVyyWV1S23p89qD8aBbro8MStNOt78=;
        b=kbpMYiA+iStsAIbT0nJKIuTEYxt/RBhcxYW8JmbvIGs3vZ40ppvr4mU4pVidRkbjVV
         a3/woskn+7+b3CVAclFOh92YbnuUepLn0IPqn4yACRL70ehZYOoa9Sk63lbq5OmUM7qu
         HsTYkr9kIq5Twitt/cPsdXqY4v4RrF2znvgJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqN1QHBzvti+0lVyyWV1S23p89qD8aBbro8MStNOt78=;
        b=XcGVCnhmo312CPvsCy71LjIHdedHoT2SPGNhZJa7QTJwYJgYdpxVImSp1T8gUGg4ph
         0xu23jsrkqM0ulsHoyGBVb8ZW7O+lJ+qKbChFtqgM8zPCLSGQAZUc7hvh4HlyLQHdMuX
         WKs8wjrM9d5wJL6SU41/Aqzx9SYjU+QrQpgn0wM8kDAlwJTazUfwbuk2fhmBFW/cRVO1
         oMVP7euOW4EZoUo5GexZh3bsgBYwXq962sh89MrxPUT7MAjDCivh9nXmnKiMXgdC4G/0
         6GrwyVRABbDYmspwAJGGaqNkqjBlleeUlnc+oKMgtHtyWJbrmrFgq6dnx1m0kydV5BDg
         JxKQ==
X-Gm-Message-State: AJIora/MTAIvkzK8DwxQ1SsPLGL8c9cfcWag8aVgZ6mEuTTshn5ZOcfV
        H2LWbQal0bwFAeaszbryBDVlwCjdkizO/JtqHs2R
X-Google-Smtp-Source: AGRyM1tt2J4Rz+9oIsBC4s4Tj6wg7vJS7LMWJaUkK/CkI/Z4pP6eZRLAOiwNr1AzlAeyVgsBljFFKBbd7/lUs6uU2Pg=
X-Received: by 2002:a81:9acd:0:b0:31d:2fd7:3331 with SMTP id
 r196-20020a819acd000000b0031d2fd73331mr1321961ywg.145.1657673975643; Tue, 12
 Jul 2022 17:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220711174632.4186047-1-atishp@rivosinc.com> <20220711174632.4186047-3-atishp@rivosinc.com>
 <CAJF2gTT=0S-_nCM-+SHUNkG0i-h1zBca_KwgRgsZ8BBE-DPG_w@mail.gmail.com>
In-Reply-To: <CAJF2gTT=0S-_nCM-+SHUNkG0i-h1zBca_KwgRgsZ8BBE-DPG_w@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 12 Jul 2022 17:59:25 -0700
Message-ID: <CAOnJCUKj5SU=wu6x1G4ZU-P1tK6uJUz79ZUcSV9jZZdbvwH3pA@mail.gmail.com>
Subject: Re: [v3 2/5] RISC-V: Update user page mapping only once during start
To:     Guo Ren <guoren@kernel.org>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 6:54 PM Guo Ren <guoren@kernel.org> wrote:
>
> Good catch, Is there any bug report?
>

Not that I know of.

> Anyway:
> Reviewed-by: Guo Ren <guoren@kernel.org>
>
>
> On Tue, Jul 12, 2022 at 1:46 AM Atish Patra <atishp@rivosinc.com> wrote:
> >
> > Currently, riscv_pmu_event_set_period updates the userpage mapping.
> > However, the caller of riscv_pmu_event_set_period should update
> > the userpage mapping because the counter can not be updated/started
> > from set_period function in counter overflow path.
> >
> > Invoke the perf_event_update_userpage at the caller so that it
> > doesn't get invoked twice during counter start path.
> >
> > Fixes: f5bfa23f576f ("RISC-V: Add a perf core library for pmu drivers")
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu.c     | 1 -
> >  drivers/perf/riscv_pmu_sbi.c | 1 +
> >  2 files changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
> > index b2b8d2074ed0..130b9f1a40e0 100644
> > --- a/drivers/perf/riscv_pmu.c
> > +++ b/drivers/perf/riscv_pmu.c
> > @@ -170,7 +170,6 @@ int riscv_pmu_event_set_period(struct perf_event *event)
> >                 left = (max_period >> 1);
> >
> >         local64_set(&hwc->prev_count, (u64)-left);
> > -       perf_event_update_userpage(event);
> >
> >         return overflow;
> >  }
> > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> > index 0cb694b794ae..3735337a4cfb 100644
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -532,6 +532,7 @@ static inline void pmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
> >                         sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
> >                                   flag, init_val, 0, 0);
> >  #endif
> > +                       perf_event_update_userpage(event);
> >                 }
> >                 ctr_ovf_mask = ctr_ovf_mask >> 1;
> >                 idx++;
> > --
> > 2.25.1
> >
>
>
> --
> Best Regards
>  Guo Ren



-- 
Regards,
Atish
