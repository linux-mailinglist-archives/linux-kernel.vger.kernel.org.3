Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B81474666
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbhLNP01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhLNP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:26:24 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30607C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:26:24 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id i63so28857495lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 07:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E1s89Tuk39UOoZlOnaYWQ3Z1+01yfMXbQponNEtbH2M=;
        b=WwgkRYx3+StpmQOX5zWNZea0LTRzvre8BcRBHN+bQETXffydPPalqRgKWQ3fW+eAFI
         KFzK2WFm26VKLSwNLWJGuC39mWkVXz6LUdX/VmLg5SCCbnB+dsBXv5wlewTxhAUmboEF
         6hKcZV6qzTaHqqZb+PkOulHm19BA4/flkL+WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E1s89Tuk39UOoZlOnaYWQ3Z1+01yfMXbQponNEtbH2M=;
        b=iH3U1/R8jXRpp4JyxZADul+r4zgB0hjJfojcXtk798uSXlshms8JXOhpLhRlFaornf
         hOFkwn0YPU77Rhiuu7LlYewGRLEGs3r9QbQVchbl/fK1EOwKhzH8eiCOGg+ECU8cTMFG
         PAK8qCWl2TBxJkQx0SKFcxVIWLbUWmP1vJauUxVtYraZGZjbruVBrTINVSi6AtY78g4d
         LEb6/Ayz8GQAiewd0dyV2D0OWZG/iCnwqKmXPPN7uXl/9ts5vybpAvI72XZ32Sly7b6U
         nEa7ER3yU5l4vRHy7kAUq3/aqiwYJi9VYM8e+wQogEaRY6c8zlI7OLoDpAbvlzXFL4S3
         EkmA==
X-Gm-Message-State: AOAM531DBX9kYuouYRuH2cTUfONaaJpm6HYSKZi1r8NN9fMgnzGI1bwG
        /RAt7iJgm7AbfyF9e/TU9tWUoufLQnjZ7EUr9PR10Q==
X-Google-Smtp-Source: ABdhPJxXEMFm5MO03ocP3YbIlaXlGoJzGI5gjZgD3+oeBt+anch+hjrguJ7Q8hdUWyFJf6G1XVFZ07wtaAndgQfCxnM=
X-Received: by 2002:a05:651c:50c:: with SMTP id o12mr5639330ljp.88.1639495577542;
 Tue, 14 Dec 2021 07:26:17 -0800 (PST)
MIME-Version: 1.0
References: <20211027162806.2014022-1-markyacoub@chromium.org>
 <20211213160742.744333-1-markyacoub@chromium.org> <CAAOTY_81KaSEWAqTWgzmshDZ9BefO3pNrqQwWbB01E4L0+mqzg@mail.gmail.com>
In-Reply-To: <CAAOTY_81KaSEWAqTWgzmshDZ9BefO3pNrqQwWbB01E4L0+mqzg@mail.gmail.com>
From:   Mark Yacoub <markyacoub@chromium.org>
Date:   Tue, 14 Dec 2021 10:26:06 -0500
Message-ID: <CAJUqKUp_Q39S912_epc3pfT-uc3DN=u4sCSdLm9VetwqdH_Pzw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Set the default value of rotation to DRM_MODE_ROTATE_0
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sean Paul <seanpaul@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>, tzungbi@google.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you so much!

On Mon, Dec 13, 2021 at 6:27 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> wro=
te:
>
> Hi, Mark:
>
> Mark Yacoub <markyacoub@chromium.org> =E6=96=BC 2021=E5=B9=B412=E6=9C=881=
4=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:08=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > At the reset hook, call __drm_atomic_helper_plane_reset which is
> > called at the initialization of the plane and sets the default value of
> > rotation on all planes to DRM_MODE_ROTATE_0 which is equal to 1.
>
> Applied to mediatek-drm-next [1], thanks.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.gi=
t/log/?h=3Dmediatek-drm-next
>
> Regards,
> Chun-Kuang.
>
> >
> > Tested on Jacuzzi (MTK).
> > Resolves IGT@kms_properties@plane-properties-{legacy,atomic}
> >
> > Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_plane.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm=
/mediatek/mtk_drm_plane.c
> > index e6dcb34d30522..accd26481b9fb 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
> > @@ -44,9 +44,10 @@ static void mtk_plane_reset(struct drm_plane *plane)
> >                 state =3D kzalloc(sizeof(*state), GFP_KERNEL);
> >                 if (!state)
> >                         return;
> > -               plane->state =3D &state->base;
> >         }
> >
> > +       __drm_atomic_helper_plane_reset(plane, &state->base);
> > +
> >         state->base.plane =3D plane;
> >         state->pending.format =3D DRM_FORMAT_RGB565;
> >  }
> > --
> > 2.34.1.173.g76aa8bc2d0-goog
> >
