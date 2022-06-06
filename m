Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DBA53EE5E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiFFTQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiFFTQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:16:51 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6906580E4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:16:49 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id l9-20020a056830268900b006054381dd35so11448102otu.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=0ISgbHiV4o5sZcHUC78zgYQXpXhaQoJ6UxzNGiryKJ8=;
        b=CBgVQb1ZbwpHj6ip0ODYxgb4cXYCkJ38H4sisthI4mJaz8l4VaspsrbKLeJJV/1SVk
         8Ymd6q9UwbXJTbOLlTFrJW6UjBC1pWbB+mvRBlN7GK2+7gJzpmci3HP3EljH9CVYa+TF
         OvYU5zEwK/vuBrZnhYaWtD2kEY6UNXXnhrjqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=0ISgbHiV4o5sZcHUC78zgYQXpXhaQoJ6UxzNGiryKJ8=;
        b=vZdalCidAlF6gs3cI1000VSUYbVJPAEflXpEQte7WNdY4jhlm/HAh7gGDKQfNM/S8N
         T6hCD9727gro8lu2wlPf15me8G4uuYBjX3m11Sr1jdti47gJMYTDAHU7vJ1890FwEY21
         JYtzzwhzyVzraWDCiYvQpcAsqjSPNEjHn2Ag32SGIRoL3sXd//B9nYsDDlp1dGKX/JWR
         QS0fTYaeqfGzgUisgpmq6d1JzsTN/DOTUy72Mb2jkEyUDn738Uy/DtpObA3x07bM7KKV
         ItjvXwIEgenPu3HQzTEtGowgmSWybR39xCx3+nALCHSwlTvlvTLXqk4NmTqwewh6EQgB
         FEqA==
X-Gm-Message-State: AOAM531xtzWwfgerQq2Je4CA9qEvxmF5PX9VF1I5UMLpAnPtXlWYA+/V
        CaFwC7guo53DCeT4z+rKO4gt51uHEoVYALHmn0cdBw==
X-Google-Smtp-Source: ABdhPJzrtp9rNjx/MRKwpP7DdfW0iFsQFuzWAL7ZNWmFj9UIEt2EemDZZ/o72GqwyMu+DAw6tK2o5XVWQKasAGXXwEI=
X-Received: by 2002:a05:6830:113:b0:60b:eb0b:4054 with SMTP id
 i19-20020a056830011300b0060beb0b4054mr5483588otp.159.1654543009163; Mon, 06
 Jun 2022 12:16:49 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jun 2022 12:16:48 -0700
MIME-Version: 1.0
In-Reply-To: <20220606152431.1889185-9-hsinyi@chromium.org>
References: <20220606152431.1889185-1-hsinyi@chromium.org> <20220606152431.1889185-9-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Jun 2022 12:16:48 -0700
Message-ID: <CAE-0n51Lq381dQW6zw3D0fibdj=Jm4r3uAYG59ySo4CXbx+EpA@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] drm/mediatek: Config orientation property if panel
 provides it
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
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
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hsin-Yi Wang (2022-06-06 08:24:31)
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index d9f10a33e6fa..c56282412bfa 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -822,6 +823,12 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>                 ret = PTR_ERR(dsi->connector);
>                 goto err_cleanup_encoder;
>         }
> +
> +       /* Read panel orientation */
> +       if (dsi->panel)
> +               drm_connector_set_panel_orientation(dsi->connector,
> +                               drm_panel_get_orientation(dsi->panel));
> +

It could be simplified like so?

	drm_connector_set_orientation_from_panel(dsi->connector, dsi->panel);

Then the API could get the orientation if the panel pointer is valid.
Does any code need to use/modify the orientation value besides
drm_connector_set_panel_orientation()?

>         drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
>
>         return 0;
