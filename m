Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F332F53AE61
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiFAUvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiFAUuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:50:11 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6311EC550
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 13:46:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id e4so3227446ljb.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 13:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fj9HtRIX4+M0EdDnghqxhr6GHQmpAm8s/XdenW9yup0=;
        b=WjRHLkgwCSWAlphNr9xuVVKYEGPDefIDXa8vtmj6h2K4iVHM8CaH0cyKh8/b2pU7oL
         04g6nvj+ijgHp8BUpa+zZhO+h0wje7fT5ZpxGla7N/gc9nSxuemkwDTZm2sU+E8gheIl
         lcSwrUkHewNgnVDmX8xCnqI66SEdC8AV+cvo+s8gm6i5cIHRjzh0iwboTcCSzSrb4UkS
         qh84i8eQatdMSnl44dhsjqBB9rQCgxlwKxlXRi2a1ajTT13maFRIUyRQoIAV9USm5xEF
         CItZYLYEb9drifjhDbJHByDwfMd0WwusljT+rG/4pmJVL1F26KP5vuH+t929KHSGunBB
         0kfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fj9HtRIX4+M0EdDnghqxhr6GHQmpAm8s/XdenW9yup0=;
        b=Xbz+znEnEvgsU+KWKAvV4lYzgdRaPAo+qtTox3PBjB8jtYT9yEg3ams+Fnz3kedZfR
         UQkPf0kEenNJijuDdwJ1pB9dY6g0xuptHK4XeQpK69UklsuvwtQQ0E/mXB7wQVrsyGFm
         LE5rzsf5Yr94eaNun9ASc7fzej5MIJBlPEQ5VEC8/Ktw/tOQhOL69cyFLxgHwTUMWs0b
         NJHoI/orCVGnQflgVrbpKrMKCDliPJJveQJAWbnv+iYPFlKaI6YrYgNAjsGq6xLB419V
         5u4W5OHtr8DKHIbF1G2Yc6SEWPfZlofFO7UF2o9lnoGcO7wfdvBoqu3vx4YeywSNNbPE
         +IiA==
X-Gm-Message-State: AOAM531weGqf/8RpTQ0nKBjPUy5T/VL3iI0rm5zS6ss/zQW0wKRdCFRr
        N0nes1Rz3g5zpageN7MS+uS9UA==
X-Google-Smtp-Source: ABdhPJxaKLcEkkU4GB/4Q1C4XrI6PGY70nBZOBslqQa/9byzq+gv3CmXYlcwJG2qlo5+RfiL+/eYJg==
X-Received: by 2002:a2e:9e41:0:b0:253:c37c:378b with SMTP id g1-20020a2e9e41000000b00253c37c378bmr39695585ljk.202.1654116415632;
        Wed, 01 Jun 2022 13:46:55 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id k8-20020a2ea288000000b0024f3d1dae99sm509610lja.33.2022.06.01.13.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 13:46:54 -0700 (PDT)
Message-ID: <f415aa0c-edf8-94de-bde8-faf151f5f530@linaro.org>
Date:   Wed, 1 Jun 2022 23:46:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 4/4] drm/bridge: parade-ps8640: Handle DP AUX more
 properly
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Robert Foss <robert.foss@linaro.org>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org
References: <20220510192944.2408515-1-dianders@chromium.org>
 <20220510122726.v3.4.Ia6324ebc848cd40b4dbd3ad3289a7ffb5c197779@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220510122726.v3.4.Ia6324ebc848cd40b4dbd3ad3289a7ffb5c197779@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2022 22:29, Douglas Anderson wrote:
> While it works, for the most part, to assume that the panel has
> finished probing when devm_of_dp_aux_populate_ep_devices() returns,
> it's a bit fragile. This is talked about at length in commit
> a1e3667a9835 ("drm/bridge: ti-sn65dsi86: Promote the AUX channel to
> its own sub-dev").
> 
> When reviewing the ps8640 code, I managed to convince myself that it
> was OK not to worry about it there and that maybe it wasn't really
> _that_ fragile. However, it turns out that it really is. Simply
> hardcoding panel_edp_probe() to return -EPROBE_DEFER was enough to put
> the boot process into an infinite loop. I believe this manages to trip
> the same issues that we used to trip with the main MSM code where
> something about our actions trigger Linux to re-probe previously
> deferred devices right away and each time we try again we re-trigger
> Linux to re-probe.
> 
> Let's fix this using the callback introduced in the patch ("drm/dp:
> Callbacks to make it easier for drivers to use DP AUX bus properly").
> When using the new callback, we have to be a little careful. The
> probe_done() callback is no longer always called in the context of
> our probe routine. That means we can't rely on being able to return
> -EPROBE_DEFER from it. We re-jigger the order of things a bit to
> account for that.
> 
> With this change, the device still boots (though obviously the panel
> doesn't come up) if I force panel-edp to always return
> -EPROBE_DEFER. If I fake it and make the panel probe exactly once it
> also works.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> 
> Changes in v3:
> - Adapt to v3 changes in aux bus.
> - Use devm_drm_bridge_add() to simplify.
> 
> Changes in v2:
> - Rewrote atop new method introduced by patch #1.
> 
>   drivers/gpu/drm/bridge/parade-ps8640.c | 74 ++++++++++++++++----------
>   1 file changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index e2467e58b5b7..ff4227f6d800 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -537,7 +537,7 @@ static const struct drm_bridge_funcs ps8640_bridge_funcs = {
>   	.pre_enable = ps8640_pre_enable,
>   };
>   
> -static int ps8640_bridge_host_attach(struct device *dev, struct ps8640 *ps_bridge)
> +static int ps8640_bridge_get_dsi_resources(struct device *dev, struct ps8640 *ps_bridge)
>   {
>   	struct device_node *in_ep, *dsi_node;
>   	struct mipi_dsi_device *dsi;
> @@ -576,13 +576,40 @@ static int ps8640_bridge_host_attach(struct device *dev, struct ps8640 *ps_bridg
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->lanes = NUM_MIPI_LANES;
>   
> -	return devm_mipi_dsi_attach(dev, dsi);
> +	return 0;
> +}
> +
> +static int ps8640_bridge_link_panel(struct drm_dp_aux *aux)
> +{
> +	struct ps8640 *ps_bridge = aux_to_ps8640(aux);
> +	struct device *dev = aux->dev;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	/*
> +	 * NOTE about returning -EPROBE_DEFER from this function: if we
> +	 * return an error (most relevant to -EPROBE_DEFER) it will only
> +	 * be passed out to ps8640_probe() if it called this directly (AKA the
> +	 * panel isn't under the "aux-bus" node). That should be fine because
> +	 * if the panel is under "aux-bus" it's guaranteed to have probed by
> +	 * the time this function has been called.
> +	 */
> +
> +	/* port@1 is ps8640 output port */
> +	ps_bridge->panel_bridge = devm_drm_of_get_bridge(dev, np, 1, 0);
> +	if (IS_ERR(ps_bridge->panel_bridge))
> +		return PTR_ERR(ps_bridge->panel_bridge);
> +
> +	ret = devm_drm_bridge_add(dev, &ps_bridge->bridge);
> +	if (ret)
> +		return ret;
> +
> +	return devm_mipi_dsi_attach(dev, ps_bridge->dsi);
>   }
>   
>   static int ps8640_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
> -	struct device_node *np = dev->of_node;
>   	struct ps8640 *ps_bridge;
>   	int ret;
>   	u32 i;
> @@ -623,6 +650,14 @@ static int ps8640_probe(struct i2c_client *client)
>   	if (!ps8640_of_panel_on_aux_bus(&client->dev))
>   		ps_bridge->bridge.ops = DRM_BRIDGE_OP_EDID;
>   
> +	/*
> +	 * Get MIPI DSI resources early. These can return -EPROBE_DEFER so
> +	 * we want to get them out of the way sooner.
> +	 */
> +	ret = ps8640_bridge_get_dsi_resources(&client->dev, ps_bridge);
> +	if (ret)
> +		return ret;
> +
>   	ps_bridge->page[PAGE0_DP_CNTL] = client;
>   
>   	ps_bridge->regmap[PAGE0_DP_CNTL] = devm_regmap_init_i2c(client, ps8640_regmap_config);
> @@ -665,35 +700,19 @@ static int ps8640_probe(struct i2c_client *client)
>   	if (ret)
>   		return ret;
>   
> -	devm_of_dp_aux_populate_ep_devices(&ps_bridge->aux);
> +	ret = devm_of_dp_aux_populate_bus(&ps_bridge->aux, ps8640_bridge_link_panel);
>   
> -	/* port@1 is ps8640 output port */
> -	ps_bridge->panel_bridge = devm_drm_of_get_bridge(dev, np, 1, 0);
> -	if (IS_ERR(ps_bridge->panel_bridge))
> -		return PTR_ERR(ps_bridge->panel_bridge);
> -
> -	drm_bridge_add(&ps_bridge->bridge);
> -
> -	ret = ps8640_bridge_host_attach(dev, ps_bridge);
> -	if (ret)
> -		goto err_bridge_remove;
> -
> -	return 0;
> +	/*
> +	 * If devm_of_dp_aux_populate_bus() returns -ENODEV then it's up to
> +	 * usa to call ps8640_bridge_link_panel() directly. NOTE: in this case
> +	 * the function is allowed to -EPROBE_DEFER.
> +	 */
> +	if (ret == -ENODEV)
> +		return ps8640_bridge_link_panel(&ps_bridge->aux);
>   
> -err_bridge_remove:
> -	drm_bridge_remove(&ps_bridge->bridge);
>   	return ret;
>   }
>   
> -static int ps8640_remove(struct i2c_client *client)
> -{
> -	struct ps8640 *ps_bridge = i2c_get_clientdata(client);
> -
> -	drm_bridge_remove(&ps_bridge->bridge);
> -
> -	return 0;
> -}
> -
>   static const struct of_device_id ps8640_match[] = {
>   	{ .compatible = "parade,ps8640" },
>   	{ }
> @@ -702,7 +721,6 @@ MODULE_DEVICE_TABLE(of, ps8640_match);
>   
>   static struct i2c_driver ps8640_driver = {
>   	.probe_new = ps8640_probe,
> -	.remove = ps8640_remove,
>   	.driver = {
>   		.name = "ps8640",
>   		.of_match_table = ps8640_match,


-- 
With best wishes
Dmitry
