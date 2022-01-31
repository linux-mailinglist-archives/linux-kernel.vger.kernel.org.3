Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904F84A4BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380331AbiAaQ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236218AbiAaQ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:26:42 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D00DC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:26:41 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 132so1693545pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cXgpXNmpURYuKO5hFXomyVO5gSKNrTXbh1rD4OzUpXg=;
        b=WR1c+rZqvGGeYSIO6gzOcCW1QC9dPCVdFWw/OeifVZiQihnPygq/QdXzuViZ9SjphP
         ayzUaWkLGwzDG4Xsge/K+PoDGxJiL1fTn8t/T5alQQYGbtr9FbCKoQYdPTPTAKoDAqvj
         qwxu29KzmhcPfmcGid0kH50kWRV7OjH2pkxpbZpJUlldIKhYyNtY2LhMbyFaHT42ZoOu
         OasYPUbcQuUdTH12mC2b6ZjJtt/eLtFk16st4bwPHmOOqg1vK9C2vNZw9XWNIuLy71FB
         Rlgj9qfzTjR4Th548pf2sEQQGJld0nPufqxTkBZUwMhezj0nXWLsjGK2YoAuSuxoPTKh
         +lJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXgpXNmpURYuKO5hFXomyVO5gSKNrTXbh1rD4OzUpXg=;
        b=hIECWzOz8iFonWQFkLgmJ5aj1jOrcHfswh4z0DWBe3qEDbPsXQukwDuspI6IeDqTIf
         WUYUonj0zZGtRNE2JMJLSVcFrnFJTYfskuFk9ezX6aGMDiql7FLVLw/COz6uvUuqXfpU
         t3PC6VNomzgR6T1/g0W4vvnTW57VYOS13jBZg2gePM7aVnOawd79hgOWPCnMJCYyzr92
         1thQ+4wl+CI9H3UlR7VbtYntOFnt/Xxy5X+KMUSnL2X7PfmOQznlw7Mc26Zh9aY4dcdh
         RitF4pHM9pCoMs55OD+uxjERN6gFzxoJNVlqWVXYP4quE/M4WO14vjoy53ky9QzMow9U
         8/gA==
X-Gm-Message-State: AOAM533yLtMujrqFoVkrJyfdY1yU6pfOf/YcjoYMeUhfl5lKGWKgirtN
        AjA1huNmZRIYHSdRDbbVh/9oSpmc5j8YXyxPQZkNSA==
X-Google-Smtp-Source: ABdhPJyul35EmKETJMvyOwoqTDyNw60O6aZw61+KCHfRM3+oym7Fio60R+RndTgIhPeuZtvYj2RPvrUYpe+m2VVADs8=
X-Received: by 2002:a63:4a49:: with SMTP id j9mr17048783pgl.178.1643646401132;
 Mon, 31 Jan 2022 08:26:41 -0800 (PST)
MIME-Version: 1.0
References: <9c20eb74d42f6d4128e58e3e46aa320482472b77.1643468761.git.christophe.jaillet@wanadoo.fr>
 <CAG3jFytrA4D2-JrABb+iG2kFQHVB5-_UQWoQyFJ3R=rfarre-A@mail.gmail.com>
In-Reply-To: <CAG3jFytrA4D2-JrABb+iG2kFQHVB5-_UQWoQyFJ3R=rfarre-A@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 31 Jan 2022 17:26:30 +0100
Message-ID: <CAG3jFys5GLKpLFfeVUg-cJaY2j17Z=4c4M+QYiS6M=+b=YH=Ag@mail.gmail.com>
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

On Mon, 31 Jan 2022 at 17:25, Robert Foss <robert.foss@linaro.org> wrote:
>
> Hey Christophe,
>
> Thanks for submitting this fix.
>
> On Sat, 29 Jan 2022 at 16:06, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > If lt9611_audio_init() fails, some resources still need to be released
> > before returning an error code.
> >
> > Add the missing goto the error handling path.
> >
> > Fixes: 23278bf54afe ("drm/bridge: Introduce LT9611 DSI to HDMI bridge")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/gpu/drm/bridge/lontium-lt9611.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> > index dafb1b47c15f..00597eb54661 100644
> > --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> > +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> > @@ -1164,7 +1164,11 @@ static int lt9611_probe(struct i2c_client *client,
> >
> >         lt9611_enable_hpd_interrupts(lt9611);
> >
> > -       return lt9611_audio_init(dev, lt9611);
> > +       ret = lt9611_audio_init(dev, lt9611);
> > +       if (ret)
> > +               goto err_remove_bridge;
> > +
> > +       return 0;
> >
> >  err_remove_bridge:
> >         drm_bridge_remove(&lt9611->bridge);
> > --
> > 2.32.0
> >
>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>

Applied to drm-misc-next.
