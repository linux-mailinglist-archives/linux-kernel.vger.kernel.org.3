Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB15658C5B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbiHHJeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241977AbiHHJd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:33:56 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C8014001
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 02:33:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id tl27so15548965ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 02:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GefsinhhZIvzOgke7/j4icom1htodcT5WCpPQe8e5y8=;
        b=S/opORLqyTfnOu0Daq4yL0wo2oib7dNnwoTOvBbJD6W1BZJ0OPAbkYnd/LAxs2qvi0
         /Xl4YEhXQ13JuM7/tNN/z1II3hLf0tTpOt123F4bRnAzsGzbV8rfAZlXK7QajOX541tn
         cLLkA0A1OCruRyhi65G3u9MlmV6buWY1osyY6ENgWMNm07gIpp1fA3zF61i/PyRFv65K
         1NNOl1J3mcpg+F+z5Yz2nOL732BQ1uzzjqi2dnYIUUChPWUw/p6IQb/RFVL9j4YPLYFv
         zQThIuZrHALJ5CV+yQF0Onnp17JbmNX/FbJwJlrKYu6FaMYOIdWGR5qDU9bc+leVMz/I
         UY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GefsinhhZIvzOgke7/j4icom1htodcT5WCpPQe8e5y8=;
        b=iP+HXKH+TqetMvob8jYy/bdjpGr+rVRDuL6ASX/wHStvc/KNmqLmc0JNuvL5QTVpCM
         V7H1rhn6skD79SJQefnrGFF7PEirr3cY4WdtvciMOVyZBAvK809lUVsrFebmCX5rZmbk
         PBGaqEPNpLYVuV9fdgCTuburPzt0+OocjeEn7iYi47fthL2clFgd5CyFmHLlf6d4AFe0
         34bkm34GOND2LvS71Z9WlQ6J661KQuMIb2+lnpr/jKnpgHv/u27R8cCND3r3rSG2vA9t
         pG+YS4H1Db/zMiE46TqeYx/j/oIQBf3U+tnB+S+CIhFeN4MAoAYJ6aO/mgIwF6Ivuxsy
         Ky+Q==
X-Gm-Message-State: ACgBeo2ygOcadZJgH63dpD3uSUB0Ear1fkQ49xu3/b8OP0lDz5d9x7c6
        yzpndmJd16DY+gT6LcrmPpqZmXdxeZjHQlkrrDw+Mg==
X-Google-Smtp-Source: AA6agR7brckEvbEzJvrYSAuJQWiGLxzv7DxLaAmWGD2gLMrCpdNaKTvehj2HlCdSdENeHhdHsjDf97yAScpdW6/xOXQ=
X-Received: by 2002:a17:907:781a:b0:730:cd06:3572 with SMTP id
 la26-20020a170907781a00b00730cd063572mr13385426ejc.487.1659951228289; Mon, 08
 Aug 2022 02:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220727073119.1578972-1-zengjx95@gmail.com>
In-Reply-To: <20220727073119.1578972-1-zengjx95@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 8 Aug 2022 11:33:37 +0200
Message-ID: <CAG3jFyuMboP9OBJgYD01thVvhdb6wR5BeLN+za_ZUFM1QT4HDg@mail.gmail.com>
Subject: Re: [PATCH] gpu: lontium-lt9611: Fix NULL pointer dereference in lt9611_connector_init()
To:     Zeng Jingxiang <zengjx95@gmail.com>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
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

On Wed, 27 Jul 2022 at 09:31, Zeng Jingxiang <zengjx95@gmail.com> wrote:
>
> From: Zeng Jingxiang <linuszeng@tencent.com>
>
> A NULL check for bridge->encoder shows that it may be NULL, but it
> already been dereferenced on all paths leading to the check.
> 812     if (!bridge->encoder) {
>
> Dereference the pointer bridge->encoder.
> 810     drm_connector_attach_encoder(&lt9611->connector, bridge->encoder);
>
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index 7ef8fe5abc12..81a4751573fa 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -807,13 +807,14 @@ static int lt9611_connector_init(struct drm_bridge *bridge, struct lt9611 *lt961
>
>         drm_connector_helper_add(&lt9611->connector,
>                                  &lt9611_bridge_connector_helper_funcs);
> -       drm_connector_attach_encoder(&lt9611->connector, bridge->encoder);
>
>         if (!bridge->encoder) {
>                 DRM_ERROR("Parent encoder object not found");
>                 return -ENODEV;
>         }
>
> +       drm_connector_attach_encoder(&lt9611->connector, bridge->encoder);
> +
>         return 0;
>  }
>
> --
> 2.27.0
>

Applied to drm-misc-next.
