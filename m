Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5444EE4AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbiCaXZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243050AbiCaXYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:24:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE2E24D9BE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:23:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g22so1049101edz.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VA4OmUlBn+h032QaRrbwfz0ENP/lgrthHNuo2cDc9zs=;
        b=nYjHIf8uflbZHObYpxif9B5oD9Wtb4t5AI1eCWohJX41q9UAn/abH6xMu9omxNFwsr
         7qUSDGsPXh0wIhNznI1YcZUJupDndJZzHhIHEE8hHppvHxSa6v170I7xv/CDtTfwhCpF
         kzEWwkEZCviEfCOEDQ+sa6YJGh6+XAWttUpDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VA4OmUlBn+h032QaRrbwfz0ENP/lgrthHNuo2cDc9zs=;
        b=nB7dmW+vO6L2fAGzJE3roF+vpnkQMDq/sRHq3K8aS+M+b27wta7pQb+1ntBsFzQGDu
         p2AzaLv8SfhJWLfdXx0TyntbKUN2XvFXPaT9jU8VyPJp4CvBwJD7Bn5jIVAdHNDf1LEb
         QOc5JcQgVAp+P616/7RZc4Zp8aNR6a+cIAt6I8vjmTQ0vEDZaBdCL0sC/BbgE/3leFKe
         vUqkdabU2leHnZef3qYiJloL8OURLkTKxCXdWzHjdr4UltEyknwNOerOvLouro0uplDW
         yi5xliuR5Bj5cDRNNaDwoGS1p6wdYPrrEoK7X1/xqT09Q1de+NHKCI63lKytWOPIh3tz
         ygDQ==
X-Gm-Message-State: AOAM533azyXY20N7CzU+HqmbzITZ/5XgtUSZhxClkRHXmx85pDDYzTju
        25QFGT/S3CnoiyjBcz2ZF8VwPD7Wo+iILVjh
X-Google-Smtp-Source: ABdhPJzXMgZilbw8HT6aoE3hYf/pV6qd0Cnizp3xMTvu1jWfx7IhUstDe3roFvaNx28UfeaNTJ1pjg==
X-Received: by 2002:a05:6402:35ca:b0:419:5a2d:9b87 with SMTP id z10-20020a05640235ca00b004195a2d9b87mr18304694edc.174.1648768981256;
        Thu, 31 Mar 2022 16:23:01 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id gn33-20020a1709070d2100b006dfcce8be86sm302318ejc.225.2022.03.31.16.22.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 16:22:59 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id h4so1749755wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:22:58 -0700 (PDT)
X-Received: by 2002:adf:fc47:0:b0:203:dda1:4311 with SMTP id
 e7-20020adffc47000000b00203dda14311mr5685367wrs.301.1648768978217; Thu, 31
 Mar 2022 16:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <1648656179-10347-1-git-send-email-quic_sbillaka@quicinc.com> <1648656179-10347-4-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1648656179-10347-4-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 31 Mar 2022 16:22:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X_ULva3J-Y7EF+0VPRRoFXSmtuKcXG9H=041Kmwa=W4A@mail.gmail.com>
Message-ID: <CAD=FV=X_ULva3J-Y7EF+0VPRRoFXSmtuKcXG9H=041Kmwa=W4A@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] drm/msm/dp: Support only IRQ_HPD and REPLUG
 interrupts for eDP
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        quic_aravindh@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 30, 2022 at 9:03 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> @@ -1374,6 +1382,12 @@ static int dp_pm_resume(struct device *dev)
>         dp_catalog_ctrl_hpd_config(dp->catalog);
>
>
> +       if (dp->dp_display.connector_type == DRM_MODE_CONNECTOR_DisplayPort)
> +               dp_catalog_hpd_config_intr(dp->catalog,
> +                               DP_DP_HPD_PLUG_INT_MASK |
> +                               DP_DP_HPD_UNPLUG_INT_MASK,
> +                               true);
> +

nit: why are there two blank lines above?


> @@ -1639,6 +1653,9 @@ void dp_bridge_enable(struct drm_bridge *drm_bridge)
>                 return;
>         }
>
> +       if (dp->connector_type == DRM_MODE_CONNECTOR_eDP)
> +               dp_hpd_plug_handle(dp_display, 0);
> +

Should you add a "pre_enable" and do it there? That would make it more
symmetric with the fact that you have the countertpart in
"post_disable".


Overall: I'm probably not familiar enough with this code to give it a
full review. I'm hoping that Dmitry knows it well enough... ;-)


-Doug
