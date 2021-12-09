Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA046E11A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhLIDFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhLIDFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:05:10 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3588C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 19:01:37 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id x1-20020a4aea01000000b002c296d82604so1391085ood.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 19:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ySPyFFqtdyuBIHLLUyShef42vTuQW5UVEw4YMSFTCGs=;
        b=fcOFBaKN8igGFkv5Hq4B7LT8hZS+vXtlE7scQQo7aB4iwIcYau2OHRYW5Hr8XJtXdY
         FPxqyzqqLvqLUKNKzo55KbG2bwgwxVsHz5NfdwiuH2UTcoA//BK4vw2rotjNxRBdIYjS
         tXawiWlofuozRlbcisqruXLxzXU4PeKNd8N7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ySPyFFqtdyuBIHLLUyShef42vTuQW5UVEw4YMSFTCGs=;
        b=Hv8bBK5mmMoqNwJQeG/Yv1hXEd4lRmFgWjYg+Z0H7v+3TK5d0zpVcU0eCbIp+oizNY
         CAnlZbFT8KTg35HOmv4iLjjAa+AKPPtT6jT5c3fgBWvwW5eZwpn6QPE8EHhbxeCsDJha
         UtXPfbklRdsVRu43PWkCsp5YPkNqbPUnXR6QWEXOs9k42W53FqAH3O3JjjLC/gUPhPlo
         VRiD5CGJ9PYlvAE3WbtHF6R/suQB0/CdyDe846/zWEw+XCcIUeaW6mBZCGTXHuQfY+qv
         SLniTH15JZyiBqX57M5GV7jVQMsOho74AU+F8bg+GCt2E/qnInuWBuF/CJyLOgvbtzTX
         6M+A==
X-Gm-Message-State: AOAM532BZe2k6acXpS72nacf/MrLKmQ8nGXFZaLiHi5nd27j49ZEybsV
        /W2IIj825P7XoHasLLBMWthj5f+btAL7uOy5YZf2fA==
X-Google-Smtp-Source: ABdhPJzfm1mjganFNfDgL21KPQZnDL2HCeKKT5S1lwgHg6taD+gRMfe1My60dFjkJru25ZQx0pTSz4jer+PE/I2RKY0=
X-Received: by 2002:a4a:cf12:: with SMTP id l18mr2340150oos.25.1639018897050;
 Wed, 08 Dec 2021 19:01:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Dec 2021 19:01:36 -0800
MIME-Version: 1.0
In-Reply-To: <1638985262-2072-1-git-send-email-quic_khsieh@quicinc.com>
References: <1638985262-2072-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 8 Dec 2021 19:01:36 -0800
Message-ID: <CAE-0n51FCOwPeWz=SFaRY58J3=yGnKdE5aHMCGx-tzK_CVEUQQ@mail.gmail.com>
Subject: Re: [PATCH v5] drm/msm/dp: dp_link_parse_sink_count() return
 immediately if aux read failed
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com, sean@poorly.run,
        vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, aravindh@codeaurora.org,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2021-12-08 09:41:02)
> Add checking aux read/write status at both dp_link_parse_sink_count()
> and dp_link_parse_sink_status_filed() to avoid long timeout delay if
> dp aux read/write failed at timeout due to cable unplugged.
>
> Changes in V4:
> -- split this patch as stand alone patch
>
> Changes in v5:
> -- rebase on msm-next branch
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>

Remove this newline please.

> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Tested-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 12 +++++++++---
>  drivers/gpu/drm/msm/dp/dp_link.c    | 19 ++++++++++++++-----
>  2 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 3d61459..0766752 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -692,9 +692,15 @@ static int dp_irq_hpd_handle(struct dp_display_private *dp, u32 data)
>                 return 0;
>         }
>
> -       ret = dp_display_usbpd_attention_cb(&dp->pdev->dev);
> -       if (ret == -ECONNRESET) { /* cable unplugged */
> -               dp->core_initialized = false;
> +       /*
> +        * dp core (ahb/aux clks) must be initialized before
> +        * irq_hpd be handled
> +        */
> +       if (dp->core_initialized) {

This part of the commit isn't described in the commit text. Can you add
some more details in the commit text about this?

> +               ret = dp_display_usbpd_attention_cb(&dp->pdev->dev);
> +               if (ret == -ECONNRESET) { /* cable unplugged */
> +                       dp->core_initialized = false;
> +               }
>         }
>         DRM_DEBUG_DP("hpd_state=%d\n", state);
>
