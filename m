Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08055AB830
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIBS3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIBS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:29:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C1811452
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:29:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h1so1700468wmd.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ru/sOMpY04FYeBztI8C2e/SBkJ3BPqiNet5T9iJERfg=;
        b=dCh61ZuMaf6p7k5dl/jPZPX6QhV/S1uPMNQ86Gu4lqEIpRPLzQzSiw8Bc2E7IOpzsq
         U5sFRNKK6cUwPjf3BYIMCOSg4LKoa/r1Q7buvOLSboCGyarp3+WzAJgz9GM0eClJYK/L
         336TuDTJLaMFnRTro/shcVjYh1mfJQcDWqJCT8oLtWCeX6ImjCKTP6X6VnVQiAqrfS8p
         eraBaC2B/zjhp1hQ9/zLMPLv/prUVTVQUMQt9V3gcC9NH35itfo3sspkYjUWN0M905Aq
         vAkDLUFv1k7fXlXzPnOCAh0SuTuHPpTLLjh4VQoZA/Uvi0fO41uAKAi490slwwgO1FlO
         49JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ru/sOMpY04FYeBztI8C2e/SBkJ3BPqiNet5T9iJERfg=;
        b=c+dRXPBSlrzHSOVOFUmPM6bSDkdTuOf7emQD6KIDq3bvNSiAyZVVfKmNrrwi6ibcJf
         ia05c6t+QyQebQx46b1fo0zyAGv6mBemP04DDQvSqcnVy6mOrZLXaUZeFsqmLi14CO/5
         Il0aHauC75i5rlSqig4RQeTncXqqSQadfmUTiC4Xn1ThzMmrhERMGLt8guwvwZZe86HS
         nJbs0FC8ZVhd+D3tX23Wm3TD2y6xnGN22vOPcKo0PAI1Tb/hscu1cjBHONpTXON4va5j
         vqVkhaOZKRqsrL2q1w4ZDP5Qg/Oz9A+dHJHRiY2S58+YURJAzvClKWgz4Hveb9rULYbQ
         wuFw==
X-Gm-Message-State: ACgBeo2Np4sDzFq9FPDvsQon4xb0PEg4j3O+RMfNx6r/18ejWbKCdinL
        CLrX2B20BusFF7E22Nnh7Y6eMRIImNArL3p9jDk=
X-Google-Smtp-Source: AA6agR5nnh+dSyoem/9Q5JklQjDjkcaPLSZgU85h1fyGIR+xfUgNS7odm+Z8mHAiW6Stc+pLtSUpqzOef6DAIzFSV10=
X-Received: by 2002:a05:600c:1e8d:b0:3a5:e37f:6fd2 with SMTP id
 be13-20020a05600c1e8d00b003a5e37f6fd2mr3771210wmb.33.1662143370997; Fri, 02
 Sep 2022 11:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220824122543.174730-1-pgwipeout@gmail.com> <YxI+4t3fecbIYC07@matsya>
In-Reply-To: <YxI+4t3fecbIYC07@matsya>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 2 Sep 2022 14:29:19 -0400
Message-ID: <CAMdYzYqKLKXm5b_GifOEq4COyd9CSWpWdwaeOxngwMcgw0gQWw@mail.gmail.com>
Subject: Re: [PATCH v3] phy: rockchip-inno-usb2: Return zero after otg sync
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Samuel Holland <samuel@sholland.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
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

On Fri, Sep 2, 2022 at 1:35 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 24-08-22, 08:25, Peter Geis wrote:
> > The otg sync state patch reuses the ret variable, but fails to set it to
> > zero after use. This leads to a situation when the otg port is in
> > peripheral mode where the otg phy aborts halfway through setup.  It also
> > fails to account for a failure to register the extcon notifier. Fix this
> > by using our own variable and skipping otg sync in case of failure.
> >
> > Fixes: 8dc60f8da22f ("phy: rockchip-inno-usb2: Sync initial otg state")
> >
>
> No blank here please
>
> > Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> > Reported-by: Michael Riesch <michael.riesch@wolfvision.net>
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
> > Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> > ---
> > Changelog:
> > v3
> > - add missing brackets around new goto
> > v2
> > - switch to using our own variable
> > - add missing goto to skip sync in case of registration failure
> > ---
> >  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > index 0b1e9337ee8e..27da5ba379c4 100644
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
> > @@ -1163,12 +1163,15 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
> >               ret = devm_extcon_register_notifier(rphy->dev, rphy->edev,
> >                                       EXTCON_USB_HOST, &rport->event_nb);
> >               if (ret)
> > +             {
>
> :-(
>
> this is _not_ linux kernel code style!
>
> Reminder: it always helps to run checkpatch

Ouch, yeah that's really embarrassing. Thank you for catching it.

>
> >                       dev_err(rphy->dev, "register USB HOST notifier failed\n");
> > +                     goto out;
> > +             }
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
> > --
> > 2.25.1
>
> --
> ~Vinod
