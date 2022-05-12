Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8A352423E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 03:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbiELB6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 21:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiELB6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:58:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773F5393D7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:58:33 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id e189so4803399oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Ew6wAX9YihrNznSFxG+GfB43C9Zeo824boapu8VVX0Y=;
        b=A2dNMrO5TZBA3uubMg3LoxxHktyTrpGgR9A7Z1wODLEXSPCMP6NdyLRepwqtDIBA2w
         XpvUEtOHgkC8CjQ2+JN5OiKrYnwNbDS6A5Xnq2iFbxHBDmT6A2ZiFhOsY9Y8loaQ/QgG
         llbcSHjRSIP163ztRPz8tCEQrWwg8V/GLuVEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Ew6wAX9YihrNznSFxG+GfB43C9Zeo824boapu8VVX0Y=;
        b=NqKq3vysqVWZJdQlcCsPETAeg4X5YAyBd+JMD6jgeb6u+DiQgWwa0Nz/hpFvQfIzd1
         pxnRKHZLAiyK0/85r7DrYl1EkEvJ4LfpDFBrHMMkxEkHNOnhqfgHXiVusJsGK+mHkOS9
         Nr9MfrEaKr3XjJnFEhJH3EnXRQYIOACTsguIwbSDiae+F3B3xnNx0vyxSmjIPq43U0I1
         dD8gh69resxrcHXIsNgc2MKnOUD+jWI45EBMj4xIJiiADKwrE0EBNou8K+m8RlXjri8t
         nWAu6i1oK5jj39Y+eOHjr/A6jDJYIx1HhzlkmLrmVoDOhO+VKMoV7xdnZ2GrOXnm2qY8
         gxag==
X-Gm-Message-State: AOAM533irqOEHhUV8EGDUTyaWuWYcCNotLSfUurEjJ6xcDehtHIj2zAY
        FbKQ6wOla2roW0WwFdAi3VAjRhU7c8rbURw5Cd3LXQ==
X-Google-Smtp-Source: ABdhPJx0Dlj1uzL7cIUiHfs3RnHj2J1c7/H0WVTcAkonpSNzGOGYsQOmIq+nRxa3NGvGJ9MXBe+33UKZZ/N2u5EPwAA=
X-Received: by 2002:a05:6808:14c2:b0:326:c129:d308 with SMTP id
 f2-20020a05680814c200b00326c129d308mr3935796oiw.193.1652320712791; Wed, 11
 May 2022 18:58:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 May 2022 18:58:32 -0700
MIME-Version: 1.0
In-Reply-To: <20220418101725.v3.1.Icf57bb12233a47727013c6ab69eebf803e22ebc1@changeid>
References: <20220418171757.2282651-1-dianders@chromium.org> <20220418101725.v3.1.Icf57bb12233a47727013c6ab69eebf803e22ebc1@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 11 May 2022 18:58:32 -0700
Message-ID: <CAE-0n51iNXN4oOP-wAqrm9U6qC84fQ+qMUBu0BODXjsCDk+H=w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/dp: Add wait_hpd_asserted() callback to struct drm_dp_aux
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org
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

Quoting Douglas Anderson (2022-04-18 10:17:54)
> Sometimes it's useful for users of the DP AUX bus (like panels) to be
> able to poll HPD. Let's add a callback that allows DP AUX busses
> drivers to provide this.
>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Left Dmitry's Reviewed-by tag off since patch changed enough.
>
> (no changes since v2)
>
> Changes in v2:
> - Change is_hpd_asserted() to wait_hpd_asserted()
>
>  include/drm/dp/drm_dp_helper.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/drm/dp/drm_dp_helper.h b/include/drm/dp/drm_dp_helper.h
> index 53d1e722f4de..0940c415db8c 100644
> --- a/include/drm/dp/drm_dp_helper.h
> +++ b/include/drm/dp/drm_dp_helper.h
> @@ -2035,6 +2035,32 @@ struct drm_dp_aux {
>         ssize_t (*transfer)(struct drm_dp_aux *aux,
>                             struct drm_dp_aux_msg *msg);
>
> +       /**
> +        * @wait_hpd_asserted: wait for HPD to be asserted
> +        *
> +        * This is mainly useful for eDP panels drivers to wait for an eDP
> +        * panel to finish powering on. This is an optional function.

Is there any use for the opposite direction? For example, does anything
care that HPD is deasserted?

> +        *
> +        * This function will efficiently wait for up to `wait_us` microseconds
> +        * for HPD to be asserted and might sleep.
> +        *
> +        * This function returns 0 if HPD was asserted or -ETIMEDOUT if time
> +        * expired and HPD wasn't asserted. This function should not print
> +        * timeout errors to the log.
> +        *
> +        * The semantics of this function are designed to match the
> +        * readx_poll_timeout() function. That means a `wait_us` of 0 means
> +        * to wait forever. If you want to do a quick poll you could pass 1
> +        * for `wait_us`.

It would also make sense to have a drm_dp_wait_hpd_asserted() API

  int drm_dp_wait_hpd_asserted(struct drm_dp_aux *aux, unsigned long wait_us);

and then this aux function could be implemented in various ways. The API
could poll if the aux can only read immediate state of HPD, or it could
sleep (is sleeping allowed? that isn't clear) and wake up the process
once HPD goes high. Or if this op isn't implemented maybe there's a
fixed timeout member that is non-zero which means "sleep this long".
Either way, making each drm_dp_aux implement that logic seems error
prone vs. having the drm_dp_aux implement some function for

	get_immediate_hpd(struct drm_dp_aux *aux)

or

	notify_on_hpd(struct drm_dp_aux *auxstruct completion *comp)

> +        *
> +        * NOTE: this function specifically reports the state of the HPD pin
> +        * that's associated with the DP AUX channel. This is different from
> +        * the HPD concept in much of the rest of DRM which is more about
> +        * physical presence of a display. For eDP, for instance, a display is
> +        * assumed always present even if the HPD pin is deasserted.
> +        */
> +       int (*wait_hpd_asserted)(struct drm_dp_aux *aux, unsigned long wait_us);
> +
>         /**
>          * @i2c_nack_count: Counts I2C NACKs, used for DP validation.
>          */
