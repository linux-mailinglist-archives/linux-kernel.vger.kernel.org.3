Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AD3501FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347146AbiDOAxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348206AbiDOAxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:53:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EA8AFACD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:51:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x17so11792015lfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QAfgxuljMEUlGourUdeq84Zaz58ldR96J/mCC2Xv6dY=;
        b=w5V96hFg/f50/jZUJkfdb9d+B5BcZctpWPKeTe1ARKt8o4ROa7HNOr9MY/1e28Xvq5
         Dba1q7jlecikOZNJQa6Gc2t+sJnrnTzCIQiCwbtS34pLf7KRD+JY0U221UuFGcCk2zoZ
         aeZVhnqetbY8evvpU6VnKqVEBgtYY5Crt/CDeGMB3a+gIJMxNUnOYiw50AscdKxsOnoY
         sBHkDHyb8k/q9mtjxw1Z/L4rdpX82CrcoIgpDSeTTT++vQ3sUg7JZbOIh1o03ZkfoFZR
         p6pCb2hVC0xjIJdMAD9xF5ReOoz422pNit/BOi+l5QBvhVY34JVa8tR/kj5x4mM+PrYQ
         rRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QAfgxuljMEUlGourUdeq84Zaz58ldR96J/mCC2Xv6dY=;
        b=l1pKt8idVXVtBGjeIMxYwiRTnL0vRYr4S0lrqyV+s4Xwye/6khoRaFzCFFMITNMux8
         HmQQNdchj9/QiwZAU0kZJTeou/cLe5GzqWPisw7qyIAR3MGv/m/WNzXLqnGmkay5EFHg
         798O+R4Y5lK+QwuuG592WGdW9tQvNSkUDkZKuipAZ0ZGhPMkjlh7X616W2cbVsSxrd4E
         JOpRyt0QeRCHXeinqHHXNofv/09vlNeSUNeInJdyyTd573Pddm81SEDYUtpz92aNES92
         CP4tdzhVal1dzqYc1vUKsbarm4TGjPfcNIs4qr3sOU/PHy6DkUNg/yIqXpd8tTfHciqY
         H4Eg==
X-Gm-Message-State: AOAM531BPKOcOgzaDfUMvS3txULCp2uZyOgK1xDIeHvwSdYadGWaIEiL
        hu+/klv8sNt3IaUOduQAYJHICg==
X-Google-Smtp-Source: ABdhPJwx+Wugev6M6MPb53JIAVUsaeLS4GX8Xph+fY2YkueCOb08UsdJhkXGHNjlHDLntwrK7F/8Lg==
X-Received: by 2002:a19:6e07:0:b0:46b:a68c:9c97 with SMTP id j7-20020a196e07000000b0046ba68c9c97mr3484622lfc.141.1649983861532;
        Thu, 14 Apr 2022 17:51:01 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p21-20020a056512313500b0046bb4fd136csm158992lfd.106.2022.04.14.17.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 17:51:01 -0700 (PDT)
Message-ID: <027b3ca1-fbd3-7bce-1ca0-ec92a5f23fee@linaro.org>
Date:   Fri, 15 Apr 2022 03:51:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH 4/6] drm/panel-edp: Take advantage of
 is_hpd_asserted() in struct drm_dp_aux
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Robert Foss <robert.foss@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.4.Icea616f57331fbaa3d48c529f300c9a8ebd37fb5@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220408193536.RFC.4.Icea616f57331fbaa3d48c529f300c9a8ebd37fb5@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 05:36, Douglas Anderson wrote:
> Let's add support for being able to read the HPD pin even if it's
> hooked directly to the controller. This will allow us to get more
> accurate delays also lets us take away the waiting in the AUX transfer
> functions of the eDP controller drivers.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/gpu/drm/panel/panel-edp.c | 37 ++++++++++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 1732b4f56e38..4a143eb9544b 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -417,6 +417,19 @@ static int panel_edp_get_hpd_gpio(struct device *dev, struct panel_edp *p)
>   	return 0;
>   }
>   
> +static bool panel_edp_can_read_hpd(struct panel_edp *p)
> +{
> +	return !p->no_hpd && (p->hpd_gpio || (p->aux && p->aux->is_hpd_asserted));
> +}
> +
> +static bool panel_edp_read_hpd(struct panel_edp *p)
> +{
> +	if (p->hpd_gpio)
> +		return gpiod_get_value_cansleep(p->hpd_gpio);
> +
> +	return p->aux->is_hpd_asserted(p->aux);
> +}
> +
>   static int panel_edp_prepare_once(struct panel_edp *p)
>   {
>   	struct device *dev = p->base.dev;
> @@ -441,13 +454,21 @@ static int panel_edp_prepare_once(struct panel_edp *p)
>   	if (delay)
>   		msleep(delay);
>   
> -	if (p->hpd_gpio) {
> +	if (panel_edp_can_read_hpd(p)) {
>   		if (p->desc->delay.hpd_absent)
>   			hpd_wait_us = p->desc->delay.hpd_absent * 1000UL;
>   		else
>   			hpd_wait_us = 2000000;
>   
> -		err = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
> +		/*
> +		 * Extra max delay, mostly to account for ps8640. ps8640
> +		 * is crazy and the bridge chip driver itself has over 200 ms
> +		 * of delay if it needs to do the pm_runtime resume of the
> +		 * bridge chip to read the HPD.
> +		 */
> +		hpd_wait_us += 3000000;

I think this should come in a separate commit and ideally this should be 
configurable somehow. Other hosts wouldn't need such 'additional' delay.

With this change removed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> +
> +		err = readx_poll_timeout(panel_edp_read_hpd, p,
>   					 hpd_asserted, hpd_asserted,
>   					 1000, hpd_wait_us);
>   		if (hpd_asserted < 0)
> @@ -532,18 +553,22 @@ static int panel_edp_enable(struct drm_panel *panel)
>   	/*
>   	 * If there is a "prepare_to_enable" delay then that's supposed to be
>   	 * the delay from HPD going high until we can turn the backlight on.
> -	 * However, we can only count this if HPD is handled by the panel
> -	 * driver, not if it goes to a dedicated pin on the controller.
> +	 * However, we can only count this if HPD is readable by the panel
> +	 * driver.
> +	 *
>   	 * If we aren't handling the HPD pin ourselves then the best we
>   	 * can do is assume that HPD went high immediately before we were
> -	 * called (and link training took zero time).
> +	 * called (and link training took zero time). Note that "no-hpd"
> +	 * actually counts as handling HPD ourselves since we're doing the
> +	 * worst case delay (in prepare) ourselves.
>   	 *
>   	 * NOTE: if we ever end up in this "if" statement then we're
>   	 * guaranteed that the panel_edp_wait() call below will do no delay.
>   	 * It already handles that case, though, so we don't need any special
>   	 * code for it.
>   	 */
> -	if (p->desc->delay.prepare_to_enable && !p->hpd_gpio && !p->no_hpd)
> +	if (p->desc->delay.prepare_to_enable &&
> +	    !panel_edp_can_read_hpd(p) && !p->no_hpd)
>   		delay = max(delay, p->desc->delay.prepare_to_enable);
>   
>   	if (delay)


-- 
With best wishes
Dmitry
