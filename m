Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F7452C4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbiERUwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242688AbiERUv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:51:58 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1B76AA55
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:51:57 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-f18e6ff0f6so4266124fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=EkJ7c6TDFhhKRa+OTrT6l5LgL8a5FN7wmT5Y/mVgOBY=;
        b=Mz/2VNmF/Qm8XBKO6jjH1wqNziZBqj3x/FvlMJSGBhS8qVox7pMhMTd1dQTEc7+Ko4
         UC0w0+n72k87GmLubXCiTT29p5zwoYExdtWWSM1UBnvP/F7TG1YnWvF3Nejy5yHG7Yw2
         LA4Aqe/62+afm1veBCNg10hLbltcuXqnLE3Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=EkJ7c6TDFhhKRa+OTrT6l5LgL8a5FN7wmT5Y/mVgOBY=;
        b=H7vZm4rVEL6JlHzeKhFJjfGNoIaKADGoVcgDgNuMIX6zo7eVuRCD9rn6XH4PhH0fsy
         kdDdVsqW7Y5mgEScq1ZLhgUX15FIKvoBuQMvtxQkAPGVroVv8+dGIAdppZ/aoWIPvjAq
         8s7S5cbCbKyReHRP1z8GtFkBYHeerxAr2lCbC0I/NdMmNEw6YkhtS4dWEfsIf6H976hn
         t0wJ7AZJ5gwv5FgvvY8lsxZu5W8rGPhHDWqbLIQp7yiy+HNm6y9BKYw/jEFiO9jsQQJ4
         0LOonOXhvY0Z48d++lnE4vhNoLqYU1Y8ZYNbsUy2nauN7CUenDkLZpIFZJe04LSpbqRP
         9gjQ==
X-Gm-Message-State: AOAM530kGv/fgb8z+cEXDjc4oDmMwYezDk0kLgHTpx3+lMhqMGqiwRCT
        haoJp3lqEG6NrbDwa8q5MZlUlyNfxJWT62TAPdaF4A==
X-Google-Smtp-Source: ABdhPJzgJw3GN2UAR/UMlvVpHQSaAwYbNIOCn2Obfjno00YjCblW9KW9QVE/gAlCwH22JwjiaD+tCtmZTlvXU0isFu0=
X-Received: by 2002:a05:6870:240d:b0:f1:b878:e97c with SMTP id
 n13-20020a056870240d00b000f1b878e97cmr739706oap.193.1652907116977; Wed, 18
 May 2022 13:51:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 May 2022 13:51:55 -0700
MIME-Version: 1.0
In-Reply-To: <1652905444-10130-2-git-send-email-quic_khsieh@quicinc.com>
References: <1652905444-10130-1-git-send-email-quic_khsieh@quicinc.com> <1652905444-10130-2-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 18 May 2022 13:51:55 -0700
Message-ID: <CAE-0n533Rf55ypeCY=A4dpxzdviUO3G9NFS41nceds6ZVFt-BQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] phy/qualcomm: add regulator_set_load to edp phy
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should subject be "phy: qcom:" prefix?

Quoting Kuogee Hsieh (2022-05-18 13:24:02)
> This patch add regulator_set_load() before enable regulator at
> eDP phy driver.
>
> Changes in v3:
> -- no regulator_set_load before disable regulator
> -- no supply name string change at probe
> -- split into two patches

These don't go here because this isn't a drm patch.

>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> index cacd32f..00b6726 100644
> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> @@ -635,6 +641,8 @@ static int qcom_edp_phy_probe(struct platform_device *pdev)
>
>         edp->supplies[0].supply = "vdda-phy";
>         edp->supplies[1].supply = "vdda-pll";
> +       edp->enable_load[0] = 21800;    /* 1.2 V */
> +       edp->enable_load[1] = 36000;    /* 1.2 V */

What does the comment mean? This is the load for 1.2V supply? Can we
have that sort of comment instead of "1.2 V"?

>         ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(edp->supplies), edp->supplies);
>         if (ret)
