Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25746577825
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 22:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiGQULR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 16:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiGQULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 16:11:16 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B95631B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:11:13 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id m10so3613466qvu.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PigXQwKM0HFVf977KpJSmEmDxCSJ/94yMR8JWMEuSKA=;
        b=XGsblwnKyTOHGD+NCSzwrCwIrW3uo8gEMmxRfTEImmCf4UQf281/Iz8nE8qoeVSISh
         g+Urw2+uGfabP/rwLmK3GsIcpTA78qLbgkLHbKaK/LZ6xv/cu2Ddxck8u2Jpo2Dj/Y1I
         IPEfYA8rTP4FQqePDLXMqCfUm+bUSwpEZxu/128HJE1l5rX6HXVyi/qok9pWd/d3Wj3o
         suhRcEWruo5GX40SxMGAXHJjJigoKFO5xM6it10VDCNYpw+CH6nsIJ172cn3e3JJ6y56
         Vo3FJggCPBFqx1L8BJ9LuX5QbbqVsMI7RjkmPfWJHKK5yEbPOnGcG6lGnnYMgzqLw4pt
         W7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PigXQwKM0HFVf977KpJSmEmDxCSJ/94yMR8JWMEuSKA=;
        b=NtQap/Yh8rWA7J1HT/fUDewS8kHmQoS7vnh4C+im3aOAiDIJ5hXlPfba5kk07oavSB
         xYA4lkQ4VcLcVBCh8ado03SaZ8V/n3k0FxRR9aULzUehorEu/LGgnBH/cXEzd71+Ur36
         SchdEXmI96ZPWgW5IZMUlyeINT+X6TfeIdyphsASq+2fJPBKF4Rega7OeyKA3NuhiEvK
         bLi6GsShYxUT1gNlkpRZ/YPyGrZG0sw2/wv5Akxp9vIc0Vg/cC25KOTaZNARAMdpIQ4j
         fXS/K26T66RoVFvUe47e7Xm1GD4TQbZKNzbRwdjuUvd2wtBd51ltxZzhGduFxjYT0JhA
         X5tw==
X-Gm-Message-State: AJIora8cwsJTHkMayLAzvX3jfRew2sWmr9kKww9OSNK0m8jItE/waX0O
        vlKeOYQmcwJ8nybsGvcE7YKt+GTw5fybJtAx37SlVw==
X-Google-Smtp-Source: AGRyM1u8+W8I9UXM+TPZAI1GxZM+CKGG6bJ3LlrO8Ax0BlTKV10aRJr+uq4nd8moWqlfrW1Oc5tOU0uygG/Skot3HUA=
X-Received: by 2002:a05:6214:d03:b0:473:7764:2ab with SMTP id
 3-20020a0562140d0300b00473776402abmr18366070qvh.119.1658088672281; Sun, 17
 Jul 2022 13:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220713143200.3686765-1-abel.vesa@linaro.org> <YtOOYryxh9oEJXyg@builder.lan>
In-Reply-To: <YtOOYryxh9oEJXyg@builder.lan>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 17 Jul 2022 23:11:01 +0300
Message-ID: <CAA8EJprbnckZSR7v172x0CAKRTieG6JHdC+Xc-12xM=kBfa0EA@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: Drop mmcx gdsc supply for dispcc and videocc
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2022 at 07:21, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Wed 13 Jul 09:32 CDT 2022, Abel Vesa wrote:
>
> > Both dispcc and videocc use mmcx power domain now.
> > Lets drop the supply mmcx from every gdsc.
> >
> > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Fixes: 266e5cf39a0f ("arm64: dts: qcom: sm8250: remove mmcx regulator")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>
> This would break backwards compatibility with dtbs that used
> mmcx-supply. We only ever used mmcx-supply in sm8250.dtsi upstream and
> given that we only boot sm8250 off Android boot images it's unlikely
> that anyone would use a new kernel with that old of a dtb...
>
> So:
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Dmitry, what do you think?

I think it's fine.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Regards,
> Bjorn
>
> > ---
> >  drivers/clk/qcom/dispcc-sm8250.c  | 1 -
> >  drivers/clk/qcom/videocc-sm8250.c | 4 ----
> >  2 files changed, 5 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
> > index 39b344ebb049..709076f0f9d7 100644
> > --- a/drivers/clk/qcom/dispcc-sm8250.c
> > +++ b/drivers/clk/qcom/dispcc-sm8250.c
> > @@ -1138,7 +1138,6 @@ static struct gdsc mdss_gdsc = {
> >       },
> >       .pwrsts = PWRSTS_OFF_ON,
> >       .flags = HW_CTRL,
> > -     .supply = "mmcx",
> >  };
> >
> >  static struct clk_regmap *disp_cc_sm8250_clocks[] = {
> > diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
> > index 8617454e4a77..f28f2cb051d7 100644
> > --- a/drivers/clk/qcom/videocc-sm8250.c
> > +++ b/drivers/clk/qcom/videocc-sm8250.c
> > @@ -277,7 +277,6 @@ static struct gdsc mvs0c_gdsc = {
> >       },
> >       .flags = 0,
> >       .pwrsts = PWRSTS_OFF_ON,
> > -     .supply = "mmcx",
> >  };
> >
> >  static struct gdsc mvs1c_gdsc = {
> > @@ -287,7 +286,6 @@ static struct gdsc mvs1c_gdsc = {
> >       },
> >       .flags = 0,
> >       .pwrsts = PWRSTS_OFF_ON,
> > -     .supply = "mmcx",
> >  };
> >
> >  static struct gdsc mvs0_gdsc = {
> > @@ -297,7 +295,6 @@ static struct gdsc mvs0_gdsc = {
> >       },
> >       .flags = HW_CTRL,
> >       .pwrsts = PWRSTS_OFF_ON,
> > -     .supply = "mmcx",
> >  };
> >
> >  static struct gdsc mvs1_gdsc = {
> > @@ -307,7 +304,6 @@ static struct gdsc mvs1_gdsc = {
> >       },
> >       .flags = HW_CTRL,
> >       .pwrsts = PWRSTS_OFF_ON,
> > -     .supply = "mmcx",
> >  };
> >
> >  static struct clk_regmap *video_cc_sm8250_clocks[] = {
> > --
> > 2.34.3
> >



-- 
With best wishes
Dmitry
