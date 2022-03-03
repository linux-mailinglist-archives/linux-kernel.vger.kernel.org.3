Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C994CBB76
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiCCKe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbiCCKeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:34:22 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F10832EFD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 02:33:32 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id bc10so4172364qtb.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 02:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hIUIRXFBoXE7LKj0blqQPxppbo/nPIraWqBU8j6waVY=;
        b=VdUl2d8LLr7udWRlgutHX9PzKUBiepsWR4ZGSOZOMFfx4AWeOCur+bRsfqi1tbR81u
         A4E/PYgAMzgVyMWZQZuiIiscLz1FUCnSRb6F+V9OV+YTEokff5b7+/uMR8jigHZ6wIeR
         Ca1blU08Qz0fVJqoNlwxrclYlnOgMQMiZuuFvn9ass0VJRZLfggditK3iHpmZOAFOQY6
         8CsOIemjBsMfjJ/dkxgBtrdOdEEStNkmr8W+cY3bLg/4ONpw8zJ6OtSum7vTE2hSmo5q
         cjv83xod6p2z7GZYj6Vn6C5Z60uj5hrtl/baKGgHEuMRwsApzircFKgSM+k/H5wxlDMg
         exKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hIUIRXFBoXE7LKj0blqQPxppbo/nPIraWqBU8j6waVY=;
        b=ly72IS67gfXZm2AecE1YRTZjLDA40EQ9TQhkYBb25yR7i4R2QYDtlgq1wk3N69tBCb
         YuZxvbXWVQUlmiQm8gun0qEV0q8lw5ktYA3JCbTMIMS7QvUfVk0ECrYiWyinNq38Bdxj
         B14SsXSZDEqZQHyBa2QVpJzcV0ay1rD5kU16yTuiQsdg9JZ0OoIVK7Im26/FJx3kpFko
         IK0ap6ACBRGB/lT+S7RP56u/cAnzsF2MKAfPiVM1seo3lVA2jGTHTWxrSbmVVelDGMG8
         THN69fLhpn4BIjHUWjbJrVqIuAFFx6pDwQPRrabM+Z9r5A0rLbKPqmCW77jlCpJLfmZF
         NqqA==
X-Gm-Message-State: AOAM531XNAJn1JAgVxrubjii1QkftctTr70hw//KMjTjkzOMPMVsCkNg
        AptpHiGOeBqpHbIgNmG7nj9wQzWI2v+KKHN74iY4Ig==
X-Google-Smtp-Source: ABdhPJyr88hvBfvOgw+m1GCaBzh3gAlaA1b0BQe2hsLrUNDuXnLB77Rt8WPohBlyTN1KHHsy5mCgRdnHWPadzhTlr6s=
X-Received: by 2002:a05:622a:1206:b0:2de:6fa4:41fb with SMTP id
 y6-20020a05622a120600b002de6fa441fbmr26633601qtx.295.1646303611639; Thu, 03
 Mar 2022 02:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20220303084824.284946-1-bhupesh.sharma@linaro.org> <20220303084824.284946-4-bhupesh.sharma@linaro.org>
In-Reply-To: <20220303084824.284946-4-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 3 Mar 2022 13:33:20 +0300
Message-ID: <CAA8EJpow=NPM5TrK24qsziVWgrD0cfbtwUxBD45CE2EQAg-msA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] clk: qcom: gcc: Add emac GDSC support for SM8150
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, tdas@codeaurora.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org
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

On Thu, 3 Mar 2022 at 11:48, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Add the EMAC GDSC defines and driver structures for SM8150.
>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/clk/qcom/gcc-sm8150.c               | 10 ++++++++++
>  include/dt-bindings/clock/qcom,gcc-sm8150.h |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
> index 85a431ac417b..08ba29e3a835 100644
> --- a/drivers/clk/qcom/gcc-sm8150.c
> +++ b/drivers/clk/qcom/gcc-sm8150.c
> @@ -3448,6 +3448,15 @@ static struct clk_branch gcc_video_xo_clk = {
>         },
>  };
>

Is it available on sm8150 or only on sa8155au? I think this deserves
at least a comment.

> +static struct gdsc emac_gdsc = {
> +       .gdscr = 0x6004,
> +       .pd = {
> +               .name = "emac_gdsc",
> +       },
> +       .pwrsts = PWRSTS_OFF_ON,
> +       .flags = POLL_CFG_GDSCR,
> +};
> +
>  static struct gdsc usb30_prim_gdsc = {
>         .gdscr = 0xf004,
>         .pd = {
> @@ -3714,6 +3723,7 @@ static const struct qcom_reset_map gcc_sm8150_resets[] = {
>  };
>
>  static struct gdsc *gcc_sm8150_gdscs[] = {
> +       [EMAC_GDSC] = &emac_gdsc,
>         [USB30_PRIM_GDSC] = &usb30_prim_gdsc,
>         [USB30_SEC_GDSC] = &usb30_sec_gdsc,
>  };
> diff --git a/include/dt-bindings/clock/qcom,gcc-sm8150.h b/include/dt-bindings/clock/qcom,gcc-sm8150.h
> index 3e1a91876610..40596b9ded06 100644
> --- a/include/dt-bindings/clock/qcom,gcc-sm8150.h
> +++ b/include/dt-bindings/clock/qcom,gcc-sm8150.h
> @@ -243,5 +243,6 @@
>  /* GCC GDSCRs */
>  #define USB30_PRIM_GDSC                     4
>  #define USB30_SEC_GDSC                                         5
> +#define EMAC_GDSC                                              6
>
>  #endif
> --
> 2.35.1
>


-- 
With best wishes
Dmitry
