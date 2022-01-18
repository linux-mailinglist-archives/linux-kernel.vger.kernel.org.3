Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47147492B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244495AbiARQdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244047AbiARQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:33:16 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDEBC06173F;
        Tue, 18 Jan 2022 08:33:14 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id D1D162000A;
        Tue, 18 Jan 2022 16:33:10 +0000 (UTC)
Date:   Tue, 18 Jan 2022 17:34:13 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-media <linux-media@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: dt-bindings: media: renesas,csi2: Update
 data-lanes property
Message-ID: <20220118163413.ge2b4g75yhfqvq3x@uno.localdomain>
References: <20220113103215.27080-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220117081110.bkwr3ttoexgr2wjt@uno.localdomain>
 <CA+V-a8t=f14QH=M8p8mufeJsqddwOn6XPqFma5TEbfQ7XdLBZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+V-a8t=f14QH=M8p8mufeJsqddwOn6XPqFma5TEbfQ7XdLBZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar

On Tue, Jan 18, 2022 at 09:11:42AM +0000, Lad, Prabhakar wrote:
> Hi Jacopo,
>
> Thank you for the review.
>
> On Mon, Jan 17, 2022 at 8:11 AM Jacopo Mondi <jacopo@jmondi.org> wrote:
> >
> > Hello Prabhakar,
> >
> > On Thu, Jan 13, 2022 at 10:32:14AM +0000, Lad Prabhakar wrote:
> > > CSI-2 (CSI4LNK0) on R-Car and RZ/G2 supports 4-lane mode which is already
> > > handled by rcar-csi2.c driver. This patch updates the data-lanes property
> > > to describe the same.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > >  .../devicetree/bindings/media/renesas,csi2.yaml          | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/renesas,csi2.yaml b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > > index e6a036721082..064a0a4c5737 100644
> > > --- a/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > > +++ b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > > @@ -67,7 +67,14 @@ properties:
> > >                  maxItems: 1
> > >
> > >                data-lanes:
> > > -                maxItems: 1
> > > +                items:
> > > +                  minItems: 1
> > > +                  maxItems: 4
> > > +                  items:
> > > +                    - const: 1
> > > +                    - const: 2
> > > +                    - const: 3
> > > +                    - const: 4
> >
> > Seeing "maxItems: 1" there confuses me too, as the property is an
> > array of data-lanes, but I'm afraid your change does not what you
> > intend as it would allow you to specify the number of data lanes as an
> > integer rather than as an array.
> >
> Agreed, what do you think of the below instead?
>
>             properties:
>               data-lanes:
>                 minItems: 1
>                 maxItems: 4
>                 items:
>                   maximum: 4
>

Sorry, I should have read your reply first :)
even better with your suggested uniqueItems

> The above should handle all the possible mix and match of the lanes.
>
> > I think it would probably be correct to set
> >
> >                 data-lanes: true
> >
> > (maybe maxItems: 1 is correct already)
> >
> > And restrict the number of valid combinations in the board DTS file
> > with a construct like:
> >
> >     data-lanes:
> >       oneOf:
> >         - items:
> >             - const: 1
> >             - const: 2
> >             - const: 3
> >             - const: 4
> >         - items:
> >             - const: 1
> >             - const: 2
> >
> I haven't come across dts files having such constraints is it allowed,
> could you point me to a example.

I see some

Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml-        properties:
Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml:          data-lanes:
Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml-            oneOf:
Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml-              - items:
Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml-                  - const: 1
Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml-                  - const: 2
Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml-                  - const: 3
Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml-                  - const: 4
Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml-              - items:
Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml-                  - const: 1
Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml-                  - const: 2
Documentation/devicetree/bindings/media/i2c/hynix,hi846.yaml-

Documentation/devicetree/bindings/media/i2c/imx258.yaml-        properties:
Documentation/devicetree/bindings/media/i2c/imx258.yaml:          data-lanes:
Documentation/devicetree/bindings/media/i2c/imx258.yaml-            oneOf:
Documentation/devicetree/bindings/media/i2c/imx258.yaml-              - items:
Documentation/devicetree/bindings/media/i2c/imx258.yaml-                  - const: 1
Documentation/devicetree/bindings/media/i2c/imx258.yaml-                  - const: 2
Documentation/devicetree/bindings/media/i2c/imx258.yaml-                  - const: 3
Documentation/devicetree/bindings/media/i2c/imx258.yaml-                  - const: 4
Documentation/devicetree/bindings/media/i2c/imx258.yaml-              - items:
Documentation/devicetree/bindings/media/i2c/imx258.yaml-                  - const: 1
Documentation/devicetree/bindings/media/i2c/imx258.yaml-                  - const: 2

Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml-        properties:
Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml:          data-lanes:
Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml-            anyOf:
Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml-              - items:
Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml-                  - const: 1
Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml-                  - const: 2
Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml-              - items:
Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml-                  - const: 1
Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml-                  - const: 2
Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml-                  - const: 3
Documentation/devicetree/bindings/media/i2c/sony,imx214.yaml-                  - const: 4

But yes, most bindings simply report

              data-lanes:
                minItems: 1
                maxItems: 4

Which allows all combinations, including repetitions, so they're
probably wrong.

Thanks
  j

>
> Cheers,
> Prabhakar
