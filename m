Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1250D5310FB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbiEWNUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiEWNU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:20:29 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FF12CE3B
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:20:27 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2fee9fe48c2so147901407b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IEQmaNNUUGULv1/BZVbeKyFXlK9ef3Jq4e2jfX8ne/8=;
        b=ITSEKXkNy+WkGjl07bzn1gW5tL8hFVuZo8CtHyHMxj15PrnXlzwJblUdMJq6Kw2A7I
         dWxzl45wH+L3Yc+lAztbclYUd1sx65t9cGSABKZ224wmI+GWKh1WBmD2h23j+jr9lwNW
         FreG9cvmggglYolcLKnAUHGgdx1VRBaoHb6g9WHO+X4ql5N7l380/Zt5bwHK4T/mhGNT
         i4WXXUQlxOMDSanxAjHHeBJxssoK3aCEYx0BniRLdps+Xbi1h/3KjXUEBjBCfuRIJx3H
         MwPbhYulG2vMVrmUKPD/U/uXHK/B00Aau3v6V6FkteTXR4pT94cVc1dvUqFYUC7YqN7j
         yIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IEQmaNNUUGULv1/BZVbeKyFXlK9ef3Jq4e2jfX8ne/8=;
        b=NM4EJMzGc5zpeqJyq7qeandQIe3X/bh/cNlD/me7Wsvkc1jBo73Kpp9Uh28zHOKri8
         WQzuoHzjZtdk/McAGgKhw916PrP1I6zjFhTx13pD46T/JA83GgNabyCaINbRmv/wGaAW
         UCjKmP+Kl/ayI5KhH8aSpR3nU2//yRiUmptqMDdwZUEYKjACJn/J0TPkyXANU61JhWDx
         cwTs1caBi/jv9v/14RGvUE+Or0YMQBwzIDTrSI/CNhho88rw6Nlkq0lpaw6ZyELV4akR
         ypN4w/aPiLJ0G6zVfwAsK9n0o7GsD7xGnrSVKnNmB+CYB3u4UqX9IHCV9ygquyXMlDpy
         fDGw==
X-Gm-Message-State: AOAM531Y+bRs5BeYZ+b7a4rjGBPVRS6OWGPBflbWrzPDCt5sYhd5BpEw
        TGTRqKM1xWv08jWOtp7uGCoGcBLV1phZZjdE2L4=
X-Google-Smtp-Source: ABdhPJxzgVyBKiSG8eHjW62fuIdgWjXdW4+EOTHt2zpp1s5dpUfHDL0SFozE6xgD8N5bHMsrNr14bsQIN1FOmM0XWG0=
X-Received: by 2002:a81:d4a:0:b0:2ff:1edb:7492 with SMTP id
 71-20020a810d4a000000b002ff1edb7492mr22660737ywn.58.1653312026778; Mon, 23
 May 2022 06:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220523130144.444225-1-net147@gmail.com> <868d010c-9fca-3fac-7657-faaa2f271c14@denx.de>
In-Reply-To: <868d010c-9fca-3fac-7657-faaa2f271c14@denx.de>
From:   Jonathan Liu <net147@gmail.com>
Date:   Mon, 23 May 2022 23:20:15 +1000
Message-ID: <CANwerB30qwH4pe1wMqAvRgi6gAntZX=AqAh67dEvg4+D1jcnfQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm: bridge: icn6211: Adjust clock phase using SYS_CTRL_1
To:     Marek Vasut <marex@denx.de>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Mon, 23 May 2022 at 23:15, Marek Vasut <marex@denx.de> wrote:
>
> On 5/23/22 15:01, Jonathan Liu wrote:
> > The code from [1] sets SYS_CTRL_1 to different values depending on the
> > desired clock phase (0, 1/4, 1/2 or 3/4). A clock phase of 0 aligns the
> > positive edge of the clock with the pixel data while other values delay
> > the clock by a fraction of the clock period. A clock phase of 1/2 aligns
> > the negative edge of the clock with the pixel data.
> >
> > The driver currently hard codes SYS_CTRL_1 to 0x88 which corresponds to
> > aligning the positive edge of the clock with the pixel data. This won't
> > work correctly for panels that require aligning the negative edge of the
> > clock with the pixel data.
> >
> > Adjust the clock phase to 0 if DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE is
> > present in bus_flags, otherwise adjust the clock phase to 1/2 as
> > appropriate for DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE.
> >
> > [1] https://github.com/tdjastrzebski/ICN6211-Configurator
> >
> > Signed-off-by: Jonathan Liu <net147@gmail.com>
> > ---
> > V2: Use GENMASK and FIELD_PREP macros
> > ---
> >   drivers/gpu/drm/bridge/chipone-icn6211.c | 18 ++++++++++++++++--
> >   1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
> > index 47dea657a752..f1538fb5f8a9 100644
> > --- a/drivers/gpu/drm/bridge/chipone-icn6211.c
> > +++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
> > @@ -9,6 +9,8 @@
> >   #include <drm/drm_print.h>
> >   #include <drm/drm_mipi_dsi.h>
> >
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> >   #include <linux/delay.h>
> >   #include <linux/gpio/consumer.h>
> >   #include <linux/i2c.h>
> > @@ -26,6 +28,11 @@
> >   #define PD_CTRL(n)          (0x0a + ((n) & 0x3)) /* 0..3 */
> >   #define RST_CTRL(n)         (0x0e + ((n) & 0x1)) /* 0..1 */
> >   #define SYS_CTRL(n)         (0x10 + ((n) & 0x7)) /* 0..4 */
> > +#define SYS_CTRL_1_CLK_PHASE_MSK     GENMASK(5, 4)
>
> This should be GENMASK(7, 6) , no ?

Clock phase 0 = 0b_1000_1000 = 0x88
Clock phase 1/4 = 0b_1001_1000 = 0x98
Clock phase 1/2 = 0b_1010_1000 = 0xA8
Clock phase 3/4 = 0b_1011_1000 = 0xB8

The clock phase bits are 5:4 not 7:6. The upper 2 bits and lower 4
bits are unknown.

Regards,
Jonathan
