Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E1C52C136
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbiERRMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbiERRMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:12:48 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BD616F922
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:12:45 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id x22so2122745qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y4UE5H+Qnusz3rzEkkxU6stWLdz4Y33ozjvYB3NqVSA=;
        b=RSfjecloRGhRW/UQN5l5aCzWD79I94AuY3gcoVKCy2Sm2uJ096vMywk3fhKDSFmJ7X
         G+f8jBhRW+Ym3igzzeqOrdwoVqtJtOJBwVhQVQoeMCnJosxDcWIZ6JHv1+3ci1bf4XOc
         cIKtiIppRT8cZtrE4qKWndWqNNXq8mUmPmDttHzmn+dqdhz0ZpDpR3jp8veOvHP939o5
         WYQnFlljHxGTTZD9GSN0aO4PALTUrMgQK59P9Tmtieh+8Y9AXmtfYvgoNZxzCnyrSMXy
         zdPpcBnAnzI8VSdapJdBwgBFSXjIToxmFovLpBMqEQLD/1VswfFCFiDzv69F2fSlJMb4
         vRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y4UE5H+Qnusz3rzEkkxU6stWLdz4Y33ozjvYB3NqVSA=;
        b=X5zLXaYl1JSVQgXquz2TcoWr7wK9upNHSmMChP/Y/hIOl7jP4NElsULHEXxlEkFc9f
         YPpLFh7+r7CnFubbT1AvYk5O8IQQ8Scg2/1PfaoZaAq/MOhERSC05LXZXJ+F6n6ALngj
         ymVdVSZgK7xxTi1kTM2bOp5G7O2bE1HqLADcnx0wT1+BGGmTp56DFUcchfjPeZ8TbTG3
         1eOF+nRyOp4zB0SE/KEgvwqOzQtjPeS8TKlXBFEvqiB31IOo/2mDCMoS63ePQ7Z35zLx
         li5w0YdMCgIWzqtNGaQvZKNiuwiG0zWqSs03QSv8FEAZWfa8cscxcDoGXL3rP/WA0TYS
         YFSA==
X-Gm-Message-State: AOAM532iwIgYqyBq9S4JTtdlMdJp1R+Wj6Aeu1B9PoFouk+1+l/Lm/iU
        VZZngdiCqMCsiPiG7xlWXXnuywj1Z6pgGB5gZ1Tdew==
X-Google-Smtp-Source: ABdhPJzkv3ubYpMhhPTvfkO5ywoWAX2qwWiKt0vZwdhBnwnSGCfCgOKT9MWkrczG3oVakt/Wc7XaWJ/Paywb2ErXrbQ=
X-Received: by 2002:ac8:57c2:0:b0:2f3:bd82:241 with SMTP id
 w2-20020ac857c2000000b002f3bd820241mr747818qta.370.1652893964869; Wed, 18 May
 2022 10:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <1652892186-22346-1-git-send-email-quic_khsieh@quicinc.com> <1652892186-22346-2-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1652892186-22346-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 18 May 2022 20:12:33 +0300
Message-ID: <CAA8EJpr9znfxLK+kDstMFFk3V8goyaceGXi4sDc9ghz4eryXMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] phy/qcom: add regulator_set_load to edp/dp phy
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 at 19:43, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> This patch add regulator_set_load() to both eDP and DP phy driver
> to have totally control regulators.
>
> Changes in v2:
> -- no regulator_set_laod() before disable regulator
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 25 +++++++++++++++++++++----
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 13 +++++++++++++

Split into -edp and -qmp part.

>  2 files changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index cacd32f..9b55095 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -87,17 +87,24 @@ struct qcom_edp {
>
>         struct clk_bulk_data clks[2];
>         struct regulator_bulk_data supplies[2];
> +       int enable_load[2];
> +       int disable_load[2];

As noticed in the review of the previous patch, disable_load is unnecessary.

>  };
>
>  static int qcom_edp_phy_init(struct phy *phy)
>  {
>         struct qcom_edp *edp = phy_get_drvdata(phy);
>         int ret;
> +       int num_consumers = ARRAY_SIZE(edp->supplies);
> +       int i;
>
> -       ret = regulator_bulk_enable(ARRAY_SIZE(edp->supplies), edp->supplies);
> +       ret = regulator_bulk_enable(num_consumers, edp->supplies);
>         if (ret)
>                 return ret;
>
> +       for (i = num_consumers - 1; i >= 0; --i)
> +               regulator_set_load(edp->supplies[i].consumer, edp->enable_load[i]);
> +
>         ret = clk_bulk_prepare_enable(ARRAY_SIZE(edp->clks), edp->clks);
>         if (ret)
>                 goto out_disable_supplies;
> @@ -425,9 +432,15 @@ static int qcom_edp_phy_power_off(struct phy *phy)
>  static int qcom_edp_phy_exit(struct phy *phy)
>  {
>         struct qcom_edp *edp = phy_get_drvdata(phy);
> +       int num_consumers = ARRAY_SIZE(edp->supplies);
> +       int i;
>
>         clk_bulk_disable_unprepare(ARRAY_SIZE(edp->clks), edp->clks);
> -       regulator_bulk_disable(ARRAY_SIZE(edp->supplies), edp->supplies);
> +
> +       for (i = num_consumers - 1; i >= 0; --i)
> +               regulator_set_load(edp->supplies[i].consumer, edp->disable_load[i]);
> +
> +       regulator_bulk_disable(num_consumers, edp->supplies);
>
>         return 0;
>  }
> @@ -633,8 +646,12 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       edp->supplies[0].supply = "vdda-phy";
> -       edp->supplies[1].supply = "vdda-pll";
> +       edp->supplies[0].supply = "vdda-1p2";
> +       edp->supplies[1].supply = "vdda-0p9";

NAK, You can not randomly change supply names.

> +       edp->enable_load[0] = 21800;    /* 1.2 V */
> +       edp->enable_load[1] = 36000;    /* 1.2 V */
> +       edp->disable_load[0] = 4;       /* 0.9 V */
> +       edp->disable_load[1] = 4;       /* 10.9V */

Again, 10.9V here. Kuogee. Have you read the review points?

>         ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(edp->supplies), edp->supplies);
>         if (ret)
>                 return ret;
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index b144ae1..0a4c8a8 100644
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
>
> @@ -5008,6 +5015,11 @@ static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
>                 return 0;
>         }
>
> +       if (cfg->vreg_enable_load) {
> +               for (i = cfg->num_vregs - 1; i >= 0; --i)

What's the point of iterating the list backwards?

> +                       regulator_set_load(qmp->vregs[i].consumer, cfg->vreg_enable_load[i]);
> +       }
> +
>         /* turn on regulator supplies */
>         ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
>         if (ret) {
> @@ -5116,6 +5128,7 @@ static int qcom_qmp_phy_com_exit(struct qmp_phy *qphy)
>
>         clk_bulk_disable_unprepare(cfg->num_clks, qmp->clks);
>
> +       /* no minimum load set required before disable regulator */

No need for the comment.

>         regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
>
>         mutex_unlock(&qmp->phy_mutex);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
