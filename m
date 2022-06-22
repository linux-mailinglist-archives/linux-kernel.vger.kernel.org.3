Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460C2554900
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353428AbiFVIb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352151AbiFVIbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:31:53 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D428F01
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:31:51 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id l11so28897824ybu.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFrveWQWOlqWcE+PwPZMC1GnolqDyvG7Ts1DbfGLvCQ=;
        b=qMZCgEKp956uUcAUTe+B8J619t80BEuZ4z2ufxolLgnN0UpgjefaBLUZGLJ7MkQz+h
         lZmtXys0aHG6vlihf1FYI4hX92qR1UVsa5kY7j05PkODaMym/k7HXP4MgUcM87+IwLKq
         2BE+Vh+b6iIH6zWlQrdoli+7Pzc9dA25AYExTbtVZLPLDnmf0LMlCemZu38bJCLOeh2W
         fOJfhrIap5ILiYtfWBHSHZ6NY0Fw/eQQTIUOy4fqOJkeqjvWnryd9yxqxsXZ4yHU87vu
         uLDMAXGBNIHyETi/QArYYxjDj2jR49Pv/w9dCjoomBmaqabbZl9v76N3jHQd0Db1bTul
         ZWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFrveWQWOlqWcE+PwPZMC1GnolqDyvG7Ts1DbfGLvCQ=;
        b=ykZzHlBgiVYJCZnu7zuDzawK4qe0w7eo3W8YkYNB6ZZMtTtbt/lq8958nNefTSNQbQ
         hVpPz04An4KQMvXpT6BHc0c+YhQhDhFOn2XegQ3zpnMNkvh/yphDGTc/ABzwR2XKuP4z
         S+Sd20bUzBxinPL5oHpIWbPsrYsjiKGKNq1k0nZbKeZ1rmfxvj6BdaS4gMTqfoMLejhi
         yNeZqp6Vpnq1UHeABS57WhlDKu0mIBBRh6EpQ5iRZk2ed314DL5DzLpfS5sQDN1SWPlF
         kqw0qVgssX1pR/FVdI13gETPsgwwLHToVF9PvEMm8Ou4RARyDn/ccZhK6ZNEE2FmaCED
         3YEA==
X-Gm-Message-State: AJIora96U27soMaKmQIhiqrBo0YNCiyBm2kfuSC2QngHyAzkDjuXfk+f
        G6p9aVhBL7tabMtlUnXOxTA09HWNnRRxIG3h9B+ZGNGl
X-Google-Smtp-Source: AGRyM1s6E87UN9fAajyCnVuoFZYmpttt79hpuA32cQUOGZs0yCkUCL5v86qQ56q2D3KhgDJIaUGbrR9kQCZ2Zs9mAmE=
X-Received: by 2002:a25:c60e:0:b0:668:b55e:4a2a with SMTP id
 k14-20020a25c60e000000b00668b55e4a2amr2634974ybf.372.1655886710409; Wed, 22
 Jun 2022 01:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220622003140.30365-1-pgwipeout@gmail.com> <f252c182-e306-174e-dd32-51c9a406d3f7@sholland.org>
In-Reply-To: <f252c182-e306-174e-dd32-51c9a406d3f7@sholland.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 22 Jun 2022 04:31:39 -0400
Message-ID: <CAMdYzYqUsr+orVtSbD023=GAyNLg4VdP9Wcrg6gON+Ut9FdzZA@mail.gmail.com>
Subject: Re: [PATCH] phy: rockchip-inno-usb2: Sync initial otg state
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
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

On Wed, Jun 22, 2022 at 1:16 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 6/21/22 7:31 PM, Peter Geis wrote:
> > The initial otg state for the phy defaults to device mode. The actual
> > state isn't detected until an ID IRQ fires. Fix this by syncing the ID
> > state during initialization.
> >
> > Fixes: 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
>
> One comment below. Either way it fixes a bug, so:
>
> Reviewed-by: Samuel Holland <samuel@sholland.org>

Thanks!

>
> > ---
> >  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > index 6711659f727c..6e44069617df 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > @@ -1162,6 +1162,12 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
> >                                       EXTCON_USB_HOST, &rport->event_nb);
> >               if (ret)
> >                       dev_err(rphy->dev, "register USB HOST notifier failed\n");
> > +
> > +             if (!of_property_read_bool(rphy->dev->of_node, "extcon")) {
>
> Currently the IRQ handler does not care who created the extcon. We should at
> least be consistent between here and there.

We care in this instance because if there is an external extcon it is
responsible for setting the initial state. Our ID pin may or may not
be used in this case and if it isn't we would overwrite the initial
state with an invalid one.

>
> Regards,
> Samuel
>
> > +                     /* do initial sync of usb state */
> > +                     ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
> > +                     extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
> > +             }
> >       }
> >
> >  out:
> >
>
