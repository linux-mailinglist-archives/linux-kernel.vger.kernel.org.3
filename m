Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61985705D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiGKOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiGKOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:38:58 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126625298
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:38:57 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id z11so2482751qkz.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XItuS7mxG3PZJmkt2lhJ3OfdyNaqBYJhSMEwOH7X7w=;
        b=PGyjfvKcWdQwelKW6M8EqUThfSKyzL47vHKiHrDemhJsneuC3ixvwPZpeXfEyG1cyR
         8KPrFdjBv/Zo/II3/JPlKy7mGsa/Q39PbpljtC0/8lm35MvZ59axYT/uPaRIMgX9amIJ
         29LaT0QCehH9Gf75ZQ8XofHL0rVkoyfgT6kbmYyLplJ+ehLCi7JEgTL1PUAkKsne9olR
         57KCROb94QPPQ0c5q70I3lEHA3Bg024JIZk74fnO2fy/HCGafLSK6XsKQLJpcd84ExE3
         YZKXT6W3Ajosz5UBCZitdo0YHcT8u+cFy+WCGW2YlQr9to7dOQd96GGGA54qbzgrtpXh
         lB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XItuS7mxG3PZJmkt2lhJ3OfdyNaqBYJhSMEwOH7X7w=;
        b=3CEmzlHVTwRuIcQXwWXyq7h1etgfTZPs1Q7s5ZpH5Mr6wsxpEdg9rB7rvdB9uB8oKL
         xFFhk2Sdb+XV2YPFycYHmhIPfxzXf3z6D2hvW6bpk42zmbWDRdnn72YkFAE9HJ5XEqrK
         /EIIsl4KzeZRs9mogW9g6tvJRfsLV4D5iUFBLHccrElBzh3hDOzExOKPCWqEBCHxSV4b
         f3CYRQ30XjjmTcbjWRSO2JgCVwdvHTI+pcvvN4KAN+JER5aljRQt8DMAt6tEPrqrDumQ
         6CkXOSEMFdw2WBPTvQcHail/DwJwq8LR4cFmVpglTRr3YmX6fRoKI0/y4heuPnpAS2Xf
         FxRw==
X-Gm-Message-State: AJIora9N/JnM4xVJdEmejOH+FZsgiiJGypT6H3+qaQbddT5pXABqIUdV
        2MsbECnjlh8cwKkdbKhmintS3bn/hWErrNKOytVhpg==
X-Google-Smtp-Source: AGRyM1v7KwvPv0nm/D8OzJicPsfijYOWEzwiJQg1F3Z9hxTc1QBfSx++f0Z1WbfPChzH+yJTRZEFC3fssklptShCyNk=
X-Received: by 2002:a05:620a:d5b:b0:6b5:660b:2939 with SMTP id
 o27-20020a05620a0d5b00b006b5660b2939mr10691619qkl.30.1657550336362; Mon, 11
 Jul 2022 07:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220711104719.40939-1-robimarko@gmail.com>
In-Reply-To: <20220711104719.40939-1-robimarko@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 11 Jul 2022 17:38:45 +0300
Message-ID: <CAA8EJpo-83y=z_uRePLg0upUuhWc439FKBq_sy_Z=5kriD7unw@mail.gmail.com>
Subject: Re: [PATCH 1/6] clk: qcom: clk-rcg2: add rcg2 mux ops
To:     Robert Marko <robimarko@gmail.com>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
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

On Mon, 11 Jul 2022 at 14:22, Robert Marko <robimarko@gmail.com> wrote:
>
> From: Christian Marangi <ansuelsmth@gmail.com>
>
> An RCG may act as a mux that switch between 2 parents.
> This is the case on IPQ6018 and IPQ8074 where the APCS core clk that feeds
> the CPU cluster clock just switches between XO and the PLL that feeds it.
>
> Add the required ops to add support for this special configuration and use
> the generic mux function to determine the rate.
>
> This way we dont have to keep a essentially dummy frequency table to use
> RCG2 as a mux.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/clk/qcom/clk-rcg.h  | 1 +
>  drivers/clk/qcom/clk-rcg2.c | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
> index 012e745794fd..01581f4d2c39 100644
> --- a/drivers/clk/qcom/clk-rcg.h
> +++ b/drivers/clk/qcom/clk-rcg.h
> @@ -167,6 +167,7 @@ struct clk_rcg2_gfx3d {
>
>  extern const struct clk_ops clk_rcg2_ops;
>  extern const struct clk_ops clk_rcg2_floor_ops;
> +extern const struct clk_ops clk_rcg2_mux_closest_ops;
>  extern const struct clk_ops clk_edp_pixel_ops;
>  extern const struct clk_ops clk_byte_ops;
>  extern const struct clk_ops clk_byte2_ops;
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index 28019edd2a50..609c10f8d0d9 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -509,6 +509,13 @@ const struct clk_ops clk_rcg2_floor_ops = {
>  };
>  EXPORT_SYMBOL_GPL(clk_rcg2_floor_ops);
>
> +const struct clk_ops clk_rcg2_mux_closest_ops = {
> +       .determine_rate = __clk_mux_determine_rate_closest,
> +       .get_parent = clk_rcg2_get_parent,
> +       .set_parent = clk_rcg2_set_parent,
> +};
> +EXPORT_SYMBOL_GPL(clk_rcg2_mux_closest_ops);
> +
>  struct frac_entry {
>         int num;
>         int den;
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
