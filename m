Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7EF048107B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 07:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbhL2Gmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 01:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhL2Gmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 01:42:45 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1FFC061574;
        Tue, 28 Dec 2021 22:42:45 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id v13so18029572pfi.3;
        Tue, 28 Dec 2021 22:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hk8i7ak6MSm4wMcB3VcMVqLqAWYqZ85wJLFDuillMdI=;
        b=NPcS2UrxPYEu3eN97frPKqJVEajrFMsMJ4UrzE4cntmJX2NbIDFH3VjlqcMGnZSK59
         UK7z3ko9ts+GFNQTphRPleDp/nzYh5XIXXdNPvkZh1PtWHWYEHMZmE3cK5qP3nMcO3XN
         oLwUsUhMQjSAn9uCjrj9BknwmrYoXlzswI+VqbJBRaOG9XzYc+x9T+EIseREjWM0R7IT
         kpEnUKmmDZGDX7zbZRqGdMBsRpDqS7JGIR6lHTguWiHmGlHbRtri2kYY3zJhYJXVVgls
         q6ChmtvkAl06LZc1h/iLzNRo/YhTqIXcxDka8Xf9LHJGVsgqbsB+/shWwc8BcJQR+oG6
         YvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hk8i7ak6MSm4wMcB3VcMVqLqAWYqZ85wJLFDuillMdI=;
        b=wisBs9dkWMdEr6pahQzYax5UGbbuSsk/Gvafds8JHy2fc/EO/uFN1fUHMKStAPZllV
         slVfk636UBiRs2jUt287tE1lrRfTR5KfTaFpTWQs2NxZIF/GLin504MHHdENSE1o+dOA
         /3d9Cm2PrBc71+f4SNcjd7IiS1LeKKWRo7YCQg7UkwRzuTPPtjNY+KJZlR3EXI3nXY8J
         TCwsoK1cJ5dYuBRxaweKI6nRb1I78jO+D7KtL2Hhkr3sDIYwXmC8s+G7/BjZOq88H4pz
         qRaGJrK1u6ylm4syrRMx4XtWdX3FNhppjkdAsdmhleHb8OLPxyEAjVUAIKaL672+ZyWw
         x+Vg==
X-Gm-Message-State: AOAM531CyDXe6ib4h6PmUf5eieKigeWEB44w1Ko4UTXVul6rAGz8gGIb
        eyyqPVUiN6t6HzHCUc8Tqh0=
X-Google-Smtp-Source: ABdhPJxMkMZ2N+iqR9miZ/YJj5nk+OVhSlb93n+1GscUIWsrWNRzxjEG0pIdDWNR6cswj4jt+G50cw==
X-Received: by 2002:aa7:860d:0:b0:4ba:93fc:ca87 with SMTP id p13-20020aa7860d000000b004ba93fcca87mr25724526pfn.6.1640760164691;
        Tue, 28 Dec 2021 22:42:44 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id x8sm24393981pfh.210.2021.12.28.22.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 22:42:44 -0800 (PST)
Date:   Wed, 29 Dec 2021 15:42:32 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v2 02/23] counter: ftm-quaddec: Drop unused
 platform_set_drvdata()
Message-ID: <YcwDWJrEfot25Dt+@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAkbqrEutrL+NjXR"
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-3-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iAkbqrEutrL+NjXR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2021 at 10:45:05AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The driver doesn't ever use platform_get_drvdata, so drop this unused
> call.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

By the way, it should be possible to remove pdev from struct ftm_quaddec
because &ftm->pdev->dev is stored to ftm->counter.parent and can be
accessed from there if needed.

> ---
>  drivers/counter/ftm-quaddec.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
> index 5ef0478709cd..9272f7b58beb 100644
> --- a/drivers/counter/ftm-quaddec.c
> +++ b/drivers/counter/ftm-quaddec.c
> @@ -269,8 +269,6 @@ static int ftm_quaddec_probe(struct platform_device *=
pdev)
>  	if (!ftm)
>  		return -ENOMEM;
> =20
> -	platform_set_drvdata(pdev, ftm);
> -
>  	io =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!io) {
>  		dev_err(&pdev->dev, "Failed to get memory region\n");
> --=20
> 2.33.0
>=20

--iAkbqrEutrL+NjXR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHMA1cACgkQhvpINdm7
VJLzWA//aQSbn5j4o8WDb8NbzW0ZD/17/JxOr42DBlC03forlAWkKW7hrBuO8fL4
WPc5o/vSNryn+PKLlRAWBLiWskUU49/M1wzabPptph78zRmcfr/l5Vyi1EVhkx57
gfLUXmisPHgFB/ftP8FVaBi/xzE4+P9MpQ1igHMSWRddJBrWBqAWNmw79VacraGL
lP1+F/uxQIshFnDdoZa+9eV42Eq76gvlXAIS74q/yqpTDww5WlWGn9lx+OD4zH3L
Ukj9o3TF+sKmZ/dvv5IqQZQm9JSa7aVyC01EhgF1lFXgmFgAPQvY7MlitsbYOQuQ
O7jEsRgzgWwldbYkKKvc9oMZFI9M/t2tIi/jVD3HZdXM0kpJF9V//XHMnHlEbF8w
5+KDiH63kLLXrtqokTIDatQzbhabrvWCYagFMeibdZFSuGKghOohMJYifCRxSJbi
xVV6nGF4E8bKkcJUWOC78VgJLK2f1xoPi+ULZtOj0HaZ379lMy0PA60LfXvPOAwE
Tz+HbKd4NP2AweJNn1ho7eHmFvXQj/QhWO0JTPnkdchD3QUDzzgVdZaGgnIPRIkw
dXHyda8F/rgLoQ1rqF5ZZIALZh+vccc4mt+iad7wwhtrca8UYSzGObB1SQSCbB61
UwvL/UQ4b1xNmIeXAmGQB9vcDxQ4ubPKUit9EMbF7dOltL6IESo=
=NbKA
-----END PGP SIGNATURE-----

--iAkbqrEutrL+NjXR--
