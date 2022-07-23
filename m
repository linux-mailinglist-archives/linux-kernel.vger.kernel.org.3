Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6794C57F00C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 17:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbiGWPSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 11:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiGWPSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 11:18:02 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BB6F596
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:18:00 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id e16so5603220qka.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+hK9CwwlpYkhVfAzwgLSB6I39rfllXoWawXAO5lSa4=;
        b=SCCLU7ZrbbSrLVSKIBLlTRn98LuFC7EORa+QL9nQ6mCfZ45D3ky8w/LkicL5KAZ0pb
         tqrcjf3h8ePQi3X1URBATugpuTJHwukw4K1NPkiM6KmRS9rHB2FqnpEdERqbQD/qB0FN
         4n7AQzhBK5PHa4CF44p8Bo2D9xMnkXQeyP9HjMspSVcKvVb43OAAuXkLz4eaE/WMt+jV
         V3ZJ7qYMAcKj+U8iuyHckT+hwrnUvIiktnsGx8dRcDOB3fBJcsOwqpMX0TeLoqdrnXT3
         CPzXpLwEugcepOEGwTkndQ0uHA6fSzg15fyqP+EBxYoQkkH4BFNyvjFez0FIQ0RGC9dD
         pN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+hK9CwwlpYkhVfAzwgLSB6I39rfllXoWawXAO5lSa4=;
        b=KAOyF4yV3JF/ZZE0tay0RSAuBIod+AgxjmG7OdQ7vfGISygk98utfjh2A1CP6NVAfU
         JAVAPZ483T2sNReaL2jCn6Qx/9kGk7LjgW6ZlZNCkmJSxJoUMoFAFbWe372lgDvIjSHV
         vnltYeQOSv22iAshh/pMfyFxmLWqd4XPZU3c4R3Fp3DkA2EXcUUgxii5wtN3Dn98S/uC
         uZDTolOrd58x6yDNhCHkYogXU5eZMVP2TVqmt8HmuPqgoZANNv5Jld8TzmDkaRNDsniY
         Svt7WUe625kdeE9YqL13FRUweaaiFv1M5C2ADGew9xfMqORPKnnaxGUdAut1dKlr8f/z
         vGFA==
X-Gm-Message-State: AJIora/GmlxplbQfQV32rMUd7EDxVAAhMQlt14XsjRfhcWCKfhwRE4ss
        FkNMG6QIU1hy4QyjpFshi+ZZrokWhlpqGDMCneL6Uw==
X-Google-Smtp-Source: AGRyM1v9YprJMgikhVusTUJa7zX3+10whwtO5HRlKFBwbiyBXcSt6N4V1RYN3I9HNSXYn4++EB+xxfxhQ0KhVGgotxg=
X-Received: by 2002:ae9:f311:0:b0:6b6:30a9:1bb1 with SMTP id
 p17-20020ae9f311000000b006b630a91bb1mr3676804qkg.30.1658589478615; Sat, 23
 Jul 2022 08:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220723145558.25210-1-ansuelsmth@gmail.com> <20220723145558.25210-3-ansuelsmth@gmail.com>
In-Reply-To: <20220723145558.25210-3-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 23 Jul 2022 18:17:47 +0300
Message-ID: <CAA8EJprb6DGfQYzPSe9d=LZWxhuu+c2t=LbidBrf7Mir4fKGTg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] clk: qcom: lcc-ipq806x: convert to parent data
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jul 2022 at 17:56, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Convert lcc-ipq806x driver to parent_data API.

Please mention using "pxo_board" rather than "pxo".

With that fixed:
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> v6:
> - Split to separate patch for ARRAY_SIZE
> - Rename .name to pxo_board
> - Drop _clk from .fw_name
> v5:
> - Fix the same compilation error (don't know what the hell happen
>   to my buildroot)
> v4:
> - Fix compilation error
> v3:
>  - Inline pxo pll4 parent
>  - Change .name from pxo to pxo_board
>
>  drivers/clk/qcom/lcc-ipq806x.c | 69 +++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
> index ba90bebba597..1833e59a6434 100644
> --- a/drivers/clk/qcom/lcc-ipq806x.c
> +++ b/drivers/clk/qcom/lcc-ipq806x.c
> @@ -34,7 +34,9 @@ static struct clk_pll pll4 = {
>         .status_bit = 16,
>         .clkr.hw.init = &(struct clk_init_data){
>                 .name = "pll4",
> -               .parent_names = (const char *[]){ "pxo" },
> +               .parent_data = &(const struct clk_parent_data) {
> +                       .fw_name = "pxo", .name = "pxo_board",
> +               },
>                 .num_parents = 1,
>                 .ops = &clk_pll_ops,
>         },
> @@ -64,9 +66,9 @@ static const struct parent_map lcc_pxo_pll4_map[] = {
>         { P_PLL4, 2 }
>  };
>
> -static const char * const lcc_pxo_pll4[] = {
> -       "pxo",
> -       "pll4_vote",
> +static const struct clk_parent_data lcc_pxo_pll4[] = {
> +       { .fw_name = "pxo", .name = "pxo_board" },
> +       { .fw_name = "pll4_vote", .name = "pll4_vote" },
>  };
>
>  static struct freq_tbl clk_tbl_aif_mi2s[] = {
> @@ -131,7 +133,7 @@ static struct clk_rcg mi2s_osr_src = {
>                 .enable_mask = BIT(9),
>                 .hw.init = &(struct clk_init_data){
>                         .name = "mi2s_osr_src",
> -                       .parent_names = lcc_pxo_pll4,
> +                       .parent_data = lcc_pxo_pll4,
>                         .num_parents = 2,
>                         .ops = &clk_rcg_ops,
>                         .flags = CLK_SET_RATE_GATE,
> @@ -139,10 +141,6 @@ static struct clk_rcg mi2s_osr_src = {
>         },
>  };
>
> -static const char * const lcc_mi2s_parents[] = {
> -       "mi2s_osr_src",
> -};
> -
>  static struct clk_branch mi2s_osr_clk = {
>         .halt_reg = 0x50,
>         .halt_bit = 1,
> @@ -152,7 +150,9 @@ static struct clk_branch mi2s_osr_clk = {
>                 .enable_mask = BIT(17),
>                 .hw.init = &(struct clk_init_data){
>                         .name = "mi2s_osr_clk",
> -                       .parent_names = lcc_mi2s_parents,
> +                       .parent_hws = (const struct clk_hw*[]) {
> +                               &mi2s_osr_src.clkr.hw,
> +                       },
>                         .num_parents = 1,
>                         .ops = &clk_branch_ops,
>                         .flags = CLK_SET_RATE_PARENT,
> @@ -167,7 +167,9 @@ static struct clk_regmap_div mi2s_div_clk = {
>         .clkr = {
>                 .hw.init = &(struct clk_init_data){
>                         .name = "mi2s_div_clk",
> -                       .parent_names = lcc_mi2s_parents,
> +                       .parent_hws = (const struct clk_hw*[]) {
> +                               &mi2s_osr_src.clkr.hw,
> +                       },
>                         .num_parents = 1,
>                         .ops = &clk_regmap_div_ops,
>                 },
> @@ -183,7 +185,9 @@ static struct clk_branch mi2s_bit_div_clk = {
>                 .enable_mask = BIT(15),
>                 .hw.init = &(struct clk_init_data){
>                         .name = "mi2s_bit_div_clk",
> -                       .parent_names = (const char *[]){ "mi2s_div_clk" },
> +                       .parent_hws = (const struct clk_hw*[]) {
> +                               &mi2s_div_clk.clkr.hw,
> +                       },
>                         .num_parents = 1,
>                         .ops = &clk_branch_ops,
>                         .flags = CLK_SET_RATE_PARENT,
> @@ -191,6 +195,10 @@ static struct clk_branch mi2s_bit_div_clk = {
>         },
>  };
>
> +static const struct clk_parent_data lcc_mi2s_bit_div_codec_clk[] = {
> +       { .hw = &mi2s_bit_div_clk.clkr.hw, },
> +       { .fw_name = "mi2s_codec", .name = "mi2s_codec_clk" },
> +};
>
>  static struct clk_regmap_mux mi2s_bit_clk = {
>         .reg = 0x48,
> @@ -199,11 +207,8 @@ static struct clk_regmap_mux mi2s_bit_clk = {
>         .clkr = {
>                 .hw.init = &(struct clk_init_data){
>                         .name = "mi2s_bit_clk",
> -                       .parent_names = (const char *[]){
> -                               "mi2s_bit_div_clk",
> -                               "mi2s_codec_clk",
> -                       },
> -                       .num_parents = 2,
> +                       .parent_data = lcc_mi2s_bit_div_codec_clk,
> +                       .num_parents = ARRAY_SIZE(lcc_mi2s_bit_div_codec_clk),
>                         .ops = &clk_regmap_mux_closest_ops,
>                         .flags = CLK_SET_RATE_PARENT,
>                 },
> @@ -245,7 +250,7 @@ static struct clk_rcg pcm_src = {
>                 .enable_mask = BIT(9),
>                 .hw.init = &(struct clk_init_data){
>                         .name = "pcm_src",
> -                       .parent_names = lcc_pxo_pll4,
> +                       .parent_data = lcc_pxo_pll4,
>                         .num_parents = 2,
>                         .ops = &clk_rcg_ops,
>                         .flags = CLK_SET_RATE_GATE,
> @@ -262,7 +267,9 @@ static struct clk_branch pcm_clk_out = {
>                 .enable_mask = BIT(11),
>                 .hw.init = &(struct clk_init_data){
>                         .name = "pcm_clk_out",
> -                       .parent_names = (const char *[]){ "pcm_src" },
> +                       .parent_hws = (const struct clk_hw*[]) {
> +                               &pcm_src.clkr.hw,
> +                       },
>                         .num_parents = 1,
>                         .ops = &clk_branch_ops,
>                         .flags = CLK_SET_RATE_PARENT,
> @@ -270,6 +277,11 @@ static struct clk_branch pcm_clk_out = {
>         },
>  };
>
> +static const struct clk_parent_data lcc_pcm_clk_out_codec_clk[] = {
> +       { .hw = &pcm_clk_out.clkr.hw, },
> +       { .fw_name = "pcm_codec_clk", .name = "pcm_codec_clk" },
> +};
> +
>  static struct clk_regmap_mux pcm_clk = {
>         .reg = 0x54,
>         .shift = 10,
> @@ -277,11 +289,8 @@ static struct clk_regmap_mux pcm_clk = {
>         .clkr = {
>                 .hw.init = &(struct clk_init_data){
>                         .name = "pcm_clk",
> -                       .parent_names = (const char *[]){
> -                               "pcm_clk_out",
> -                               "pcm_codec_clk",
> -                       },
> -                       .num_parents = 2,
> +                       .parent_data = lcc_pcm_clk_out_codec_clk,
> +                       .num_parents = ARRAY_SIZE(lcc_pcm_clk_out_codec_clk),
>                         .ops = &clk_regmap_mux_closest_ops,
>                         .flags = CLK_SET_RATE_PARENT,
>                 },
> @@ -325,7 +334,7 @@ static struct clk_rcg spdif_src = {
>                 .enable_mask = BIT(9),
>                 .hw.init = &(struct clk_init_data){
>                         .name = "spdif_src",
> -                       .parent_names = lcc_pxo_pll4,
> +                       .parent_data = lcc_pxo_pll4,
>                         .num_parents = 2,
>                         .ops = &clk_rcg_ops,
>                         .flags = CLK_SET_RATE_GATE,
> @@ -333,10 +342,6 @@ static struct clk_rcg spdif_src = {
>         },
>  };
>
> -static const char * const lcc_spdif_parents[] = {
> -       "spdif_src",
> -};
> -
>  static struct clk_branch spdif_clk = {
>         .halt_reg = 0xd4,
>         .halt_bit = 1,
> @@ -346,7 +351,9 @@ static struct clk_branch spdif_clk = {
>                 .enable_mask = BIT(12),
>                 .hw.init = &(struct clk_init_data){
>                         .name = "spdif_clk",
> -                       .parent_names = lcc_spdif_parents,
> +                       .parent_hws = (const struct clk_hw*[]) {
> +                               &spdif_src.clkr.hw,
> +                       },
>                         .num_parents = 1,
>                         .ops = &clk_branch_ops,
>                         .flags = CLK_SET_RATE_PARENT,
> @@ -384,7 +391,7 @@ static struct clk_rcg ahbix_clk = {
>                 .enable_mask = BIT(11),
>                 .hw.init = &(struct clk_init_data){
>                         .name = "ahbix",
> -                       .parent_names = lcc_pxo_pll4,
> +                       .parent_data = lcc_pxo_pll4,
>                         .num_parents = 2,
>                         .ops = &clk_rcg_lcc_ops,
>                 },
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
