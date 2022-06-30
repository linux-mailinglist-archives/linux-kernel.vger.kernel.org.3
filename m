Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9736B561518
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiF3I3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiF3I3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:29:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08279B30;
        Thu, 30 Jun 2022 01:29:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j21so32456227lfe.1;
        Thu, 30 Jun 2022 01:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PsBHGFQ8BgFUT5RFMX64e2Cinbnfgc5LS96HHjhx2Ns=;
        b=eqk/ejoJYg18atheE6dB2+gp+sjR0NJehewpaTKusOOc4Gi76xgOXWUr/AeynopHtm
         lQPrPhNXnB7Z4zQ0EW058ZELzDmzHLusEQJCFRmW9/qSIHSC4tLq9+sxw3r0TdZuwCyj
         BJ1rLz/BjqPx8QsGMwax69M+waf0uKBoYVxFr1mzfxG64Pvxz+REv55wpmLFBF1nCTdW
         U2yqZjVWoS5imgUyU1Cg2CxkrL2nw3tZ6k/zWvocIl4kEzSx0tMpiuZjmo9RYp7UwiHw
         Aj+Vo8k3pXtp0eLYmhQiL9kaB/qGvOMadb7+/722+ytD3NhiWmgoUa8UpjzhRhcvsSIx
         hSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PsBHGFQ8BgFUT5RFMX64e2Cinbnfgc5LS96HHjhx2Ns=;
        b=8LIMqxgeujysD+yoHkHqPYbWHjBWFpWuan3Go9nLLaGSd3QJnFXVcj1wnp51ZKfi84
         NCIKHQlW8PvCrr7HKF/7nO1KWBGlM+UGZpIryJ3z4RW4tQVbTIf9He0OLoGqwtR2ZTNk
         X2xQ5V72jBv0ajNyhpQ5RcfiMe9+MMkZ4WZxFgLF1zUgmV8vjEhUo6vEOSrJdzVgYUxz
         V7OvXD6E0tOsUd/qOtV8dZqyh0fjN2tllUbJQNfwn1hMUqiToJETpGU5mWvTPQ/lMG8v
         HEYIrxSh+5Yhc0dUok17lQWuMAg+ljt+hmh08CDBUnU4OTsA5nby964+sho9oTqCw01m
         oxuA==
X-Gm-Message-State: AJIora9kMZIaKB8ekvUcaj3A6ffN5jzaLinFHe1HmJ5liOEHvY+mN3gm
        puuVCquBuRv7vA5BKWrPHPI=
X-Google-Smtp-Source: AGRyM1vjCeUPX1qrmmV50QUgY3vnb+sMzRFCSNP3gJbrS5m+iVVDhtB+fl1TQwbtaaa5PNoZoY3Q2w==
X-Received: by 2002:a05:6512:24d:b0:47f:6457:4082 with SMTP id b13-20020a056512024d00b0047f64574082mr4624340lfo.43.1656577775124;
        Thu, 30 Jun 2022 01:29:35 -0700 (PDT)
Received: from gmail.com (c-2ec2f5c4-74736162.cust.telenor.se. [46.194.245.196])
        by smtp.gmail.com with ESMTPSA id 8-20020ac25f08000000b00477cab33759sm2960517lfq.256.2022.06.30.01.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 01:29:34 -0700 (PDT)
Date:   Thu, 30 Jun 2022 10:32:42 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] iio: adc: mcp3911: add support for buffers
Message-ID: <Yr1fqi/49l1nWYtt@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
 <20220625103853.2470346-3-marcus.folkesson@gmail.com>
 <20220625124537.163bf426@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KfwtesvVeNKYhzrQ"
Content-Disposition: inline
In-Reply-To: <20220625124537.163bf426@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KfwtesvVeNKYhzrQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, Jun 25, 2022 at 12:45:37PM +0100, Jonathan Cameron wrote:
> On Sat, 25 Jun 2022 12:38:46 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> > Add support for buffers to make the driver fit for more usecases.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Hi Marcus,
>=20
> Good to see this feature.  A few comments inline, mostly around
> optimising the data flow / device accesses.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >=20
> > Notes:
> >     v2:
> >         - No changes
> >=20
> >  drivers/iio/adc/mcp3911.c | 58 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 57 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> > index 25a235cce56c..2a4bf374f140 100644
> > --- a/drivers/iio/adc/mcp3911.c
> > +++ b/drivers/iio/adc/mcp3911.c
> > @@ -9,6 +9,10 @@
> >  #include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/iio/iio.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/trigger.h>
> >  #include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/property.h>
> > @@ -54,6 +58,10 @@ struct mcp3911 {
> >  	struct regulator *vref;
> >  	struct clk *clki;
> >  	u32 dev_addr;
> > +	struct {
> > +		u32 channels[2];
> > +		s64 ts __aligned(8);
> > +	} scan;
> >  };
> > =20
> >  static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
> > @@ -187,16 +195,58 @@ static int mcp3911_write_raw(struct iio_dev *indi=
o_dev,
> >  		.type =3D IIO_VOLTAGE,				\
> >  		.indexed =3D 1,					\
> >  		.channel =3D idx,					\
> > +		.scan_index =3D idx,				\
> >  		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |	\
> >  			BIT(IIO_CHAN_INFO_OFFSET) |		\
> >  			BIT(IIO_CHAN_INFO_SCALE),		\
> > +		.scan_type =3D {					\
> > +			.sign =3D 's',				\
> > +			.realbits =3D 24,				\
> > +			.storagebits =3D 32,			\
> > +		},						\
> >  }
> > =20
> >  static const struct iio_chan_spec mcp3911_channels[] =3D {
> >  	MCP3911_CHAN(0),
> >  	MCP3911_CHAN(1),
> > +	IIO_CHAN_SOFT_TIMESTAMP(2),
> >  };
> > =20
> > +static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf =3D p;
> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > +	struct mcp3911 *adc =3D iio_priv(indio_dev);
> > +	int scan_index;
> > +	int i =3D 0;
> > +	u32 val;
> > +
> > +	mutex_lock(&adc->lock);
> > +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> > +			indio_dev->masklength) {
> > +		const struct iio_chan_spec *scan_chan =3D
> > +			&indio_dev->channels[scan_index];
> > +		int ret =3D mcp3911_read(adc,
> > +				MCP3911_CHANNEL(scan_chan->channel), &val, 3);
>=20
> I was a bit surprised not to see some overlap of address setting and
> read out here if both channels are enabled, so opened up the data sheet.
>=20
> Can we take advantage of "Continuous communication looping on address set"

Sure, I will make it use continuous reads when both channels are enabled,
thanks.

> (6.7 on the datasheet).  Also for buffered capture we'd normally make
> things like shifting and endian conversion a userspace problem.  Can we
> not do that here for some reason?  You'd need to take care to ensure

The endian conversion&shifting was actually the reason for why I did not
make use of continoues reads from the beginning.

> any buffers that might be used directly for DMA obey DMA safety rules
> (currently avoided by using spi_write_then_read), but it would be
> nice to do less data manipulation int his path if we can.

I will change to spi_sync() and skip the data manipulation.

>=20
>=20
>=20
> > +
> > +		if (ret < 0) {
> > +			dev_warn(&adc->spi->dev,
> > +					"failed to get conversion data\n");
> > +			goto out;
> > +		}
> > +
> > +		adc->scan.channels[i] =3D val;
> > +		i++;
> > +	}
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &adc->scan,
> > +			iio_get_time_ns(indio_dev)); =20
> > +out:
> > +	mutex_unlock(&adc->lock);
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static const struct iio_info mcp3911_info =3D {
> >  	.read_raw =3D mcp3911_read_raw,
> >  	.write_raw =3D mcp3911_write_raw,
> > @@ -303,7 +353,7 @@ static int mcp3911_probe(struct spi_device *spi)
> >  		goto clk_disable;
> > =20
> >  	indio_dev->name =3D spi_get_device_id(spi)->name;
> > -	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
>=20
> The core sets INDIO_BUFFER_TRIGGERED as part of devm_iio_triggered_buffer=
_setup()
> so you need to set DIRECT_MODE here (that one isn't visible to the core)

Ok, thank you. I sent patches that fixes this in two other ADC-drivers
as well to avoid more people following the same thing.

>=20
> >  	indio_dev->info =3D &mcp3911_info;
> >  	spi_set_drvdata(spi, indio_dev);
> > =20
> > @@ -312,6 +362,12 @@ static int mcp3911_probe(struct spi_device *spi)
> > =20
> >  	mutex_init(&adc->lock);
> > =20
> > +	ret =3D devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> Can't use devm here for the same reason it was inappropriate in patch 2.
>=20
> I'd suggest a precursor patch(es) to move the driver fully over to
> devm_ managed such that you don't need a remove function and the ordering
> is maintained.

Yep, I will keep this and fix patch 2 instead.

> > +			NULL,
> > +			mcp3911_trigger_handler, NULL);
> > +	if (ret)
> > +		goto clk_disable;
> > +
> >  	ret =3D devm_iio_device_register(&adc->spi->dev, indio_dev);
> >  	if (ret)
> >  		goto clk_disable;
>=20

/Marcus

--KfwtesvVeNKYhzrQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmK9X6UACgkQiIBOb1ld
UjLVXRAAi+2ypYWt5I0kPX7JtuXSrmmTToAIBK8Vluw/SyV+1LIlLIaXec1epThH
Z8CqrtZPJWy5+Zdv7yjQWm//E0/ZS/7ZE8RBJafisvT9O0rI0CPalIoVhuycOCav
YYiPuAes1ZO42bjr8vg5Q3p8eFlVbg7q7S1nVE8F5Lz95C1eDKCyNr7q56e0I+za
K4lIWhVxk1H+PK2qbwXbaotZVxrE+E6IHYxbaLbM9aM4wSYJDwZQRJg5KahoOhhn
MRHFdqiu3uMC43hIbj2/d6Vou0szIBXuEUoaDmNqMFbjTIT7kdJ44yP9jli+p757
LpNaYspk4hy1QILGPBhlv/lY4e2IWy3YX2bcWaoYhwRkfD3666oXIsTopSg4u09M
bx5vcdVV2rxAVqD9gwfDskan33F4nW0x6kmfChYrhJ66hpLT6qadAAKkmZWWeRDz
VBPte44q9Az4FNCQYW79hy2E0W/bGrrzk7GWwLn73aNwDfXcrWQNwUTFn9BvU+a2
lVWZ2IpjVv+JAOhyqujyOgRG5y8Hdswrj7MOTqBSvSUnPSiUEfw6VFbnIEKf4vDI
ZFT3EJ0qJGrrT/KGrcC7P8HMZ6rFAP793PieAinoFbBrD67wiGqqikNPUtf5hCaX
iwEycKWDsKg/79GFDkuELTuAKDDHXJc99C6LZWdU1fg+Ls7JtVc=
=5u7F
-----END PGP SIGNATURE-----

--KfwtesvVeNKYhzrQ--
