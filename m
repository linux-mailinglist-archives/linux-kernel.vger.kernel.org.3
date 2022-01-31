Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F284A4BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380303AbiAaQZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245196AbiAaQZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:25:35 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94872C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:25:34 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id v74so13302348pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tH4Dt4VfD+f2v5yRHdWa89N16xlCoMNOcH1dEff8QrA=;
        b=esoJHuFWJuRYH89Lq143BAKhwHoiqJwjnoXsYbx2bmRYpJFO180G1vxNSfZ+Icd7Bp
         M6a1pOoVNMGUZskUPl1PEDmx4Qmbo8woVamQs8dCEZvgserXopUfCrdPhk9W7eOLioaX
         1TgQmNv8RYLneEjejDfEZgFZFJLerQDzApiFlUk7J3G3UwEoQhhvV6bFcYSHFggWKefA
         HV0PDonrmnrk86JLcR0QIEZJ7RFBdWIHUvU+Ku+BLgEKZSoL9xpi0+K/9g35aWZ+Wij2
         0zKmOblDkVXxxsDqXQYmGvDC3ZV8vnJeQL2ebaNRabmYyOlTU2uVrkgCy36ln+vsP0Ns
         cDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tH4Dt4VfD+f2v5yRHdWa89N16xlCoMNOcH1dEff8QrA=;
        b=mA/VykqZ0B+syN2bPTHJ8vr8Q8MoHt9hwXpyictjKZ/ZrM0tZg+39MOIlOCormt2aa
         NLb5n+nxCBngIqRXargkawpbQMyeowToiIPGOcOO5tQ1JWBXwPlRkOM4rwL+XpM213lO
         EMg0Dpy56fOwjkfLi5WCw0YQDexkYNzvMnuEmPVLOjm1jlh5nsHk6Cwy30Yvu+XVfYHF
         BdyRsMdZ46/DL6rnMPFnpMTDVvz8lKHTZxiEjV1F4SC5wxX8XyWmsiq7O9oo9ebxSI/s
         kyzeKBeJnmV2/kwpWdFpCM4zTR/VW6AN4azNJE63ROMF/AouVVFxU+Fk1K1g4EWOoaj+
         yywQ==
X-Gm-Message-State: AOAM532+1pdFQdwQyRh3KhZxETuGGrIXymVUm5+XWb/ozTPr6Fwu026W
        9CBivtFMoBdIGr7CSjXuPpDJF2E3vKylnSpVBZHGRg==
X-Google-Smtp-Source: ABdhPJwENZbL1Q+TBrnar+Rgwvb0PPSNZUScFAwdzFtfG/EkQzbwzbSc1S0LLCdkRYee1cv7+KDyPaKyJ9FQMuMBAK0=
X-Received: by 2002:aa7:8490:: with SMTP id u16mr20808783pfn.1.1643646333972;
 Mon, 31 Jan 2022 08:25:33 -0800 (PST)
MIME-Version: 1.0
References: <9c20eb74d42f6d4128e58e3e46aa320482472b77.1643468761.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <9c20eb74d42f6d4128e58e3e46aa320482472b77.1643468761.git.christophe.jaillet@wanadoo.fr>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 31 Jan 2022 17:25:22 +0100
Message-ID: <CAG3jFytrA4D2-JrABb+iG2kFQHVB5-_UQWoQyFJ3R=rfarre-A@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: lt9611: Fix an error handling path in lt9611_probe()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Christophe,

Thanks for submitting this fix.

On Sat, 29 Jan 2022 at 16:06, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> If lt9611_audio_init() fails, some resources still need to be released
> before returning an error code.
>
> Add the missing goto the error handling path.
>
> Fixes: 23278bf54afe ("drm/bridge: Introduce LT9611 DSI to HDMI bridge")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index dafb1b47c15f..00597eb54661 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -1164,7 +1164,11 @@ static int lt9611_probe(struct i2c_client *client,
>
>         lt9611_enable_hpd_interrupts(lt9611);
>
> -       return lt9611_audio_init(dev, lt9611);
> +       ret = lt9611_audio_init(dev, lt9611);
> +       if (ret)
> +               goto err_remove_bridge;
> +
> +       return 0;
>
>  err_remove_bridge:
>         drm_bridge_remove(&lt9611->bridge);
> --
> 2.32.0
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
