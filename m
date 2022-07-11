Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CB3570353
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiGKMuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiGKMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:50:13 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD1D27CF1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:50:11 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id l11so265181qvu.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEHURGAeySs8pLSairxsGs7mq8uiqtu81CRP/E1NRr8=;
        b=JlNaJtMpP1U0cBY6E0notJX2QeC3sW7FqFQOkNGHGLThRaRs080jhqkSXh7nYgYhbj
         zPGW4g4pX9jUGVhlXJNA0+Zh5UzW23gPUHjVUA5L3m7ljClWK96+odb6rFCWuiLCcncD
         ltgP6DjUrUZ+G6hI7gxxr4FcO6TzdJgGZxvftuoliyuXrNN60LpUBnCcLqnkwtzYd0dA
         Ux+MO0LXL2M5pTbxSEqfuYv4h2SjBElXy3vgGgj+/tclmu6ZjgFGEJ00x4Qj/hwM43ou
         gju/uU5m36lNVsO/a0UvFS+SeydP2jX0qmruSaLr2TxF/7Y7H2ZMErxdUP3s3C7LZ/vF
         EWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEHURGAeySs8pLSairxsGs7mq8uiqtu81CRP/E1NRr8=;
        b=Fup5mY6yfDIxmmakV1JI3AcLiJe7MCnDW7COHFjO2dd1RPjGuDqNBUh3aWK6GmvJm7
         D3Y0ZPenCyV+Agxblprj+Pp8c6Nr6oGt/Yyp1ImeIuFO2gBz6oFacC4Z0YWXm9/K4+WI
         HIRmSidIqP+PO9aJE5+aFPICcu5zqR1n+b8yUJjVZJZ28fFLPJjERoJXLZyqwOTvhHo0
         S97gWm4ni0Xcoo1Dbl93CEnYtWjilqODvCilj33H0ixgUi8cPgR4/Fv4CbkBjTGu7F0j
         ENEuye0wW28MxdHtPZ3GkPPr3cqvdBtvkzxhg1C7sPSPLDzvJTiG/Nn7aTmE8wzHDR/B
         NHbw==
X-Gm-Message-State: AJIora9QJOAfpU+xWIrObPIKRhYvmN/+80bmzKQE1eg6Nmo9xhZedAq0
        Cf6EGGSf6azh4VNZYiUz39NeKXJmBlkVOdipbmdB7Q==
X-Google-Smtp-Source: AGRyM1s5ZngvOSu76C4hMxexIc8pddQYKN1AZRMPIOmvoztDmi8b5yFedk5rkqlJkrO6J15ZNU5pggeJRbUh4VgcI18=
X-Received: by 2002:ad4:5f8a:0:b0:473:2108:7fe0 with SMTP id
 jp10-20020ad45f8a000000b0047321087fe0mr13256062qvb.115.1657543810922; Mon, 11
 Jul 2022 05:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220711104719.40939-1-robimarko@gmail.com> <20220711104719.40939-3-robimarko@gmail.com>
In-Reply-To: <20220711104719.40939-3-robimarko@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 11 Jul 2022 15:49:59 +0300
Message-ID: <CAA8EJprxxrCYEaD73GO98wnbE1z0mxHxiDit6ML8kB+XpKu8pw@mail.gmail.com>
Subject: Re: [PATCH 3/6] clk: qcom: apss-ipq6018: mark apcs_alias0_core_clk as critical
To:     Robert Marko <robimarko@gmail.com>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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
> While fixing up the driver I noticed that my IPQ8074 board was hanging
> after CPUFreq switched the frequency during boot, WDT would eventually
> reset it.
>
> So mark apcs_alias0_core_clk as critical since its the clock feeding the
> CPU cluster and must never be disabled.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Fixes: 5e77b4ef1b19 ("clk: qcom: Add ipq6018 apss clock controller")
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  drivers/clk/qcom/apss-ipq6018.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> index be952d417ded..f2f502e2d5a4 100644
> --- a/drivers/clk/qcom/apss-ipq6018.c
> +++ b/drivers/clk/qcom/apss-ipq6018.c
> @@ -56,7 +56,7 @@ static struct clk_branch apcs_alias0_core_clk = {
>                         .parent_hws = (const struct clk_hw *[]){
>                                 &apcs_alias0_clk_src.clkr.hw },
>                         .num_parents = 1,
> -                       .flags = CLK_SET_RATE_PARENT,
> +                       .flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
>                         .ops = &clk_branch2_ops,
>                 },
>         },
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
