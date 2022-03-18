Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191884DE213
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 21:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbiCRT75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 15:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240452AbiCRT7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 15:59:51 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D832818CD30;
        Fri, 18 Mar 2022 12:58:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id E55F4DF9DE;
        Fri, 18 Mar 2022 12:58:29 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id udOeLCim9yMm; Fri, 18 Mar 2022 12:58:29 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
To:     Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] power: supply: max17042_battery: use ModelCfg refresh on max17055
Date:   Fri, 18 Mar 2022 20:58:24 +0100
Message-ID: <7080597.aeNJFYEL58@pliszka>
In-Reply-To: <facf5551-bfc7-aeb4-daed-5bfcb8a36475@kernel.org>
References: <20220318001048.20922-1-sebastian.krzyszkowiak@puri.sm> <20220318001048.20922-3-sebastian.krzyszkowiak@puri.sm> <facf5551-bfc7-aeb4-daed-5bfcb8a36475@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7086655.44csPzL39Z"; micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7086655.44csPzL39Z
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Date: Fri, 18 Mar 2022 20:58:24 +0100
Message-ID: <7080597.aeNJFYEL58@pliszka>
In-Reply-To: <facf5551-bfc7-aeb4-daed-5bfcb8a36475@kernel.org>

On pi=C4=85tek, 18 marca 2022 09:22:16 CET Krzysztof Kozlowski wrote:
> On 18/03/2022 01:10, Sebastian Krzyszkowiak wrote:
> > Unlike other models, max17055 doesn't require cell characterization
> > data and operates on smaller amount of input variables (DesignCap,
> > VEmpty, IChgTerm and ModelCfg). Input data can already be filled in
> > by max17042_override_por_values, however model refresh bit has to be
> > set after adjusting input variables in order to make them apply.
> >=20
> > Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
> > ---
> >=20
> >  drivers/power/supply/max17042_battery.c | 73 +++++++++++++++----------
> >  include/linux/power/max17042_battery.h  |  3 +
> >  2 files changed, 48 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/max17042_battery.c
> > b/drivers/power/supply/max17042_battery.c index
> > c019d6c52363..c39250349a1d 100644
> > --- a/drivers/power/supply/max17042_battery.c
> > +++ b/drivers/power/supply/max17042_battery.c
> > @@ -806,6 +806,13 @@ static inline void
> > max17042_override_por_values(struct max17042_chip *chip)>=20
> >  	    (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055)) {
> >  	=09
> >  		max17042_override_por(map, MAX17047_V_empty, config-
>vempty);
> >  =09
> >  	}
> >=20
> > +
> > +	if (chip->chip_type =3D=3D MAXIM_DEVICE_TYPE_MAX17055) {
> > +		max17042_override_por(map, MAX17055_ModelCfg, config-
>model_cfg);
> > +		// VChg is 1 by default, so allow it to be set to 0
>=20
> Consistent comment, so /* */
>=20
> I actually do not understand fully the comment and the code. You write
> entire model_cfg to MAX17055_ModelCfg and then immediately do it again,
> but with smaller mask. Why?

That's because VChg is 1 on POR, and max17042_override_por doesn't do anyth=
ing=20
when value equals 0 - which means that if the whole config->model_cfg is 0,=
=20
VChg won't get unset (which is needed for 4.2V batteries).

This could actually be replaced with a single regmap_write.

> > +		regmap_update_bits(map, MAX17055_ModelCfg,
> > +				MAX17055_MODELCFG_VCHG_BIT,=20
config->model_cfg);
>=20
> Can you align the continued line with previous line? Same in other
> places if it is not aligned.
>=20
> > +	}
> >=20
> >  }
> > =20
> >  static int max17042_init_chip(struct max17042_chip *chip)
> >=20
> > @@ -814,44 +821,54 @@ static int max17042_init_chip(struct max17042_chip
> > *chip)>=20
> >  	int ret;
>=20
> Best regards,
> Krzysztof


--nextPart7086655.44csPzL39Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEIt2frgBqEUNYNmF86PI1zzvbw/8FAmI05GAACgkQ6PI1zzvb
w/+wJA/9GMBU1aHb9AcTnFkoZwyhIAeAKz+4/cb9YhRzCr3XnC73PBmVXkYh67T1
I7x+reLYD3loA2p5BLp90Tpi892mnB18KdrzUDA4Ho0irsHVlC7vVcJRu7MgKHH/
LfbQH7b9vvBY3v5WvbZkb2K1FOCr63/3KpLyn3LwtuRODnr48w6SyfiSONwsT3N4
JAqg7kBriOCVBI8Wo0MWiJE+8DiVqqTMTgQhgx32pEk14AhUh63F//RqyDUHvVG4
HmVoQWz8y+w1x/hJ9ISAWcA00rkFL14xyTt5EJf3RM3oREy4xMWeCaus8UOpS7je
w+SZpuGFpbHwj3NPRtWfLzWudQfjV2fbLAyktWwMhVLwHAf5fbyHMP1sIJ9lZDlM
b0sZzGlt3MwLpgNXYU7pK+8i53f46dNNcY2jDRbu/cNxA4sF+xyHlka6pjv/kohp
SmHt2c5gysBeVD4UpvmOTarpxAWAaya5Tn9Gj4fcsQW7SaxmbHksgnmLm+WilLM7
lmKrSQ4OYV578LDqi4A5GhVUJyauZlwiX5gbf1WJDpANQiM+7DWPsXOie+k0/Mhj
hJ6fezC/ka+t5LEmPz/CjRSU2QnDmsVLXqXiLRtK94Y/xiBTGkVHF2FQngZJ3cwe
o9SugyfZ4CLLtOH5YW+SrNnzl1RX5ES32j7fwjJrkp5jETKuDdI=
=CbGF
-----END PGP SIGNATURE-----

--nextPart7086655.44csPzL39Z--



