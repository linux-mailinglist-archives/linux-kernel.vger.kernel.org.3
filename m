Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245294A9AA3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbiBDOFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbiBDOFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:05:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8748BC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 06:05:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q63so5661880pja.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 06:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qpcRyh+24qtP2VVaX3PS7mv2lf5IWfW1neqWFvhdxM=;
        b=HjMI8iZLqfdazRpmnpfZL//MzxxnWj63vgQoTMi7jsbHxH1ssKOVpsZzSZEQnOlY6E
         wZAWPbVnJ5++71gvc3WZRhn/63ZmQAyUB0jZiJOkwwNcPxWvUETM53K37Dcw2Fu/ATWn
         Jx0H11c+ls9yn0/KiuE9h4bDVdg6X+8QFjcbPYb5FjndjsGDzGDBLMsYL9kuE6BRizKQ
         B71ju3Tpo160s0fXVOw/ZkbOpWxe4Ay+f3W05T9OY6Uli045hEVr2rC0WRQgQ+ZNNgpx
         3CfbNChebx1P8JuuOKOot8OtyCkJ3aK2q0Zy9HD1r5SdEDUGAvCLFWlABsXZBaN2MPio
         c/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qpcRyh+24qtP2VVaX3PS7mv2lf5IWfW1neqWFvhdxM=;
        b=y30zduHFZGhSg4tNmMvy8lQ6G6xajyn82Hp6lkOKO7v7LTbVpygwWwBepuCc939wtp
         s76FFc+fqz2GVWMAWBg17gmeD1cBB0Z02tx6SoLX3vg9s306LMrbnOt/wvQnOoQpo5Zv
         NkWIYMxJZMHuIj+euQFSJfmMJRTeT1EEktPOEM8N80EKeKv9j2YWsYKpcE/sNh/L2+oF
         SrIjNgElA/xmyUzLRRLsCxs4x0vNh0Ls5DzYAhZVlOxsirazQGqxmyU4hL384bD8OI7Q
         1FKxBxSOc3Up217vTbf3Qhij+33HAQrQT6p7pyY/ePvBAr7m9UTLvSWHjEXJz4tq+06G
         SY4A==
X-Gm-Message-State: AOAM530kYAEJUBvtgW+1Uy2g84JUU2iZMcX+7TsV615KOGMPWiC37Rn8
        rYhJfZSUqzoymwLaHlTpn3D1mgTzZuL8rIXkom1oeg==
X-Google-Smtp-Source: ABdhPJz/hl4o9naclBibn/3lZ3yW55IUCJbzoEq5EV8ShNlXxqU02ZIHt8TgohirAOEr5upB4OmCwB4CEpZUJ1U+1wU=
X-Received: by 2002:a17:90b:4a86:: with SMTP id lp6mr3334875pjb.152.1643983529997;
 Fri, 04 Feb 2022 06:05:29 -0800 (PST)
MIME-Version: 1.0
References: <20220119122843.1455611-1-narmstrong@baylibre.com>
In-Reply-To: <20220119122843.1455611-1-narmstrong@baylibre.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 4 Feb 2022 15:05:16 +0100
Message-ID: <CAG3jFyv15AhfZP0HTAt73U0yvKHNAMLmKzFu-9AfX9v76h7s6g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: dw-hdmi: use safe format when first in
 bridge chain
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kieran.bingham@ideasonboard.com,
        biju.das.jz@bp.renesas.com,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 13:28, Neil Armstrong <narmstrong@baylibre.com> wrote:
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

I think this is the wrong hash. Is 7cd70656d128 the actual hash?

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

This hash too.

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
>                 *num_output_fmts = 1;
>                 output_fmts[0] = MEDIA_BUS_FMT_FIXED;
>
> --
> 2.25.1
>

There are two checkstyle issues apart from the above mentioned hash
issues, and I think we can ignore those. With the above mentioned
issue fixed, feel free to add my r-b.

Reviewed-by: Robert Foss <robert.foss@linaro.org>
