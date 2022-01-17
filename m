Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF5B490597
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbiAQJ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:59:48 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43215 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbiAQJ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:59:42 -0500
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 26CF01C0010;
        Mon, 17 Jan 2022 09:59:37 +0000 (UTC)
Date:   Mon, 17 Jan 2022 11:00:40 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: media: renesas,csi2: Update
 data-lanes property
Message-ID: <20220117100040.wa3ple6meahebtni@uno.localdomain>
References: <20220113103215.27080-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220117081110.bkwr3ttoexgr2wjt@uno.localdomain>
 <YeU1kDee7L26QJ86@oden.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YeU1kDee7L26QJ86@oden.dyn.berto.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On Mon, Jan 17, 2022 at 10:23:28AM +0100, Niklas Söderlund wrote:
> Hello Jacopo,
>
> On 2022-01-17 09:11:10 +0100, Jacopo Mondi wrote:
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
>
> I don't think this is correct, what if data lanes 2 and 3 are used?
>

These were examples that allow you to accept <1 2> and <1 2 3 4> as
valid properties. If other combinations are accepted they can be
specified there, in your example, <2 3> with

             - items:
               - const: 2
               - const: 3

As lane re-reordering is quite unusual as a feature (afaik) there are
usually just an handful of supported combinations for 1, 2 and 4 data
lanes setups.

If full lane re-ordering is supported then it's enough to set
data-lanes: true and accepts all combinations.

Also, the reason why imho the property should go in the board DTS and
not in the SoC .dtsi is that not all the available data lanes of the
IP-core might be routed out on a specific board.

That's at least my understanding which I would be glad to be disproved
as specifying the valid combinations in each board dts is rather
un-convenient.

Thanks
   j

> >
> > Thanks
> >    j
> >
> > >
> > >              required:
> > >                - clock-lanes
> > > --
> > > 2.17.1
> > >
>
> --
> Kind Regards,
> Niklas Söderlund
