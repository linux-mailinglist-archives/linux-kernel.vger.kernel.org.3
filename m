Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B6454B5BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbiFNQQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243150AbiFNQP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:15:58 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18095443FD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:15:44 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id b3so1016650qtp.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HugF3kVZQV7tRWlbsi9AfRP8AXxUXr/ecMMBI60Ommg=;
        b=aP8eJtZG8tX82Qcc+gRKt0ht+U2+a1jDaWf2J/lStM2+QcR3HRqjrGHCe0CIua2aP4
         rlXPJkAUjgkE3udu3n9eLgXCIkyIHFiRrSMUgM32h9ysFvkfmNIZGQ1SS3z0tg7KdPlX
         htJhJFdeXYimZoUifB6n4TD2DIJZJMK3TlyzR4mS3cF1yGtlAgzFzm9fIi+rUF0UWzF8
         vFht7MrUkWAzP9v3xfNaaPPTE50D/kTCbHOp8Fm6XckzMVqy5fUM+GcAWLQpRFxqiA03
         WrMZgSf0kwwtV2ZhVJTURUKRBgsmqx22fYNXs4xLij+yg4jPmHVltXJe6aMPbc/wTx2s
         Qvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HugF3kVZQV7tRWlbsi9AfRP8AXxUXr/ecMMBI60Ommg=;
        b=gVNZRxnXYAFuu+A1l97D51ZpJiAfO5tPK0bPYGpiE6SGi5RaHc29yVje+EpYIOLlf1
         4IfnlNoun8hVmP8DmuW+fl/L8tM8FdQgI4etmMykQDO5xvLTEcDdi2f9pklh3gCclMiN
         fRuY/1Ef03l/1o09IPW/KWw4o3bOrI3X84WQI3aSTXspfsEKjwrPpJ2o2SuJf0tj2UcX
         wmvVj1UOCJGD8xXCHDWIr7Xgb5sdUW6c75UCNqntSuSBHWE7k5EG4pDf7oiD5IRTbFCp
         bvMZU7jALlD45zTkXFSMQFB8WbE+eOTT6D4ko1jqlhFgF0RSfoGaImyQHDYoRSMo1u2o
         zVNg==
X-Gm-Message-State: AOAM533AUJtef1ZjS6Ky0PpZ+X5UcysTXlzxbtLXcVHWBWIbk1mKYh3+
        V+eefcl8LyzCKyKttxqBIY2Q3g==
X-Google-Smtp-Source: ABdhPJxMUEksBnAPeMx4IH1vi+69QnqxoNTWSDXP8lLm42vGB69JoW9G6iWS+IRyaTMcUQy0y3NynA==
X-Received: by 2002:ac8:5c16:0:b0:305:34a0:f538 with SMTP id i22-20020ac85c16000000b0030534a0f538mr4701831qti.653.1655223342723;
        Tue, 14 Jun 2022 09:15:42 -0700 (PDT)
Received: from fedora ([23.82.142.207])
        by smtp.gmail.com with ESMTPSA id c7-20020a05620a268700b006a6f57fe2e1sm9905165qkp.98.2022.06.14.09.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 09:15:42 -0700 (PDT)
Date:   Tue, 14 Jun 2022 12:15:40 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: cio-dac: Implement and utilize register
 structures
Message-ID: <Yqi0LEbqiSCNxWS3@fedora>
References: <cover.1654118389.git.william.gray@linaro.org>
 <44aec703753f930cceff448babd1c8e2959eebb0.1654118389.git.william.gray@linaro.org>
 <20220614122618.68e2e9d1@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M7k0kYrMKQquTa5e"
Content-Disposition: inline
In-Reply-To: <20220614122618.68e2e9d1@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M7k0kYrMKQquTa5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2022 at 12:26:18PM +0100, Jonathan Cameron wrote:
> On Mon,  6 Jun 2022 10:15:18 -0400
> William Breathitt Gray <william.gray@linaro.org> wrote:
>=20
> > Reduce magic numbers and improve code readability by implementing and
> > utilizing named register data structures.
> >=20
> > Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
>=20
> I'm unconvinced this one really helps readability seeing
> as you are only indexing a straight forward array.
>=20
> Simply using u16 __iomem *
> would provide the main cleanup which is avoiding the indexing
> via * 2.
>=20
> Thanks,
>=20
> Jonathan

I agree, that is a much simpler approach and reduces the changes we need
to make to this file. I'll adjust this to u16 __iomem * in v2.

William Breathitt Gray

>=20
>=20
> > ---
> >  drivers/iio/dac/cio-dac.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
> > index 8080984dcb03..7860450ceaf3 100644
> > --- a/drivers/iio/dac/cio-dac.c
> > +++ b/drivers/iio/dac/cio-dac.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/isa.h>
> >  #include <linux/module.h>
> >  #include <linux/moduleparam.h>
> > +#include <linux/types.h>
> > =20
> >  #define CIO_DAC_NUM_CHAN 16
> > =20
> > @@ -34,14 +35,22 @@ static unsigned int num_cio_dac;
> >  module_param_hw_array(base, uint, ioport, &num_cio_dac, 0);
> >  MODULE_PARM_DESC(base, "Measurement Computing CIO-DAC base addresses");
> > =20
> > +/**
> > + * struct cio_dac_reg - device register structure
> > + * @da:	D/A data
> > + */
> > +struct cio_dac_reg {
> > +	u16 da[CIO_DAC_NUM_CHAN];
> > +};
> > +
> >  /**
> >   * struct cio_dac_iio - IIO device private data structure
> >   * @chan_out_states:	channels' output states
> > - * @base:		base port address of the IIO device
> > + * @reg:		I/O address offset for the device registers
> >   */
> >  struct cio_dac_iio {
> >  	int chan_out_states[CIO_DAC_NUM_CHAN];
> > -	void __iomem *base;
> > +	struct cio_dac_reg __iomem *reg;
> >  };
> > =20
> >  static int cio_dac_read_raw(struct iio_dev *indio_dev,
> > @@ -61,7 +70,6 @@ static int cio_dac_write_raw(struct iio_dev *indio_de=
v,
> >  	struct iio_chan_spec const *chan, int val, int val2, long mask)
> >  {
> >  	struct cio_dac_iio *const priv =3D iio_priv(indio_dev);
> > -	const unsigned int chan_addr_offset =3D 2 * chan->channel;
> > =20
> >  	if (mask !=3D IIO_CHAN_INFO_RAW)
> >  		return -EINVAL;
> > @@ -71,7 +79,7 @@ static int cio_dac_write_raw(struct iio_dev *indio_de=
v,
> >  		return -EINVAL;
> > =20
> >  	priv->chan_out_states[chan->channel] =3D val;
> > -	iowrite16(val, priv->base + chan_addr_offset);
> > +	iowrite16(val, priv->reg->da + chan->channel);
> > =20
> >  	return 0;
> >  }
> > @@ -106,8 +114,8 @@ static int cio_dac_probe(struct device *dev, unsign=
ed int id)
> >  	}
> > =20
> >  	priv =3D iio_priv(indio_dev);
> > -	priv->base =3D devm_ioport_map(dev, base[id], CIO_DAC_EXTENT);
> > -	if (!priv->base)
> > +	priv->reg =3D devm_ioport_map(dev, base[id], CIO_DAC_EXTENT);
> > +	if (!priv->reg)
> >  		return -ENOMEM;
> > =20
> >  	indio_dev->info =3D &cio_dac_info;
> > @@ -117,8 +125,8 @@ static int cio_dac_probe(struct device *dev, unsign=
ed int id)
> >  	indio_dev->name =3D dev_name(dev);
> > =20
> >  	/* initialize DAC outputs to 0V */
> > -	for (i =3D 0; i < 32; i +=3D 2)
> > -		iowrite16(0, priv->base + i);
> > +	for (i =3D 0; i < CIO_DAC_NUM_CHAN; i++)
> > +		iowrite16(0, priv->reg->da + i);
> > =20
> >  	return devm_iio_device_register(dev, indio_dev);
> >  }
>=20

--M7k0kYrMKQquTa5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYqi0LAAKCRC1SFbKvhIj
KwubAQDCBfPf574F1urURdZ+BjUNIUM0lqyWwuNm1L4ezTWehQD/S/iJ3N3FK1LU
pWU+3u6BD2L1q0oiTQmKa+HFQ5+YLwE=
=Nm6o
-----END PGP SIGNATURE-----

--M7k0kYrMKQquTa5e--
