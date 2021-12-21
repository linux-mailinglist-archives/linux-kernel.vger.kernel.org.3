Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825F247C5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240982AbhLUSKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240983AbhLUSKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:10:21 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44315C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:10:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so65478pjp.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4FuABV3XoqwgxmPM2DVzmvHufVQQiVq0PwOIhRuBkJE=;
        b=TCQ4oKSx2h35z3HXnqfYySrjNvdMuc/a9FIZIXm18lo9JdL3cV3xZb5ypxinwh0Y1R
         M9b9pFFM78FvWj1v05ipFHfOvZNIlV9o6WWOsHUg9vDhuigbYTkXirFMHS0bxYoBtuPO
         XRBeTOeKmXx4E4gDxUGkfuabR8qoJ7DZ90dLsb31Xi1RTncgx6YI2v6co0yjZkgFkT1G
         RTSy2JBvPo4zm83lw/ez4HvGOHCeB17hDq8N3ZOKe74bfBhgxzIiuoL/9lTm1AHJpSMH
         pHkYtC34d+qM0DDXrmO5dStKWVO1tKpVy605tBCgn0Xuq/QIe6Goa4Pbbqr1Uqzz6l29
         waug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4FuABV3XoqwgxmPM2DVzmvHufVQQiVq0PwOIhRuBkJE=;
        b=ia7/RUFvRRxNmN0eWJ1QFXAKuQmcvTmvgnaMaHafWmsST9VylVxzvhni0duPlseous
         34iO8s6++ehDj7rPF46h0i9mCVMFrJz8kzxJR+BzybS3w+9SBJfnZLuoftNO6yzcmgkp
         C2a+/HTJmJ6yc/lb6z8+ulj1QMgb4UjbM2YpVrwu/j/oqyVm4NU2XBVffSv8VDhs8evG
         zErxCWqInukk0ontdq0OYd2QGfgIikb0F1D29KdBPY+sdsos9WfLb/vVCTiVn1HK2PLB
         f3lydX//cL3qnkbTkN6w4D3xDk1GXTiZNAXH89TbUO16Jcp8PPu1mZJLKXzvnUej9pYk
         vYIg==
X-Gm-Message-State: AOAM530SNYHWh0VaAkZusyKkQbKvltHt9Cv0zrJcRShM/t5f4gNU9sbE
        zKAYf/BgEDfFVF36A4cl8NcioCrgBOW3LiuGnkYM3g==
X-Google-Smtp-Source: ABdhPJyS4DlfdDaRd80TupBPC+uE1c6GlFCyekTNS0D5lSfHTXGWJT77wKdvjjaQkWF/w74WHVm6w0Nq/T5hEN505FQ=
X-Received: by 2002:a17:90b:3e8c:: with SMTP id rj12mr5331171pjb.152.1640110220761;
 Tue, 21 Dec 2021 10:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20211002233447.1105-1-digetx@gmail.com> <CAG3jFysa8G_fuGDfSLze-ovft3=gc5PXLaPtwTkC2_e0itQYNw@mail.gmail.com>
 <c09bd552-767e-e783-3f9f-114b8cedb475@gmail.com> <a999b141-4b14-cdd0-f6fa-3d861c0f381f@gmail.com>
In-Reply-To: <a999b141-4b14-cdd0-f6fa-3d861c0f381f@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 21 Dec 2021 19:10:09 +0100
Message-ID: <CAG3jFytG110MN=AjnY3mz4pHtLYaTTXVWr9z_1=qpCo8hJoM2g@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Improvements for TC358768 DSI bridge driver
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dmitry,

On Sun, 19 Dec 2021 at 17:02, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 19.10.2021 23:37, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 19.10.2021 12:47, Robert Foss =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> Applied to drm-misc-next
> >>
> >> On Sun, 3 Oct 2021 at 01:35, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>>
> >>> This series adds couple improvements to the TC358768 DSI bridge drive=
r,
> >>> enabling Panasonic VVX10F004B00 DSI panel support. This panel is used=
 by
> >>> ASUS Transformer TF700T tablet, which is ready for upstream kernel an=
d
> >>> display panel support is the biggest missing part.
> >>>
> >>> Dmitry Osipenko (5):
> >>>   drm/bridge: tc358768: Enable reference clock
> >>>   drm/bridge: tc358768: Support pulse mode
> >>>   drm/bridge: tc358768: Calculate video start delay
> >>>   drm/bridge: tc358768: Disable non-continuous clock mode
> >>>   drm/bridge: tc358768: Correct BTACNTRL1 programming
> >>>
> >>>  drivers/gpu/drm/bridge/tc358768.c | 94 +++++++++++++++++++++++------=
--
> >>>  1 file changed, 71 insertions(+), 23 deletions(-)
> >>>
> >>> --
> >>> 2.32.0
> >>>
> >
> > Robert, thank you for taking care of these patches! Now nothing is
> > holding us from upstreaming the device-tree of the Transformer tablet.
> >
>
> Hello Robert,
>
> These patches spent 2 months in drm-misc-next, will they graduate into
> v5.17 or something special needs to be done for that?

They series has landed in linux-next, and will be in v5.17 if nothing
catastrophic happens.


Rob.
