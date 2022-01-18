Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFDE492B17
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiARQV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiARQVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:21:25 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64179C061574;
        Tue, 18 Jan 2022 08:21:24 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 8D7021BF206;
        Tue, 18 Jan 2022 16:21:19 +0000 (UTC)
Date:   Tue, 18 Jan 2022 17:22:21 +0100
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
Message-ID: <20220118162221.yfwen6ppx7gcjzvw@uno.localdomain>
References: <20220113103215.27080-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220117081110.bkwr3ttoexgr2wjt@uno.localdomain>
 <YeU1kDee7L26QJ86@oden.dyn.berto.se>
 <20220117100040.wa3ple6meahebtni@uno.localdomain>
 <YeaXZO+3C/fUM7ex@oden.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YeaXZO+3C/fUM7ex@oden.dyn.berto.se>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On Tue, Jan 18, 2022 at 11:33:08AM +0100, Niklas Söderlund wrote:
> Hi Jacopo,
>
> Thanks for your feedback.
>
> On 2022-01-17 11:00:40 +0100, Jacopo Mondi wrote:
> > Hi Niklas,
> >
> > On Mon, Jan 17, 2022 at 10:23:28AM +0100, Niklas Söderlund wrote:
> > > Hello Jacopo,
> > >
> > > On 2022-01-17 09:11:10 +0100, Jacopo Mondi wrote:
> > > > Hello Prabhakar,
> > > >
> > > > On Thu, Jan 13, 2022 at 10:32:14AM +0000, Lad Prabhakar wrote:
> > > > > CSI-2 (CSI4LNK0) on R-Car and RZ/G2 supports 4-lane mode which is already
> > > > > handled by rcar-csi2.c driver. This patch updates the data-lanes property
> > > > > to describe the same.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > ---
> > > > >  .../devicetree/bindings/media/renesas,csi2.yaml          | 9 ++++++++-
> > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/media/renesas,csi2.yaml b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > > > > index e6a036721082..064a0a4c5737 100644
> > > > > --- a/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > > > > +++ b/Documentation/devicetree/bindings/media/renesas,csi2.yaml
> > > > > @@ -67,7 +67,14 @@ properties:
> > > > >                  maxItems: 1
> > > > >
> > > > >                data-lanes:
> > > > > -                maxItems: 1
> > > > > +                items:
> > > > > +                  minItems: 1
> > > > > +                  maxItems: 4
> > > > > +                  items:
> > > > > +                    - const: 1
> > > > > +                    - const: 2
> > > > > +                    - const: 3
> > > > > +                    - const: 4
> > > >
> > > > Seeing "maxItems: 1" there confuses me too, as the property is an
> > > > array of data-lanes, but I'm afraid your change does not what you
> > > > intend as it would allow you to specify the number of data lanes as an
> > > > integer rather than as an array.
> > > >
> > > > I think it would probably be correct to set
> > > >
> > > >                 data-lanes: true
> > > >
> > > > (maybe maxItems: 1 is correct already)
> > > >
> > > > And restrict the number of valid combinations in the board DTS file
> > > > with a construct like:
> > > >
> > > >     data-lanes:
> > > >       oneOf:
> > > >         - items:
> > > >             - const: 1
> > > >             - const: 2
> > > >             - const: 3
> > > >             - const: 4
> > > >         - items:
> > > >             - const: 1
> > > >             - const: 2
> > >
> > > I don't think this is correct, what if data lanes 2 and 3 are used?
> > >
> >
> > These were examples that allow you to accept <1 2> and <1 2 3 4> as
> > valid properties. If other combinations are accepted they can be
> > specified there, in your example, <2 3> with
> >
> >              - items:
> >                - const: 2
> >                - const: 3
> >
> > As lane re-reordering is quite unusual as a feature (afaik) there are
> > usually just an handful of supported combinations for 1, 2 and 4 data
> > lanes setups.
>
> R-Car CSI-2 hardware and driver supports full lane swapping, see the
> LSWAP register and usage of struct rcar_csi2.lane_swap.

Uh, I missed that. So indeed restricting the possible combinations in
the .dts file is a no-go :0

>
> I think it's a good idea to extend the binding description to limit the
> data-lanes property to an array of max 4 items where each value use is
> ether a 1, 2, 3 or 4. But it must allow for any combination of the
> values.
>

Agreed then.

Looking at the definition in video-interfaces.txt
  data-lanes:
    $ref: /schemas/types.yaml#/definitions/uint32-array
    minItems: 1
    maxItems: 8
    items:
      # Assume up to 9 physical lane indices
      maximum: 8

Should the R-Car CSI-2 bindings report (validated with
dt_binding_check)

      data-lanes:
        maxItems: 4
        items:
          maximum: 4

Thanks
   j

> >
> > If full lane re-ordering is supported then it's enough to set
> > data-lanes: true and accepts all combinations.
> >
> > Also, the reason why imho the property should go in the board DTS and
> > not in the SoC .dtsi is that not all the available data lanes of the
> > IP-core might be routed out on a specific board.
> >
> > That's at least my understanding which I would be glad to be disproved
> > as specifying the valid combinations in each board dts is rather
> > un-convenient.
> >
> > Thanks
> >    j
> >
> > > >
> > > > Thanks
> > > >    j
> > > >
> > > > >
> > > > >              required:
> > > > >                - clock-lanes
> > > > > --
> > > > > 2.17.1
> > > > >
> > >
> > > --
> > > Kind Regards,
> > > Niklas Söderlund
>
> --
> Kind Regards,
> Niklas Söderlund
