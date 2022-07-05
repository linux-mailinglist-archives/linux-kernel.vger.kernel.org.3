Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2ED56789F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiGEUsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiGEUsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:48:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7A7DFC9;
        Tue,  5 Jul 2022 13:48:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z41so16851513ede.1;
        Tue, 05 Jul 2022 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=MRsqnkg6Sw0lDh66QHOBAyWH6VLBpScway/9RQJ7qxU=;
        b=H3lXiY+EIjJMVj7CScumQ/Cd6ayOLJ5AtrfmyqAoq11ZFqrbrxGepYeoTbSc8iW1RP
         QqdKU3CAhCX1ZgHzzgXi1v+YZ/Zipe5Bsb+23k5h0wBqGC7/QRM87djSI6Fxwk0ZEo3A
         PKCmKIdwkcZ01LrgXoIRNkUUVS47EhhKEdy5ADw3P8ooBig5YUEsAFGF5iaIvRNXDyG/
         2bMb4EGr1bAmVA1odYQ+bJHGnO6tjTCvfDBeKOTeMcy/KUSRuZrgE4pzP0h6pephrthb
         5l8KZXHoPmSNvmVPEFN76Yn7aq02kCsnIWVgl0jrXMddCbhyLuIE3M1ZNjlotmVqSiKP
         XUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=MRsqnkg6Sw0lDh66QHOBAyWH6VLBpScway/9RQJ7qxU=;
        b=DJmYV1fW1bUhtz29QfvnLrBAxggvPDr4w1XMfvuQGJt0kzrZoDrUgBGeI8Q0QYN3JB
         0a9KqxSFfEyOcj4CSSq1ppkP+KgwzokfR7+qIsUVJHnWB4BIgrxzrI6Cx07HTz0w/Sa+
         w6qOdy7Gj1PtSqllEDnGXh6JNYxpzjPb3p+gyutkfILDJF3ZE1UyRuMUL8T0O1jvJfyP
         u0dF3HgoOiO8T8S/ZgZEjeiKZHI0VSFTP4AHdbrIltsnVBNhNs1Q8U9e1U3zdtZK15wx
         gFgP+sbMmmjKnE7TGmo1mXzP/j/13KMtnk8u0VDNEcm0WyeG45rPpi6wMhb8pAzjBFm3
         X0eQ==
X-Gm-Message-State: AJIora83CkBw1mVcdXyNkEs7vt3z9lIs7vuvG6cp0CFL0tg2qTAjvl7a
        D9bAV0lrTzzsH/iWtPbWHJs=
X-Google-Smtp-Source: AGRyM1uJhz9IaRkKTfd0o3g3oAhpbPpOmCNTXEaMtw2mOYL9lRYjzcPipB6Gikg3DUrxyj8Cmz4HTw==
X-Received: by 2002:a05:6402:b9b:b0:43a:5aac:ed6 with SMTP id cf27-20020a0564020b9b00b0043a5aac0ed6mr16203459edb.131.1657054091833;
        Tue, 05 Jul 2022 13:48:11 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id hx23-20020a170906847700b00722e84c3d44sm16227104ejc.118.2022.07.05.13.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:48:11 -0700 (PDT)
Message-ID: <62c4a38b.1c69fb81.4d58e.ce99@mx.google.com>
X-Google-Original-Message-ID: <YsSdPdW8zTSL3nki@Ansuel-xps.>
Date:   Tue, 5 Jul 2022 22:21:17 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] clk: qcom: lcc-ipq806x: convert to parent data
References: <20220621163326.16858-1-ansuelsmth@gmail.com>
 <20220621163326.16858-3-ansuelsmth@gmail.com>
 <CAA8EJpqQTTevQa4pQg3E+x4_AOjYo8ajOqUrfwGsVtC8N=bpOw@mail.gmail.com>
 <62b228b6.1c69fb81.e4673.34a2@mx.google.com>
 <CAA8EJprb=xV9+gZMANAYrt_JnKAtC89h1RAosL+g517_-Ugd2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprb=xV9+gZMANAYrt_JnKAtC89h1RAosL+g517_-Ugd2g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 11:43:10PM +0300, Dmitry Baryshkov wrote:
> On Tue, 21 Jun 2022 at 23:23, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Tue, Jun 21, 2022 at 08:15:57PM +0300, Dmitry Baryshkov wrote:
> > > On Tue, 21 Jun 2022 at 19:33, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > Convert lcc-ipq806x driver to parent_data API.
> > > >
> > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > ---
> > > > v2:
> > > > - Fix Sob tag
> > > >
> > > >  drivers/clk/qcom/lcc-ipq806x.c | 79 +++++++++++++++++++---------------
> > > >  1 file changed, 44 insertions(+), 35 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
> > > > index ba90bebba597..c07ca8dc6e3a 100644
> > > > --- a/drivers/clk/qcom/lcc-ipq806x.c
> > > > +++ b/drivers/clk/qcom/lcc-ipq806x.c
> > > > @@ -24,6 +24,10 @@
> > > >  #include "clk-regmap-mux.h"
> > > >  #include "reset.h"
> > > >
> > > > +static const struct clk_parent_data gcc_pxo[] = {
> > > > +       { .fw_name = "pxo", .name = "pxo" },
> > >
> > > I think you'd use .name = "pxo_board" here. You don't need to use the
> > > interim clock.
> > >
> >
> > In gcc and in the rest of this driver we use pxo. Wonder what is right?
> 
> I'd use .fw_name = "pxo", .name = "pxo_board", like the rest of drivers do.
>

Will do the change, but I need an explaination... Is the use of
pxo_board correct?

I'm sending a patch that sets the pxo_board fixed clock in dts to output
"pxo". The only clock that still use pxo_board is rpm, everything else
at least for ipq806x use pxo and i'm sending a patch to use pxo for rpm.

Considering pxo is always present and pxo_board should be dropped
because every ipq806x driver use "pxo".

What is correct naming pxo or pxo_board? I assume pxo right?

> >
> > > > +};
> > > > +
> > > >  static struct clk_pll pll4 = {
> > > >         .l_reg = 0x4,
> > > >         .m_reg = 0x8,
> > > > @@ -34,7 +38,7 @@ static struct clk_pll pll4 = {
> > > >         .status_bit = 16,
> > > >         .clkr.hw.init = &(struct clk_init_data){
> > > >                 .name = "pll4",
> > > > -               .parent_names = (const char *[]){ "pxo" },
> > > > +               .parent_data = gcc_pxo,
> > > >                 .num_parents = 1,
> > >
> > > Could you please either inline the gcc_pxo here (yes, it's ugly, but
> > > it works for small arrays) or use ARRAY_SIZE here.
> > >
> >
> > Yes will inline gcc_pxo.
> >
> > > >                 .ops = &clk_pll_ops,
> > > >         },
> > > > @@ -64,9 +68,9 @@ static const struct parent_map lcc_pxo_pll4_map[] = {
> > > >         { P_PLL4, 2 }
> > > >  };
> > > >
> > > > -static const char * const lcc_pxo_pll4[] = {
> > > > -       "pxo",
> > > > -       "pll4_vote",
> > > > +static const struct clk_parent_data lcc_pxo_pll4[] = {
> > > > +       { .fw_name = "pxo", .name = "pxo" },
> > > > +       { .fw_name = "pll4_vote", .name = "pll4_vote" },
> > > >  };
> > > >
> > > >  static struct freq_tbl clk_tbl_aif_mi2s[] = {
> > > > @@ -131,18 +135,14 @@ static struct clk_rcg mi2s_osr_src = {
> > > >                 .enable_mask = BIT(9),
> > > >                 .hw.init = &(struct clk_init_data){
> > > >                         .name = "mi2s_osr_src",
> > > > -                       .parent_names = lcc_pxo_pll4,
> > > > -                       .num_parents = 2,
> > > > +                       .parent_data = lcc_pxo_pll4,
> > > > +                       .num_parents = ARRAY_SIZE(lcc_pxo_pll4),
> > > >                         .ops = &clk_rcg_ops,
> > > >                         .flags = CLK_SET_RATE_GATE,
> > > >                 },
> > > >         },
> > > >  };
> > > >
> > > > -static const char * const lcc_mi2s_parents[] = {
> > > > -       "mi2s_osr_src",
> > > > -};
> > > > -
> > > >  static struct clk_branch mi2s_osr_clk = {
> > > >         .halt_reg = 0x50,
> > > >         .halt_bit = 1,
> > > > @@ -152,7 +152,9 @@ static struct clk_branch mi2s_osr_clk = {
> > > >                 .enable_mask = BIT(17),
> > > >                 .hw.init = &(struct clk_init_data){
> > > >                         .name = "mi2s_osr_clk",
> > > > -                       .parent_names = lcc_mi2s_parents,
> > > > +                       .parent_hws = (const struct clk_hw*[]){
> > > > +                               &mi2s_osr_src.clkr.hw,
> > > > +                       },
> > > >                         .num_parents = 1,
> > > >                         .ops = &clk_branch_ops,
> > > >                         .flags = CLK_SET_RATE_PARENT,
> > > > @@ -167,7 +169,9 @@ static struct clk_regmap_div mi2s_div_clk = {
> > > >         .clkr = {
> > > >                 .hw.init = &(struct clk_init_data){
> > > >                         .name = "mi2s_div_clk",
> > > > -                       .parent_names = lcc_mi2s_parents,
> > > > +                       .parent_hws = (const struct clk_hw*[]){
> > > > +                               &mi2s_osr_src.clkr.hw,
> > > > +                       },
> > > >                         .num_parents = 1,
> > > >                         .ops = &clk_regmap_div_ops,
> > > >                 },
> > > > @@ -183,7 +187,9 @@ static struct clk_branch mi2s_bit_div_clk = {
> > > >                 .enable_mask = BIT(15),
> > > >                 .hw.init = &(struct clk_init_data){
> > > >                         .name = "mi2s_bit_div_clk",
> > > > -                       .parent_names = (const char *[]){ "mi2s_div_clk" },
> > > > +                       .parent_hws = (const struct clk_hw*[]){
> > > > +                               &mi2s_div_clk.clkr.hw,
> > > > +                       },
> > > >                         .num_parents = 1,
> > > >                         .ops = &clk_branch_ops,
> > > >                         .flags = CLK_SET_RATE_PARENT,
> > > > @@ -191,6 +197,10 @@ static struct clk_branch mi2s_bit_div_clk = {
> > > >         },
> > > >  };
> > > >
> > > > +static const struct clk_parent_data lcc_mi2s_bit_div_codec_clk[] = {
> > > > +       { .hw = &mi2s_bit_div_clk.clkr.hw, },
> > > > +       { .fw_name = "mi2s_codec_clk", .name = "mi2s_codec_clk" },
> > > > +};
> > > >
> > > >  static struct clk_regmap_mux mi2s_bit_clk = {
> > > >         .reg = 0x48,
> > > > @@ -199,11 +209,8 @@ static struct clk_regmap_mux mi2s_bit_clk = {
> > > >         .clkr = {
> > > >                 .hw.init = &(struct clk_init_data){
> > > >                         .name = "mi2s_bit_clk",
> > > > -                       .parent_names = (const char *[]){
> > > > -                               "mi2s_bit_div_clk",
> > > > -                               "mi2s_codec_clk",
> > > > -                       },
> > > > -                       .num_parents = 2,
> > > > +                       .parent_data = lcc_mi2s_bit_div_codec_clk,
> > > > +                       .num_parents = ARRAY_SIZE(lcc_mi2s_bit_div_codec_clk),
> > > >                         .ops = &clk_regmap_mux_closest_ops,
> > > >                         .flags = CLK_SET_RATE_PARENT,
> > > >                 },
> > > > @@ -245,8 +252,8 @@ static struct clk_rcg pcm_src = {
> > > >                 .enable_mask = BIT(9),
> > > >                 .hw.init = &(struct clk_init_data){
> > > >                         .name = "pcm_src",
> > > > -                       .parent_names = lcc_pxo_pll4,
> > > > -                       .num_parents = 2,
> > > > +                       .parent_data = lcc_pxo_pll4,
> > > > +                       .num_parents = ARRAY_SIZE(lcc_pxo_pll4),
> > > >                         .ops = &clk_rcg_ops,
> > > >                         .flags = CLK_SET_RATE_GATE,
> > > >                 },
> > > > @@ -262,7 +269,9 @@ static struct clk_branch pcm_clk_out = {
> > > >                 .enable_mask = BIT(11),
> > > >                 .hw.init = &(struct clk_init_data){
> > > >                         .name = "pcm_clk_out",
> > > > -                       .parent_names = (const char *[]){ "pcm_src" },
> > > > +                       .parent_hws = (const struct clk_hw*[]){
> > > > +                               &pcm_src.clkr.hw,
> > > > +                       },
> > > >                         .num_parents = 1,
> > > >                         .ops = &clk_branch_ops,
> > > >                         .flags = CLK_SET_RATE_PARENT,
> > > > @@ -270,6 +279,11 @@ static struct clk_branch pcm_clk_out = {
> > > >         },
> > > >  };
> > > >
> > > > +static const struct clk_parent_data lcc_pcm_clk_out_codec_clk[] = {
> > > > +       { .hw = &pcm_clk_out.clkr.hw, },
> > > > +       { .fw_name = "pcm_codec_clk", .name = "pcm_codec_clk" },
> > > > +};
> > > > +
> > > >  static struct clk_regmap_mux pcm_clk = {
> > > >         .reg = 0x54,
> > > >         .shift = 10,
> > > > @@ -277,11 +291,8 @@ static struct clk_regmap_mux pcm_clk = {
> > > >         .clkr = {
> > > >                 .hw.init = &(struct clk_init_data){
> > > >                         .name = "pcm_clk",
> > > > -                       .parent_names = (const char *[]){
> > > > -                               "pcm_clk_out",
> > > > -                               "pcm_codec_clk",
> > > > -                       },
> > > > -                       .num_parents = 2,
> > > > +                       .parent_data = lcc_pcm_clk_out_codec_clk,
> > > > +                       .num_parents = ARRAY_SIZE(lcc_pcm_clk_out_codec_clk),
> > > >                         .ops = &clk_regmap_mux_closest_ops,
> > > >                         .flags = CLK_SET_RATE_PARENT,
> > > >                 },
> > > > @@ -325,18 +336,14 @@ static struct clk_rcg spdif_src = {
> > > >                 .enable_mask = BIT(9),
> > > >                 .hw.init = &(struct clk_init_data){
> > > >                         .name = "spdif_src",
> > > > -                       .parent_names = lcc_pxo_pll4,
> > > > -                       .num_parents = 2,
> > > > +                       .parent_data = lcc_pxo_pll4,
> > > > +                       .num_parents = ARRAY_SIZE(lcc_pxo_pll4),
> > > >                         .ops = &clk_rcg_ops,
> > > >                         .flags = CLK_SET_RATE_GATE,
> > > >                 },
> > > >         },
> > > >  };
> > > >
> > > > -static const char * const lcc_spdif_parents[] = {
> > > > -       "spdif_src",
> > > > -};
> > > > -
> > > >  static struct clk_branch spdif_clk = {
> > > >         .halt_reg = 0xd4,
> > > >         .halt_bit = 1,
> > > > @@ -346,7 +353,9 @@ static struct clk_branch spdif_clk = {
> > > >                 .enable_mask = BIT(12),
> > > >                 .hw.init = &(struct clk_init_data){
> > > >                         .name = "spdif_clk",
> > > > -                       .parent_names = lcc_spdif_parents,
> > > > +                       .parent_hws = (const struct clk_hw*[]){
> > > > +                               &spdif_src.clkr.hw,
> > > > +                       },
> > > >                         .num_parents = 1,
> > > >                         .ops = &clk_branch_ops,
> > > >                         .flags = CLK_SET_RATE_PARENT,
> > > > @@ -384,8 +393,8 @@ static struct clk_rcg ahbix_clk = {
> > > >                 .enable_mask = BIT(11),
> > > >                 .hw.init = &(struct clk_init_data){
> > > >                         .name = "ahbix",
> > > > -                       .parent_names = lcc_pxo_pll4,
> > > > -                       .num_parents = 2,
> > > > +                       .parent_data = lcc_pxo_pll4,
> > > > +                       .num_parents = ARRAY_SIZE(lcc_pxo_pll4),
> > > >                         .ops = &clk_rcg_lcc_ops,
> > > >                 },
> > > >         },
> > > > --
> > > > 2.36.1
> > > >
> > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
> >
> > --
> >         Ansuel
> 
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
