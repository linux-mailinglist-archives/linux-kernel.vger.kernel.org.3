Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4185501FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348190AbiDOAuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbiDOAug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:50:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65165B822C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:48:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p10so11761540lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BycpfwmzoR4vzcAZR2CT84zb+01RL1PgdUJzETRbklU=;
        b=NBQEoiYmC/899Hw9WnmJ+R+JGTM5xfbrHKBaRot/VLZdi5oUx132Hm34eKvvuzCQq4
         wKW7E6pru0TICqR+6kebPpRT6Vcb53nbTvdPh+5Uz4BRRilxTNIguBHGly9DxV520Zhu
         ZRc7hnUYVvPL3q5Muo7vIDSv5MrJ8J+Bgk6L1tyCvJ4P7FK6ZeNidUaxmu9v78STJr7U
         7/cNbXOQrTXbCWDTs3iSe+ad3Err8qBiC33WZfzyagj4X3erSZrykwgp9WxLmXP4z87u
         yjSnHSWEO37JgM+CUb6PXghGg0BXDK9u1oeb+Oq6pwVMV2jqzjMiE33pmH7YNUhZvRZi
         wGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BycpfwmzoR4vzcAZR2CT84zb+01RL1PgdUJzETRbklU=;
        b=oE9v059LJS7POroFhed9ndIU1ZZeHl7KT5v9xMXXb/WsJ3XrynpW7LiVedWMCzDPIE
         KjWs04rRTO2NsBbfW64ZikzQNn+Og7SWeWIuvia+VadfxJcnr5qskojQyqYMXdqCxF0W
         11xF0UvfuKFMEyCASlUHY3/m8JLJ+JOmtJqWjLlVhti6mu1pg+e9yqVVw1nPKyNIFGum
         VJyxpuCmWwT11RZIFjEiSAuCnxM3bGJDLhSxfYIGAC3k2YDi4MfveVcaYhjmFqx4I04u
         0hvm1eYYfvRbHvr8pVhb2pbRD3gY2qK7MK3a1J9qDWAkXkQmZcpVkSGn5VAkx3jW5ahI
         5f6g==
X-Gm-Message-State: AOAM530l/TDYVuWYB96BVj/8h6tQazYfUPRHfOHrdNuEA0ww1jBCfwEe
        2dCiQUaprb6QbVF+zP5nZucT6w==
X-Google-Smtp-Source: ABdhPJwbti2aqvzvc7DFdbELNEMXxtK8iweXhJZDxAE3gj2VfSKrWrYUMtY4ksILtWY52drF7E1T9w==
X-Received: by 2002:ac2:4e11:0:b0:46b:a38d:686a with SMTP id e17-20020ac24e11000000b0046ba38d686amr3522985lfr.564.1649983688700;
        Thu, 14 Apr 2022 17:48:08 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p24-20020a2ea418000000b0024b5b76a06csm139293ljn.12.2022.04.14.17.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 17:48:08 -0700 (PDT)
Message-ID: <68538a58-54e2-e82e-0789-52eb1cc6b66a@linaro.org>
Date:   Fri, 15 Apr 2022 03:48:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH 3/6] drm/dp: Add is_hpd_asserted() callback to struct
 drm_dp_aux
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
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.3.Icf57bb12233a47727013c6ab69eebf803e22ebc1@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220408193536.RFC.3.Icf57bb12233a47727013c6ab69eebf803e22ebc1@changeid>
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
> Sometimes it's useful for users of the DP AUX bus (like panels) to be
> able to poll HPD. Let's add a callback that allows DP AUX busses
> drivers to provide this.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> 
>   include/drm/dp/drm_dp_helper.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/include/drm/dp/drm_dp_helper.h b/include/drm/dp/drm_dp_helper.h
> index dad1442c91df..a12951319573 100644
> --- a/include/drm/dp/drm_dp_helper.h
> +++ b/include/drm/dp/drm_dp_helper.h
> @@ -2021,6 +2021,20 @@ struct drm_dp_aux {
>   	ssize_t (*transfer)(struct drm_dp_aux *aux,
>   			    struct drm_dp_aux_msg *msg);
>   
> +	/**
> +	 * @is_hpd_asserted: returns true if HPD is asserted
> +	 *
> +	 * This is mainly useful for eDP panels drivers to query whether
> +	 * an eDP panel has finished powering on. This is an optional function.
> +	 *
> +	 * NOTE: this function specifically reports the state of the HPD pin
> +	 * that's associated with the DP AUX channel. This is different from
> +	 * the HPD concept in much of the rest of DRM which is more about
> +	 * physical presence of a display. For eDP, for instance, a display is
> +	 * assumed always present even if the HPD pin is deasserted.
> +	 */
> +	bool (*is_hpd_asserted)(struct drm_dp_aux *aux);
> +
>   	/**
>   	 * @i2c_nack_count: Counts I2C NACKs, used for DP validation.
>   	 */


-- 
With best wishes
Dmitry
