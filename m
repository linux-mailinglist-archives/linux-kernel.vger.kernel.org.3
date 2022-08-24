Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8584A59F746
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbiHXKR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiHXKRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:17:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B52672B5B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:17:52 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n7so20160821wrv.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2rEDI8nneWR8uBhC0k6la2EvHD4yLzs+a+6fUoYoKU4=;
        b=VFeU530PAmK3n65fcXn1z65tSUzwYLn85+ojxSycSOPVQcheykt616CE28AJr0U3SN
         WEwvG4O8Wn+wPOXom3oZdoxlCbYU0rvZSTXRgr8Xn9jVyIc4dbpJrVE9sn2c0xkg9yE4
         m72FqQyOrhyqyoY4JiFaZOhyOJH095QKXbX/jwHZzpMMGl23vDec+NOLToJ5lkCCTcbQ
         bxnb/saWP3f2H5q2mDOY6tovIJc4bFcZ/u4UvTf4DiCXiun4CiMT1fB5sEI1EJA/tHxQ
         ZONjdcHmDa3AnyGz3zLzKDdBmv85QfIdlr9xdYrPKcWJs4/KcjrejIuyx+1R33YoBCYm
         vAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2rEDI8nneWR8uBhC0k6la2EvHD4yLzs+a+6fUoYoKU4=;
        b=cLzxVggLnXVznImxFe35WfJUV94Bo9Gzrkc8IsGYhACKS5QouTkMayvjmPwd/8FSrn
         4+yG0XhuBNNflg2OR5bsKGjuejsoPWiItTuUh111I7XrjXEQXMJ/qlJo87V88lUdEP4c
         hk/jlsh1rbpAhsyv9V2QABhZTUDGofgNGI9sb/2wNU6+h2Nt3KBSrLnr+ZjuvCwkealA
         mij7d+1e6gqN3UDaI1oE7vSgBJqQplfxLfjmU+NW2IvNI9myR6DKMzBKNRqKIirNwApF
         2jIbGE4xf7kZ4ZZB5ralJqWzGJj2leQN+4QUn158z3fOb/+lQSh8q34xzc7qXXPEbj0i
         rZIg==
X-Gm-Message-State: ACgBeo0L9uXotMhfs0biz5iaFrL+xphV0EBpOPIs8BJ1UGhtmezKLaBo
        tEPKU/x3EFOALYAjgYSoiu1hpmJRWaQCjI4HRm0vXhmeHB8=
X-Google-Smtp-Source: AA6agR7sQ+Joxq+aq8uIl+CNG/GIrqr+nGL3cJhEBxurQU45bDdJBx8cY5FhIPu5261Cv1lHhcYULOg7B0jFQMr9xIA=
X-Received: by 2002:a5d:45c1:0:b0:225:2803:e791 with SMTP id
 b1-20020a5d45c1000000b002252803e791mr15643183wrs.539.1661336270818; Wed, 24
 Aug 2022 03:17:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220823144728.47068-1-pgwipeout@gmail.com> <86198a8a-96d4-5856-bc2d-44bf352c82fe@wolfvision.net>
In-Reply-To: <86198a8a-96d4-5856-bc2d-44bf352c82fe@wolfvision.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 24 Aug 2022 12:17:39 +0200
Message-ID: <CAMdYzYopzOJ2RtWtYgP3G4ESVMFhCqU3fOQq_kCc1g51ZDZ=bA@mail.gmail.com>
Subject: Re: [PATCH v2] phy: rockchip-inno-usb2: Return zero after otg sync
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 7:33 AM Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Peter,
>
> On 8/23/22 16:47, Peter Geis wrote:
> > The otg sync state patch reuses the ret variable, but fails to set it to
> > zero after use. This leads to a situation when the otg port is in
> > peripheral mode where the otg phy aborts halfway through setup.  It also
> > fails to account for a failure to register the extcon notifier. Fix this
> > by using our own variable and skipping otg sync in case of failure.
> >
> > Fixes: 8dc60f8da22f ("phy: rockchip-inno-usb2: Sync initial otg state")
> >
> > Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> > Reported-by: Michael Riesch <michael.riesch@wolfvision.net>
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
> > Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> > ---
> >  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > index 0b1e9337ee8e..d579a22c61df 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > @@ -1124,7 +1124,7 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
> >                                         struct rockchip_usb2phy_port *rport,
> >                                         struct device_node *child_np)
> >  {
> > -     int ret;
> > +     int ret, id;
> >
> >       rport->port_id = USB2PHY_PORT_OTG;
> >       rport->port_cfg = &rphy->phy_cfg->port_cfgs[USB2PHY_PORT_OTG];
> > @@ -1164,11 +1164,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
> >                                       EXTCON_USB_HOST, &rport->event_nb);
> >               if (ret)
>
> This needs braces, right?
>
>         if (ret) {
> >                       dev_err(rphy->dev, "register USB HOST notifier failed\n");
> > +                     goto out;
>
>         }
>
> With the braces the patch works as expected.

Yup, thanks for that. I hate working without access to my hardware.

>
> Thanks and best regards,
> Michael
>
> >
> >               if (!of_property_read_bool(rphy->dev->of_node, "extcon")) {
> >                       /* do initial sync of usb state */
> > -                     ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
> > -                     extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
> > +                     id = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
> > +                     extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !id);
> >               }
> >       }
> >
