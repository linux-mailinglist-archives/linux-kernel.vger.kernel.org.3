Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23E534529
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 22:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345171AbiEYUmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 16:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiEYUmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:42:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA6737ABD
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:42:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id wh22so43824554ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1tmkvp6sDA4X5j5VRkmkL2D7IkhmAAW95A+ijZhkJU=;
        b=hdSlEDp6nSKW7SL4b+AAwfShBQ5wbLAsHH1qJvozSkZcPfy7F/OpM87KatYUA6vrCY
         YxJ6g9EIN21FrdFF6xXIgjDU7gyTD6ce6WiCIQSDeEly7Ydtv7jbbckJmndfgWjC7Xwd
         D/tuOIe/q2WnOKZglCmgOxs0ik1oxM7G9rcbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1tmkvp6sDA4X5j5VRkmkL2D7IkhmAAW95A+ijZhkJU=;
        b=JQNTfBRh9MoIy0o4RrTk4uyHsY6ol1PRJrmHtXUk4JriTbYtyXCuHmkbxsmXQ2JzVc
         Qt5RFMEO6M4ka1mbJjkTTdfA0p0mX33SUxgxNyI62LycV5/c0PS8bL23Ru9Ut+XIYriI
         mhUHLe/4aM3wekQbob+5gErUaqIhkpgTveeMOx+j5QS+olqZ6mbiu3EpSEeeRAX2MZV7
         xtbbhwM2Ql+5I3oGnRowKbybGPX4wcR3P8fskyeuch4hObKqggTtGvSa1pWrrAMBoSMU
         MP7faN2e7fx5WxvuOhoEc0ZHoze9jQblL6udGQoYMWN/XtZATZVgpoeIM4sFFyz7za2p
         LnhQ==
X-Gm-Message-State: AOAM533p2wZJdRd+Clr3CwrE8Olgt9YHsTJsqq6EfElSFmmFsgsrtNOd
        8OYQjEISTZxs8ZTKiS5ro+zJAotqzWunXSONHu0=
X-Google-Smtp-Source: ABdhPJyHYfgBpanliJcc63qfXs+ffwROYx5QIu0TIN0qpFdKiM0JmrJJFOqiHmaHzwsmf9XTEEOFSw==
X-Received: by 2002:a17:906:9749:b0:6f5:6cd:5bd9 with SMTP id o9-20020a170906974900b006f506cd5bd9mr31923584ejy.523.1653511336531;
        Wed, 25 May 2022 13:42:16 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906024500b006fe8bf56f53sm8097152ejl.43.2022.05.25.13.42.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 13:42:15 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id s28so31526016wrb.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:42:14 -0700 (PDT)
X-Received: by 2002:a05:6000:1548:b0:20f:c4e3:637a with SMTP id
 8-20020a056000154800b0020fc4e3637amr19353512wry.513.1653511334048; Wed, 25
 May 2022 13:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <1653507433-22585-1-git-send-email-quic_khsieh@quicinc.com> <1653507433-22585-3-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1653507433-22585-3-git-send-email-quic_khsieh@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 25 May 2022 13:42:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VgZi7TpC6q2jvE+jfUQxUjXRZP3QAp-aP39zfD1XjRkg@mail.gmail.com>
Message-ID: <CAD=FV=VgZi7TpC6q2jvE+jfUQxUjXRZP3QAp-aP39zfD1XjRkg@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] phy: qcom-qmp: add regulator_set_load to dp phy
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
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 25, 2022 at 12:37 PM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> This patch add regulator_set_load() before enable regulator at
> DP phy driver.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 41 +++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index b144ae1..5fda39f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -3075,6 +3075,17 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
>         QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_PRE_GAIN, 0x2e),
>  };
>
> +/* list of regulators */
> +struct qmp_regulator_data {
> +       const char *name;
> +       unsigned int enable_load;
> +};
> +
> +struct qmp_regulator_data qmp_phy_vreg_l[] = {
> +       { .name = "vdda-phy", .enable_load = 21800 },
> +       { .name = "vdda-pll", .enable_load = 36000 },
> +};
> +
>  struct qmp_phy;
>
>  /* struct qmp_phy_cfg - per-PHY initialization config */
> @@ -3129,7 +3140,7 @@ struct qmp_phy_cfg {
>         const char * const *reset_list;
>         int num_resets;
>         /* regulators to be requested */
> -       const char * const *vreg_list;
> +       const struct qmp_regulator_data *vreg_list;
>         int num_vregs;
>
>         /* array of registers with different offsets */
> @@ -3341,11 +3352,6 @@ static const char * const sdm845_pciephy_reset_l[] = {
>         "phy",
>  };
>
> -/* list of regulators */
> -static const char * const qmp_phy_vreg_l[] = {
> -       "vdda-phy", "vdda-pll",
> -};
> -
>  static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
>         .type                   = PHY_TYPE_USB3,
>         .nlanes                 = 1,
> @@ -5488,16 +5494,33 @@ static int qcom_qmp_phy_vreg_init(struct device *dev, const struct qmp_phy_cfg *
>  {
>         struct qcom_qmp *qmp = dev_get_drvdata(dev);
>         int num = cfg->num_vregs;
> -       int i;
> +       int ret, i;
>
>         qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
>         if (!qmp->vregs)
>                 return -ENOMEM;
>
>         for (i = 0; i < num; i++)
> -               qmp->vregs[i].supply = cfg->vreg_list[i];
> +               qmp->vregs[i].supply = cfg->vreg_list[i].name;
>
> -       return devm_regulator_bulk_get(dev, num, qmp->vregs);
> +       ret = devm_regulator_bulk_get(dev, num, qmp->vregs);
> +       if (ret) {
> +               dev_err(dev, "failed at devm_regulator_bulk_get\n");
> +               goto err;

There's no reason for a goto and in general kernel style that I've
seen would suggest just "return ret;" here


> +       }
> +
> +       for (i = 0; i < num; i++) {
> +               ret = regulator_set_load(qmp->vregs[i].consumer,
> +                                       cfg->vreg_list[i].enable_load);

super nitty, but there should be one more space before "cfg" to line
up under the parenthesis.


> +               if (ret) {
> +                       dev_err(dev, "failed to set load at %s\n",
> +                               qmp->vregs[i].supply);
> +                       break;

optional: I guess I don't care tons, but I'd be tempted to just
"return ret;" here. Then at the end of the function just "return 0;"


All of these are pretty nitty though, so I'm happy enough with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

On Wed, May 25, 2022 at 12:37 PM Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> This patch add regulator_set_load() before enable regulator at
> DP phy driver.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 41 +++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index b144ae1..5fda39f 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -3075,6 +3075,17 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_pcs_misc_tbl[] = {
>         QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_G4_PRE_GAIN, 0x2e),
>  };
>
> +/* list of regulators */
> +struct qmp_regulator_data {
> +       const char *name;
> +       unsigned int enable_load;
> +};
> +
> +struct qmp_regulator_data qmp_phy_vreg_l[] = {
> +       { .name = "vdda-phy", .enable_load = 21800 },
> +       { .name = "vdda-pll", .enable_load = 36000 },
> +};
> +
>  struct qmp_phy;
>
>  /* struct qmp_phy_cfg - per-PHY initialization config */
> @@ -3129,7 +3140,7 @@ struct qmp_phy_cfg {
>         const char * const *reset_list;
>         int num_resets;
>         /* regulators to be requested */
> -       const char * const *vreg_list;
> +       const struct qmp_regulator_data *vreg_list;
>         int num_vregs;
>
>         /* array of registers with different offsets */
> @@ -3341,11 +3352,6 @@ static const char * const sdm845_pciephy_reset_l[] = {
>         "phy",
>  };
>
> -/* list of regulators */
> -static const char * const qmp_phy_vreg_l[] = {
> -       "vdda-phy", "vdda-pll",
> -};
> -
>  static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
>         .type                   = PHY_TYPE_USB3,
>         .nlanes                 = 1,
> @@ -5488,16 +5494,33 @@ static int qcom_qmp_phy_vreg_init(struct device *dev, const struct qmp_phy_cfg *
>  {
>         struct qcom_qmp *qmp = dev_get_drvdata(dev);
>         int num = cfg->num_vregs;
> -       int i;
> +       int ret, i;
>
>         qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
>         if (!qmp->vregs)
>                 return -ENOMEM;
>
>         for (i = 0; i < num; i++)
> -               qmp->vregs[i].supply = cfg->vreg_list[i];
> +               qmp->vregs[i].supply = cfg->vreg_list[i].name;
>
> -       return devm_regulator_bulk_get(dev, num, qmp->vregs);
> +       ret = devm_regulator_bulk_get(dev, num, qmp->vregs);
> +       if (ret) {
> +               dev_err(dev, "failed at devm_regulator_bulk_get\n");
> +               goto err;
> +       }
> +
> +       for (i = 0; i < num; i++) {
> +               ret = regulator_set_load(qmp->vregs[i].consumer,
> +                                       cfg->vreg_list[i].enable_load);
> +               if (ret) {
> +                       dev_err(dev, "failed to set load at %s\n",
> +                               qmp->vregs[i].supply);
> +                       break;
> +               }
> +       }
> +
> +err:
> +       return ret;
>  }
>
>  static int qcom_qmp_phy_reset_init(struct device *dev, const struct qmp_phy_cfg *cfg)
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
