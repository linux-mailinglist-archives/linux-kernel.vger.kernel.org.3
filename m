Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76876539FEE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350966AbiFAI5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238309AbiFAI5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 021B549C8E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654073831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lCOUyyDM2EIXc4RPNW8pyLJMNdGYc/IzffrR0m7ZqEw=;
        b=B2MfWPPemgZpykUZ4iF9Y08YU8T5+chDzAmHKjKhx6k0qc+v3BDhfJ+YXHYlIxhsrXpGJA
        uYjZ3j2AMGRBkA8aspIdAGWSjgusrc0O+n7shsVNkQ86rdhEIQRIzMEon0XTITv0PpHX1V
        pAeY8TPFPt4EGzQ5qUvCSD568pttHts=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-_RbTV0vMNyW01Nt8XPXAnQ-1; Wed, 01 Jun 2022 04:57:09 -0400
X-MC-Unique: _RbTV0vMNyW01Nt8XPXAnQ-1
Received: by mail-ej1-f70.google.com with SMTP id p7-20020a170906614700b006f87f866117so591357ejl.21
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lCOUyyDM2EIXc4RPNW8pyLJMNdGYc/IzffrR0m7ZqEw=;
        b=qB/l2zzMh3VFY/iCPoyODWdLhwzPf46TYrdTd10YwxXeeY+a55gpl9yW3+myr4pp8V
         hRS/hHnMp3RPFcJXJ/q78Nq6gF54RHCpbz9gO0hZKoBxAryM5CtPVeYnlDiNgf7sz6ZY
         UqA6/ygV94Bdn8divyzKsiCHADeF5rcCaB7ds4aG/VVhT1GoSLH7wmju8zN6n+WjSn3k
         M4UCv5C7dJ08Avnc78yRt4sP8dzIzL7e0SIl1V2ptYVBwr2V3nYzNqMOt53b8L6IW2kA
         O3vk84QDaKHVv/OwnHmt4M4/sfUhzdXqhrS0pgFE00iznP+zDCYzWqED4C5gHIPI70ZY
         DYSQ==
X-Gm-Message-State: AOAM533V5uZgRzMQCDfgN3W37qPI1Bdj/HfZ275DUtBaKXDuxr9VJSCZ
        EL+S3z1+O0K8ox2z7WORo1C/0ogKWffv9b1r2RyHggsvO5AAIIcsnzUoUuzKS+Vu7evat9+00UU
        W4jB0HqSJrlbMeUXnyVMJMxMS
X-Received: by 2002:a17:907:3ea0:b0:6ff:7d7a:480d with SMTP id hs32-20020a1709073ea000b006ff7d7a480dmr12015284ejc.750.1654073828312;
        Wed, 01 Jun 2022 01:57:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDqD6pKipOJm2UHddq2V2tE+4Dh/llNuSewqbfAAqKxh7eaW78QHTMcUwNyG47vvudKgNjkQ==
X-Received: by 2002:a17:907:3ea0:b0:6ff:7d7a:480d with SMTP id hs32-20020a1709073ea000b006ff7d7a480dmr12015265ejc.750.1654073828091;
        Wed, 01 Jun 2022 01:57:08 -0700 (PDT)
Received: from [192.168.43.127] ([109.36.130.134])
        by smtp.gmail.com with ESMTPSA id y22-20020aa7ca16000000b0042dcbc3f302sm619741eds.36.2022.06.01.01.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 01:57:07 -0700 (PDT)
Message-ID: <c890efc4-dfda-cab1-8a46-527e3e02168a@redhat.com>
Date:   Wed, 1 Jun 2022 10:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 8/8] drm/mediatek: Config orientation property if panel
 provides it
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220601081823.1038797-1-hsinyi@chromium.org>
 <20220601081823.1038797-9-hsinyi@chromium.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220601081823.1038797-9-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/1/22 10:18, Hsin-Yi Wang wrote:
> Panel orientation property should be set before drm_dev_register().
> Mediatek drm driver calls drm_dev_register() in .bind(). However, most
> panels sets orientation property relatively late, mostly in .get_modes()
> callback, since this is when they are able to get the connector and
> binds the orientation property to it, though the value should be known
> when the panel is probed.
> 
> Let the drm driver check if the remote end point is a panel and if it
> contains the orientation property. If it does, set it before
> drm_dev_register() is called.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> The concept is the same as the previous version.
> https://patchwork.kernel.org/project/linux-mediatek/patch/20220530113033.124072-1-hsinyi@chromium.org/
> The only difference is, it now uses the panel API instead of parsing
> orientation from the driver.
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index bd3f5b485085..12836a697f56 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -185,6 +185,7 @@ struct mtk_dsi {
>  	struct drm_encoder encoder;
>  	struct drm_bridge bridge;
>  	struct drm_bridge *next_bridge;
> +	struct drm_panel *panel;
>  	struct drm_connector *connector;
>  	struct phy *phy;
>  
> @@ -822,6 +823,16 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>  		ret = PTR_ERR(dsi->connector);
>  		goto err_cleanup_encoder;
>  	}
> +
> +	/* Read panel orientation */
> +	if (dsi->panel) {
> +		enum drm_panel_orientation orientation;
> +
> +		orientation = drm_panel_get_orientation(dsi->panel);
> +		if (orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> +			drm_connector_set_panel_orientation(dsi->connector, orientation);
> +	}
> +
>  	drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
>  
>  	return 0;

drm_connector_set_panel_orientation() is a no-op when called with 
DRM_MODE_PANEL_ORIENTATION_UNKNOWN, so the check for this is not
necessary. This allows this to be simplified to:

	/* Read panel orientation */
	if (dsi->panel)
		drm_connector_set_panel_orientation(dsi->connector,
						    drm_panel_get_orientation(dsi->panel));


Note since drm_panel_get_orientation() checks for a NULL panel, you could even
drop the "if (dsi->panel)", but I think the meaning of the code is more
clear with that present.






> @@ -837,6 +848,9 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>  	struct drm_device *drm = data;
>  	struct mtk_dsi *dsi = dev_get_drvdata(dev);
>  
> +	/* Get panel if existed */
> +	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &dsi->panel, NULL);
> +

Check ret? or maybe not assign to ret ?    I understand some errors are expected
so maybe something like:

	if (ret && ret != -ENODEV)
		return ret;

?

Note -ENODEV is probably not the right error the check for!

Regards,

Hans



>  	ret = mtk_dsi_encoder_init(drm, dsi);
>  	if (ret)
>  		return ret;

