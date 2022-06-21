Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DF4553B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiFUUXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354338AbiFUUXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:23:24 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7F513F6A;
        Tue, 21 Jun 2022 13:23:22 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o8so20509070wro.3;
        Tue, 21 Jun 2022 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=QAT6SWc55tzdZAkJWCvpHRcd5t3vnhoiATlEpv06WdA=;
        b=Fx3fUCjmST6q3UsD0a6cB7LrH7NSm1kUG0cnyecEsUrqPdadOw3/oYHEjdadu0YUKs
         3nT+O0wQQB5+FK1BRs3XGoM9/8WrTv5kdcDDWthFSE3W898gBuOK4LcVY2DRLlvigQfc
         qAlwj4pBm3EJvq81vytiY6WJd95WcisHPLVbrSZeMiBfWUg7bgnVTc4/rqS+DFkdLCyn
         yrB3s12S0jWQT2z9px2HZxnIqwvnHExBjFYqE1MawzP1TTl+FhnXe8PcPLUayBUWDZ4S
         qnZ6X1GWpiW8BFwJxOQ1kh+thH2h3ufuGkp4WqynYMdQlv0ul4tMna2iNPWLKBAMq0fr
         Nhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=QAT6SWc55tzdZAkJWCvpHRcd5t3vnhoiATlEpv06WdA=;
        b=NZ6CSJjWMsYPFkHEMe+ddK+SjWXdM0Aai/mWMpUJUpuOE71/+378BmiVnua8YhcRj1
         Btu2g7+slsacMyUqXlNo6GyXeRyqFWz3Zq4GXOJk0YORJk+mnPfjeGGqucY5FOuKF/JD
         EDEPcb1DgkWdoVetYAXq3/b062Revl3E8/xNjLoi1CP2hCVODYOHVuJLQng7nDiNaiZU
         baE2RiD/laB+Pb9XlVALkoFTe7QJg9ZlN0ka3WdrBHUVvZDsgU85vDLpuCWkzkDJKIJX
         wgrFAW6vqVLGcAtPbeWoKtLjGKaTkreogiJ3Yci/bGHBnsR1K0fSrQ/cxwwI4wzCsUZE
         7h1A==
X-Gm-Message-State: AJIora/Pk/I1zIf+4l4rWSXn8BzzBcq3PnVqWLYa9taFOIvP+z/rTtCA
        pFQVGn1APgQ5WLGlX/1o5oiNeY//jSA=
X-Google-Smtp-Source: AGRyM1tStv1F8UqO7JT3i+lddtDNeOpgoLnm2TJtlhH8ZZcPgaDob/cD1bkB4oSHo5fHqXL1VyPumw==
X-Received: by 2002:a05:6000:1a89:b0:21b:83aa:ebd5 with SMTP id f9-20020a0560001a8900b0021b83aaebd5mr19799624wry.476.1655843000929;
        Tue, 21 Jun 2022 13:23:20 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id e13-20020adfe7cd000000b0021b89181863sm9762729wrn.41.2022.06.21.13.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 13:23:18 -0700 (PDT)
Message-ID: <62b228b6.1c69fb81.e4673.34a2@mx.google.com>
X-Google-Original-Message-ID: <YrIotGGd60xzdBf1@Ansuel-xps.>
Date:   Tue, 21 Jun 2022 22:23:16 +0200
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqQTTevQa4pQg3E+x4_AOjYo8ajOqUrfwGsVtC8N=bpOw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 08:15:57PM +0300, Dmitry Baryshkov wrote:
> On Tue, 21 Jun 2022 at 19:33, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Convert lcc-ipq806x driver to parent_data API.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > v2:
> > - Fix Sob tag
> >
> >  drivers/clk/qcom/lcc-ipq806x.c | 79 +++++++++++++++++++---------------
> >  1 file changed, 44 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
> > index ba90bebba597..c07ca8dc6e3a 100644
> > --- a/drivers/clk/qcom/lcc-ipq806x.c
> > +++ b/drivers/clk/qcom/lcc-ipq806x.c
> > @@ -24,6 +24,10 @@
> >  #include "clk-regmap-mux.h"
> >  #include "reset.h"
> >
> > +static const struct clk_parent_data gcc_pxo[] = {
> > +       { .fw_name = "pxo", .name = "pxo" },
> 
> I think you'd use .name = "pxo_board" here. You don't need to use the
> interim clock.
>

In gcc and in the rest of this driver we use pxo. Wonder what is right?

> > +};
> > +
> >  static struct clk_pll pll4 = {
> >         .l_reg = 0x4,
> >         .m_reg = 0x8,
> > @@ -34,7 +38,7 @@ static struct clk_pll pll4 = {
> >         .status_bit = 16,
> >         .clkr.hw.init = &(struct clk_init_data){
> >                 .name = "pll4",
> > -               .parent_names = (const char *[]){ "pxo" },
> > +               .parent_data = gcc_pxo,
> >                 .num_parents = 1,
> 
> Could you please either inline the gcc_pxo here (yes, it's ugly, but
> it works for small arrays) or use ARRAY_SIZE here.
> 

Yes will inline gcc_pxo.

> >                 .ops = &clk_pll_ops,
> >         },
> > @@ -64,9 +68,9 @@ static const struct parent_map lcc_pxo_pll4_map[] = {
> >         { P_PLL4, 2 }
> >  };
> >
> > -static const char * const lcc_pxo_pll4[] = {
> > -       "pxo",
> > -       "pll4_vote",
> > +static const struct clk_parent_data lcc_pxo_pll4[] = {
> > +       { .fw_name = "pxo", .name = "pxo" },
> > +       { .fw_name = "pll4_vote", .name = "pll4_vote" },
> >  };
> >
> >  static struct freq_tbl clk_tbl_aif_mi2s[] = {
> > @@ -131,18 +135,14 @@ static struct clk_rcg mi2s_osr_src = {
> >                 .enable_mask = BIT(9),
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "mi2s_osr_src",
> > -                       .parent_names = lcc_pxo_pll4,
> > -                       .num_parents = 2,
> > +                       .parent_data = lcc_pxo_pll4,
> > +                       .num_parents = ARRAY_SIZE(lcc_pxo_pll4),
> >                         .ops = &clk_rcg_ops,
> >                         .flags = CLK_SET_RATE_GATE,
> >                 },
> >         },
> >  };
> >
> > -static const char * const lcc_mi2s_parents[] = {
> > -       "mi2s_osr_src",
> > -};
> > -
> >  static struct clk_branch mi2s_osr_clk = {
> >         .halt_reg = 0x50,
> >         .halt_bit = 1,
> > @@ -152,7 +152,9 @@ static struct clk_branch mi2s_osr_clk = {
> >                 .enable_mask = BIT(17),
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "mi2s_osr_clk",
> > -                       .parent_names = lcc_mi2s_parents,
> > +                       .parent_hws = (const struct clk_hw*[]){
> > +                               &mi2s_osr_src.clkr.hw,
> > +                       },
> >                         .num_parents = 1,
> >                         .ops = &clk_branch_ops,
> >                         .flags = CLK_SET_RATE_PARENT,
> > @@ -167,7 +169,9 @@ static struct clk_regmap_div mi2s_div_clk = {
> >         .clkr = {
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "mi2s_div_clk",
> > -                       .parent_names = lcc_mi2s_parents,
> > +                       .parent_hws = (const struct clk_hw*[]){
> > +                               &mi2s_osr_src.clkr.hw,
> > +                       },
> >                         .num_parents = 1,
> >                         .ops = &clk_regmap_div_ops,
> >                 },
> > @@ -183,7 +187,9 @@ static struct clk_branch mi2s_bit_div_clk = {
> >                 .enable_mask = BIT(15),
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "mi2s_bit_div_clk",
> > -                       .parent_names = (const char *[]){ "mi2s_div_clk" },
> > +                       .parent_hws = (const struct clk_hw*[]){
> > +                               &mi2s_div_clk.clkr.hw,
> > +                       },
> >                         .num_parents = 1,
> >                         .ops = &clk_branch_ops,
> >                         .flags = CLK_SET_RATE_PARENT,
> > @@ -191,6 +197,10 @@ static struct clk_branch mi2s_bit_div_clk = {
> >         },
> >  };
> >
> > +static const struct clk_parent_data lcc_mi2s_bit_div_codec_clk[] = {
> > +       { .hw = &mi2s_bit_div_clk.clkr.hw, },
> > +       { .fw_name = "mi2s_codec_clk", .name = "mi2s_codec_clk" },
> > +};
> >
> >  static struct clk_regmap_mux mi2s_bit_clk = {
> >         .reg = 0x48,
> > @@ -199,11 +209,8 @@ static struct clk_regmap_mux mi2s_bit_clk = {
> >         .clkr = {
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "mi2s_bit_clk",
> > -                       .parent_names = (const char *[]){
> > -                               "mi2s_bit_div_clk",
> > -                               "mi2s_codec_clk",
> > -                       },
> > -                       .num_parents = 2,
> > +                       .parent_data = lcc_mi2s_bit_div_codec_clk,
> > +                       .num_parents = ARRAY_SIZE(lcc_mi2s_bit_div_codec_clk),
> >                         .ops = &clk_regmap_mux_closest_ops,
> >                         .flags = CLK_SET_RATE_PARENT,
> >                 },
> > @@ -245,8 +252,8 @@ static struct clk_rcg pcm_src = {
> >                 .enable_mask = BIT(9),
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "pcm_src",
> > -                       .parent_names = lcc_pxo_pll4,
> > -                       .num_parents = 2,
> > +                       .parent_data = lcc_pxo_pll4,
> > +                       .num_parents = ARRAY_SIZE(lcc_pxo_pll4),
> >                         .ops = &clk_rcg_ops,
> >                         .flags = CLK_SET_RATE_GATE,
> >                 },
> > @@ -262,7 +269,9 @@ static struct clk_branch pcm_clk_out = {
> >                 .enable_mask = BIT(11),
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "pcm_clk_out",
> > -                       .parent_names = (const char *[]){ "pcm_src" },
> > +                       .parent_hws = (const struct clk_hw*[]){
> > +                               &pcm_src.clkr.hw,
> > +                       },
> >                         .num_parents = 1,
> >                         .ops = &clk_branch_ops,
> >                         .flags = CLK_SET_RATE_PARENT,
> > @@ -270,6 +279,11 @@ static struct clk_branch pcm_clk_out = {
> >         },
> >  };
> >
> > +static const struct clk_parent_data lcc_pcm_clk_out_codec_clk[] = {
> > +       { .hw = &pcm_clk_out.clkr.hw, },
> > +       { .fw_name = "pcm_codec_clk", .name = "pcm_codec_clk" },
> > +};
> > +
> >  static struct clk_regmap_mux pcm_clk = {
> >         .reg = 0x54,
> >         .shift = 10,
> > @@ -277,11 +291,8 @@ static struct clk_regmap_mux pcm_clk = {
> >         .clkr = {
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "pcm_clk",
> > -                       .parent_names = (const char *[]){
> > -                               "pcm_clk_out",
> > -                               "pcm_codec_clk",
> > -                       },
> > -                       .num_parents = 2,
> > +                       .parent_data = lcc_pcm_clk_out_codec_clk,
> > +                       .num_parents = ARRAY_SIZE(lcc_pcm_clk_out_codec_clk),
> >                         .ops = &clk_regmap_mux_closest_ops,
> >                         .flags = CLK_SET_RATE_PARENT,
> >                 },
> > @@ -325,18 +336,14 @@ static struct clk_rcg spdif_src = {
> >                 .enable_mask = BIT(9),
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "spdif_src",
> > -                       .parent_names = lcc_pxo_pll4,
> > -                       .num_parents = 2,
> > +                       .parent_data = lcc_pxo_pll4,
> > +                       .num_parents = ARRAY_SIZE(lcc_pxo_pll4),
> >                         .ops = &clk_rcg_ops,
> >                         .flags = CLK_SET_RATE_GATE,
> >                 },
> >         },
> >  };
> >
> > -static const char * const lcc_spdif_parents[] = {
> > -       "spdif_src",
> > -};
> > -
> >  static struct clk_branch spdif_clk = {
> >         .halt_reg = 0xd4,
> >         .halt_bit = 1,
> > @@ -346,7 +353,9 @@ static struct clk_branch spdif_clk = {
> >                 .enable_mask = BIT(12),
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "spdif_clk",
> > -                       .parent_names = lcc_spdif_parents,
> > +                       .parent_hws = (const struct clk_hw*[]){
> > +                               &spdif_src.clkr.hw,
> > +                       },
> >                         .num_parents = 1,
> >                         .ops = &clk_branch_ops,
> >                         .flags = CLK_SET_RATE_PARENT,
> > @@ -384,8 +393,8 @@ static struct clk_rcg ahbix_clk = {
> >                 .enable_mask = BIT(11),
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "ahbix",
> > -                       .parent_names = lcc_pxo_pll4,
> > -                       .num_parents = 2,
> > +                       .parent_data = lcc_pxo_pll4,
> > +                       .num_parents = ARRAY_SIZE(lcc_pxo_pll4),
> >                         .ops = &clk_rcg_lcc_ops,
> >                 },
> >         },
> > --
> > 2.36.1
> >
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
	Ansuel
