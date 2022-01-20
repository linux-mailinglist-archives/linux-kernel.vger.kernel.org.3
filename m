Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27296494C97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiATLPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiATLPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:15:02 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F1CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:15:02 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id m11so27022584edi.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCGbnSIdeVbc+bdXt5zsiojMkCxV5VpYtP9a9mDjURU=;
        b=FT7qC5sPu+G1OIfrLGzhNGP+P1cPEnYbuJkYByoReQfid0NZ7HxsgC9qC2YGLtgdHp
         C2p7aktVbPdVexnAAX9rTbxTVDCIOyMc7PaesN3OWvw9LET1QlycXuzgU5P3f+Hs44wR
         gsZhHmatoEmOwZ46sMLQdUM3vzmMe3Mxkhk8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCGbnSIdeVbc+bdXt5zsiojMkCxV5VpYtP9a9mDjURU=;
        b=jMsOY1ZEE9DFyA3Zy7H5m6U87SFviO/ZPJ6NR5WYDj4sLy38k/cP1LhzJ0dR/+Ipl1
         aLIG5ezBLaoTHlina8fDqwqyRbLpOzFcT0ZlIh9sT3f5OOnFg0R5A9hFGGpBljCO7tti
         bBmYwPNTlo6CQHJbknHoruf4rmctD54+HqTYUZd4g4xVd4zdGxBp9TnnQ8BK0NByrX/7
         hGEq09YWM1u+HlyDmZ8zaYQet3TGIoo1kYSev3yzG2EOpnQOnu8JHo48DbnC0EdeK4Of
         plbqyQheMaZ/wPGrf8hziN8UKLD7zJcHPjuCLPmwNuDqhEVlF3ra5YmhkSe/r7uK9BBo
         CDXQ==
X-Gm-Message-State: AOAM532LWQfYPqxPC6SgVqJN/068zVzhfXLcqACNT3tKwpCH2DAnVdYQ
        UB4jhbvGT1YpvkMM86yooMvmJWvTYMqUa9rvff3oZQ==
X-Google-Smtp-Source: ABdhPJy0Rw3dNudsqr44tsK3H1wq7yJrlB7b/cPD/JGratpsbyDUX3QaW1JHCSJhFUXeCVCWwXV8lL0DwW+oi82UKkE=
X-Received: by 2002:a05:6402:4244:: with SMTP id g4mr12693422edb.271.1642677301085;
 Thu, 20 Jan 2022 03:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20220119122843.1455611-1-narmstrong@baylibre.com>
In-Reply-To: <20220119122843.1455611-1-narmstrong@baylibre.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 20 Jan 2022 16:44:50 +0530
Message-ID: <CAMty3ZBHSt2jjOxhQWpyYviTM3-uF0HXFtbGPjVddk4PP8Npsw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi: use safe format when first in
 bridge chain
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robert.foss@linaro.org, jernej.skrabec@gmail.com, jonas@kwiboo.se,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kieran.bingham@ideasonboard.com,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        laurent.pinchart@ideasonboard.com, biju.das.jz@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 5:58 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> When the dw-hdmi bridge is in first place of the bridge chain, this
> means there is no way to select an input format of the dw-hdmi HW
> component.
>
> Since introduction of display-connector, negotiation was broken since
> the dw-hdmi negotiation code only worked when the dw-hdmi bridge was
> in last position of the bridge chain or behind another bridge also
> supporting input & output format negotiation.
>
> Commit 0656d1285b79 ("drm/bridge: display-connector: implement bus fmts callbacks")
> was introduced to make negotiation work again by making display-connector
> act as a pass-through concerning input & output format negotiation.
>
> But in the case where the dw-hdmi is single in the bridge chain, for
> example on Renesas SoCs, with the display-connector bridge the dw-hdmi
> is no more single, breaking output format.
>
> Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
> Bisected-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Fixes: 0656d1285b79 ("drm/bridge: display-connector: implement bus fmts callbacks").
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> Changes since v1:
> - Remove bad fix in dw_hdmi_bridge_atomic_get_input_bus_fmts
> - Fix typos in commit message
>
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 54d8fdad395f..97cdc61b57f6 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2551,8 +2551,9 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>         if (!output_fmts)
>                 return NULL;
>
> -       /* If dw-hdmi is the only bridge, avoid negociating with ourselves */
> -       if (list_is_singular(&bridge->encoder->bridge_chain)) {
> +       /* If dw-hdmi is the first or only bridge, avoid negociating with ourselves */
> +       if (list_is_singular(&bridge->encoder->bridge_chain) ||
> +           list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain)) {

What if we use bridge helper, drm_bridge_chain_get_first_bridge in
order to find the first bridge in chain?

Thanks,
Jagan.
