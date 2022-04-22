Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C659850B573
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446777AbiDVKpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446696AbiDVKpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:45:02 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C271DE1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:42:08 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i20so13724594ybj.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sRlCrOg5yqyYWcX3Vmg+YXtz00jXFt02K1SvmfVHuEo=;
        b=YZKNNVCdCW1H9YpHWN2WwcXTeHpzenuCACQWt1cFsofkPWDjj+CZhGo5qBz34bXMrL
         a8sGChDb4rj11K4jsnxJQrpcCmi/sg7315+vVhjz+9kcNVq0RLVpAunksA3AeNO7kccO
         QnNI74QbFKhy8/7Hn2169LoSjveGvAA/Z6ar8aCW0HQP89inqH/9L9x7cFs3j0YJMi24
         Vjl4hdYaqEQWvZhlLqiDMVG79bCKBj8oRlloEsu3mrlqK7q7t842V9yGwDbx4guv3qh6
         zSgBtiXdqIR3W3Eg+4JrHKGcvBwnvXDx2oadjegPOLpPoCnkhqXvmyP5PynUzjZz/MkE
         hD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sRlCrOg5yqyYWcX3Vmg+YXtz00jXFt02K1SvmfVHuEo=;
        b=6mf14xJJioWeh0pBWWg7w3JvNl4ZYKLPqyuI1gi++aYLS5yDa5wHH+0Yzu1ITGM1fo
         F4jLMx+FmoP3cg34lluaD+SUpV81t3N2bMrsCgvsU6wNwJVCLLqFTmMShYv31XNn4H2C
         6D2/48ML/WQQd5HCyML8rCodxGauE/xRD1uzsK+Kvq7B/gpI3hYyw2A4zcQ3N3iCIrst
         /ylvFlqcmp8V0ZeJ5OnCXj6rd04slbDPuUr9/DAl8KqnLDsCYuM5CY03CUNkQrK7gUX+
         eFmn5vpl+CcXtXgM5E+2P0oSiPK+DRFjuwp41BZp8uukUEnD+0LMMGueMdEs6chxC/99
         UDXg==
X-Gm-Message-State: AOAM530ATBqWuPtklKJHCnTi2WB/m8FFkO1zeG+UwJHtYsgCVc81BIJn
        R5x64krAPUKAaFbCIhdwAuGrpVImRlX8tdh0KI2fXw==
X-Google-Smtp-Source: ABdhPJy+O9d88W+UfOJ7vyvqvuTfKHdZH3HhJTpSFNYmS29n1nw7GUb9A4Lca7pUm7kxAmK0DqCAl/r83g43Qgqyask=
X-Received: by 2002:a25:d507:0:b0:63d:a541:1a8c with SMTP id
 r7-20020a25d507000000b0063da5411a8cmr3865477ybe.92.1650624127547; Fri, 22 Apr
 2022 03:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084951.2776123-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220422084951.2776123-1-lv.ruyi@zte.com.cn>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 22 Apr 2022 13:41:56 +0300
Message-ID: <CAA8EJpqJrWpRo_DJJdJqSMyDUyJJt3L3S7dNuWw6YeQgsp+TkA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: fix error check return value of irq_of_parse_and_map()
To:     cgel.zte@gmail.com
Cc:     robdclark@gmail.com, sean@poorly.run, quic_abhinavk@quicinc.com,
        airlied@linux.ie, daniel@ffwll.ch, swboyd@chromium.org,
        quic_khsieh@quicinc.com, bjorn.andersson@linaro.org,
        linux@roeck-us.net, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 11:50, <cgel.zte@gmail.com> wrote:
>
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> The irq_of_parse_and_map() function returns 0 on failure, and does not
> return an negative value.
>
> Fixes:  8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

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
> -       if (dp->irq < 0) {
> +       if (!dp->irq) {
>                 rc = dp->irq;
>                 DRM_ERROR("failed to get irq: %d\n", rc);
>                 return rc;
> --
> 2.25.1
>


-- 
With best wishes
Dmitry
