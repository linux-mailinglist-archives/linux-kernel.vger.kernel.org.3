Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61E4CFCD1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241912AbiCGL3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242973AbiCGL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:29:14 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DEA57146;
        Mon,  7 Mar 2022 03:10:45 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E1EA1FF80E;
        Mon,  7 Mar 2022 11:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646651440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=va6hgBVRbtr10BKiH5oDCOu0VwLfnjed/wWRNnb7DUY=;
        b=gC3ndSWkdul0/O5Y4jHV6jR7MkWuyj436eSHmu6S2Z9kuJJDSUV/+c8Xr4gqjTTzXxPi+e
        yn8Lz317xPszLkKWTUlDMBkooNHSefTzJUtscXF5RjZ4EQIcZHO31ulyM+57oIEl/H6Mqu
        iY3E52NJNZNdzNUFaXXfRfr0nTlvpgUqBqlckY7VlUqJ+Lvem3NbcSekMU1w4LIhNRBzkE
        /jRyqod+8XYQiPJml0/297HhrIfs4htUqbz8dfBWo0IkqRf7CsYNFbOI5wPGWxeF3wa+0e
        i/yxXJGB8jMuo5CbkqTpqa/UBaJxO4JnO9AnsMj4QhLR6S9cDwXfWzfy1dPIFQ==
Date:   Mon, 7 Mar 2022 12:10:33 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ryan Barnett <ryan.barnett@collins.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v6 14/48] mfd: ti_am335x_tscadc: Don't search the tree
 for our clock
Message-ID: <20220307121033.5630fee7@xps13>
In-Reply-To: <7336E356-57E3-4BC5-B098-0A791C2CB360@goldelico.com>
References: <20211015081506.933180-1-miquel.raynal@bootlin.com>
        <20211015081506.933180-15-miquel.raynal@bootlin.com>
        <7336E356-57E3-4BC5-B098-0A791C2CB360@goldelico.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikolaus,

hns@goldelico.com wrote on Fri, 4 Mar 2022 23:38:25 +0100:

> Hi Miquel,
> I recently found that our BeagleBoneBlack with external touch screen stop=
ped
> to find it.
>=20
> A git bisect revealed this patch (merged into v5.16-rc1) as the first bad:
>=20
> > Am 15.10.2021 um 10:14 schrieb Miquel Raynal <miquel.raynal@bootlin.com=
>:
> >=20
> > There is a single clock available in our node, which is named
> > "fck". The clock handler then points to adc_tsc_fck but no need to point
> > directly to it and do a full tree search.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> > drivers/mfd/ti_am335x_tscadc.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tsc=
adc.c
> > index e2c4416f192d..8af44c08d925 100644
> > --- a/drivers/mfd/ti_am335x_tscadc.c
> > +++ b/drivers/mfd/ti_am335x_tscadc.c
> > @@ -206,7 +206,7 @@ static	int ti_tscadc_probe(struct platform_device *=
pdev)
> > 	 * This frequency is valid since TSC_ADC_SS controller design
> > 	 * assumes the OCP clock is at least 6x faster than the ADC clock.
> > 	 */
> > -	clk =3D devm_clk_get(&pdev->dev, "adc_tsc_fck");
> > +	clk =3D devm_clk_get(&pdev->dev, NULL);
> > 	if (IS_ERR(clk)) {
> > 		dev_err(&pdev->dev, "failed to get TSC fck\n");
> > 		err =3D PTR_ERR(clk);
> > --=20
> > 2.27.0
> >  =20
>=20
> While I understand the reasons for this change there seems to be something
> missing now in the device tree because the clock isn't found any more.
>=20
> After knowing about the problem I could also locate the log entry:
>=20
> [    4.456680] ti_am3359-tscadc 44e0d000.tscadc: failed to get TSC fck
>=20
> Reverting your patch makes it work again.

Sorry for the wrong behavior on your side and thanks for the
investigation.

> Is there missing a change in the am335x-boneblack or am335x DTS?

I've looked at the code and indeed the am33xx-clock.dtsi file defines
the touchscreen clock, but unfortunately the am33xx-l4.dtsi file which
defines the touchscreen node does not reference the clock. The bindings
clearly require the clocks to be referenced but I believe this was not
noticed until now because the clock exist and clk_get() did a lookup
across the tree.

On my side I tested it with an am437x SoC which uses another base
device tree, which properly references the touchscreen clock where it's
needed.

I will send a patch (untested), can you give it a try and report if it
fixes your issue?

>=20
> Our (private) DTS looks like this, i.e. we don't play with clocks inherit=
ed
> from mainline tree:
>=20
> #include "am335x-boneblack.dts"
>=20
> ...
>=20
> &tscadc {
>         status =3D "okay";
>=20
>         tsc {
>                 ti,wires =3D <4>;
>                 ti,x-plate-resistance =3D <600>;
>                 ti,coordinate-readouts =3D <5>;
>                 ti,wire-config =3D <0x00 0x11 0x22 0x33>;
>         };
>=20
>         adc {
>                 ti,adc-channels =3D <4 5 6 7>;
>         };
> };
>=20
> BR and thanks,
> Nikolaus

Thanks,
Miqu=C3=A8l
