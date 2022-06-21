Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1E2553BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354309AbiFUUnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354315AbiFUUnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:43:25 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF0B1EED4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:43:22 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d128so11073066qkg.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtpCQnbPei5i3Chjiqws4cfZt7ZHazzgd2kv6G7CTAQ=;
        b=wSysnFkP6NkiVmtaKk472hJcX7JCuqQopnlk3wGRrdS8MXXCHSFcxo8VNl8+QmZMfs
         rARH9Sg/qJyN/ihl4SmqsFdFKMncuD9lRqE+rky1fajh648gt/iC7Pwu2mVsfqbr6ghQ
         xY7s1UI8RejGeaJ2GeUK+ICQezKEFErL3bqJ8JY2IG6uHfZgNz1xWyEnx29WDHvONwIa
         j2/mljx9WitO0PIZFUM/Y92PY2BLpOpvZ887HnM7NnDoMN7mKyZO8sxw+2LYuU12hrdd
         rt6fiDdRGvE5qUw+cD3Nejvs8h0dDhRDKw3bnqDm+PbDf54fCCzMNR3cIesqogGvwvcA
         dJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtpCQnbPei5i3Chjiqws4cfZt7ZHazzgd2kv6G7CTAQ=;
        b=QgDkrq+uGwhyaaKkSe6abJuqCDasvypenKoywKlXUYZ8+YMOK9JJF6oiNDVg93Lw0Y
         dTCRggBCLj0kTeidGdaDDDlPm0zI6+st71PTKRRE5uXKI+iYwDnDDAtpt9L51qbay0xv
         Qkt57TOk8wEvzloZE9hfRChfcfUc9QnFrH/w4W2LpQIbd5MFoUcsVn7NJTcV/3R5eAb4
         IsVdT1/bbhTwE+dAtds9DLYgI9ELyDy8LWDDmBx+s8e4Gcc2grMTmRolATRVfde5r5pL
         te9ZuFeWdyoPBU/M7rCFJ36BUFZ8i3fUKhMZGCfzmtNPzSLLBnQ52ptaGxPeWCtLK0GL
         hD7g==
X-Gm-Message-State: AJIora9LllcBu6u0OeRBu83R3ROYifcXPnW/f9qumhiE/hxJxTP3SUZP
        nUxWWxVGnjllrjLQmOvn9wBygocT5VAhWjPlH4/flTbReBQd4Q==
X-Google-Smtp-Source: AGRyM1sT8t1roxOoy78scxFjhcppZd6dpo+9QF4yRJwojcldHoGPBK0qr5h4F8qxdANge5zsjzDj3AJxuq8bYOIoFPQ=
X-Received: by 2002:a05:620a:4305:b0:6a9:3829:c03 with SMTP id
 u5-20020a05620a430500b006a938290c03mr21461205qko.363.1655844201566; Tue, 21
 Jun 2022 13:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220621163326.16858-1-ansuelsmth@gmail.com> <20220621163326.16858-3-ansuelsmth@gmail.com>
 <CAA8EJpqQTTevQa4pQg3E+x4_AOjYo8ajOqUrfwGsVtC8N=bpOw@mail.gmail.com> <62b228b6.1c69fb81.e4673.34a2@mx.google.com>
In-Reply-To: <62b228b6.1c69fb81.e4673.34a2@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Jun 2022 23:43:10 +0300
Message-ID: <CAA8EJprb=xV9+gZMANAYrt_JnKAtC89h1RAosL+g517_-Ugd2g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] clk: qcom: lcc-ipq806x: convert to parent data
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 23:23, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Tue, Jun 21, 2022 at 08:15:57PM +0300, Dmitry Baryshkov wrote:
> > On Tue, 21 Jun 2022 at 19:33, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > >
> > > Convert lcc-ipq806x driver to parent_data API.
> > >
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > > v2:
> > > - Fix Sob tag
> > >
> > >  drivers/clk/qcom/lcc-ipq806x.c | 79 +++++++++++++++++++---------------
> > >  1 file changed, 44 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
> > > index ba90bebba597..c07ca8dc6e3a 100644
> > > --- a/drivers/clk/qcom/lcc-ipq806x.c
> > > +++ b/drivers/clk/qcom/lcc-ipq806x.c
> > > @@ -24,6 +24,10 @@
> > >  #include "clk-regmap-mux.h"
> > >  #include "reset.h"
> > >
> > > +static const struct clk_parent_data gcc_pxo[] = {
> > > +       { .fw_name = "pxo", .name = "pxo" },
> >
> > I think you'd use .name = "pxo_board" here. You don't need to use the
> > interim clock.
> >
>
> In gcc and in the rest of this driver we use pxo. Wonder what is right?

I'd use .fw_name = "pxo", .name = "pxo_board", like the rest of drivers do.

>
> > > +};
> > > +
> > >  static struct clk_pll pll4 = {
> > >         .l_reg = 0x4,
> > >         .m_reg = 0x8,
> > > @@ -34,7 +38,7 @@ static struct clk_pll pll4 = {
> > >         .status_bit = 16,
> > >         .clkr.hw.init = &(struct clk_init_data){
> > >                 .name = "pll4",
> > > -               .parent_names = (const char *[]){ "pxo" },
> > > +               .parent_data = gcc_pxo,
> > >                 .num_parents = 1,
> >
> > Could you please either inline the gcc_pxo here (yes, it's ugly, but
> > it works for small arrays) or use ARRAY_SIZE here.
> >
>
> Yes will inline gcc_pxo.
>
> > >                 .ops = &clk_pll_ops,
> > >         },
> > > @@ -64,9 +68,9 @@ static const struct parent_map lcc_pxo_pll4_map[] = {
> > >         { P_PLL4, 2 }
> > >  };
> > >
> > > -static const char * const lcc_pxo_pll4[] = {
> > > -       "pxo",
> > > -       "pll4_vote",
> > > +static const struct clk_parent_data lcc_pxo_pll4[] = {
> > > +       { .fw_name = "pxo", .name = "pxo" },
> > > +       { .fw_name = "pll4_vote", .name = "pll4_vote" },
> > >  };
> > >
> > >  static struct freq_tbl clk_tbl_aif_mi2s[] = {
> > > @@ -131,18 +135,14 @@ static struct clk_rcg mi2s_osr_src = {
> > >                 .enable_mask = BIT(9),
> > >                 .hw.init = &(struct clk_init_data){
> > >                         .name = "mi2s_osr_src",
> > > -                       .parent_names = lcc_pxo_pll4,
> > > -                       .num_parents = 2,
> > > +                       .parent_data = lcc_pxo_pll4,
> > > +                       .num_parents = ARRAY_SIZE(lcc_pxo_pll4),
> > >                         .ops = &clk_rcg_ops,
> > >                         .flags = CLK_SET_RATE_GATE,
> > >                 },
> > >         },
> > >  };
> > >
> > > -static const char * const lcc_mi2s_parents[] = {
> > > -       "mi2s_osr_src",
> > > -};
> > > -
> > >  static struct clk_branch mi2s_osr_clk = {
> > >         .halt_reg = 0x50,
> > >         .halt_bit = 1,
> > > @@ -152,7 +152,9 @@ static struct clk_branch mi2s_osr_clk = {
> > >                 .enable_mask = BIT(17),
> > >                 .hw.init = &(struct clk_init_data){
> > >                         .name = "mi2s_osr_clk",
> > > -                       .parent_names = lcc_mi2s_parents,
> > > +                       .parent_hws = (const struct clk_hw*[]){
> > > +                               &mi2s_osr_src.clkr.hw,
> > > +                       },
> > >                         .num_parents = 1,
> > >                         .ops = &clk_branch_ops,
> > >                         .flags = CLK_SET_RATE_PARENT,
> > > @@ -167,7 +169,9 @@ static struct clk_regmap_div mi2s_div_clk = {
> > >         .clkr = {
> > >                 .hw.init = &(struct clk_init_data){
> > >                         .name = "mi2s_div_clk",
> > > -                       .parent_names = lcc_mi2s_parents,
> > > +                       .parent_hws = (const struct clk_hw*[]){
> > > +                               &mi2s_osr_src.clkr.hw,
> > > +                       },
> > >                         .num_parents = 1,
> > >                         .ops = &clk_regmap_div_ops,
> > >                 },
> > > @@ -183,7 +187,9 @@ static struct clk_branch mi2s_bit_div_clk = {
> > >                 .enable_mask = BIT(15),
> > >                 .hw.init = &(struct clk_init_data){
> > >                         .name = "mi2s_bit_div_clk",
> > > -                       .parent_names = (const char *[]){ "mi2s_div_clk" },
> > > +                       .parent_hws = (const struct clk_hw*[]){
> > > +                               &mi2s_div_clk.clkr.hw,
> > > +                       },
> > >                         .num_parents = 1,
> > >                         .ops = &clk_branch_ops,
> > >                         .flags = CLK_SET_RATE_PARENT,
> > > @@ -191,6 +197,10 @@ static struct clk_branch mi2s_bit_div_clk = {
> > >         },
> > >  };
> > >
> > > +static const struct clk_parent_data lcc_mi2s_bit_div_codec_clk[] = {
> > > +       { .hw = &mi2s_bit_div_clk.clkr.hw, },
> > > +       { .fw_name = "mi2s_codec_clk", .name = "mi2s_codec_clk" },
> > > +};
> > >
> > >  static struct clk_regmap_mux mi2s_bit_clk = {
> > >         .reg = 0x48,
> > > @@ -199,11 +209,8 @@ static struct clk_regmap_mux mi2s_bit_clk = {
> > >         .clkr = {
> > >                 .hw.init = &(struct clk_init_data){
> > >                         .name = "mi2s_bit_clk",
> > > -                       .parent_names = (const char *[]){
> > > -                               "mi2s_bit_div_clk",
> > > -                               "mi2s_codec_clk",
> > > -                       },
> > > -                       .num_parents = 2,
> > > +                       .parent_data = lcc_mi2s_bit_div_codec_clk,
> > > +                       .num_parents = ARRAY_SIZE(lcc_mi2s_bit_div_codec_clk),
> > >                         .ops = &clk_regmap_mux_closest_ops,
> > >                         .flags = CLK_SET_RATE_PARENT,
> > >                 },
> > > @@ -245,8 +252,8 @@ static struct clk_rcg pcm_src = {
> > >                 .enable_mask = BIT(9),
> > >                 .hw.init = &(struct clk_init_data){
> > >                         .name = "pcm_src",
> > > -                       .parent_names = lcc_pxo_pll4,
> > > -                       .num_parents = 2,
> > > +                       .parent_data = lcc_pxo_pll4,
> > > +                       .num_parents = ARRAY_SIZE(lcc_pxo_pll4),
> > >                         .ops = &clk_rcg_ops,
> > >                         .flags = CLK_SET_RATE_GATE,
> > >                 },
> > > @@ -262,7 +269,9 @@ static struct clk_branch pcm_clk_out = {
> > >                 .enable_mask = BIT(11),
> > >                 .hw.init = &(struct clk_init_data){
> > >                         .name = "pcm_clk_out",
> > > -                       .parent_names = (const char *[]){ "pcm_src" },
> > > +                       .parent_hws = (const struct clk_hw*[]){
> > > +                               &pcm_src.clkr.hw,
> > > +                       },
> > >                         .num_parents = 1,
> > >                         .ops = &clk_branch_ops,
> > >                         .flags = CLK_SET_RATE_PARENT,
> > > @@ -270,6 +279,11 @@ static struct clk_branch pcm_clk_out = {
> > >         },
> > >  };
> > >
> > > +static const struct clk_parent_data lcc_pcm_clk_out_codec_clk[] = {
> > > +       { .hw = &pcm_clk_out.clkr.hw, },
> > > +       { .fw_name = "pcm_codec_clk", .name = "pcm_codec_clk" },
> > > +};
> > > +
> > >  static struct clk_regmap_mux pcm_clk = {
> > >         .reg = 0x54,
> > >         .shift = 10,
> > > @@ -277,11 +291,8 @@ static struct clk_regmap_mux pcm_clk = {
> > >         .clkr = {
> > >                 .hw.init = &(struct clk_init_data){
> > >                         .name = "pcm_clk",
> > > -                       .parent_names = (const char *[]){
> > > -                               "pcm_clk_out",
> > > -                               "pcm_codec_clk",
> > > -                       },
> > > -                       .num_parents = 2,
> > > +                       .parent_data = lcc_pcm_clk_out_codec_clk,
> > > +                       .num_parents = ARRAY_SIZE(lcc_pcm_clk_out_codec_clk),
> > >                         .ops = &clk_regmap_mux_closest_ops,
> > >                         .flags = CLK_SET_RATE_PARENT,
> > >                 },
> > > @@ -325,18 +336,14 @@ static struct clk_rcg spdif_src = {
> > >                 .enable_mask = BIT(9),
> > >                 .hw.init = &(struct clk_init_data){
> > >                         .name = "spdif_src",
> > > -                       .parent_names = lcc_pxo_pll4,
> > > -                       .num_parents = 2,
> > > +                       .parent_data = lcc_pxo_pll4,
> > > +                       .num_parents = ARRAY_SIZE(lcc_pxo_pll4),
> > >                         .ops = &clk_rcg_ops,
> > >                         .flags = CLK_SET_RATE_GATE,
> > >                 },
> > >         },
> > >  };
> > >
> > > -static const char * const lcc_spdif_parents[] = {
> > > -       "spdif_src",
> > > -};
> > > -
> > >  static struct clk_branch spdif_clk = {
> > >         .halt_reg = 0xd4,
> > >         .halt_bit = 1,
> > > @@ -346,7 +353,9 @@ static struct clk_branch spdif_clk = {
> > >                 .enable_mask = BIT(12),
> > >                 .hw.init = &(struct clk_init_data){
> > >                         .name = "spdif_clk",
> > > -                       .parent_names = lcc_spdif_parents,
> > > +                       .parent_hws = (const struct clk_hw*[]){
> > > +                               &spdif_src.clkr.hw,
> > > +                       },
> > >                         .num_parents = 1,
> > >                         .ops = &clk_branch_ops,
> > >                         .flags = CLK_SET_RATE_PARENT,
> > > @@ -384,8 +393,8 @@ static struct clk_rcg ahbix_clk = {
> > >                 .enable_mask = BIT(11),
> > >                 .hw.init = &(struct clk_init_data){
> > >                         .name = "ahbix",
> > > -                       .parent_names = lcc_pxo_pll4,
> > > -                       .num_parents = 2,
> > > +                       .parent_data = lcc_pxo_pll4,
> > > +                       .num_parents = ARRAY_SIZE(lcc_pxo_pll4),
> > >                         .ops = &clk_rcg_lcc_ops,
> > >                 },
> > >         },
> > > --
> > > 2.36.1
> > >
> >
> >
> > --
> > With best wishes
> > Dmitry
>
> --
>         Ansuel



-- 
With best wishes
Dmitry
