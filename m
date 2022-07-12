Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3525713F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbiGLIH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiGLIH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:07:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10AE9D535
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:07:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id va17so12983799ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITVhnqo1Cv9/rj2IS2OAC3zsa28ryV/5jfshq0IqbrM=;
        b=HH5x+ipYuSILhjaCqwXRHRGdn8R2iE9it0Raabx0zG7RiLVbQD6paOyfsCyl0WDrLF
         R5XoZ7aTaJTnZF2x2seTAP7qb0LiLkKUyC2nOuXmKzTmbCJKcHdw/ptEKclRERYOF59E
         KkgJPwoxfu4c024UgrISFxVoaiqk4HGG+APntuIOEfWfWK0uJ0Fe04lJ7YsuHkyG28Gt
         vjqKag19IHw0lh3qsOIFh0pPk0Ebm7SZFO8ZG7+2xbLVN3FtyxP3znjVJjuWLOR1dUQ6
         SrMUgw6oy2EcLYRYJYR8M0smp2b9tKiy0ctybyRv/i9Rd+x1x8vRuZzkT/BNsSvGu0fg
         iJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITVhnqo1Cv9/rj2IS2OAC3zsa28ryV/5jfshq0IqbrM=;
        b=xZTsxXNxuRCSq8rgQ7TDpvi83AhFFMTqeMBnkyJiPMi0ZX+bs1Gy69QmWjiKqkpKNO
         kazs+PgcjhxlfwHgReaOZUUwjx5O89h1bur61T71h4Ifwk0GGWBdGx+PM0usHK0lSIJI
         Mwk2frl9dz7RfR60d/jxdu1e1cVtxkbZtLmHeEnGD5uC0jyLe5x/XwpOib4mtIcQzPux
         8qXXpB1lcaoLn7uEPeQ+B/8bFeJOQHceugnOFc/w9xhy4IxHYoo/8RQd5w7LUDIz4Ywm
         Rz4IQeSzshY2rGESCIPSN7LWbJH497CouaV+fXihoY1N7nDAD3hiBxTUedlqwiqIq2zR
         3v2Q==
X-Gm-Message-State: AJIora9VlDuwVDGcn3FrEKp4q9XNE1xg2Khl0pyxwAesV40qnYkMWo+J
        99Z0ICDzGcgSlLiwX3r/NW42i4Iwyo27LpTEKVGM+Q==
X-Google-Smtp-Source: AGRyM1tPaVDQ4QKhpXmcSUkc8kF1eeRMrVHZYwDUL9byPNuSCRXq7stKql2iScJzi/bvVrwBvpPq0VXb013QRxtlSks=
X-Received: by 2002:a17:906:b6c7:b0:726:60aa:1b81 with SMTP id
 ec7-20020a170906b6c700b0072660aa1b81mr22449356ejb.383.1657613273439; Tue, 12
 Jul 2022 01:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220707080600.49041-1-allen.chen@ite.com.tw> <20220707080600.49041-2-allen.chen@ite.com.tw>
In-Reply-To: <20220707080600.49041-2-allen.chen@ite.com.tw>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 12 Jul 2022 10:07:41 +0200
Message-ID: <CAG3jFystTA3sD2nWJHPYq39WxRwjVt4qj2DMDk2Khh1kR=8ntg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/bridge: it6505: Modified power sequence
To:     allen <allen.chen@ite.com.tw>
Cc:     Pin-yen Lin <treapking@google.com>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Pin-Yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

On Thu, 7 Jul 2022 at 10:06, allen <allen.chen@ite.com.tw> wrote:
>
> From: allen chen <allen.chen@ite.com.tw>
>
> Change power sequence to meet it6505 data sheet requirement when boot on.
>
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 2d119e3016b3..aa5e0aa1af85 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -3029,7 +3029,7 @@ static int it6505_init_pdata(struct it6505 *it6505)
>                 return PTR_ERR(pdata->ovdd);
>         }
>
> -       pdata->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +       pdata->gpiod_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);

Making this change is problematic since it requires a corresponding
change in all of the device trees that use this device. It's against
policy to change this interface after it has been introduced.

Unless anyone thinks otherwise, I would like to see this patch dropped.

>         if (IS_ERR(pdata->gpiod_reset)) {
>                 dev_err(dev, "gpiod_reset gpio not found");
>                 return PTR_ERR(pdata->gpiod_reset);
> --
> 2.25.1
>
