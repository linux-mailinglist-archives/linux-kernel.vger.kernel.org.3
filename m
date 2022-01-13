Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2DF48D3A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiAMIar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbiAMIaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:30:46 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3275C061748
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:30:46 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z19so1809085ioj.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y5adlxntEYi2bnudQTucURekR8+PW27N0Rz8bbantH4=;
        b=jb7FRwDCCwtlzdLBCME9hmSLl6t7/jrRvUs1KMP4s2xtHys/g1zhAKVvFhafLd1MEf
         gqGDsX1bWdGx6ZF0ePXExEcMJ7tFz+5LAyXjBd7hCpx4gRUoxc4DCkZRhD4V9sKPWT6k
         FquTEMFAWvmQ+r/J7JsjlbXmLTwevYe+dYn5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y5adlxntEYi2bnudQTucURekR8+PW27N0Rz8bbantH4=;
        b=LTa7cep3FKfhFzBi63bSkgSNeH8va/t3jzvPQCi86rxUVrRnojMg9LmeNM3PILGt/7
         ppyqAUezW1M4Fned+SuQpboEikvQjtFhIKAjLacpDXcuW2Y1W2t1mpZ1Za2p5MXxHA0t
         Z0Y6eQGxDAM2DTg/ybiQl+RSohMudKAl25m6n9wvllAOW0P0fwKBSYsxM0Of+7dWZEwk
         yGha28CUcejQiYZX4S0gWVr1bVBbt3OG1RlJFFeHzBBKbbUgQ6vf8dduzP15TR/a66/y
         EF2juQEgdSTXlrqN5MsJsFeWnpWukGrPUPoTQnUxiriGAq6uyka9GKWFFJh6uyMoV0uG
         0QWg==
X-Gm-Message-State: AOAM531AJnWd7C7WOUijbrtwPXcsMzVpDwpb/m8J8wHL4W7/gftZKry7
        or8eNNk/pqA6ieO9ooLCHCf7iKJ1rD9uo5oWOZi0Vg==
X-Google-Smtp-Source: ABdhPJzxd5OkVm/ge397TAbNMmK+9iaTRpcp6F/fGx99WpqbPLJMhgOV7b8m/VuiIwqFY4GBST05XnrVQezh3f0Nqbo=
X-Received: by 2002:a6b:7b49:: with SMTP id m9mr415723iop.204.1642062646094;
 Thu, 13 Jan 2022 00:30:46 -0800 (PST)
MIME-Version: 1.0
References: <20220113073158.2171673-1-hsinyi@chromium.org> <2e676870-11f2-b5fa-faf1-d6633e801a5a@wanadoo.fr>
In-Reply-To: <2e676870-11f2-b5fa-faf1-d6633e801a5a@wanadoo.fr>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 13 Jan 2022 16:30:20 +0800
Message-ID: <CAJMQK-jZgw0Kw0ON8sY=+FFf_Z_Pys48DN+r+g6cCUqcw_7-8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/bridge: anx7625: Convert to use devm_kzalloc
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Xin Ji <xji@analogixsemi.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 4:04 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 13/01/2022 =C3=A0 08:31, Hsin-Yi Wang a =C3=A9crit :
> > Use devm_kzalloc instead of kzalloc and drop kfree(). Let the memory
> > handled by driver detach.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >   drivers/gpu/drm/bridge/analogix/anx7625.c | 9 +++------
> >   1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/dr=
m/bridge/analogix/anx7625.c
> > index 0b858c78abe8b6..dbe708eb3bcf11 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -2515,7 +2515,7 @@ static int anx7625_i2c_probe(struct i2c_client *c=
lient,
> >               return -ENODEV;
> >       }
> >
> > -     platform =3D kzalloc(sizeof(*platform), GFP_KERNEL);
> > +     platform =3D devm_kzalloc(dev, sizeof(*platform), GFP_KERNEL);
> >       if (!platform) {
> >               DRM_DEV_ERROR(dev, "fail to allocate driver data\n");
> >               return -ENOMEM;
> > @@ -2527,7 +2527,7 @@ static int anx7625_i2c_probe(struct i2c_client *c=
lient,
> >       if (ret) {
> >               if (ret !=3D -EPROBE_DEFER)
> >                       DRM_DEV_ERROR(dev, "fail to parse DT : %d\n", ret=
);
> > -             goto free_platform;
> > +             return ret;
> >       }
> >
> >       platform->client =3D client;
> > @@ -2552,7 +2552,7 @@ static int anx7625_i2c_probe(struct i2c_client *c=
lient,
> >       if (!platform->hdcp_workqueue) {
> >               dev_err(dev, "fail to create work queue\n");
> >               ret =3D -ENOMEM;
> > -             goto free_platform;
> > +             return ret;
> >       }
> >
> >       platform->pdata.intp_irq =3D client->irq;
> > @@ -2637,9 +2637,6 @@ static int anx7625_i2c_probe(struct i2c_client *c=
lient,
> >       if (platform->hdcp_workqueue)
> >               destroy_workqueue(platform->hdcp_workqueue);
> >
> > -free_platform:
> > -     kfree(platform);
> > -
> >       return ret;
> >   }
> >
>
> Hi,
>
> you also need to update anx7625_i2c_remove() accordingly, otherwise you
> introduce a double free.
>
Hi,

Updated in v3.
> CJ
>
>
