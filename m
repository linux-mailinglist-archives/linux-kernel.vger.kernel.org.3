Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CAB48422C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiADNNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiADNNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:13:17 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49148C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 05:13:17 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id s15so32194606pfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 05:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQb0DIrsgwrY39ZJp4Gbi20DdgFhiCJMM0UBEM1mze8=;
        b=qfMgs3gNP9IhkFZpOxI/W0VlK2Rki6/H+1oKwkREx4rl+Ox2CQxa1vQ0OWLiwYhRbz
         0HkyYqM1u+acg86NMtLrO9w8zD1whdcLZProe33Q+JC69IXoAMqh3Y/pceobavfBVT/j
         eOziwPg0xeIAfisD0qaU85nb5DJYL9NbXMRH+SpPIUYdmkZ/MFRs+ByxJJSCTAlW+ZCl
         PLgk3mnPOlufa/0JYqn9qLnVju+/JYp54ePyepzpBo7aQo2O2V6AMtvU/RYTjcVEurVT
         LUUVYushGPiua20JjEMyNgpe7EmB2+fbZ611lApQdRvoeVGLeIxEPcqLJlaHum7Fg2b6
         ywhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQb0DIrsgwrY39ZJp4Gbi20DdgFhiCJMM0UBEM1mze8=;
        b=Yx4dtt0FPJBU4SviW3N5YmpXuvkED1ZF3Q+hvvk7S0EOaIk1eZPBtWm0dci9kP06O4
         dzP56wiS4aqUrP1JmuANzBs+htsjXEbgS3c4wx1rsTY9o9DuJsXPUZNa4KeXDiRZNoZ+
         jd/LWZChUOVYxl8jjHNdF2UkntWCbpi6fjtdzM49mZXRmbDZAIaGrFIhx7e48eWRl3+0
         22MXDNJqpk4XQOTjYIMzuIIrD8EZdUzQln9QA5wuRIViLkKBp9/p4bAATy3NdIQHYmv+
         hMXZhhksyuFqvGSCjzLDAYf2uSqmMVL8MDe74im6MqQ5ElAC9CaN+cTQ9CvUVLHdf1/w
         TEnQ==
X-Gm-Message-State: AOAM530WSV1+AbY2fM3ETyr/z1ge6xBKfAvKVtv/i79hfrSOarfB3O2x
        BaEhpcTTW4pYFHjuBdc1BbEbU6JA0NjRMdiD7m4sRg==
X-Google-Smtp-Source: ABdhPJx+P5Je+IhljrJKeXPje/sQlDLlysR9Jr9VsVBOTdAksyr4JhbGrpRtfGq7ayAtXHn87lvMqSvOTR3amiAJ3v8=
X-Received: by 2002:a63:854a:: with SMTP id u71mr43738870pgd.201.1641301996726;
 Tue, 04 Jan 2022 05:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20211227092522.21755-1-linmq006@gmail.com>
In-Reply-To: <20211227092522.21755-1-linmq006@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Jan 2022 14:13:05 +0100
Message-ID: <CAG3jFytHBizw_kxbjgRkv0WcxJE1LsKhO7X98fDGSqCzh2kafA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: Fix free wrong object in sii8620_init_rcp_input_dev
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 at 10:25, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> rc_dev is allocated by rc_allocate_device(), and doesn't assigned to
> ctx->rc_dev before calling  rc_free_device(ctx->rc_dev).
> So it should call rc_free_device(rc_dev);
>
> Fixes: e25f1f7 ("drm/bridge/sii8620: add remote control support")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/gpu/drm/bridge/sil-sii8620.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
> index 843265d7f1b1..ec7745c31da0 100644
> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
> @@ -2120,7 +2120,7 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>         if (ret) {
>                 dev_err(ctx->dev, "Failed to register RC device\n");
>                 ctx->error = ret;
> -               rc_free_device(ctx->rc_dev);
> +               rc_free_device(rc_dev);
>                 return;
>         }
>         ctx->rc_dev = rc_dev;
> --

Reviewed-by: Robert Foss <robert.foss@linaro.org>
