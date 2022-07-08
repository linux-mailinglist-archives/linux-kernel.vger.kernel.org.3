Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E2A56BA3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbiGHNDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbiGHNDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:03:38 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A64193C2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:03:37 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f2a4c51c45so29114591fac.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y17ryAIxO/dvkSkByT2s1yRZ7L0UbD2LWBRjA+w7j+Q=;
        b=jSYYobr311VNLy07Cjz8gDIG+oESJa6dRhMqxo30Bq3rvsN+6nGLs8Fkv+qliwrohi
         01HgAiRu2w5d3q5gNVkvvXR8UPo3/3IAXoQu4XW9HGDncf5FQTk7DxEbsgTxT7JTd3sy
         q3HESzfd/jnKqN20HiShjxbb/tRY+q1TsvYncabPkgUyi/EpHDFxnUQdGHucC93ci5rG
         R6KpUpqosBMJHsBCyH+lx5GxzJ9cGVnZVX0ziCKRvrM14Qb70/b4u5k8lZDakIPjZeZi
         JMHrhUCtK/PngH+0VLpXU/Of6n0kW2lwlmnHI/GcFSHU6qM7zd2JfoG0We01Lzsw6Da2
         x1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y17ryAIxO/dvkSkByT2s1yRZ7L0UbD2LWBRjA+w7j+Q=;
        b=ith/xODiwUf+ah7IrND2kA2BUMfsgTBHc8L6MOkezRPD4SbHYiHjjmOzqGFW0BGSdm
         4wzBhf35P69kRw8N0/j4CDdtxPz6YGnupKW58AfNDIXi7e/FfA3spbJoaIwYGVdZT335
         OfdXGgDURk7PO7t/c2awsSUE9Sg7PwKny9yAS/wdy9ogQMhZcsOKqfxHMUfbLYd8cArF
         X2x7tGudGyIQ38fVEdQN4A2DcVGw6ofCjVwvkoOwapW7pBqeeFruw+IQRusIHsv3W1nX
         zESV5XOxnC98bycYRZaEyIMp6qAqxWvYgV0d61ppu4zSeo/I0gsFmVOUXpFgrdr6K0uH
         v44g==
X-Gm-Message-State: AJIora/IbEBW7kxpnmY9bOVaH+8y6Rphrc01mgm8bwPE4wf5ZlsWbYaB
        +XWS3te60UNuZ0WbSrXUqJ9/MyfRXqzBTmXTK9z8TfF4frI=
X-Google-Smtp-Source: AGRyM1tS5kDwbKFQZtNj91Ot3KokuF+ATZYxfy3zfBjWanx+q0Lt7A+xPf2a+vz2v9/S5xbz8uHmruFmJ0OZs1QmNM0=
X-Received: by 2002:a05:6870:88a8:b0:101:6409:ae26 with SMTP id
 m40-20020a05687088a800b001016409ae26mr1811331oam.160.1657285416958; Fri, 08
 Jul 2022 06:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220708061434.38115-1-samuel@sholland.org> <trinity-e64eb9b8-7b25-4893-a1a2-ecbf9da3ef71-1657280834206@3c-app-gmx-bs34>
In-Reply-To: <trinity-e64eb9b8-7b25-4893-a1a2-ecbf9da3ef71-1657280834206@3c-app-gmx-bs34>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 8 Jul 2022 09:03:25 -0400
Message-ID: <CAMdYzYpN1B8fPzDhyqUKVMD_1bM4cYjk9_QHGLeCBis-8SUatg@mail.gmail.com>
Subject: Re: [PATCH] phy: rockchip-inno-usb2: Ignore OTG IRQs in host mode
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Samuel Holland <samuel@sholland.org>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
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

Good Morning,

I've confirmed this also resolves the issues with phy warnings on quartz64-=
a.
Tested-by: Peter Geis <pgwipeout@gmail.com>

Very Respectfully,
Peter Geis

On Fri, Jul 8, 2022 at 7:47 AM Frank Wunderlich <frank-w@public-files.de> w=
rote:
>
> Hi Samuel
>
> thx for the fix...with this it works again
>
> Tested-by: Frank Wunderlich <frank-w@public-files.de>
>
> regards Frank
>
>
> > Gesendet: Freitag, 08. Juli 2022 um 08:14 Uhr
> > Von: "Samuel Holland" <samuel@sholland.org>
> > An: "Frank Wunderlich" <frank-w@public-files.de>, "Vinod Koul" <vkoul@k=
ernel.org>
> > Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Peter Geis" <pg=
wipeout@gmail.com>, "Samuel Holland" <samuel@sholland.org>, "Heiko Stuebner=
" <heiko@sntech.de>, "Kishon Vijay Abraham I" <kishon@ti.com>, linux-arm-ke=
rnel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.inf=
radead.org, linux-rockchip@lists.infradead.org
> > Betreff: [PATCH] phy: rockchip-inno-usb2: Ignore OTG IRQs in host mode
> >
> > When the OTG port is fixed to host mode, the driver does not request it=
s
> > IRQs, nor does it enable those IRQs in hardware. Similarly, the driver
> > should ignore the OTG port IRQs when handling the shared interrupt.
> >
> > Otherwise, it would update the extcon based on an ID pin which may be i=
n
> > an undefined state, or try to queue a uninitialized work item.
> >
> > Fixes: 6a98df08ccd5 ("phy: rockchip-inno-usb2: Fix muxed interrupt supp=
ort")
> > Reported-by: Frank Wunderlich <frank-w@public-files.de>
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> >
> >  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/ph=
y/rockchip/phy-rockchip-inno-usb2.c
> > index 6711659f727c..26b841c49ec6 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > @@ -978,7 +978,9 @@ static irqreturn_t rockchip_usb2phy_irq(int irq, vo=
id *data)
> >
> >               switch (rport->port_id) {
> >               case USB2PHY_PORT_OTG:
> > -                     ret |=3D rockchip_usb2phy_otg_mux_irq(irq, rport)=
;
> > +                     if (rport->mode !=3D USB_DR_MODE_HOST &&
> > +                         rport->mode !=3D USB_DR_MODE_UNKNOWN)
> > +                             ret |=3D rockchip_usb2phy_otg_mux_irq(irq=
, rport);
> >                       break;
> >               case USB2PHY_PORT_HOST:
> >                       ret |=3D rockchip_usb2phy_linestate_irq(irq, rpor=
t);
> > --
> > 2.35.1
> >
> >
