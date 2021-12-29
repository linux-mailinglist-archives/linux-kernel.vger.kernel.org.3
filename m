Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B8E4810F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 09:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbhL2Iaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 03:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239341AbhL2I3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 03:29:32 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4C7C061574;
        Wed, 29 Dec 2021 00:29:32 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 8so17933441pgc.10;
        Wed, 29 Dec 2021 00:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gwBHFdB7N1ja2m4oe0z47QdOsIrbOnaS4zIyZBYTApI=;
        b=fGY+Utp0FiqPbbc2mqo0byLeoZt9CBAb4WCRsbWXY2b27soIAOdJr6t02dFmu5kmFw
         rNJdSsY2tuWl/H/dumd6KQ/dqakz/ZoHoTzUoIXzvoJ7Z29Qz5vyUnbY2uuAMGWMNSv7
         ax+DPfwtXzIhIb3SLFk5CubIidQNs2MwYkQEMJnv4pbSL0mMtnw4cJwej5CwpLW3ZuDE
         VPyrbDLx4N+w05bhQ7luOcvaxfYo9Q1gSnaxxWnxXoeN3PyxdyjJEmJe327cdnA+gJs/
         vGSf+y+jMBo0X8P0dGPvQi3UpoVv7tAuGVXjy6IYjVUgbRpTmWH1rl0MWIkArPftzKFd
         mzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gwBHFdB7N1ja2m4oe0z47QdOsIrbOnaS4zIyZBYTApI=;
        b=c/4S+ek3k88cqT4Kiy/foQUE/4XL/VgrOK3lI2ZqWhM+pzSKQ87VBgPNtdoJBuICOz
         0jmx1CPfE9kQF9iRRh0x3T6vFsK+9yNyqMK6RIiL4EARv2ayA/n9OVRg3x8qjNnA/krm
         HXJsGtpjRsYSBfRstg722gdtvAPlb9ab6J2DnV7AkgpZbBznp48warT+qcVSjEjy/9Gg
         Wal2SpVIS4d0Yi9U2xV38taHPoap0cazvCOgwABQeytAiEOiC0kED2Io1fGNk+cMDrhg
         SOjyBOK45FrKzgkesZoW/oDOjExaYOxdT3zXaBu+qIG0HX7eNxVjQBgNrJT7C4BUv82y
         inwg==
X-Gm-Message-State: AOAM530st1dQvfORXz63c8J/KdsTf5IlI5URjwDjxuW5qfTY7Qf9/2Q4
        DpC4aFf+WKJtK9iPrGRNWmY=
X-Google-Smtp-Source: ABdhPJxqkKC4FxP0j/HJ89cN4a6WbeCd/N6jA6XodqgUEv1EOtDjHocpIhUy8YbIJ80ZvTTQqzl3mQ==
X-Received: by 2002:a63:81c8:: with SMTP id t191mr22348762pgd.598.1640766572265;
        Wed, 29 Dec 2021 00:29:32 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id i68sm13614268pfc.151.2021.12.29.00.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 00:29:31 -0800 (PST)
Date:   Wed, 29 Dec 2021 17:29:24 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: Re: [PATCH v2 17/23] counter: intel-qep: Convert to new counter
 registration
Message-ID: <YcwcZMO53T+EVlLM@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-18-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sXfI5985ago25I36"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-18-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sXfI5985ago25I36
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:20AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This fixes device lifetime issues where it was possible to free a live
> struct device.
>=20
> Fixes: b711f687a1c1 ("counter: Add support for Intel Quadrature Encoder P=
eripheral")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/intel-qep.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
> index 8f84a48508ac..47a6a9dfc9e8 100644
> --- a/drivers/counter/intel-qep.c
> +++ b/drivers/counter/intel-qep.c
> @@ -63,7 +63,6 @@
>  #define INTEL_QEP_CLK_PERIOD_NS		10
> =20
>  struct intel_qep {
> -	struct counter_device counter;
>  	struct mutex lock;
>  	struct device *dev;
>  	void __iomem *regs;
> @@ -392,14 +391,16 @@ static struct counter_count intel_qep_counter_count=
[] =3D {
> =20
>  static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_=
id *id)
>  {
> +	struct counter_device *counter;
>  	struct intel_qep *qep;
>  	struct device *dev =3D &pci->dev;
>  	void __iomem *regs;
>  	int ret;
> =20
> -	qep =3D devm_kzalloc(dev, sizeof(*qep), GFP_KERNEL);
> -	if (!qep)
> +	counter =3D devm_counter_alloc(dev, sizeof(*qep));
> +	if (!counter)
>  		return -ENOMEM;
> +	qep =3D counter_priv(counter);
> =20
>  	ret =3D pcim_enable_device(pci);
>  	if (ret)
> @@ -422,20 +423,23 @@ static int intel_qep_probe(struct pci_dev *pci, con=
st struct pci_device_id *id)
>  	intel_qep_init(qep);
>  	pci_set_drvdata(pci, qep);
> =20
> -	qep->counter.name =3D pci_name(pci);
> -	qep->counter.parent =3D dev;
> -	qep->counter.ops =3D &intel_qep_counter_ops;
> -	qep->counter.counts =3D intel_qep_counter_count;
> -	qep->counter.num_counts =3D ARRAY_SIZE(intel_qep_counter_count);
> -	qep->counter.signals =3D intel_qep_signals;
> -	qep->counter.num_signals =3D ARRAY_SIZE(intel_qep_signals);
> -	qep->counter.priv =3D qep;
> +	counter->name =3D pci_name(pci);
> +	counter->parent =3D dev;
> +	counter->ops =3D &intel_qep_counter_ops;
> +	counter->counts =3D intel_qep_counter_count;
> +	counter->num_counts =3D ARRAY_SIZE(intel_qep_counter_count);
> +	counter->signals =3D intel_qep_signals;
> +	counter->num_signals =3D ARRAY_SIZE(intel_qep_signals);
>  	qep->enabled =3D false;
> =20
>  	pm_runtime_put(dev);
>  	pm_runtime_allow(dev);
> =20
> -	return devm_counter_register(&pci->dev, &qep->counter);
> +	ret =3D devm_counter_add(&pci->dev, counter);
> +	if (ret < 0)
> +		return dev_err_probe(&pci->dev, ret, "Failed to add counter\n");
> +
> +	return 0;
>  }
> =20
>  static void intel_qep_remove(struct pci_dev *pci)
> --=20
> 2.33.0
>=20

--sXfI5985ago25I36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMHGQACgkQhvpINdm7
VJJyJhAAvxAkl4VyoW+tNeb1hO+Dwn5HgtpF+7nZHqI3i+WcUSK7rFymR+q3iuZX
dQna4F8CEpE35rbA1b/wgY3o8dK1ARFt+f1xVZo4PmIsLqspcRp6rq7MFeDbeOwB
tn8In+bAXnyJM6uLjiAmjY3N3vXGKjhGTGAqgZLNrbAACYIyPfQJLlEcLSoOEfYB
Tn/ayRhVqVJj1a+c8pO2p9zmEa3mLmQQzaqS5Ie1BopKv7Qiza+UqRNqW89d0SUc
UEnzXswufE10Ao9aH9en7cG2WBePzqA0Fsl0uVvD65wcVorGOIEGC7e8xZ8nPLcA
4OMhufi3HOQsikFgeePrVoOkc1w7NW615A7yraDus77rcV117bLZY2mkFZfPUOfp
GNL0uORe9GQ3nMlmnuj2/27x0Xf7eHBs8bHgwK5CjNwqLCZjgevow9ii121T/AXm
feNSb3OObzshC87LNy3F+RRCB4M1Fk/ltvvybMIL06bAokWQSOAe9IEhTSF01iLQ
SVn3Mwuzgz25xdh1rIHbATSK2lqwPazhyrlgkwTh1MRJ+kaz/hgC6+6uEp5iCFf+
OYMaAzUGXgFP09vO6lbMQ8ogWCu35UaLOfYAMqjXKzstwkopBOv2ECF2VGUHEQHf
WGpeQbT+8MJ2lTN02EUvpOChz+b0IZ02JFM+s+gHnLDftxDxJrA=
=2l70
-----END PGP SIGNATURE-----

--sXfI5985ago25I36--
