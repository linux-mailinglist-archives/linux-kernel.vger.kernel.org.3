Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE3159D0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbiHWFqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbiHWFq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:46:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE7B5E66D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:46:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h24so15654654wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=S3hadl3hnB3ja/rLFfnUVQHzIaI1Bjt1VSUaqwXqPhw=;
        b=PkDs6E9tNKB8nTGQHP7GsuewTj8vV23xYK6woP4pI4q7HWlzbAtjhfdZ/tleOYQfvM
         0nSEcNlZfPn55lmg2+A2oT1rMntPZSA3T3aN1LM0tlcC/JHy9ltqgH1AwkRDmN8VBHB/
         NHfDFWYxMaILhxpy5zAxdXET6ss6ymDpRo8eoTRPNApSECXxJMKcYROA8qfDDaPqbgtK
         0bA3DU4B5D61uXpiwf2ZwNdxFtccLdtmF0HyohZX05u0npzSo0gfWfPrOgRdE9370sCc
         qP0utuGqJxL6uxsK9fdrxtN+FDUp/zlo/C8HcbGMwQQLEtUVShCa7AmWwJHP7qYizkZP
         uzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=S3hadl3hnB3ja/rLFfnUVQHzIaI1Bjt1VSUaqwXqPhw=;
        b=fvX4wO+HkJm+5KgysK3YYEY+vTfgRlefVv8gcz5tXoEkbuQYaCNxGcwZLG+4enaDyZ
         lNmDrGwTzaVbiVgrlts18vU9fFhCJG0kqAStkAzSL9YHelUpm0SRHEso2aKRxuddNeIy
         j1dj3fS6Ml4O6iGXxq9oY1FPcEQ+nyIk2Z4lATV/3A28dcqRSjWH81EdsGot+rn6MFVZ
         CawzA/74CSA5QRcgZjxDgH0JLMR3+q8j1uV2n6y9idunyVCeq6fTOanv45rGwQXqDdPu
         i283GQnHnjj7e9O4qCJ7CQJYaQLQUS6SgwXLDNRuiLXqoIa08Mckw16ik438FY2Gy+77
         WBGg==
X-Gm-Message-State: ACgBeo1r7/fYZhh01oaHKNSXhzK0Z83KVk45WkYWz7Bxy/U9BMtzQdLz
        5uoTC8KrMwQX9fBYSLgJidy1SoWBbEUZbfIn2NwVDIXLfs+/pByt
X-Google-Smtp-Source: AA6agR5pMCqhK5pkzZWg3wHSwh51C+FFrKVW4WSn7T110jcqvDraHFfd8D25wI1nho4Hd4/IVeYi2xD86Yb7G0qV+Q4=
X-Received: by 2002:a05:6000:1acb:b0:223:5de3:f8bf with SMTP id
 i11-20020a0560001acb00b002235de3f8bfmr12219378wry.691.1661233586555; Mon, 22
 Aug 2022 22:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220822103219.3985075-1-pgwipeout@gmail.com> <717fe4e0-ef9c-edef-80d1-caeeae1319b9@sholland.org>
In-Reply-To: <717fe4e0-ef9c-edef-80d1-caeeae1319b9@sholland.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 23 Aug 2022 07:46:16 +0200
Message-ID: <CAMdYzYqMN93tgGmgQyHFZVw7nuru_tc=D26rKEuzmXgApwiFOQ@mail.gmail.com>
Subject: Re: [PATCH] phy: rockchip-inno-usb2: Return zero after otg sync
To:     Samuel Holland <samuel@sholland.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
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

On Tue, Aug 23, 2022 at 5:41 AM Samuel Holland <samuel@sholland.org> wrote:
>
> On 8/22/22 5:32 AM, Peter Geis wrote:
> > The otg sync state patch reuses the ret variable, but fails to set it to
> > zero after use. This leads to a situation when the otg port is in
> > peripheral mode where the otg phy aborts halfway through setup. Fix this
> > by setting ret to zero after use.
> >
> > Fixes: 8dc60f8da22f ("phy: rockchip-inno-usb2: Sync initial otg state")
> >
> > Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> > Reported-by: Michael Riesch <michael.riesch@wolfvision.net>
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
> > Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> > ---
> >  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > index 0b1e9337ee8e..5fc7c374a6b4 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > @@ -1169,6 +1169,7 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
> >                       /* do initial sync of usb state */
> >                       ret = property_enabled(rphy->grf, &rport->port_cfg->utmi_id);
> >                       extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST, !ret);
> > +                     ret = 0;
>
> The bug was caused by the unexpected consequence of (mis|re)using the "ret"
> variable for a temporary value. Please introduce a new variable here, else the
> use of "ret" is even more confusing. This code also wipes out any error returned
> by devm_extcon_register_notifier().

I see your point here, I also need to skip this if
devm_extcon_register_notifier() fails as well. I'll spin up a v2.

Thanks for catching that!

>
> Regards,
> Samuel
