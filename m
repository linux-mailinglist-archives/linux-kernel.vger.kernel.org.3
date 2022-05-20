Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A4C52EFFF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351316AbiETQDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351285AbiETQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:03:51 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E102417CE65
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:03:49 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bs17so7262190qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MdtVgPrWdCotf9wN05tQ+Fm3z+o2BvCtpjvU0RkkeHQ=;
        b=OsHMli1EJDxKXD0oi4SI7BaQUT1mjWDBkNrth0PCuX6BjsKhbMRNNEJzRIAgWpMl4z
         FGjHEJw1fvk4l7PKUjSUZmZCqcnHe+c43wexzoH178vn1P9Drtlbx9FscKjKPIDp+gUC
         T0x+kjKdJtMzvE9TQqSsmQpt6eSng1upz0HbOkRCuk03vPSQd8vxDcJYneFSIbzuchxn
         eYHLDPeYauskzn826Zu3eH4yUPm20noiaBFKz5mN6kkB1BUWtp/Svlg9aGajFByOGvj6
         ygElPF7dN2wNSlLp+alJ3+4vv89ibYmWa/45f0U3ZUqfvK2JzfaCTzYSN4SztwnlvdNu
         XbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdtVgPrWdCotf9wN05tQ+Fm3z+o2BvCtpjvU0RkkeHQ=;
        b=eZYv1RFqHSbvnY0Hyw9CpWbR9Zx6Z9OqSBLsbLG4ZxNC/rlO033TZ2mRZPlVnqZTD6
         R0g7rprEGPdyNjfzvZ2ytu0g9MelHGw7kVrMooNXAHQZnC2Na14VFK6rr8Kgzl5segTH
         J6LfVjVpNKKyxoxPWT9eCJhiSo5sxU8jn1WdpAaUMblukkvPELTmug4Tee8aESdMyohk
         CDJ5mL6L+eDPTsawo+gS7p5MGqX/Fc3bT52C7YCfag5DaKMWI3AMot6mnyHmUqHrfdQL
         5r4+ps5oc4CqrHAtiV0sAC7+mMDlA2+BIsFL0QRcy6c9pKqZ78N/6LBtvdoRIr1BTo1/
         Bcog==
X-Gm-Message-State: AOAM5328NmiO1u0uW0queAIyPy+rUX+cliKX5/FGWklhZrrLjAx1dAD6
        oF5w4yTTMao67KskxBJUqI3a8G07XRk/05SUwxw40w==
X-Google-Smtp-Source: ABdhPJzLjUPH898P83+vLG4zDKSCgyesRwhebPGxJnX+Fd1ta1QNiUqPpPdwg3enEOBka0JBQPB7eL6M+5RJN8NwMag=
X-Received: by 2002:a37:582:0:b0:6a3:2ce4:3c72 with SMTP id
 124-20020a370582000000b006a32ce43c72mr6289694qkf.203.1653062628721; Fri, 20
 May 2022 09:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <1653060079-11086-1-git-send-email-quic_khsieh@quicinc.com> <1653060079-11086-2-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1653060079-11086-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 20 May 2022 19:03:37 +0300
Message-ID: <CAA8EJpp6dF_44=_ZsYP46JabV-MyW+3NtpKi45z4=m5wYhR7zA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] phy: qcom-edp: add regulator_set_load to edp phy
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

On Fri, 20 May 2022 at 18:21, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> This patch add regulator_set_load() before enable regulator at
> eDP phy driver.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index cacd32f..6715dd2 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -87,14 +87,20 @@ struct qcom_edp {
>
>         struct clk_bulk_data clks[2];
>         struct regulator_bulk_data supplies[2];
> +       int enable_load[2];
>  };
>
>  static int qcom_edp_phy_init(struct phy *phy)
>  {
>         struct qcom_edp *edp = phy_get_drvdata(phy);
>         int ret;
> +       int num_consumers = ARRAY_SIZE(edp->supplies);

Please. Leave the ARRAY_SIZE in place, rather than moving it to the variable.

> +       int i;
>
> -       ret = regulator_bulk_enable(ARRAY_SIZE(edp->supplies), edp->supplies);
> +       for (i = 0; i < num_consumers; i++)
> +               regulator_set_load(edp->supplies[i].consumer, edp->enable_load[i]);
> +
> +       ret = regulator_bulk_enable(num_consumers, edp->supplies);
>         if (ret)
>                 return ret;
>
> @@ -635,6 +641,8 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>
>         edp->supplies[0].supply = "vdda-phy";
>         edp->supplies[1].supply = "vdda-pll";
> +       edp->enable_load[0] = 21800;    /* load for 1.2 V vdda-phy supply */
> +       edp->enable_load[1] = 36000;    /* load for 0.9 V vdda-pll supply */
>         ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(edp->supplies), edp->supplies);
>         if (ret)
>                 return ret;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>


-- 
With best wishes
Dmitry
