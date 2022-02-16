Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723C84B835B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiBPIt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:49:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiBPIt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:49:56 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A52AA38D;
        Wed, 16 Feb 2022 00:49:44 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id f13so753321uab.10;
        Wed, 16 Feb 2022 00:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0bhXlnXqDizbIEA4ENk9MkVJXN84VO5oXnDq1fIauCo=;
        b=bYXdZ9MkxvdMCLFBrnPiK5Y8QTO8TsRMunFndlLnY9SWpHdKKIX6XUV8CKadjfg35i
         UyADFjrUv18JTx+ECOIV5b2tE6X9RHhG3mglf9DBxfnomaX4kHRkt0n23iDDTq47Msxi
         NtZ3JEoYbM18103KV/HSwZHacXaFO/XjTm4KFva+jqmII4fsC3KaGwfI26jGWQH5gwwP
         y3JDI+L9GOzzA2EPjm5PweQ/HPG+ttDcFlUn7CsHmLrwvIUFrFoew5LIDVlpGMv2WNjk
         1uykjiB1TnTkFmvCnjRL1KPOoaKriF5QfAbAwR2qC98GyjDMdu9/P5M7RXUafxDBNLv0
         gXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0bhXlnXqDizbIEA4ENk9MkVJXN84VO5oXnDq1fIauCo=;
        b=HRyb6gYDOP7Gz4ANFDoQBd4Q9F4AgI9VsUal9Hd8vfQzKXM+1YejdVWSSwd085pxxi
         Aq0j7ejO2og7ktlhI4kgEgrs5B4Th0B8GlY1jskkgoOMF2Xuy5D2hRKnnT/41c4obrsD
         Z+FITUOSEtEZUikxpX6bBxvh4G9IeCl9gi0Dasog/a6SROKcWT6QSzpaIQVJ6HexHwhX
         rgYK9fmk7QD/Jxa2CUd6uqXmIsEFRWxSGEqEl9SfXF85I+r5aDaK4Tp0mAmQuFUqFKCk
         Ps8ohaCaqlJuy3rMv38iiWuJXVv+ymMdK0lQGzMX4vh1ONmOzRZKaYrdVTbuYwR9t2WP
         zMCg==
X-Gm-Message-State: AOAM531Z6I2j6rrIMY/CbGNOGxtOzt5kHt4ZRi7vZuphRnuLzraetOMu
        Zca6PYAHonoPd8dkd61Sw2NIY2LRyonnj31A04PFTCqu3B8=
X-Google-Smtp-Source: ABdhPJy6dGxqPcK/iaOv24HvFiVDydA1y9izkmAc0VpVGcppsQSjOyjWvzqGS7+O+ee18urMVOcq//oe2Ci34i/ZrLA=
X-Received: by 2002:a9f:3f8c:0:b0:33d:c02:c938 with SMTP id
 k12-20020a9f3f8c000000b0033d0c02c938mr712157uaj.13.1645001383463; Wed, 16 Feb
 2022 00:49:43 -0800 (PST)
MIME-Version: 1.0
References: <1644949454-814-1-git-send-email-quic_c_sanm@quicinc.com>
 <1644949454-814-3-git-send-email-quic_c_sanm@quicinc.com> <CAKgpwJWEZ7275LihHqxg50cWNVNxUcGR8e7pM-V2bH=aodL7YA@mail.gmail.com>
 <20220216080028.GA13793@hu-pkondeti-hyd.qualcomm.com>
In-Reply-To: <20220216080028.GA13793@hu-pkondeti-hyd.qualcomm.com>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Wed, 16 Feb 2022 16:49:32 +0800
Message-ID: <CAKgpwJVwTDd40ZR3tKOgVpRTNs1OjE5ssMM+Lj-Ak0CHPSAWQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: dwc: host: add xhci_plat_priv quirk XHCI_SKIP_PHY_INIT
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>, Li Jun <jun.li@nxp.com>
Cc:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, quic_ppratap@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavan Kondeti <quic_pkondeti@quicinc.com> =E4=BA=8E2022=E5=B9=B42=E6=9C=881=
6=E6=97=A5=E5=91=A8=E4=B8=89 16:00=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Feb 16, 2022 at 03:16:40PM +0800, Jun Li wrote:
> > Sandeep Maheswaram <quic_c_sanm@quicinc.com> =E4=BA=8E2022=E5=B9=B42=E6=
=9C=8816=E6=97=A5=E5=91=A8=E4=B8=89 14:58=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > dwc3 manages PHY by own DRD driver, so skip the management by
> > > HCD core.
> > > During runtime suspend phy was not getting suspend because
> > > runtime_usage value is 2.
> > >
> > > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > ---
> > >  drivers/usb/dwc3/host.c | 15 +++++++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> > > index eda8719..4a035a8 100644
> > > --- a/drivers/usb/dwc3/host.c
> > > +++ b/drivers/usb/dwc3/host.c
> > > @@ -13,6 +13,14 @@
> > >  #include <linux/platform_device.h>
> > >
> > >  #include "core.h"
> > > +#include <linux/usb/hcd.h>
> > > +#include <linux/usb/xhci-plat.h>
> > > +#include <linux/usb/xhci-quirks.h>
> > > +
> > > +
> > > +static const struct xhci_plat_priv xhci_plat_dwc3_xhci =3D {
> > > +       .quirks =3D XHCI_SKIP_PHY_INIT,
> > > +};
> >
> > It's better to create this xhci_plat_priv by each dwc3 glue layer,
> > with that, we can use this priv to pass other flags and possibly
> > override APIs by each glue driver which may not apply to all dwc3
> > platforms.
> >
>
> Do you see a need for any glue driver to know about this xHC platform dat=
a?

Yes. I have some xhci quirks which are specifix to NXP iMX platforms.

> AFAICT, glue driver has no direction connection with the dwc3 core. All
> the required data is coming from dT on ARM based boards. Adding a private
> interface between dwc3 core and glue for passing xhci platform data seems
> to be overkill. If there is a pressing need, why not?

And looking at xhci_plat_priv members

-struct xhci_plat_priv {
-       const char *firmware_name;
-       unsigned long long quirks;
-       int (*plat_setup)(struct usb_hcd *);
-       void (*plat_start)(struct usb_hcd *);
-       int (*init_quirk)(struct usb_hcd *);
-       int (*suspend_quirk)(struct usb_hcd *);
-       int (*resume_quirk)(struct usb_hcd *);
-};

Are we going to share the same all those quirks and APIs
implementation across all dwc3 platforms?

Thanks
Li Jun
>
> Thanks,
> Pavan
