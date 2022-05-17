Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E4B52AA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351929AbiEQSS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244889AbiEQSSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:18:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B27506EC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:18:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id kq17so36286731ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qH8JUwLx+nM2xLEZwshDyeOy6cvrct0hZrP49LTkuDM=;
        b=EY9f44uXKvLkOY8iZd14BHawAhNUN5U4GqSLHNYuqKHcKS0Qke1+e4dR2Lr2q+pgtm
         PuNJGHYdn8j0Q/PHfKAhuitiiKnVmprU51irprKmrChcHh4UC7xaOLSS3bNfv3rRF2Ws
         I6aoIAW3INBzIFcGpdp5JQMEl5AHmprHor3Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qH8JUwLx+nM2xLEZwshDyeOy6cvrct0hZrP49LTkuDM=;
        b=O0+dHJGvYh1PuKF3ZtRxTUqvAn0yHX54QBdvo0/FMpWFwSAnWbFVosRjpkCHisrmIC
         xlDwTRFXGRwN/H/PqcUPwIe4unSSOcjtM7E6hKXqef3hFSHTFSa6K5WtoebMMpTCRriZ
         hlyAMiqyff7NFRzPmqJNcemTyBXqjaOX6V/mxunzjAFLN2cPxLrDiBPS16nuao2IwUlo
         YcqIDSmM6KQSRWfBMSO/sYV4PCCGiLwHQvsq1z66/RJBvOKFCfUWj5jnsTXURHu3QEhV
         0era1JiwAbGTtrgn9vbHz0qiBzp/tUuw2qcF5IrPGDDNd3oQTbm1CA6oLeOJmYVhi7ow
         lDag==
X-Gm-Message-State: AOAM531Wl8Yv/4cnWwWg0rZ5HNJNpM1PIGE0kKd8mlNYWQEBbEULQbjJ
        kCbDkCDHUMEHQy3jGgycAAlXNVTep37blw==
X-Google-Smtp-Source: ABdhPJze1DT8GG3WBrZ5xs5TA3Q4dQCOfoC7sTVApB6Z4s95DbFlBXY3SMIeLOFjeErymvrSN2O3EQ==
X-Received: by 2002:a17:907:2ce4:b0:6f4:352b:bb9b with SMTP id hz4-20020a1709072ce400b006f4352bbb9bmr20962155ejc.398.1652811499993;
        Tue, 17 May 2022 11:18:19 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id u2-20020aa7db82000000b0042617ba63a7sm7260746edt.49.2022.05.17.11.18.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 11:18:18 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id j25so24828816wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 11:18:17 -0700 (PDT)
X-Received: by 2002:a5d:5009:0:b0:20d:846:f4da with SMTP id
 e9-20020a5d5009000000b0020d0846f4damr10202605wrt.301.1652811497320; Tue, 17
 May 2022 11:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <1652808360-9830-1-git-send-email-quic_khsieh@quicinc.com> <1652808360-9830-2-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1652808360-9830-2-git-send-email-quic_khsieh@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 May 2022 11:18:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U0Ba0th-jmF+3t9BPEisXU2ZmjiahV7YFUqC0fbUrvJQ@mail.gmail.com>
Message-ID: <CAD=FV=U0Ba0th-jmF+3t9BPEisXU2ZmjiahV7YFUqC0fbUrvJQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] phy/qcom: add regulator_set_load to edp/dp phy
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 17, 2022 at 10:26 AM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> This patch add regulator_set_load() to both eDP and DP phy driver
> to have totally control regulators.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 25 +++++++++++++++++++++----
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 24 ++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 4 deletions(-)
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
> +       edp->enable_load[0] = 21800;    /* 1.2 V */
> +       edp->enable_load[1] = 36000;    /* 1.2 V */
> +       edp->disable_load[0] = 4;       /* 0.9 V */
> +       edp->disable_load[1] = 4;       /* 10.9V */

10.9V? That's a lot!


>         ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(edp->supplies), edp->supplies);
>         if (ret)
>                 return ret;
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index b144ae1..c589231 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -3130,6 +3130,8 @@ struct qmp_phy_cfg {
>         int num_resets;
>         /* regulators to be requested */
>         const char * const *vreg_list;
> +       const unsigned int *vreg_enable_load;
> +       const unsigned int *vreg_disable_load;
>         int num_vregs;
>
>         /* array of registers with different offsets */
> @@ -3346,6 +3348,14 @@ static const char * const qmp_phy_vreg_l[] = {
>         "vdda-phy", "vdda-pll",
>  };
>
> +static const unsigned int qmp_phy_vreg_enable_load[] = {
> +       21800, 36000
> +};
> +
> +static const unsigned int qmp_phy_vreg_disable_load[] = {
> +       4, 32
> +};
> +
>  static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
>         .type                   = PHY_TYPE_USB3,
>         .nlanes                 = 1,
> @@ -4072,6 +4082,8 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
>         .reset_list             = msm8996_usb3phy_reset_l,
>         .num_resets             = ARRAY_SIZE(msm8996_usb3phy_reset_l),
>         .vreg_list              = qmp_phy_vreg_l,
> +       .vreg_enable_load       = qmp_phy_vreg_enable_load,
> +       .vreg_disable_load      = qmp_phy_vreg_disable_load,
>         .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>         .regs                   = qmp_v4_usb3phy_regs_layout,
>
> @@ -4139,6 +4151,8 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
>         .reset_list             = msm8996_usb3phy_reset_l,
>         .num_resets             = ARRAY_SIZE(msm8996_usb3phy_reset_l),
>         .vreg_list              = qmp_phy_vreg_l,
> +       .vreg_enable_load       = qmp_phy_vreg_enable_load,
> +       .vreg_disable_load      = qmp_phy_vreg_disable_load,
>         .num_vregs              = ARRAY_SIZE(qmp_phy_vreg_l),
>         .regs                   = qmp_v4_usb3phy_regs_layout,
>
> @@ -5015,6 +5029,11 @@ static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
>                 goto err_reg_enable;
>         }
>
> +       if (cfg->vreg_enable_load) {
> +               for (i = cfg->num_vregs - 1; i >= 0; --i)
> +                       regulator_set_load(qmp->vregs[i].consumer, cfg->vreg_enable_load[i]);
> +       }
> +
>         for (i = 0; i < cfg->num_resets; i++) {
>                 ret = reset_control_assert(qmp->resets[i]);
>                 if (ret) {
> @@ -5116,6 +5135,11 @@ static int qcom_qmp_phy_com_exit(struct qmp_phy *qphy)
>
>         clk_bulk_disable_unprepare(cfg->num_clks, qmp->clks);
>
> +       if (cfg->vreg_disable_load[i]) {
> +               for (i = cfg->num_vregs - 1; i >= 0; --i)
> +                       regulator_set_load(qmp->vregs[i].consumer, cfg->vreg_disable_load[i]);
> +       }
> +
>         regulator_bulk_disable(cfg->num_vregs, qmp->vregs);

You don't haven't needed the regulator_set_load() on
regulator_bulk_disable() for many years now. See commit 5451781dadf8
("regulator: core: Only count load for enabled consumers")

...so the only place you should set the load is in qcom_edp_phy_init()

-Doug
