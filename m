Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE4153BB6A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiFBPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiFBPMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:12:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8097C3B3EC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 08:12:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so8282414lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M/dYHmnkSGV1dzutNBubTQIn3L/JOh4kpdNfkA1ozno=;
        b=o6x7JoZst/euEHN/7b7RpYwl7U9npG8+UKi8f0qw2s5r5nzGIf3zIFc4dYxLjBril6
         ZZ2PHdneaQk9tsJwpn0RpWf8rRQEkK66rXkz0/aqRtpleMMdJ8+b4tGTwiU6Uk9Dd2tL
         lSY8Y7s5xa7l6hJ3oVe1HPXpO2b4SSJdXUAe5F/MYudRmtSX360eFzWvX533x/lIJN7i
         L7G9pWnNECErvDHtFwsGDIBMC8Tos5FNNwt190izOWANCPBmDrTvFOYYlyntyTajQ/Iz
         fqGkDu7BBKm6nevCEeR6uvLZQU5YV/DeqfAk+ywEuZ7QqU+zgHqqV8bpHJLQo6SgkjEB
         33mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M/dYHmnkSGV1dzutNBubTQIn3L/JOh4kpdNfkA1ozno=;
        b=dAOLuz0ZyYoqkISKCAN/LlptNwhqNC4hzuYnfIULTbiGM87r7k4rm7guYW8o+dEzLY
         rYypsE8lMcpVWGE5YR5A6FLsbJQx8jqIwQnFnCrvYv88vjxPuM5AZtcN72KOczIs2BBo
         h71u7vOq/jxUGzANT7Bg4jd+FMV+nsAo20rCa5JgreBBNdUXa8dV0MgVs/OH7Y7epZz7
         bZtxD9xxheESrOdyH++vzpRu92b/sySPlAzJXHz544Cu6UBKXX3DYWsoVzL2ypiEXKWg
         bBSa8SpXagb2l7YW7TjM1cJWUTfNUkU9D0k6Nn+lz745x3nZq5hGqqC+zmY4WCJc0xFL
         pPnw==
X-Gm-Message-State: AOAM531vw7Ic2M+c4FdS+U2FwlhiENNZInwm151GgWyd+XfAZhxE7EgB
        XIWFLWvlUuADnPFgRh7SWdmTsw==
X-Google-Smtp-Source: ABdhPJzNQG2JweGywHctHB6i1b+OwfsJ+fKsEK7fPzNN9ID/Rbu8LbjUFE2FmuGsrsKRJz4Cig4dOQ==
X-Received: by 2002:a05:6512:15a4:b0:477:cc23:6252 with SMTP id bp36-20020a05651215a400b00477cc236252mr49298222lfb.389.1654182731748;
        Thu, 02 Jun 2022 08:12:11 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e8-20020ac25ca8000000b00478f0799dd0sm1083250lfq.21.2022.06.02.08.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 08:12:11 -0700 (PDT)
Message-ID: <eb66c55c-cecb-0af0-8800-0a9e59d67a9b@linaro.org>
Date:   Thu, 2 Jun 2022 18:12:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 2/4] drm/panel-edp: Take advantage of
 wait_hpd_asserted() in struct drm_dp_aux
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220418171757.2282651-1-dianders@chromium.org>
 <20220418101725.v3.2.Icea616f57331fbaa3d48c529f300c9a8ebd37fb5@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220418101725.v3.2.Icea616f57331fbaa3d48c529f300c9a8ebd37fb5@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2022 20:17, Douglas Anderson wrote:
> Let's add support for being able to read the HPD pin even if it's
> hooked directly to the controller. This will allow us to get more
> accurate delays also lets us take away the waiting in the AUX transfer
> functions of the eDP controller drivers.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Change is_hpd_asserted() to wait_hpd_asserted()
> 
>   drivers/gpu/drm/panel/panel-edp.c | 33 +++++++++++++++++++++----------
>   1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 1732b4f56e38..086e0bf52fb9 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -417,6 +417,11 @@ static int panel_edp_get_hpd_gpio(struct device *dev, struct panel_edp *p)
>   	return 0;
>   }
>   
> +static bool panel_edp_can_read_hpd(struct panel_edp *p)
> +{
> +	return !p->no_hpd && (p->hpd_gpio || (p->aux && p->aux->wait_hpd_asserted));
> +}
> +
>   static int panel_edp_prepare_once(struct panel_edp *p)
>   {
>   	struct device *dev = p->base.dev;
> @@ -441,17 +446,21 @@ static int panel_edp_prepare_once(struct panel_edp *p)
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
> -					 hpd_asserted, hpd_asserted,
> -					 1000, hpd_wait_us);
> -		if (hpd_asserted < 0)
> -			err = hpd_asserted;
> +		if (p->hpd_gpio) {
> +			err = readx_poll_timeout(gpiod_get_value_cansleep,
> +						 p->hpd_gpio, hpd_asserted,
> +						 hpd_asserted, 1000, hpd_wait_us);
> +			if (hpd_asserted < 0)
> +				err = hpd_asserted;
> +		} else {
> +			err = p->aux->wait_hpd_asserted(p->aux, hpd_wait_us);
> +		}

I'm close to thinking that this construct deserves a separate helper.

>   
>   		if (err) {
>   			if (err != -ETIMEDOUT)
> @@ -532,18 +541,22 @@ static int panel_edp_enable(struct drm_panel *panel)
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
