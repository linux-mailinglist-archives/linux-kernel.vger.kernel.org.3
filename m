Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55698505D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346803AbiDRRGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244917AbiDRRGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:06:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C551C2AC54
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:03:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t25so18118035edt.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEVLLEtF9oBKLDY/ohm3uW1ISyX/Spn5iFJqT7mqbpw=;
        b=CkRHRcAvDhWXXNqsvkhQFf/OOmlSEkzFiHGj8pHVvAe/BuBS/kEYgJxBVd3LKdP1Ce
         3Kt+Ihjf7GT/i1PRLMbT3wbuHtoLMJbfRpDrV3Gcj+uBKCorEJyl/vPXFo+rq3fos16M
         xCm8iA6xiiyFWLajUCJUQmy1TVAYkZezlrCc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEVLLEtF9oBKLDY/ohm3uW1ISyX/Spn5iFJqT7mqbpw=;
        b=T/MS+lm3LAIUZ9Srv1lH68IdwY+C2NuiO5Hmcy7JRyq6IDgFuWfUUbMYdLyur+W2yg
         XoObHMW8L8I1fwr4LI83iCwajteRGRitlk9/6ERdOvms+GA4rNJA6HZE2D2yJJPCs5z7
         sKcSEDy1lnWafDJWtG93lNtna8M+2JSp8x3MqLuGbXi7HdBkKE7rrJxrBhnXfw/cqX/w
         yS56KyLoa7OvABXRKmFKmmKIGEYGRDPCqFButloV4VYN67UCoRW4ItGlR/ZgHTXPI/di
         Uzcx7lwrZ7Ke/BA5aImMm5G/FQC9CeO0mN4l8zMahL73VLxi5Ab3v2PYKVmvvO5JkRK9
         cC5w==
X-Gm-Message-State: AOAM533z0JfPh+55CFiw42tSDX/DRdhCvzDE97gdR8hHZbQlxCWH0rQE
        8bs46w4Rj6KKOR8en2RhdtorNlmiPg6gLQ==
X-Google-Smtp-Source: ABdhPJzKblmkGmW4BJWAdPCkXEAEszp0RcP4SDs0+ONlLmyytd5uvm2hRn1YEevrZ3oHeiQ58j/Hwg==
X-Received: by 2002:a05:6402:d62:b0:41d:79e6:1617 with SMTP id ec34-20020a0564020d6200b0041d79e61617mr13255033edb.378.1650301408883;
        Mon, 18 Apr 2022 10:03:28 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id k14-20020a170906128e00b006e4b67514a1sm4807085ejb.179.2022.04.18.10.03.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 10:03:27 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id ay11-20020a05600c1e0b00b0038eb92fa965so12117669wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:03:27 -0700 (PDT)
X-Received: by 2002:a05:600c:210b:b0:38e:c62a:398b with SMTP id
 u11-20020a05600c210b00b0038ec62a398bmr16056507wml.118.1650301406391; Mon, 18
 Apr 2022 10:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220418165642.2218514-1-dianders@chromium.org> <20220418095557.v2.3.I9ee239f6b95b944c8fa030f300ad222a7af9899d@changeid>
In-Reply-To: <20220418095557.v2.3.I9ee239f6b95b944c8fa030f300ad222a7af9899d@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Apr 2022 10:03:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xd27oxROMN18svqhLi5pdyi0AED3ksCwwPYB7ESr8J0g@mail.gmail.com>
Message-ID: <CAD=FV=Xd27oxROMN18svqhLi5pdyi0AED3ksCwwPYB7ESr8J0g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/panel: atna33xc20: Take advantage of
 wait_hpd_asserted() in struct drm_dp_aux
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 18, 2022 at 9:58 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Let's add support for being able to read the HPD pin even if it's
> hooked directly to the controller. This will let us take away the
> waiting in the AUX transfer functions of the eDP controller drivers.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Change is_hpd_asserted() to wait_hpd_asserted()
>
>  .../gpu/drm/panel/panel-samsung-atna33xc20.c  | 38 ++++++++++++-------
>  1 file changed, 25 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> index 20666b6217e7..7f9af3e9aeb8 100644
> --- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> +++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
> @@ -19,6 +19,10 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_panel.h>
>
> +/* T3 VCC to HPD high is max 200 ms */
> +#define HPD_MAX_MS     200
> +#define HPD_MAX_US     (HPD_MAX_MS * 1000)
> +
>  struct atana33xc20_panel {
>         struct drm_panel base;
>         bool prepared;
> @@ -30,6 +34,7 @@ struct atana33xc20_panel {
>
>         struct regulator *supply;
>         struct gpio_desc *el_on3_gpio;
> +       struct drm_dp_aux *aux;
>
>         struct edid *edid;
>
> @@ -90,20 +95,25 @@ static int atana33xc20_resume(struct device *dev)
>                 return ret;
>         p->powered_on_time = ktime_get();
>
> -       /*
> -        * Handle HPD. Note: if HPD is hooked up to a dedicated pin on the
> -        * eDP controller then "no_hpd" will be false _and_ "hpd_gpio" will be
> -        * NULL. It's up to the controller driver to wait for HPD after
> -        * preparing the panel in that case.
> -        */
>         if (p->no_hpd) {
> -               /* T3 VCC to HPD high is max 200 ms */
> -               msleep(200);
> -       } else if (p->hpd_gpio) {
> -               ret = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
> -                                        hpd_asserted, hpd_asserted,
> -                                        1000, 200000);
> -               if (!hpd_asserted)
> +               msleep(HPD_MAX_MS);
> +       } else {
> +               if (p->hpd_gpio)
> +                       ret = readx_poll_timeout(gpiod_get_value_cansleep,
> +                                                p->hpd_gpio, hpd_asserted,
> +                                                hpd_asserted, 1000, HPD_MAX_US);
> +               else if (p->aux->wait_hpd_asserted)
> +                       ret = p->aux->wait_hpd_asserted(p->aux, HPD_MAX_US);
> +
> +               /*
> +                * Note that it's possible that no_hpd is false, hpd_gpio is
> +                * NULL, and wait_hpd_asserted is NULL. This is because
> +                * wait_hpd_asserted() is optional even if HPD is hooked up to
> +                * a dedicated pin on the eDP controller. In this case we just
> +                * assume that the controller driver will wait for HPD at the
> +                * right times.
> +                */
> +               if (!hpd_asserted && (p->hpd_gpio || p->aux->wait_hpd_asserted))
>                         dev_warn(dev, "Timeout waiting for HPD\n");

Ugh, right after I sent this out I found a bug! :( It should be
checking for "ret", not "hpd_asserted" in the above "if" test. I'll
spin out a quick v3 right away!

-Doug
