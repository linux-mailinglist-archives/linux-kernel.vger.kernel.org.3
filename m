Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DED450BFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiDVSqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiDVSqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:46:14 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FD2F2A1D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:41:26 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-e5ca5c580fso9512395fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=6gjAV10Iy0bb8vJ2mOVMB0SZrY0b5n77L6j1RU8VdXM=;
        b=UQLEZxu3Gnefj4+OtaImRrfZBjyDsrGOwqT3L4D8+PELfmRybKg6N+U9kwXbBNec8B
         qKpVkU06TkaCo4dktwV6f4nhGtJIzV103OXK13R6QipAYixnIGfC1U+WJMelXl3+cQ94
         IIkClZnxp2vThBevLk9Vg09fFu4m+FnV5PonI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=6gjAV10Iy0bb8vJ2mOVMB0SZrY0b5n77L6j1RU8VdXM=;
        b=u1pGpT/q2Y8LedLmd8krTqK0kZqOelQkSEWocveYKJeEniBy3/QLoVIR7ZWPeYD6Z2
         PuYwu7fgNIhMfpML2FBYVyebPI0Dg1NIEJUjE430aiD/5xQqxOSKuVr2eezHTMBaSCrm
         VfM8NQx4rDHTwYbPE39NzKlx+AhgVg4yRHiAbGFdvwftzJQI1JZSgfc/+FIVnUF5oLN6
         RC8xTC344v1fNK2w5s1rp5+r/YUAvn1AZMCtGxO5/5/TGiKe15IXyWpoa3pHXdP9ia7o
         g6SGLLV9vZ7HXbFGK6ezefBIM68PuRdbs/wWihH9eznTqdRdwoeLrBJqFSuy2GKlx8nN
         Yr8g==
X-Gm-Message-State: AOAM533V0wrf6ZVmlmMZcLExd9lLbN4ph++/cjfy/qWnGvm2fvcuagXr
        A1mmjfY8NbNmUzoImMtrAExC2/GX8QAcXUAz9w+zXw==
X-Google-Smtp-Source: ABdhPJxjCR1tRv5Vi4Nt0QWTz2GZsD8/5wZBQ5hBZZW11jMP7uvutfanuEQOvf2fWtfAZz7mqXvfI8Y23sNg2MX1b3Q=
X-Received: by 2002:a05:6870:15ca:b0:e9:551:6d1c with SMTP id
 k10-20020a05687015ca00b000e905516d1cmr1291139oad.193.1650652758892; Fri, 22
 Apr 2022 11:39:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Apr 2022 11:39:18 -0700
MIME-Version: 1.0
In-Reply-To: <20220422084951.2776123-1-lv.ruyi@zte.com.cn>
References: <20220422084951.2776123-1-lv.ruyi@zte.com.cn>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 22 Apr 2022 11:39:18 -0700
Message-ID: <CAE-0n52nFSUA-3CWa81mE-WUFW8pjOwYsFp-eGOkzupg2cZ9Yg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: fix error check return value of irq_of_parse_and_map()
To:     cgel.zte@gmail.com, quic_abhinavk@quicinc.com, robdclark@gmail.com,
        sean@poorly.run
Cc:     airlied@linux.ie, daniel@ffwll.ch, dmitry.baryshkov@linaro.org,
        quic_khsieh@quicinc.com, bjorn.andersson@linaro.org,
        linux@roeck-us.net, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting cgel.zte@gmail.com (2022-04-22 01:49:51)
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> The irq_of_parse_and_map() function returns 0 on failure, and does not
> return an negative value.
>
> Fixes:  8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index a42732b67349..3926d2ac107d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1239,7 +1239,7 @@ int dp_display_request_irq(struct msm_dp *dp_display)
>         dp = container_of(dp_display, struct dp_display_private, dp_display);
>
>         dp->irq = irq_of_parse_and_map(dp->pdev->dev.of_node, 0);

Why can't platform_get_irq() be used?

> -       if (dp->irq < 0) {
> +       if (!dp->irq) {
>                 rc = dp->irq;

zero as an error return value is an error?

>                 DRM_ERROR("failed to get irq: %d\n", rc);
>                 return rc;
