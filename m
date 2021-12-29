Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A24810BA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbhL2Hg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbhL2Hgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:36:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE45FC06173E;
        Tue, 28 Dec 2021 23:36:55 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i6so9291703pla.0;
        Tue, 28 Dec 2021 23:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zs/GVRqeKa79+ZvaYojti+jCFFp4hFnSa7ptWWiB0sc=;
        b=Y3hF0TBVV3GohHneQ5WAI/Fu4ZIF3i6HW3e7423kPc1Ldo3z2WvMzmacnzLoYfsYFn
         UQufyIQxehf5juWwrmNDSXY1AH4kFvpfCFxR7axLi9Ap+A9y7JqADpo90DSRq+fxWg0u
         h6gyWMnZ7qQzucTGmDYI4QklBQAzg4Z0+JFodvVIKPYY19ojRzJPVHTRnlBgXEh39Svt
         zjYglnVGCIUfGi1nR3mclvEwasJ+fXXjnuZfn29lTFqx82UiEzmYnBen2N9G4cf8o5Hd
         Y+q+UWeeBz6LHy0hA98r+eWTR6poK+M34nZZ+tKHReq0fS0QgPJ2fFgRgjtCA3c6VW+B
         kyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zs/GVRqeKa79+ZvaYojti+jCFFp4hFnSa7ptWWiB0sc=;
        b=EZm4kq3v+1rXdmicMk8FHi+ZCHjkY0ihvQUXwThWGkwUzNBjATSzi63NbF7O0biaAP
         YGj+OrkaqZxI5LXqSiGNSI8K+itZcYsUcYv49mo1g9KmZsuzcZSdu84oIDODzafZ6eVt
         pvpbg2UjL+BLC3VJPh9YeVqKwlp0NAMrWSZ9TlHTtc40dYtxCoYPnCjLwoFXRiYtUQbm
         oA9eGVTwe32TGaUztzn0ANZT99iVQfUlD+k1wNduTtGQwMALQwd7ujai5IRvQQdqLzHz
         nx/heynVs6gNH1rAI/MIAN4uZyvo+qRaBDaafzt5vEiOXqzwDDzCieSQAFym/FyPWTD6
         KrqQ==
X-Gm-Message-State: AOAM532dfxLNUzRUT00BjHbLlWW3DYljcxCHnbYnLsZf17IatUC9KKwb
        fSW9KBF+oA1ztIx5fp7z+AU=
X-Google-Smtp-Source: ABdhPJwGR8DxjUqzkQlMRpvpApTn7tiAWCjTqUVCdvt3xK6KzhpjEmj7CJaJBFoNlaDiC87SsmeRtA==
X-Received: by 2002:a17:903:2306:b0:149:296:c9e1 with SMTP id d6-20020a170903230600b001490296c9e1mr25101371plh.10.1640763415419;
        Tue, 28 Dec 2021 23:36:55 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id f16sm24571958pfj.6.2021.12.28.23.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 23:36:54 -0800 (PST)
Date:   Wed, 29 Dec 2021 16:36:38 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v2 09/23] counter: ftm-quaddec: Convert to counter_priv()
 wrapper
Message-ID: <YcwQBjD4e9qVKL+2@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-10-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5GfMtX2wQyLOwk+v"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-10-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5GfMtX2wQyLOwk+v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:12AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This is a straight forward conversion to the new counter_priv() wrapper.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/ftm-quaddec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 9272f7b58beb..f5d92df6a611 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -118,7 +118,7 @@ static void ftm_quaddec_disable(void *ftm)
>  static int ftm_quaddec_get_prescaler(struct counter_device *counter,
>  				     struct counter_count *count, u32 *cnt_mode)
>  {
> -	struct ftm_quaddec *ftm =3D counter->priv;
> +	struct ftm_quaddec *ftm =3D counter_priv(counter);
>  	uint32_t scflags;
> =20
>  	ftm_read(ftm, FTM_SC, &scflags);
> @@ -131,7 +131,7 @@ static int ftm_quaddec_get_prescaler(struct counter_d=
evice *counter,
>  static int ftm_quaddec_set_prescaler(struct counter_device *counter,
>  				     struct counter_count *count, u32 cnt_mode)
>  {
> -	struct ftm_quaddec *ftm =3D counter->priv;
> +	struct ftm_quaddec *ftm =3D counter_priv(counter);
> =20
>  	mutex_lock(&ftm->ftm_quaddec_mutex);
> =20
> @@ -162,7 +162,7 @@ static int ftm_quaddec_count_read(struct counter_devi=
ce *counter,
>  				  struct counter_count *count,
>  				  u64 *val)
>  {
> -	struct ftm_quaddec *const ftm =3D counter->priv;
> +	struct ftm_quaddec *const ftm =3D counter_priv(counter);
>  	uint32_t cntval;
> =20
>  	ftm_read(ftm, FTM_CNT, &cntval);
> @@ -176,7 +176,7 @@ static int ftm_quaddec_count_write(struct counter_dev=
ice *counter,
>  				   struct counter_count *count,
>  				   const u64 val)
>  {
> -	struct ftm_quaddec *const ftm =3D counter->priv;
> +	struct ftm_quaddec *const ftm =3D counter_priv(counter);
> =20
>  	if (val !=3D 0) {
>  		dev_warn(&ftm->pdev->dev, "Can only accept '0' as new counter value\n"=
);
> --=20
> 2.33.0
>=20

--5GfMtX2wQyLOwk+v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMEAYACgkQhvpINdm7
VJLorhAAueGE1YkCbKcBJ0GkQ+ziTvzAXz3WH+zh1GtwVCa5OmKLbrnSGlk8f+6P
Z7i1tBXu+MUEfAbD6ThQ73EjtHEGzsdjRYvKjVJ1Iuzp5k8SYZFWvuoif2NHi4iV
xGQJ5WJbfGWW0E4Hs16DAuTpkchVudBLtlO7WZtMrQNI4xlXFbrh1M80WsGM6KvC
suyDju2tAJjSlTqpF1kEhFwccG1dkyAkL+je8KNe7QBVS1Q28/arPXC+YfY6TS69
I3/Tf0uwougtSNAGSxJJtbPIcF6n8CQKUqQUw1C7jfsh7F8T51NHoVkF2VHw80QZ
5jJoRO/gXdrO3xqa9pFFLNW4apDJk8BJn3yxhHRA69ihxpUIOIFwmFL5MhgMCe9e
+cidCTsTqcyja5f/choSbanq1YhxEkvsm2xm3rbhiefo+sK1DHtrNNdHhi1BeLE6
HciAs6lSqPNKI/JKhZKZunHTNuboCnE2nAAkYorZjCP0nOKsv6lbfH/eQ0L7BJkA
9yYrYHqMZWOAvdGnAVRT3XP+aKpXk4oO0PrLIeE3/TRE5Zz5gFf5nDunvkaimOgx
3FkRGK7sHw8ILzKTvrhaUgD4fxRLT98MgxoipdboHVS/C6QKqTfDM5JjfapmAJ3T
FvY/mY9t0lUJcoS8inAiPCoD81jTNlsQMBJ9HPCvTanImuqTx94=
=S9bS
-----END PGP SIGNATURE-----

--5GfMtX2wQyLOwk+v--
