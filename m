Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AB251D424
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390405AbiEFJWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbiEFJWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:22:24 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DD563502;
        Fri,  6 May 2022 02:18:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8DAA31F4608C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651828719;
        bh=LagxlbknCNKZ/XfP0so1ZIDtnMrlAsXXeHWaGvHTB4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cM39Y7h+YdmaL5+yQdLEp+AHGdUEQriZx4EHdV2GwT//rXc7oQCQL3lcs+g8cdL39
         hK882V/9z4a67vzdMiSeYx9uDsMCiTQgG409tJAEhWWFMJw9NhB3noO08myQXsJtsy
         BsYPT5MNWPG0R7vjPwUDn/cPhZiytcZw39GZaoZkJsaY7RjKXjvHNh39B2G1ThifMv
         Kw8Ud/gBiaJnCjHR4v0TOurkPw8ICP6lAIoGV8iA3esDMgEdUslAcabn1vupUfC7ow
         TQzEjuF7haew1hme03M4bAqfbqajucOj6mCPqWMkCsz5E/PJKS6nhRybyDKxwe9omI
         H64n/RkSM7ELA==
Received: by mercury (Postfix, from userid 1000)
        id 0DAAE1060437; Fri,  6 May 2022 11:18:37 +0200 (CEST)
Date:   Fri, 6 May 2022 11:18:37 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>, kernel@collabora.com
Subject: Re: [PATCHv2 09/21] mmc: sdhci-of-dwcmshc: add reset call back for
 rockchip Socs
Message-ID: <20220506091837.bbwupigb4f3hwgp4@mercury.elektranox.org>
References: <20220504213251.264819-1-sebastian.reichel@collabora.com>
 <20220504213251.264819-10-sebastian.reichel@collabora.com>
 <CAPDyKFqLn4LfPRbhoWw_9BF26Lgmzq_1j=RB31NDGn9YvMnB5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xt2hfq4oogyrqves"
Content-Disposition: inline
In-Reply-To: <CAPDyKFqLn4LfPRbhoWw_9BF26Lgmzq_1j=RB31NDGn9YvMnB5w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xt2hfq4oogyrqves
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 06, 2022 at 10:52:42AM +0200, Ulf Hansson wrote:
> On Wed, 4 May 2022 at 23:33, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > From: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> >
> > The reset function build in the SDHCI will not reset the logic
> > circuit related to the tuning function, which may cause data
> > reading errors. Resetting the complete SDHCI controller through
> > the reset controller fixes the issue.
> >
> > Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> > [rebase, use optional variant of reset getter]
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> I think this needs a corresponding update of the DT docs. Otherwise
> this looks good to me.

I do have 'resets' and 'reset-names' properties in the rk3588s.dtsi
for the sdhci interface and 'make dtbs_check' did not complain about
anything but missing 'arm,sdei-1.0' compatible for the rk3588 EVB
(sdei binding has not yet been converted to yaml). Thus I assume the
resets property is inferred from somewhere?

-- Sebastian

>=20
> Kind regards
> Uffe
>=20
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdh=
ci-of-dwcmshc.c
> > index bac874ab0b33..3a1b5ba36405 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> > +#include <linux/reset.h>
> >  #include <linux/sizes.h>
> >
> >  #include "sdhci-pltfm.h"
> > @@ -63,6 +64,7 @@
> >  struct rk3568_priv {
> >         /* Rockchip specified optional clocks */
> >         struct clk_bulk_data rockchip_clks[RK3568_MAX_CLKS];
> > +       struct reset_control *reset;
> >         u8 txclk_tapnum;
> >  };
> >
> > @@ -255,6 +257,21 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_=
host *host, unsigned int clock
> >         sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
> >  }
> >
> > +static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +       struct dwcmshc_priv *dwc_priv =3D sdhci_pltfm_priv(pltfm_host);
> > +       struct rk35xx_priv *priv =3D dwc_priv->priv;
> > +
> > +       if (mask & SDHCI_RESET_ALL && priv->reset) {
> > +               reset_control_assert(priv->reset);
> > +               udelay(1);
> > +               reset_control_deassert(priv->reset);
> > +       }
> > +
> > +       sdhci_reset(host, mask);
> > +}
> > +
> >  static const struct sdhci_ops sdhci_dwcmshc_ops =3D {
> >         .set_clock              =3D sdhci_set_clock,
> >         .set_bus_width          =3D sdhci_set_bus_width,
> > @@ -269,7 +286,7 @@ static const struct sdhci_ops sdhci_dwcmshc_rk3568_=
ops =3D {
> >         .set_bus_width          =3D sdhci_set_bus_width,
> >         .set_uhs_signaling      =3D dwcmshc_set_uhs_signaling,
> >         .get_max_clock          =3D sdhci_pltfm_clk_get_max_clock,
> > -       .reset                  =3D sdhci_reset,
> > +       .reset                  =3D rk35xx_sdhci_reset,
> >         .adma_write_desc        =3D dwcmshc_adma_write_desc,
> >  };
> >
> > @@ -292,6 +309,13 @@ static int dwcmshc_rk3568_init(struct sdhci_host *=
host, struct dwcmshc_priv *dwc
> >         int err;
> >         struct rk3568_priv *priv =3D dwc_priv->priv;
> >
> > +       priv->reset =3D devm_reset_control_array_get_optional_exclusive=
(mmc_dev(host->mmc));
> > +       if (IS_ERR(priv->reset)) {
> > +               err =3D PTR_ERR(priv->reset);
> > +               dev_err(mmc_dev(host->mmc), "failed to get reset contro=
l %d\n", err);
> > +               return err;
> > +       }
> > +
> >         priv->rockchip_clks[0].id =3D "axi";
> >         priv->rockchip_clks[1].id =3D "block";
> >         priv->rockchip_clks[2].id =3D "timer";
> > --
> > 2.35.1
> >

--xt2hfq4oogyrqves
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJ059oACgkQ2O7X88g7
+pp5Cw/9G072+IU/K2eJWP6MsQoWNwQMA5mqxId7SEACncdb+5ywvkilvq4UOtHM
s2MHQxKpMxWKQFQEYFXh48Dn6OeVElkrO7kIGRSR0M8KuXXKQ4eQm0Q5a0jbryFl
YqwRShmGpd4urXNhsCRjRjL/u/jTvhYKIzz2AiwFKgiHTZFB6fifmy67KIzAe8lx
F8v57BW994hmYpABPnybuvMk1VGOJqw9xXrC/mTiGd1HyDBjot1KrIVvWpT9Q3ZL
nwTP3EzJGIsrCQi9/YOuPCifjxJI2CppJZhy5Hd3aG8H9cZog9yEUalsd7x2sVih
/eeVopGR+fhM/qwVV4Swya7QL/4/0ZjXCGP5HApLqzewQc6UGkAHkcZTfJ+78Yfc
upAIXzL4CSJItDkZ2IT1O4hgwEW+933ol4z7gOA3yhvGQ7drLtnrXt65qTrw5k5P
xt1ouOL76Ru8D9Xm8fMBzcHXOz+9xwLgtDnHHBzIr535biqqhTtRlu6CTbDxEGEn
UZxNxg2punmcQ82ODHw0cvmGmiCkqPPUYEFxS/5a1P4hyUZE6PSXve+V6Hp21mNL
jC1TXbbjVeroh11HGuz9yqC/wMvV5U3+951r79DODpIS6rXMIFzVFtTHyHs1kUSw
WtfO28lxaTfaq7jwpyAvxAs1mIJl7POoaXODSCna+T3lf21nDaM=
=UBWn
-----END PGP SIGNATURE-----

--xt2hfq4oogyrqves--
