Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E3E48107F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 07:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbhL2Gri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 01:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhL2Grh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 01:47:37 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A638FC061574;
        Tue, 28 Dec 2021 22:47:37 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i8so9269398pgt.13;
        Tue, 28 Dec 2021 22:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mxoJPosDGQnC4wJms+vZpbVMvtrVmDJpQDC64M585K4=;
        b=JUhdeH9UPyvt6D/Cbyj8bw+VAlC4tQqnez5p6IwZiGrnde2j3wq2I5qb2cqsMAR8m3
         zJoDdBgWuVcql0N8osfh0xE4oAC6M7LvGLi3kfSmCpotf3L4fsvUBYAgJyV9o7Vi+12m
         BjmwnkJhrXl9JMbvpTJlmQEZPJKTVSiAvhpskeLCeaumAk9b2CcfNPHRWNdDt3MRVUOQ
         5xsPrggtD7116wQwh2y6mtdqBQBG0UeD7fc8v4w92gE7FvrKccpUnubG174pirhWKJXQ
         wiX4Ld9L9m9D8+7Nwjy/RcIo74dzvlx+La4IVA/ub88UDyCme6eEgCqCCcOiaYr/1I6e
         z/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mxoJPosDGQnC4wJms+vZpbVMvtrVmDJpQDC64M585K4=;
        b=7oecX8SLObPQaSd2LL6iuhwc0Gurfm7tPV2f9WQ5nswxiI41/vlJzIOJXDBndMfUhk
         T5XwDxrocPzlVZ9xnMTTRF6MSwLlBykMk+HIcPQA5CPMlsKtIKKNusb9h0vPcoGQh/yY
         Dssn0AgANjC8M8ZoIVNJNYJk/xoogXaYfpcGIiMXg5jlwCdxDQG8f1X6yGPCFZ0sL2bZ
         ofsiJqjsCHWyIqP5CM4YQdWTthbkrq9JKWZUjvbUOEiVvShnzLNtdnbIaa/1isHJqfHh
         DSeCKp0NWMsXXeQjcXW+BINr60BYhAf5NjmG1cA32vW+g3vSzVOTQd5nYubTr5EDDC9n
         Sx8g==
X-Gm-Message-State: AOAM531eKROtCI5Tj3xSltmHtf/q3htAR+NtGUsOg6WATXxuenYAoAN/
        VzCKPMrCNwNZxA7QyIZbnec=
X-Google-Smtp-Source: ABdhPJx2gbInvGtiPzpuA4FfrItLA4Y26uwmlRjQSQd/hPGkRsdUdXUsKCXFhrn4Z/5s9l/e9qJkGQ==
X-Received: by 2002:a65:460c:: with SMTP id v12mr22116378pgq.58.1640760457023;
        Tue, 28 Dec 2021 22:47:37 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id j23sm18574289pga.59.2021.12.28.22.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 22:47:36 -0800 (PST)
Date:   Wed, 29 Dec 2021 15:47:30 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/23] counter: Provide a wrapper to access device
 private data
Message-ID: <YcwEgi8o1PhSjPk3@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-5-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GYEyXTeJQnHhqWPA"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-5-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GYEyXTeJQnHhqWPA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:07AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> For now this just wraps accessing struct counter_device::priv. However
> this is about to change and converting drivers to this helper
> individually makes fixing device lifetime issues result in easier to
> review patches.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/counter-core.c | 12 ++++++++++++
>  include/linux/counter.h        |  2 ++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-cor=
e.c
> index f053a43c6c04..00c41f28c101 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -45,6 +45,18 @@ static struct bus_type counter_bus_type =3D {
> =20
>  static dev_t counter_devt;
> =20
> +/**
> + * counter_priv - access counter device private data
> + * @counter: counter device
> + *
> + * Get the counter device private data
> + */
> +void *counter_priv(const struct counter_device *const counter)
> +{
> +	return counter->priv;
> +}
> +EXPORT_SYMBOL_GPL(counter_priv);
> +
>  /**
>   * counter_register - register Counter to the system
>   * @counter:	pointer to Counter to register
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index b7d0a00a61cf..8daaa38c71d8 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -329,6 +329,8 @@ struct counter_device {
>  	struct mutex ops_exist_lock;
>  };
> =20
> +void *counter_priv(const struct counter_device *const counter);
> +
>  int counter_register(struct counter_device *const counter);
>  void counter_unregister(struct counter_device *const counter);
>  int devm_counter_register(struct device *dev,
> --=20
> 2.33.0
>=20

--GYEyXTeJQnHhqWPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMBIIACgkQhvpINdm7
VJJumg//dxn9fddbnyZDf2MouF1+B0ByUCMreokFTjoHwxrgn5B0lNU/+ttNwa9f
dKThHlBZ8+GHK5g2l9ah97dT76XsDkB7jtO9BTWM2nweTQ5/qZ+gP3YXhq+ONP3r
K2G+g/sVB57UFMZ77Q3vLVr76qvWAqKGE6/XIJ1S1dqjK+uSXCDRqd7VV+YWYnxe
tKThEtzoLQxIWRUPGlsjw/M0+V5024qy48YlBoMyQFbnKAiXMtbClsqXzI0q04/o
Koibr1LHCFEpkvgC+wXH3XGbDl6m1xP7tsqpEeOWZ8BYOXzwOemLoppMLtPhL7db
8JmU1PSqYf2FfRLfF5B0tOgk3v2OTrTjOzqj8LGm7FvEZaMRumwwuM24zorUyYuz
VVlRZ8w6sRsoljDol7v+jBCigxEKNI+mAk/4gOZqPHhl3Xj5kQ1dMAGSNcVSk4On
1FCnuexU2I+JMFr3nWHY+hLbAsUDJnvDXL5atFqaj6eyWTZBzLB7k8b0+Qgn6fPI
+b2TZZ1pFFAJQM9w9TXPYhQIoJIvos2wZ+IQzpyKnkCaTpZUcktowmHgNQVFCbBo
jGZJKaH1ZbEU3x5/KLVBtc5+zCVNTVB67GpwTCmc6jut1Qg8ivDuY3N10jJdtwoa
lI/pIQR5BjJUW99lrjTOb0mdlD7/96Ff3x7JCcoUfS9Z4fymtIg=
=f+KW
-----END PGP SIGNATURE-----

--GYEyXTeJQnHhqWPA--
