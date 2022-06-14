Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A1854B803
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345002AbiFNRtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344959AbiFNRtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:49:14 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537B933E33
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:49:12 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-30ec2aa3b6cso37312787b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b6GogiLvLlJyAw9fEai9KHL7CPWrIDSYkmrligLXeM0=;
        b=B+GgFxGSs58Fp+QAQlXmzpKdMTZABypU787d0qHLoDzxlJqoJ1k4nsrK+GLVFQ+4yb
         VOslI8mnRQ0TpcM6WUwdqCuagPSOtMOkoZw+N9XdOxR5RdGpaoCySoJRza5pOrlznLf8
         Qf8S94NeqjsFaIMJTAYxJ8xwx83GP+BwppPgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b6GogiLvLlJyAw9fEai9KHL7CPWrIDSYkmrligLXeM0=;
        b=P2Tx6v0c/bhH2L7++zui4JaB3/Nez8eSiWT0tOrBW+5CXIcL1MNvhuoatWMlxluq78
         UsRvxqc55K7R9qi6GYO6NQ5TnboLk4iFdYxp5AW7gV5wTXwaiDEosvFXiOV8/dMKsk+p
         +q+4LbQeKKjmkYBBYLqedGg9VVGlc9nKhRY+XZr+LAImMkOSRFZFV7Ueat5S7ygmI8wG
         97Lnkqtlkj6qU3A2CrtzQ6Ruijrt8dlrnoyMVjsL6Wmcspuj3vxCL0WQaL9MldpBfqKS
         2PWseCXui2wk5dpewz45ZscxqCR7ntnTHLvfNeDFQXSJIZAE8qyJG0Ut4fQbhvbMjnHK
         z1EQ==
X-Gm-Message-State: AJIora+SGAFGkZ9pKjzY+RvE8jCpIr0v6Bs8yJq30WixLnSsMhPdLZ02
        FveGuxkgUGZ804EaYN+ER/4cQrM37vsuuvPy+zQg
X-Google-Smtp-Source: AGRyM1sDcCfjFf4ocWAHLB7HhdEhMNAAc6F+Hg5b93YIV7qtybRZKmiB4D49bQzzzntxupZcf8hBdRtdbAb6gItu9r0=
X-Received: by 2002:a81:1c08:0:b0:30c:cb78:8ae2 with SMTP id
 c8-20020a811c08000000b0030ccb788ae2mr7150978ywc.194.1655228951516; Tue, 14
 Jun 2022 10:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220527042937.1124009-1-atishp@rivosinc.com> <20220527042937.1124009-4-atishp@rivosinc.com>
 <CAAhSdy3DXobZK-QSJ9tvG+hLEOD_dz4eqD7yO=Pna1ghhMghKQ@mail.gmail.com>
In-Reply-To: <CAAhSdy3DXobZK-QSJ9tvG+hLEOD_dz4eqD7yO=Pna1ghhMghKQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 14 Jun 2022 10:49:00 -0700
Message-ID: <CAOnJCUJgV8zBca+m8q2CrCLdkp3ycwVSn6bOUYyCodh1MUKVGA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] RISC-V: Prefer sstc extension if available
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atishp@rivosinc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
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

On Thu, Jun 9, 2022 at 9:41 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Fri, May 27, 2022 at 9:59 AM Atish Patra <atishp@rivosinc.com> wrote:
> >
> > RISC-V ISA has sstc extension which allows updating the next clock event
> > via a CSR (stimecmp) instead of an SBI call. This should happen dynamically
> > if sstc extension is available. Otherwise, it will fallback to SBI call
> > to maintain backward compatibility.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/clocksource/timer-riscv.c | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> > index 1767f8bf2013..881d9335c92d 100644
> > --- a/drivers/clocksource/timer-riscv.c
> > +++ b/drivers/clocksource/timer-riscv.c
> > @@ -7,6 +7,9 @@
> >   * either be read from the "time" and "timeh" CSRs, and can use the SBI to
> >   * setup events, or directly accessed using MMIO registers.
> >   */
> > +
> > +#define pr_fmt(fmt) "timer: " fmt
>
> The "timer: " prefix is too generic. I suggest to use "riscv-timer: "
> as a prefix.
>

Sured. Fixed in the next version.

> > +
> >  #include <linux/clocksource.h>
> >  #include <linux/clockchips.h>
> >  #include <linux/cpu.h>
> > @@ -23,11 +26,24 @@
> >  #include <asm/sbi.h>
> >  #include <asm/timex.h>
> >
> > +static DEFINE_STATIC_KEY_FALSE(riscv_sstc_available);
> > +
> >  static int riscv_clock_next_event(unsigned long delta,
> >                 struct clock_event_device *ce)
> >  {
> > +       u64 next_tval = get_cycles64() + delta;
> > +
> >         csr_set(CSR_IE, IE_TIE);
> > -       sbi_set_timer(get_cycles64() + delta);
> > +       if (static_branch_likely(&riscv_sstc_available)) {
> > +#if defined(CONFIG_32BIT)
> > +               csr_write(CSR_STIMECMP, next_tval & 0xFFFFFFFF);
> > +               csr_write(CSR_STIMECMPH, next_tval >> 32);
> > +#else
> > +               csr_write(CSR_STIMECMP, next_tval);
> > +#endif
> > +       } else
> > +               sbi_set_timer(next_tval);
> > +
> >         return 0;
> >  }
> >
> > @@ -165,6 +181,12 @@ static int __init riscv_timer_init_dt(struct device_node *n)
> >         if (error)
> >                 pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
> >                        error);
> > +
> > +       if (riscv_isa_extension_available(NULL, SSTC)) {
> > +               pr_info("Timer interrupt in S-mode is available via sstc extension\n");
> > +               static_branch_enable(&riscv_sstc_available);
> > +       }
> > +
> >         return error;
> >  }
> >
> > --
> > 2.25.1
> >
>
> Apart from the minor comment above, this looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup



-- 
Regards,
Atish
