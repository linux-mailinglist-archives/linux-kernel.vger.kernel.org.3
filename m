Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BF156497A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 21:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiGCTPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 15:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGCTPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 15:15:33 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E67138BC;
        Sun,  3 Jul 2022 12:15:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f39so12412934lfv.3;
        Sun, 03 Jul 2022 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eG3F97a2VgYD7L6VbAezBTNfUEjS5NCnSFgyzHZI6zY=;
        b=LmyfN1ZaO2CNjGvSwxTFzSOc9ITmuk6z2LJu0XZese4wnkDPpH3s/OZmm22WGTtTBX
         dsx+nPHfKIVvZ7gyXvuS8+o7O+Dbbm9yNy41NzjlrERjPUjJIu3qRbp6sL5749VCbgyu
         xvj/xuy05PXs6SyM0qymGqLgrhMe76v35j7z+wpRWzsUtyYnH5eBLQF0pTpkKYPXVuK+
         00+TpfqybeFaS6JEhG0c+qfeYCAK5fadTCHSw0AD8wnzXBWgkLrB0acyFkE3emeZO93/
         uR+g5LNMSoTeQI/7muZUjd8ouPnPCfHRm1Iz+CtYX3gAPvgng11SM+eCyg1APNzruO5i
         K/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eG3F97a2VgYD7L6VbAezBTNfUEjS5NCnSFgyzHZI6zY=;
        b=iYdnyeAkqfzUQ5ZePqfQL3j4Qa8tcK7/ewxXIxoJArFym6kq7lZoMHGDEjv/dSf+p8
         qfqis/2FAfKh5RrPIQI1W8fvT3wYXUuZwkkB65/MqwBhc8WlDHCZU1e7UL0WPAKhz4wZ
         nQQWkRjvjogi1U+YcY3sKBd+ss0XjNeCdQcUiM7zt9frfqGZNfUASdkvorOmd0/gbte1
         rZp3xXhPWTRa8+XDEnNjelSdiD0uH2jFCh8kvq2skwrsuTYAy1N+YtNOap76Vwyn/Vmh
         KtixeF67GjoKn4WzbU/bfLAYTiZ6LYUI/GK4Dyy/HeHpDdijEvorYUIlk5GfEsCoIHoP
         DcTA==
X-Gm-Message-State: AJIora8wxASE3IgPdRCuOou7wRexpg8kJSvxofUxC2ONQdoliSljI8O8
        zJ9/2dVHtZHcTEBKRkUIxks=
X-Google-Smtp-Source: AGRyM1smPbdXGquCG625z52pig6BMRWYtEwyaBy2i6m86DT30ZxgT41H7mDGLfbq1AQebMUo5Zd6TA==
X-Received: by 2002:a05:6512:1695:b0:47f:b0b4:3b38 with SMTP id bu21-20020a056512169500b0047fb0b43b38mr14946928lfb.248.1656875729719;
        Sun, 03 Jul 2022 12:15:29 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b0047fa2cc38ccsm4822327lfm.198.2022.07.03.12.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 12:15:28 -0700 (PDT)
Date:   Sun, 3 Jul 2022 21:18:46 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 04/10] iio: adc: mcp3911: add support for interrupts
Message-ID: <YsHrlmfxOkwzVvfO@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
 <20220625103853.2470346-4-marcus.folkesson@gmail.com>
 <20220625125652.2f988964@jic23-huawei>
 <20220625130637.223180f2@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nkFejJuc99Xh3uiS"
Content-Disposition: inline
In-Reply-To: <20220625130637.223180f2@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nkFejJuc99Xh3uiS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 25, 2022 at 01:06:37PM +0100, Jonathan Cameron wrote:
>=20
> ...
>=20
> > >  static int mcp3911_probe(struct spi_device *spi)
> > >  {
> > >  	struct iio_dev *indio_dev;
> > > @@ -352,6 +382,15 @@ static int mcp3911_probe(struct spi_device *spi)
> > >  	if (ret)
> > >  		goto clk_disable;
> > > =20
> > > +	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready=
-hiz"))
> > > +		ret =3D mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSC=
OM_DRHIZ,
> > > +				0, 2);
> > > +	else
> > > +		ret =3D mcp3911_update(adc, MCP3911_REG_STATUSCOM, MCP3911_STATUSC=
OM_DRHIZ,
> > > +				MCP3911_STATUSCOM_DRHIZ, 2);
> > > +	if (ret < 0)
> > > +		goto clk_disable;
> > > +
> > >  	indio_dev->name =3D spi_get_device_id(spi)->name;
> > >  	indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> > >  	indio_dev->info =3D &mcp3911_info;
> > > @@ -362,6 +401,32 @@ static int mcp3911_probe(struct spi_device *spi)
> > > =20
> > >  	mutex_init(&adc->lock);
> > > =20
> > > +	if (spi->irq > 0) {
> > > +		adc->trig =3D devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> > > +				indio_dev->name,
> > > +				iio_device_id(indio_dev));
> > > +		if (!adc->trig)
> > > +			goto clk_disable; =20
> > You definitely want to use devm managed cleanup for these.
> >=20
> > There is a patch set that adds these as standard functions, but I haven=
't
> > yet seen it being picked up for this cycle (reviews have been slow comi=
ng).
> >=20
> > https://lore.kernel.org/all/20220520075737.758761-1-u.kleine-koenig@pen=
gutronix.de/
>=20
> Ah, elsewhere in my unread email was a thread that says it's in clk-next =
so
> will be in the next merge window.  I haven't confirmed, but looks like St=
ephen
> put up an immutable branch so I could pull it into the IIO togreg branch =
if you
> want to transition directly to that new code. @Stephen, would you be fine
> with me pulling your clk-devm-enable branch into IIO (with the fix which
> got posted earlier in the week presumably also going on that branch when
> you push out?)

Please do, thanks

>=20
> Thanks,
>=20
> Jonathan
>=20
>=20
>=20
> >=20
> > In meantime role your own with devm_add_action_or_reset()

Best regards,
Marcus Folkesson

--nkFejJuc99Xh3uiS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmLB65EACgkQiIBOb1ld
UjJCURAAlmAjxUJQVlUe+a6+y5i06nMoQcOicCOsxkIcXRqKsgwVkksbUNXX6cCF
Oe8mJ4pLud8SRxIPSlpRSkfHffgOpcMep0M7XfnvK0+b6naQH8tQF0LBnFwRd1rS
3o8HcG8k39RRCUzzfWO4lWFSVECC2VEZvNpIkcqy2CLGKLZc613kF6SzZnN3rZpO
Et69bTlQ0OyOyvpw0cDg0ENTJmP397EDxj5HjOXCsAMn/pF96YkmQ2FBZsjpyiYy
uQKvk/dzUpiLmbLYuE/vY0NMtb3RFkGGXITtOmVHraqKlgwbCfiGC5xflkSVJmkW
IhezmhzrkoUPIVqBsp/xndClbvunkwAde0sPklgYdXD/gJhUYBNq6Hcp4xTr+IUX
HLNb8Dc7VAofd00SedKzN5uTpxIsSXygrTE3Y0kcmUUvDMzs4Gjz1WAh2tCf5Z1F
x2/Mxjp+cIqd38knhZiaxfbIF1vKkmD5/M2NtcZnX2nnVCDb4RtPhN9uciPLaABn
yTox8uQucfAy9P6f/3fTjTj2ib/fv8p5mBzPHsHjQs7qBNZFRs3u6FwdckLJpRDX
x2dqQZeuiEfsd9LrpikZrF/WJOqwlX7WJu07ZRKa8Mj48y6OjM5Jg5lQNpej/hbe
xSadDlL+fhRAes43sTDiqUm/QLlJ+MHkmopCD0MUabtrRa2I07g=
=uWvi
-----END PGP SIGNATURE-----

--nkFejJuc99Xh3uiS--
