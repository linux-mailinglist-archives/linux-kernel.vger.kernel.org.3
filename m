Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC0D54B585
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357029AbiFNQMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356991AbiFNQMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:12:23 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B571178
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:12:21 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w13so5578347qts.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3jBqBxMB7fqDN551D5iAxDom4QaYI7W0sqRlfDkpCc8=;
        b=kmuz4JLangHbni60CUWT2xTGrO5G1qMmeyyTNxwO2GAUS9Zo/A9AGz+Js0L0ZpUj5S
         0dymZ5D4Abl1SKY7smIhJSGpq812JzZyGyg6gnJM1hsTARM41oQjGdw7JCuhIVYJLdIu
         v8njo7+6ylA1Lg21LW6b4mxnwduGTlBjtKTpMvSTMEd7wp2iesqCVWtJqcyN5sgVS1yh
         gnkly6txocbpDtWykSVEi0Qwc4YRgXPc1zweFl+WDIw3wIiY2UHjCNIvyXQmpCgd6/cq
         P2Iyg0v1FvnNz18zXmByvrNB6z5nC3aSUlRofDZHgpUR3e2ovDY2nezeSOgVN0vQ1lcO
         bm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3jBqBxMB7fqDN551D5iAxDom4QaYI7W0sqRlfDkpCc8=;
        b=bMXofIR+1y98eCIBThCEyl4f4YNfFxkxay17qdQC48vmAizzLFLzDimFEIUhCAGZ/a
         O0NCPyHGTV5yLOCNHIcZylqLVPlL5Ub5zp1K7W+8gm76Y//LtyWSay3ig35Xxf+uIgfj
         0WTkNvdUlbcOaEzV68UOxr/Ts/SdsKmbvB8tEPi3gzWZ8wPfa9zopB/jAnCY9FTWwZo/
         HKeorEMo1KAFjH3udLRqcxx5s83yuTHExDk+OOB6elY5hG/cBlOR8VS85ORIRR3kYvhH
         8MKU2J/7BWerPcSxvgeuMy0RNU6+rvDdDpdDKJkU4PLpsGyFNUH6Sxm1QxxhT16pbok/
         qPrg==
X-Gm-Message-State: AOAM533iorIVHUqsYI5Jy3ofiy759iram7zGANe05DWfQMsxW+WdYRfA
        8ew5uRJn2ARNrHjCqybYCvDw+A==
X-Google-Smtp-Source: ABdhPJzCveOrz66ys+OxsOHkdqq6dB46agmi3j4eoqqBAXFFpNzvKeU1zTejfZB/KOvowZ4r4C33og==
X-Received: by 2002:a05:622a:54a:b0:305:3186:1fe9 with SMTP id m10-20020a05622a054a00b0030531861fe9mr4804128qtx.60.1655223140435;
        Tue, 14 Jun 2022 09:12:20 -0700 (PDT)
Received: from fedora ([23.82.142.207])
        by smtp.gmail.com with ESMTPSA id cj19-20020a05622a259300b00304f6f4199dsm7237283qtb.65.2022.06.14.09.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:12:20 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:12:18 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: stx104: Implement and utilize register
 structures
Message-ID: <YqizYqqu3tyzRUJ3@fedora>
References: <cover.1654118389.git.william.gray@linaro.org>
 <a2dca9435f7f1f727c696a1faa0ab9e27927f9f3.1654118389.git.william.gray@linaro.org>
 <20220614122248.7f257556@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zKhNy45o+JagUNi2"
Content-Disposition: inline
In-Reply-To: <20220614122248.7f257556@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zKhNy45o+JagUNi2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2022 at 12:22:48PM +0100, Jonathan Cameron wrote:
> On Mon,  6 Jun 2022 10:15:17 -0400
> William Breathitt Gray <william.gray@linaro.org> wrote:
>=20
> > Reduce magic numbers and improve code readability by implementing and
> > utilizing named register data structures.
> >=20
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> A few comments inline, but looks fine to me otherwise.
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/adc/stx104.c | 70 +++++++++++++++++++++++++++-------------
> >  1 file changed, 47 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
> > index 7552351bfed9..7656b363e281 100644
> > --- a/drivers/iio/adc/stx104.c
> > +++ b/drivers/iio/adc/stx104.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/module.h>
> >  #include <linux/moduleparam.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/types.h>
> > =20
> >  #define STX104_OUT_CHAN(chan) {				\
> >  	.type =3D IIO_VOLTAGE,				\
> > @@ -44,14 +45,36 @@ static unsigned int num_stx104;
> >  module_param_hw_array(base, uint, ioport, &num_stx104, 0);
> >  MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
> > =20
> > +/**
> > + * struct stx104_reg - device register structure
> > + * @ad:		ADC Data
> > + * @achan:	ADC Channel
> > + * @dio:	Digital I/O
> > + * @dac:	DAC Channels
> > + * @cir_asr:	Clear Interrupts and ADC Status
> > + * @acr:	ADC Control
> > + * @pccr_fsh:	Pacer Clock Control and FIFO Status MSB
> > + * @acfg:	ADC Configuration
> > + */
> > +struct stx104_reg {
> > +	u16 ad;
> > +	u8 achan;
> > +	u8 dio;
> > +	u16 dac[2];
> > +	u8 cir_asr;
> > +	u8 acr;
> > +	u8 pccr_fsh;
> > +	u8 acfg;
> > +};
> > +
> >  /**
> >   * struct stx104_iio - IIO device private data structure
> >   * @chan_out_states:	channels' output states
> > - * @base:		base port address of the IIO device
> > + * @reg:		I/O address offset for the device registers
> >   */
> >  struct stx104_iio {
> >  	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
> > -	void __iomem *base;
> > +	struct stx104_reg __iomem *reg;
> >  };
> > =20
> >  /**
> > @@ -64,7 +87,7 @@ struct stx104_iio {
> >  struct stx104_gpio {
> >  	struct gpio_chip chip;
> >  	spinlock_t lock;
> > -	void __iomem *base;
> > +	u8 __iomem *base;
> >  	unsigned int out_state;
> >  };
> > =20
> > @@ -72,6 +95,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
> >  	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> >  {
> >  	struct stx104_iio *const priv =3D iio_priv(indio_dev);
> > +	struct stx104_reg __iomem *const reg =3D priv->reg;
> >  	unsigned int adc_config;
> >  	int adbu;
> >  	int gain;
> > @@ -79,7 +103,7 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_HARDWAREGAIN:
> >  		/* get gain configuration */
> > -		adc_config =3D ioread8(priv->base + 11);
> > +		adc_config =3D ioread8(&reg->acfg);
> >  		gain =3D adc_config & 0x3;
> > =20
> >  		*val =3D 1 << gain;
> > @@ -91,24 +115,24 @@ static int stx104_read_raw(struct iio_dev *indio_d=
ev,
> >  		}
> > =20
> >  		/* select ADC channel */
> > -		iowrite8(chan->channel | (chan->channel << 4), priv->base + 2);
> > +		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
> > =20
> >  		/* trigger ADC sample capture and wait for completion */
> > -		iowrite8(0, priv->base);
> > -		while (ioread8(priv->base + 8) & BIT(7));
> > +		iowrite8(0, &reg->ad);
>=20
> Curious - 8 bit write to a 16 bit address?  Maybe worth a comment
> on why.

This address doubles as the 8-bit Software Strobe Register; writing an
8-bit value to this address will initiate an ADC sample capture. I'll
rename this member to ssr_ad and add some comments to make this more
explicit.

>=20
> > +		while (ioread8(&reg->cir_asr) & BIT(7));
> > =20
> > -		*val =3D ioread16(priv->base);
> > +		*val =3D ioread16(&reg->ad);
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_OFFSET:
> >  		/* get ADC bipolar/unipolar configuration */
> > -		adc_config =3D ioread8(priv->base + 11);
> > +		adc_config =3D ioread8(&reg->acfg);
> >  		adbu =3D !(adc_config & BIT(2));
> > =20
> >  		*val =3D -32768 * adbu;
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_SCALE:
> >  		/* get ADC bipolar/unipolar and gain configuration */
> > -		adc_config =3D ioread8(priv->base + 11);
> > +		adc_config =3D ioread8(&reg->acfg);
> >  		adbu =3D !(adc_config & BIT(2));
> >  		gain =3D adc_config & 0x3;
> > =20
> > @@ -130,16 +154,16 @@ static int stx104_write_raw(struct iio_dev *indio=
_dev,
> >  		/* Only four gain states (x1, x2, x4, x8) */
> >  		switch (val) {
> >  		case 1:
> > -			iowrite8(0, priv->base + 11);
> > +			iowrite8(0, &priv->reg->acfg);
> >  			break;
> >  		case 2:
> > -			iowrite8(1, priv->base + 11);
> > +			iowrite8(1, &priv->reg->acfg);
> >  			break;
> >  		case 4:
> > -			iowrite8(2, priv->base + 11);
> > +			iowrite8(2, &priv->reg->acfg);
> >  			break;
> >  		case 8:
> > -			iowrite8(3, priv->base + 11);
> > +			iowrite8(3, &priv->reg->acfg);
> >  			break;
> >  		default:
> >  			return -EINVAL;
> > @@ -153,7 +177,7 @@ static int stx104_write_raw(struct iio_dev *indio_d=
ev,
> >  				return -EINVAL;
> > =20
> >  			priv->chan_out_states[chan->channel] =3D val;
> > -			iowrite16(val, priv->base + 4 + 2 * chan->channel);
> > +			iowrite16(val, priv->reg->dac + chan->channel);
> Perhaps for consistency with below go with
> &priv->reg->dac[chan->channels];

Ack.

William Breathitt Gray

> > =20
> >  			return 0;
> >  		}
> > @@ -307,15 +331,15 @@ static int stx104_probe(struct device *dev, unsig=
ned int id)
> >  	}
> > =20
> >  	priv =3D iio_priv(indio_dev);
> > -	priv->base =3D devm_ioport_map(dev, base[id], STX104_EXTENT);
> > -	if (!priv->base)
> > +	priv->reg =3D devm_ioport_map(dev, base[id], STX104_EXTENT);
> > +	if (!priv->reg)
> >  		return -ENOMEM;
> > =20
> >  	indio_dev->info =3D &stx104_info;
> >  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > =20
> >  	/* determine if differential inputs */
> > -	if (ioread8(priv->base + 8) & BIT(5)) {
> > +	if (ioread8(&priv->reg->cir_asr) & BIT(5)) {
> >  		indio_dev->num_channels =3D ARRAY_SIZE(stx104_channels_diff);
> >  		indio_dev->channels =3D stx104_channels_diff;
> >  	} else {
> > @@ -326,14 +350,14 @@ static int stx104_probe(struct device *dev, unsig=
ned int id)
> >  	indio_dev->name =3D dev_name(dev);
> > =20
> >  	/* configure device for software trigger operation */
> > -	iowrite8(0, priv->base + 9);
> > +	iowrite8(0, &priv->reg->acr);
> > =20
> >  	/* initialize gain setting to x1 */
> > -	iowrite8(0, priv->base + 11);
> > +	iowrite8(0, &priv->reg->acfg);
> > =20
> >  	/* initialize DAC output to 0V */
> > -	iowrite16(0, priv->base + 4);
> > -	iowrite16(0, priv->base + 6);
> > +	iowrite16(0, &priv->reg->dac[0]);
> > +	iowrite16(0, &priv->reg->dac[1]);
> > =20
> >  	stx104gpio->chip.label =3D dev_name(dev);
> >  	stx104gpio->chip.parent =3D dev;
> > @@ -348,7 +372,7 @@ static int stx104_probe(struct device *dev, unsigne=
d int id)
> >  	stx104gpio->chip.get_multiple =3D stx104_gpio_get_multiple;
> >  	stx104gpio->chip.set =3D stx104_gpio_set;
> >  	stx104gpio->chip.set_multiple =3D stx104_gpio_set_multiple;
> > -	stx104gpio->base =3D priv->base + 3;
> > +	stx104gpio->base =3D &priv->reg->dio;
> >  	stx104gpio->out_state =3D 0x0;
> > =20
> >  	spin_lock_init(&stx104gpio->lock);
>=20

--zKhNy45o+JagUNi2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYqizYgAKCRC1SFbKvhIj
K5vmAQChcLKhfi0sWCfjC9SAoN/3WVMynSdCNnQvj9Mwk3HMlAEA5Y93Y4cM7zff
eNDbkKot5hO57G8W/Qr5pQKQbQ81uQk=
=1gzP
-----END PGP SIGNATURE-----

--zKhNy45o+JagUNi2--
