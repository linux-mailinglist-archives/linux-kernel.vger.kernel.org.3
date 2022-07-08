Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815B756BA8C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237978AbiGHNTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiGHNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:19:32 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B7F275D7;
        Fri,  8 Jul 2022 06:19:31 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id e7so1620707qts.1;
        Fri, 08 Jul 2022 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JtDIuSDJgMHOnSZ7PDsNMgEqGS4IDU10U0hH9sHl3tg=;
        b=F1TT9/4N2rf2mudIbCeIRjEmhB/dOOSNMlAnJije4cTLlMr+FJ96dYAM3lSjRN82Fn
         5phQrraQEKfjUbDlb2u08NXgt4TDCjj9vbuvnJ2SyivezzJxr3FYhYouCxzVqIWPYfYW
         kI8p2+w2VA1XVe0uwwkP2s4Q1+KKicxu7LYfQymp7H4TTECwVWMWpj9lEhEZwX6StSYO
         0T1M9bS9eY27tmsDZKaHxYY592yn5PkQ57uyQ8Nt0K9DjpU9ZgJDvZ7IsNkafjWiFqf9
         u/BOHf3LNPoqR548ZyHd3pk9jyMgHaPHVj2fJbw3ZXFJ3BKJqb6dNlng4aH/ZckF+8+b
         2DZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JtDIuSDJgMHOnSZ7PDsNMgEqGS4IDU10U0hH9sHl3tg=;
        b=XPzMYq3XMRr7QOlMLgNhJysAsm4Pr6ccg50dw0j0eofSAkOCFUqqPjK/1m7bAucdAd
         i/uyRgrSQiwtNZQdPFetp7TuGh84ZwlU9LycfW8qD/UbpOkFui3LuidjwgRgwIzshylD
         KWHWvU2ma5dzYOaQGTQeBsRj9hoXr+3EiFuev2lYQbHbzoLpz+7amGWgcYFI0XI0eJQY
         vz3954YMGUCm7uDV+O2XTh8Ghn19V3OlIhQyKQWpzzMZDTJR63OCJaSF9/vxEc4c7V9o
         Ndh/0p6neOabYG8v7zwb3C3LG55mEB/hUN5yJHzBdprtRG8jNgC3cM+9dKuVx1xPNTfc
         f3gg==
X-Gm-Message-State: AJIora8LJmBdq3bfpmdZxVP39FtudiUnSAkUs31XRrhgYFnVAQLhV6Qz
        IdyAM5+EuftdhhfME3w6x5fodCVohzucJbD4y7ewy0gGe0E=
X-Google-Smtp-Source: AGRyM1tOJmb8x3r+oLBvKHiggRAd8q9ZzGU7GGBH5P9GK5C4c87aPPF8+j7O07cl13llleHzkRCaPLfYivNLIdaYh0M=
X-Received: by 2002:ac8:5dcb:0:b0:31d:42c8:95d7 with SMTP id
 e11-20020ac85dcb000000b0031d42c895d7mr2859884qtx.546.1657286370465; Fri, 08
 Jul 2022 06:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220705191017.1683716-1-robimarko@gmail.com> <fa748405-ca38-8ec8-0e8d-83a99a0c9c57@somainline.org>
In-Reply-To: <fa748405-ca38-8ec8-0e8d-83a99a0c9c57@somainline.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 8 Jul 2022 15:19:19 +0200
Message-ID: <CAOX2RU4bpd5xAMA-2wFWW9iypbqijkhnwkLZ_gqBorCkyuKegQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] clk: qcom: clk-alpha-pll: add support for APSS PLL
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2022 at 15:14, Konrad Dybcio <konrad.dybcio@somainline.org> wrote:
>
>
>
> On 5.07.2022 21:10, Robert Marko wrote:
> > APSS PLL type will be used by the IPQ8074 APSS driver for providing the
> > CPU core clocks and enabling CPU Frequency scaling.
> >
> > This is ported from the downstream 5.4 kernel.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  drivers/clk/qcom/clk-alpha-pll.c | 12 ++++++++++++
> >  drivers/clk/qcom/clk-alpha-pll.h |  1 +
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> > index 4406cf609aae..8270363ff98e 100644
> > --- a/drivers/clk/qcom/clk-alpha-pll.c
> > +++ b/drivers/clk/qcom/clk-alpha-pll.c
> > @@ -154,6 +154,18 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
> >               [PLL_OFF_TEST_CTL_U] = 0x30,
> >               [PLL_OFF_TEST_CTL_U1] = 0x34,
> >       },
> > +     [CLK_ALPHA_PLL_TYPE_APSS] = {
> The name is surely not correct, can somebody from qcom chime in
> and suggest what it should be?

Hi Konrad,
That is how Qualcomm refers to the type in the downstream 4.4 and 5.4 kernels.
I dont have any other reference to the name unless somebody from
Qualcomm can chime in.

Regards,
Robert
>
> Konrad
> > +             [PLL_OFF_L_VAL] = 0x08,
> > +             [PLL_OFF_ALPHA_VAL] = 0x10,
> > +             [PLL_OFF_ALPHA_VAL_U] = 0xff,
> > +             [PLL_OFF_USER_CTL] = 0x18,
> > +             [PLL_OFF_USER_CTL_U] = 0xff,
> > +             [PLL_OFF_CONFIG_CTL] = 0x20,
> > +             [PLL_OFF_CONFIG_CTL_U] = 0x24,
> > +             [PLL_OFF_TEST_CTL] = 0x30,
> > +             [PLL_OFF_TEST_CTL_U] = 0x34,
> > +             [PLL_OFF_STATUS] = 0x28,
> > +     },
> >  };
> >  EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
> >
> > diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> > index 6e9907deaf30..626fdf80336d 100644
> > --- a/drivers/clk/qcom/clk-alpha-pll.h
> > +++ b/drivers/clk/qcom/clk-alpha-pll.h
> > @@ -18,6 +18,7 @@ enum {
> >       CLK_ALPHA_PLL_TYPE_AGERA,
> >       CLK_ALPHA_PLL_TYPE_ZONDA,
> >       CLK_ALPHA_PLL_TYPE_LUCID_EVO,
> > +     CLK_ALPHA_PLL_TYPE_APSS,
> >       CLK_ALPHA_PLL_TYPE_MAX,
> >  };
> >
