Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3314C52C639
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiERW1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiERW13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:27:29 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AA416D4A1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:27:26 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id u3so3231354qta.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4e2k0Xzs0N4K3ysaBNCtRHldaZWwVY5QUxC6Y2ywRTc=;
        b=eTFHghXuJ6ffqSdFZkHc9pwFYJ2ct5eV2UB05tO+YLjqqoFMP2y7b6UgbffHNiidTA
         NLa1Z8CVNeTzkORvqOCBxL1lzZnlxw+j6DZdUt82085zHshmD+LAIdtlirSveKGGJBq0
         kdxX78gtzhNMRqW2VfYcX1urWuJuP9q4VP9Ns7r2s5FWtZHBpP92VJXGfcW2jgFwik9S
         aJnvKgN6GwZcrC1hm/Wq6U3ZyL7zl3JJqmqSsE+vqCtpT8sxxp35sHd3amQARNxEH1Xd
         4zUgH1H7f48Q8jK9uzMJrTYtkMVOar/kzVhCDUaxfdlPjAFfmd5kH01I7DGx9u3vqEfq
         yTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4e2k0Xzs0N4K3ysaBNCtRHldaZWwVY5QUxC6Y2ywRTc=;
        b=RpYWPGTxo7/koXjJSRlo6Q+sZ8DFyoilAZJpSTyuCOTS0Q82SBMxD2RhVyUuGQnVh7
         q0xx0PjA7t923y0UJ+9mvxpLd9LSIQwVSYwuuzQ8GVluOzE6d/YZfANR3bIqz+fyR4/y
         QM/qGZNqK81PpNjOr6cdteXq4topGQ8wGchR+9VjSEK17LQcUaBXGgJT3/fb448tmHw2
         +ELN8xKT+JzUyoACkbjHMcOss6hkl9q0h/+yFWyVbKAiwJyREh42YHkU7UKOpGlYdbdB
         e351PVkdYYdg9uSN1MrlsG2a+WeoM8vU828Qd/OZTquxq7WHbBp5nsjGn4Pnufyguda3
         MhCQ==
X-Gm-Message-State: AOAM5335xTmu92WfxylNTX4GywIUp66L2zpSAavsNEsrC0s3N5k4G+FY
        VT22hy2VZMOqKqkC341VFpMolhbv6695jVopVurTQw==
X-Google-Smtp-Source: ABdhPJyWforIMlP/Mylzyx44Pfglhahym13tW4MHFx0tewZ1ZB1zO3uJVZvqSDA4ETYcknhJQXeQpIR4c/HnjW+eEEU=
X-Received: by 2002:ac8:4e45:0:b0:2f9:fc2:ee3a with SMTP id
 e5-20020ac84e45000000b002f90fc2ee3amr561381qtw.370.1652912845789; Wed, 18 May
 2022 15:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <1652909790-16245-1-git-send-email-quic_khsieh@quicinc.com> <1652909790-16245-3-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1652909790-16245-3-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 19 May 2022 01:27:14 +0300
Message-ID: <CAA8EJpoQ5B=iZo=u0Yi4Bgn7b3DHXkf7aKOEzvV3yvFwmRSFhg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] phy/qualcomm: add regulator_set_load to dp phy
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org,
        quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 19 May 2022 at 00:36, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> This patch add regulator_set_load() before enable regulator at
> DP phy driver.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index b144ae1..20ac446 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -3130,6 +3130,7 @@ struct qmp_phy_cfg {
>         int num_resets;
>         /* regulators to be requested */
>         const char * const *vreg_list;
> +       const unsigned int *vreg_enable_load;
>         int num_vregs;
>
>         /* array of registers with different offsets */
> @@ -3346,6 +3347,10 @@ static const char * const qmp_phy_vreg_l[] = {
>         "vdda-phy", "vdda-pll",
>  };
>
> +static const unsigned int qmp_phy_vreg_enable_load[] = {
> +       21800, 36000
> +};
> +
>  static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
>         .type                   = PHY_TYPE_USB3,
>         .nlanes                 = 1,
> @@ -4072,6 +4077,7 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
>         .reset_list             = msm8996_usb3phy_reset_l,
>         .num_resets             = ARRAY_SIZE(msm8996_usb3phy_reset_l),
>         .vreg_list              = qmp_phy_vreg_l,
> +       .vreg_enable_load       = qmp_phy_vreg_enable_load,
>         .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>         .regs                   = qmp_v4_usb3phy_regs_layout,
>
> @@ -4139,6 +4145,7 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
>         .reset_list             = msm8996_usb3phy_reset_l,
>         .num_resets             = ARRAY_SIZE(msm8996_usb3phy_reset_l),
>         .vreg_list              = qmp_phy_vreg_l,
> +       .vreg_enable_load       = qmp_phy_vreg_enable_load,
>         .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>         .regs                   = qmp_v4_usb3phy_regs_layout,

I'd ask again: what about the sdm845? SC8180x? SC7180? Do we need to
change them too?
Currently they will all be handled by the DP driver.

>
> @@ -5008,6 +5015,11 @@ static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
>                 return 0;
>         }
>
> +       if (cfg->vreg_enable_load) {
> +               for (i = cfg->num_vregs - 1; i >= 0; --i)
> +                       regulator_set_load(qmp->vregs[i].consumer, cfg->vreg_enable_load[i]);
> +       }
> +
>         /* turn on regulator supplies */
>         ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
>         if (ret) {
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
