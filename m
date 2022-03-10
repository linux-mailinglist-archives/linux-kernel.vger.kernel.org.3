Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4A4D551E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344171AbiCJXLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344585AbiCJXLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:11:37 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BC0199E3D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:10:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qx21so15381735ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdRD7UqyvIUj279CEK1jZhIkgCE+xn41rfRl2yq1BwA=;
        b=T/q56MG2EY5bFCFeahW25OmtAXtMaEF5rZwoAkIuXrQ+H+ausHtpVCkE4IGxGnitV9
         7wuejt/lAn4WozekwFbX/ISvBi2gQ2dmVE7m0S3Ug4eXsNJ9DfMOqauA+agFNy33+qN1
         xyrawS89u6mWz1ZMfZ9rS/OTtQw2YrBmH8MXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdRD7UqyvIUj279CEK1jZhIkgCE+xn41rfRl2yq1BwA=;
        b=6C8EWPezVjEDuzc1JoXgLyayTD0lwoabA5QRrZXjWgBUnH5TnebqWe/ioF2itunEy4
         VfX4OgNNdM7/uJXD/CsXtXq1otQIGEsmTH2kL9lcANett7x6RdtRgpkwLSYls28DIgOw
         rgT8z0gHFYBtUrmdKp2eRONLw9H9r5/VHxbC4Qwv3Qv3uUfLRNVu5j2cQ/WmIeQkv2K4
         PBRyaGfeKXxEL9Hj0SGgHFCwGR9DpSaW+MyS4Xt9TCjQ95Go0qeR+erSmITABkEkEx62
         bKQ+v6h1ZYW3RR1tpuWSS0Lzg2mvUgZUMU+SIq3gZiTOUosHJleO1R+owvsuAdfzaA6M
         KlXA==
X-Gm-Message-State: AOAM532GqWTMp3WncGvTSbcoYisnH1cYhP8ralGX2vC8DJg+63pEvgfj
        zKASt/TK4cF45cDlTyFjACYFySSnwWBVPZCR
X-Google-Smtp-Source: ABdhPJxM3uUUpzbHyqWUxH9guzz06GTbjtGWXqy1GuRHlJlaIiqpJf+s09PVzT14kRFktNRZiGkYYA==
X-Received: by 2002:a17:906:7056:b0:6d6:dd99:f2a4 with SMTP id r22-20020a170906705600b006d6dd99f2a4mr6141456ejj.43.1646953834560;
        Thu, 10 Mar 2022 15:10:34 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id y12-20020a50eb8c000000b00410f02e577esm2589691edr.7.2022.03.10.15.10.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 15:10:34 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id h15so10392522wrc.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:10:34 -0800 (PST)
X-Received: by 2002:adf:e983:0:b0:1f1:f52b:8328 with SMTP id
 h3-20020adfe983000000b001f1f52b8328mr5208098wrm.513.1646953833413; Thu, 10
 Mar 2022 15:10:33 -0800 (PST)
MIME-Version: 1.0
References: <20220310152227.2122960-1-kieran.bingham+renesas@ideasonboard.com> <20220310152227.2122960-3-kieran.bingham+renesas@ideasonboard.com>
In-Reply-To: <20220310152227.2122960-3-kieran.bingham+renesas@ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Mar 2022 15:10:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UcfrWLQdCOx5dCfjvjrLzkdLDeoAROmMtqFWB_X90rwQ@mail.gmail.com>
Message-ID: <CAD=FV=UcfrWLQdCOx5dCfjvjrLzkdLDeoAROmMtqFWB_X90rwQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/bridge: ti-sn65dsi86: Implement bridge
 connector operations
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 10, 2022 at 7:22 AM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
>
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Implement the bridge connector-related .get_edid() operation, and report
> the related bridge capabilities and type.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
> Changes since v1:
>
> - The connector .get_modes() operation doesn't rely on EDID anymore,
>   __ti_sn_bridge_get_edid() and ti_sn_bridge_get_edid() got merged
>   together
>  - Fix on top of Sam Ravnborg's DRM_BRIDGE_STATE_OPS
>
> Changes since v2: [Kieran]
>  - Only support EDID on DRM_MODE_CONNECTOR_DisplayPort modes.
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 93b54fcba8ba..d581c820e5d8 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -1135,10 +1135,24 @@ static void ti_sn_bridge_atomic_post_disable(struct drm_bridge *bridge,
>         pm_runtime_put_sync(pdata->dev);
>  }
>
> +static struct edid *ti_sn_bridge_get_edid(struct drm_bridge *bridge,
> +                                         struct drm_connector *connector)
> +{
> +       struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
> +       struct edid *edid;
> +
> +       pm_runtime_get_sync(pdata->dev);
> +       edid = drm_get_edid(connector, &pdata->aux.ddc);
> +       pm_runtime_put_autosuspend(pdata->dev);

I'm 99% sure that the pm_runtime calls here are not needed and can be
removed.. The AUX transfer function handles the pm_runtime_get_sync()
and it also does the "put" with autosuspend so that the whole EDID can
be read without constantly powering the bridge up and down again.
