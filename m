Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F0450B963
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448283AbiDVOEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbiDVOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:04:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE56E5A0AC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:01:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q3so11071206plg.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Chb15DVMiI2nGn5AZ2xaunn8HK8CS50zKGvASbJkZjg=;
        b=QatWE9vcezju8KZl04JD7UfRVJ4Y7NOBD6/+Fdab+va2kyzFWhSohVlK06dqj0tqTQ
         +19nVVhwEG7HkHQOobNow0MogRGN1nGIsduZX12Mz1/QWkXK42qyq2wyqfaAwyu087W8
         H5oWGD+vF72x/7kygDyGvloW9TZGJwqd3XMpughfAmjols2y9vU913bLVepHpIWye+O5
         qlfOU+QGmLCJAtXHoDuyT/JoLl/2GsI1VFGjruoGHCFH4zAoy6KQSqBA5vuM6cMSPuse
         J+mcRdWWfL3Vb9B9LsnSnvO3mzM1OuM9OQJAMR98FVboKN2XN6WN6AUYp4h7cnIzP6om
         LzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Chb15DVMiI2nGn5AZ2xaunn8HK8CS50zKGvASbJkZjg=;
        b=uad41LYG11B2r8dMbOv3O7yuju5b1rIm5BIi5xSTP9XXl2u5IlTgx1QdLMrgL4qSW0
         3zXtrnrhIVCVDWiLH+NwSjBM/WvmYl6LfdeGxtxFUOvuX3lntcu0r084zQHW3MKMlsCr
         gnQhNSQcrb9a/x7u8QTUbIdyfnRp4Xrz9Xz5le2ySBJbO2A225OrKuhx0tVMiG/84Gov
         1h1+RJt3fALGwE8ZojIGUPCXTctHEFsMFf2alNhN2R9Bo4/06Ode0zYLyHfGZgrSohEF
         92sotRqeaiX/bhk3qLyi+KTfwjQMVCjCKHPQlFio+lPrCY4YBmZ5iWDKgil8ls5vBsfQ
         ilUA==
X-Gm-Message-State: AOAM531dfRh9ZUW7r4/x3OnjGtwEdiW6SLitaU5xqOF1jiBFiTfGyDit
        s7pMghJH2ZxMeOgkelCbatk79av+SS6WG/AIb4L2PQ==
X-Google-Smtp-Source: ABdhPJzF+5b6hj1uqWK03OgtUL14jzCt3qYijxoHNoT/KQlFt+N85j+F4eLD6WITOKqe4Cpy2YNOGDMYFU6lSAjI7O4=
X-Received: by 2002:a17:90b:3e84:b0:1d2:c015:2182 with SMTP id
 rj4-20020a17090b3e8400b001d2c0152182mr5548093pjb.232.1650636118195; Fri, 22
 Apr 2022 07:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084720.959271-1-xji@analogixsemi.com> <20220422084720.959271-4-xji@analogixsemi.com>
In-Reply-To: <20220422084720.959271-4-xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 22 Apr 2022 16:01:47 +0200
Message-ID: <CAG3jFytWGSUM9mevHewdmEe-hq3JgB74s7_f0fsEQqkXr9VUHg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/bridge: anx7625: Use DPI bus type
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 10:49, Xin Ji <xji@analogixsemi.com> wrote:
>
> As V4L2_FWNODE_BUS_TYPE_PARALLEL not properly descript for DPI
> interface, this patch use new defined V4L2_FWNODE_BUS_TYPE_DPI for it.
>
> Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 376da01243a3..71df977e8f53 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
>
>         anx7625_get_swing_setting(dev, pdata);
>
> -       pdata->is_dpi = 1; /* default dpi mode */
> +       pdata->is_dpi = 0; /* default dsi mode */
>         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
>         if (!pdata->mipi_host_node) {
>                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
>                 return -ENODEV;
>         }
>
> -       bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
> +       bus_type = 0;
>         mipi_lanes = MAX_LANES_SUPPORT;
>         ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
>         if (ep0) {
> @@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
>                 mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
>         }
>
> -       if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> -               pdata->is_dpi = 0;
> +       if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
> +               pdata->is_dpi = 1;
>
>         pdata->mipi_lanes = mipi_lanes;
>         if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)

Reviewed-by: Robert Foss <robert.foss@linaro.org>
