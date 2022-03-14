Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FB74D8F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245474AbiCNWGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiCNWGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:06:16 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8F112740;
        Mon, 14 Mar 2022 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bpBj1jLPuNXD2bHuGOl7hPinc2wD6kM0zd7V33MycNU=; b=RSyobZrklHqOZU4UMuimLrJIj3
        t/V9q7Bcww+Anrbeb6sQe5Ano87Y/KjVNON9OzlfNmgFb+bhCUAAt+bKTby0nhyY7LqvpFTwASEM3
        r/a1cjUYVp2mgNhdl8bMX6cY4Vx/Yo1ZSrnRVoVV6zTvbFZC1JGIbxA2x1B9HwtFLyaM=;
Received: from p200300ccff0ce9001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0c:e900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1nTso4-00043u-01; Mon, 14 Mar 2022 23:04:48 +0100
Date:   Mon, 14 Mar 2022 23:04:46 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alistair@alistair23.me,
        samuel@sholland.org, josua.mayer@jm0.eu,
        letux-kernel@openphoenux.org
Subject: Re: [RFC PATCH 1/6] dt-bindings: display: imx: Add EPDC
Message-ID: <20220314230446.5cc52121@aktux>
In-Reply-To: <YizzRKSDvHon83ks@latitude>
References: <20220206080016.796556-1-andreas@kemnade.info>
        <20220206080016.796556-2-andreas@kemnade.info>
        <YizzRKSDvHon83ks@latitude>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2022 20:23:48 +0100
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> Hello Andreas,
>=20
> Sorry for the delay, I finally got around to having a look at the
> patchset.
>=20
> Some comments from skimming the patches below, and in my other replies.
>=20
>=20
> On Sun, Feb 06, 2022 at 09:00:11AM +0100, Andreas Kemnade wrote:
> > Add a binding for the Electrophoretic Display Controller found at least
> > in the i.MX6.
> > The timing subnode is directly here to avoid having display parameters
> > spread all over the plate.
> >=20
> > Supplies are organized the same way as in the fbdev driver in the
> > NXP/Freescale kernel forks. The regulators used for that purpose,
> > like the TPS65185, the SY7636A and MAX17135 have typically a single bit=
 to
> > start a bunch of regulators of higher or negative voltage with a
> > well-defined timing. VCOM can be handled separately, but can also be
> > incorporated into that single bit.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  .../bindings/display/imx/fsl,mxc-epdc.yaml    | 159 ++++++++++++++++++
> >  1 file changed, 159 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,m=
xc-epdc.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc=
.yaml b/Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml
> > new file mode 100644
> > index 000000000000..7e0795cc3f70
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml
> > @@ -0,0 +1,159 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +--- =20
> [...]
> > +  - vscan-holdoff
> > +  - sdoed-width
> > +  - sdoed-delay
> > +  - sdoez-width
> > +  - sdoez-delay
> > +  - gdclk-hp-offs
> > +  - gdsp-offs
> > +  - gdoe-offs
> > +  - gdclk-offs
> > +  - num-ce =20
>=20
> These parameters should perhaps have sane defaults in the driver, and be
> optional in the DT.
>=20
First of all I think I should document them better (as said in an
earlier review mail)

I doubt there are sane defaults, in vendor kernels, there is typically a
definition of these parameters and a video mode per display.

>=20
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx6sl-clock.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    epdc: epdc@20f4000 { =20
> [...]
> > +
> > +        timing {
> > +                clock-frequency =3D <80000000>;
> > +                hactive =3D <1448>;
> > +                hback-porch =3D <16>;
> > +                hfront-porch =3D <102>;
> > +                hsync-len =3D <28>;
> > +                vactive =3D <1072>;
> > +                vback-porch =3D <4>;
> > +                vfront-porch =3D <4>;
> > +                vsync-len =3D <2>;
> > +        };
> > +    }; =20
>=20
> The way you did it here, the timing parameters are directly under the
> EPDC node in the DT, but I wonder if it would be better to have a
> separate node for the display panel, which can then provide the timing
> parameters either in the DT or in the panel driver (selected by compatible
> string of the panel).
>=20
IMHO it makes sense to store these timing parameters together with the
timing parameters from above. If that all somehow comes from a panel
driver, we need to design an interface for it. So for simplicity I
added the stuff just to the EPDC node.

Vendor kernel has this:
struct imx_epdc_fb_mode {
    struct fb_videomode *vmode;
    int vscan_holdoff;
    int sdoed_width;
    int sdoed_delay;
    int sdoez_width;
    int sdoez_delay;
    int gdclk_hp_offs;
    int gdsp_offs;
    int gdoe_offs;
    int gdclk_offs;
    int num_ce;
};

So things are basically combined here.

Regards,
Andreas
