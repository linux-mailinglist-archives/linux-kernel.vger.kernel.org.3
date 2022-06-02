Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD3653B6F8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbiFBKW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiFBKWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:22:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8910213E7E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 03:22:38 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id m25so1432652lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 03:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mhke0saUmUh/aB/di9/WbB1JwcFcgftrzK7UikGh97E=;
        b=bFvw+MLHVt+ArFBhnhxD4VGaWyar1Iw3Ys0oV4R9sP/bLgk9xK9kxzaaTZalR0EZcs
         DYSWd3KPnS2lKOJh8kuqKmbP0WytCHCLGP6f8aTF+7KR6jaPf/5c6UWfEtDMiLmKuYvu
         nSRNVsYr30Wy9XsFQjKkTsSelPDRlDAzdaouzM8KqVJC1FgwxXkJQKq2hqYkt76XSiQB
         zVCYTPHReYyktuzPNOEHoZK7KUZiiTF95MfsA6Lj40AukNe97nQ2ovR44xX/dekLSSVa
         TxXYFlcJ7uFbdFw6GvMxus+wXABsmy51VnApOpbnLGuauTZdeDtz6FXQ0PgkF3PwHF3w
         mrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mhke0saUmUh/aB/di9/WbB1JwcFcgftrzK7UikGh97E=;
        b=iZaEHCTpSuWjNKTwZfgkWWq1r/5yVSZFBTPFpYLFFiKh9kAsNMh0SxjWP7744ccj5V
         JC3vhpCLt+xruUP6M32NpArAY84PJMgavksl6NNrrQbUuBvtrgyxTGf4Mx/VZ6tSgNOl
         X07Lma6H/nuaqYgWgmG+5U8ppShaN+iqxRjixRlSKoCDAmelNEhksjcWw5U0wdcq1+0H
         z3D7HQlOmVNNK0O26RTcjO3JEh4eh+R+x0ddspbPs88tGtlY1HjckgRLwLxr0fcDGxz7
         lAEBcYXs8luUZ9zk3PllrVOTI2LQTLkA9LztjXUGJiBWagPe/ASz5QQDPT3HUh3/xGrs
         zBlA==
X-Gm-Message-State: AOAM533Q4wUoTcp7sduUGJxLcN3ld4UHEamZe5DabpWM/bKVZoxZlLw5
        i+f6mrLiiYK2kzy6L9/SzEricw==
X-Google-Smtp-Source: ABdhPJxBmqiSkec8TbeMYs+RFw+Rm4q/emiOOaTWMfi/pJk8O6t7jgcEYLMBlu3LcQem9bMjd/eBbg==
X-Received: by 2002:a2e:8881:0:b0:255:7790:25e6 with SMTP id k1-20020a2e8881000000b00255779025e6mr964729lji.525.1654165357162;
        Thu, 02 Jun 2022 03:22:37 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d16-20020a0565123d1000b0047255d21132sm961705lfv.97.2022.06.02.03.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 03:22:36 -0700 (PDT)
Message-ID: <b157ebf3-9846-1235-c8e7-693abe4569d3@linaro.org>
Date:   Thu, 2 Jun 2022 13:22:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 1/4] drm/dp: Add wait_hpd_asserted() callback to struct
 drm_dp_aux
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
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org
References: <20220418171757.2282651-1-dianders@chromium.org>
 <20220418101725.v3.1.Icf57bb12233a47727013c6ab69eebf803e22ebc1@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220418101725.v3.1.Icf57bb12233a47727013c6ab69eebf803e22ebc1@changeid>
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
> Sometimes it's useful for users of the DP AUX bus (like panels) to be
> able to poll HPD. Let's add a callback that allows DP AUX busses
> drivers to provide this.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
> Left Dmitry's Reviewed-by tag off since patch changed enough.
> 
> (no changes since v2)
> 
> Changes in v2:
> - Change is_hpd_asserted() to wait_hpd_asserted()
> 
>   include/drm/dp/drm_dp_helper.h | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/include/drm/dp/drm_dp_helper.h b/include/drm/dp/drm_dp_helper.h
> index 53d1e722f4de..0940c415db8c 100644
> --- a/include/drm/dp/drm_dp_helper.h
> +++ b/include/drm/dp/drm_dp_helper.h
> @@ -2035,6 +2035,32 @@ struct drm_dp_aux {
>   	ssize_t (*transfer)(struct drm_dp_aux *aux,
>   			    struct drm_dp_aux_msg *msg);
>   
> +	/**
> +	 * @wait_hpd_asserted: wait for HPD to be asserted
> +	 *
> +	 * This is mainly useful for eDP panels drivers to wait for an eDP
> +	 * panel to finish powering on. This is an optional function.
> +	 *
> +	 * This function will efficiently wait for up to `wait_us` microseconds
> +	 * for HPD to be asserted and might sleep.
> +	 *
> +	 * This function returns 0 if HPD was asserted or -ETIMEDOUT if time
> +	 * expired and HPD wasn't asserted. This function should not print
> +	 * timeout errors to the log.
> +	 *
> +	 * The semantics of this function are designed to match the
> +	 * readx_poll_timeout() function. That means a `wait_us` of 0 means
> +	 * to wait forever. If you want to do a quick poll you could pass 1
> +	 * for `wait_us`.
> +	 *
> +	 * NOTE: this function specifically reports the state of the HPD pin
> +	 * that's associated with the DP AUX channel. This is different from
> +	 * the HPD concept in much of the rest of DRM which is more about
> +	 * physical presence of a display. For eDP, for instance, a display is
> +	 * assumed always present even if the HPD pin is deasserted.
> +	 */
> +	int (*wait_hpd_asserted)(struct drm_dp_aux *aux, unsigned long wait_us);
> +
>   	/**
>   	 * @i2c_nack_count: Counts I2C NACKs, used for DP validation.
>   	 */


-- 
With best wishes
Dmitry
