Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA91850B9DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448559AbiDVOTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448529AbiDVOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:19:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B305AECC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:16:21 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c23so11177109plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mhiX9pOS55YaO3CdrDwpUy6BkzPbq10Xj73NWvQBwAg=;
        b=vRUi3XTt6AzV9QlheY6fezduSTcEh/sZN3k+dAddNZiw8rhhyhbGXtJLNYs3J/UwD5
         bRx0NNWnHM1TYIelLSIgCtSpmnbMKDgukzfetN9iXKdtLRwPXB54SYzt6H400lsd3P4D
         ++PGiqJSRNedibPs1CaxKSPMQyTwkUYyruCII4+3lOh3uWSvP8+idLkPjw5BBA8QJsEi
         kvO8DlCiTkUMJj9c+3Kb4kPubeS7hxUdkzPshkGtiJXpeZOSSMzbk6sHBs+4HmVJPMRp
         e9Uz5m7trgk2XIsiSCfl29aZ0LqcmQ7ZWTP8PJh4RgMon1aGFHXpRKjuAUHuYVAvcCcH
         noKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mhiX9pOS55YaO3CdrDwpUy6BkzPbq10Xj73NWvQBwAg=;
        b=m5hIAFvszlhsmHPkSBOlgxx9Gco5LQpB3ybbWFUYBYiHQRu76fUHMaGojIBM8BQ9jg
         MLnUb5UIpSujhjJfG5DVkmouFSZmM8ikR5dv27UM0BFK4lm1u8BizE181wAkL1bXtxqj
         6/ZRkwX2xkJKVNpo99Ilj/1Nl45Arh0gU/ahrxpXcPJENbMhkfi3d/sxa82Oi2vbJbA8
         tC16ZFnH/IuvsBkhGPqGUo6yFvm2+Fe0n62r55CUitxsBbLk8NlsB+9k6fZB6duHftTR
         JbzXnH3C5GtgFVL19IPnpQPOJGeA1Gw3EB7oXdJ4URxjA6qF5SvqZ8WV60hCuLUu+3+j
         4VBg==
X-Gm-Message-State: AOAM530c9C2qlrs1XC2E1NETufZ39ermjfNncGXoUW8aZFgWK1fJVQyu
        8YdkiEvgZ7WAKJE3ss597xWEwm22A5QlQJslIT5UfQ==
X-Google-Smtp-Source: ABdhPJz8CXOzCAMrumvED5/FUzZpCHykjU/HdiKEagzluI2x9YcnPtdeO8E7Knfq/KSP3T5vLQuff5phq8eDfMmbJXk=
X-Received: by 2002:a17:903:2352:b0:159:3fa:261 with SMTP id
 c18-20020a170903235200b0015903fa0261mr4632628plh.21.1650636980753; Fri, 22
 Apr 2022 07:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220419010852.452169-1-victor.liu@nxp.com> <20220419010852.452169-2-victor.liu@nxp.com>
In-Reply-To: <20220419010852.452169-2-victor.liu@nxp.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 22 Apr 2022 16:16:09 +0200
Message-ID: <CAG3jFyvAjzHaA_BUJYj18Y-FbY5ROd3iXetAJ+BJaoEjZd6vsQ@mail.gmail.com>
Subject: Re: [PATCH resend v8 1/5] drm/bridge: nwl-dsi: Set PHY mode in nwl_dsi_mode_set()
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        vkoul@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, agx@sigxcpu.org,
        robert.chiras@nxp.com, martin.kepplinger@puri.sm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 at 03:07, Liu Ying <victor.liu@nxp.com> wrote:
>
> The Northwest Logic MIPI DSI host controller embedded in i.MX8qxp
> works with a Mixel MIPI DPHY + LVDS PHY combo to support either
> a MIPI DSI display or a LVDS display.  So, this patch calls
> phy_set_mode() from nwl_dsi_mode_set() to set PHY mode to MIPI DPHY
> explicitly.
>
> Cc: Guido G=C3=BCnther <agx@sigxcpu.org>
> Cc: Robert Chiras <robert.chiras@nxp.com>
> Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v7->v8:
> * Resend with Andrzej's and Jernej's mail addressed updated.
>
> v6->v7:
> * No change.
>
> v5->v6:
> * Rebase the series upon v5.17-rc1.
> * Set PHY mode in ->mode_set() instead of ->pre_enable() in the nwl-dsi
>   bridge driver due to the rebase.
> * Drop Guido's R-b tag due to the rebase.
>
> v4->v5:
> * No change.
>
> v3->v4:
> * No change.
>
> v2->v3:
> * No change.
>
> v1->v2:
> * Add Guido's R-b tag.
>
>  drivers/gpu/drm/bridge/nwl-dsi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nw=
l-dsi.c
> index d5945501a5ee..85bab7372af1 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -666,6 +666,12 @@ static int nwl_dsi_mode_set(struct nwl_dsi *dsi)
>                 return ret;
>         }
>
> +       ret =3D phy_set_mode(dsi->phy, PHY_MODE_MIPI_DPHY);
> +       if (ret < 0) {
> +               DRM_DEV_ERROR(dev, "Failed to set DSI phy mode: %d\n", re=
t);
> +               goto uninit_phy;
> +       }
> +
>         ret =3D phy_configure(dsi->phy, phy_cfg);
>         if (ret < 0) {
>                 DRM_DEV_ERROR(dev, "Failed to configure DSI phy: %d\n", r=
et);
> --
> 2.25.1
>

Acked-by: Robert Foss <robert.foss@linaro.org>
