Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DEF486E7F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 01:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343849AbiAGAPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 19:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbiAGAPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 19:15:40 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70351C061212
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 16:15:40 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id k15-20020a4a850f000000b002dc3cdb0256so663306ooh.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 16:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=MNyeIISDwaP906Fyw5+wTJ1iyG5+6D9QgHbtTef0zTw=;
        b=BHQjzeDcGe24UGKrK3UHuDDHKFKMvuivbXPMLeOhY99kwMH3AIcd1LKmxfOODHcyiq
         5B1odz88ZZTiyANh5C6KoAmhuDFrsgl/xmOu6PLS16p/dCPi/uUzL9f/j5qVlDptWI5d
         zRrWvzQIMMtfHn+Rmtzz8xDS94tEc2ancboUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=MNyeIISDwaP906Fyw5+wTJ1iyG5+6D9QgHbtTef0zTw=;
        b=OIQNS566V30zCkSZ0Hzu1WUzCtuMqb+54C/2hz2fXNpBeJYntzxry2o68OKMEuZNF2
         U72JEmJSas9g4r86eMqp1xLcquyjTFaD0tPbdYRR3cnmeH4H/uO51+Ic0Y+h3qOfEtvD
         RoqUAmfOiJvGinGzvIq+M/s2HzStH9ybuV4N7MmB19TLS8p74yhV2QLExfPnP7jz/93i
         VSWI6u/RBpzw07PPtlnAacBWMt0t11Z11n+zfi8FWNm+Gq8Dficx29aOk4mOCevBOipW
         962S5ClQIpvtaHUFy1nJg9gJ7lpvxzoZ4A6/z0R9T996yJ22ckZ9WKBHLthQ92nXxa7A
         s0ig==
X-Gm-Message-State: AOAM533o4L6TlOxQN6dAfhKy/IQLzwJdx3M+8bovCehUMryDuKGCOCMX
        mLuY3k/F+xt5Zjl4Dy7AM5l+YYhUiiD4RLwHT3QvZA==
X-Google-Smtp-Source: ABdhPJxxe43QBYYTykv4Vu5bViFJ1xZXLwGzxWBx1KASqdAqJuwtKQfJVr38VaAl71Ec9QZCp7/GqF3T3K/7IgcSk8U=
X-Received: by 2002:a4a:dd08:: with SMTP id m8mr38057741oou.25.1641514539834;
 Thu, 06 Jan 2022 16:15:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jan 2022 16:15:39 -0800
MIME-Version: 1.0
In-Reply-To: <1641489296-16215-1-git-send-email-quic_khsieh@quicinc.com>
References: <1641489296-16215-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 6 Jan 2022 16:15:39 -0800
Message-ID: <CAE-0n52uRJiY2f_u-Kh+8YZ_Ns=OOb3r02UG45oU8PiaMo2XrA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: add support of tps4 (training pattern 4)
 for HBR3
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kuogee Hsieh <khsieh@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-01-06 09:14:56)
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 39558a2..ba70387 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1189,12 +1190,20 @@ static int dp_ctrl_link_train_2(struct dp_ctrl_private *ctrl,
>
>         *training_step = DP_TRAINING_2;
>
> -       if (drm_dp_tps3_supported(ctrl->panel->dpcd))
> +       if (drm_dp_tps4_supported(ctrl->panel->dpcd)) {
> +               pattern = DP_TRAINING_PATTERN_4;
> +               state_ctrl_bit = 4;
> +       }
> +       else if (drm_dp_tps3_supported(ctrl->panel->dpcd)) {
>                 pattern = DP_TRAINING_PATTERN_3;
> -       else
> +               state_ctrl_bit = 3;
> +       }
> +       else {

This should be

	} else {

>                 pattern = DP_TRAINING_PATTERN_2;
> +               state_ctrl_bit = 2;
> +       }
>
> -       ret = dp_catalog_ctrl_set_pattern(ctrl->catalog, pattern);
> +       ret = dp_catalog_ctrl_set_pattern_state_bit(ctrl->catalog, state_ctrl_bit);
>         if (ret)
>                 return ret;
>

With that fixed

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
