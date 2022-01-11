Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E937548BAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbiAKWtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiAKWtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:49:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C443C06173F;
        Tue, 11 Jan 2022 14:49:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so8109691pjf.3;
        Tue, 11 Jan 2022 14:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=21jKrUVkF66YiKV2sXrARGR2A/0nZBDfj7NXOCvKelA=;
        b=nXisYx8ZBeSjDj6qmYeFs0Yqef21/FqVlz4k8H5KmfMkzOYxFEblle1Nw19AdU847l
         Gct9CO6zeDGHSpuXie0DfjveD1MAWSmSfMXa8rhbHd02jBDtBcIiWSEQpXK8zcRT8dWK
         n8kNWQ0FqN21whTeiWu+pTSLMjVIYQfMgv3vkDxCnoWMmbKssGELswfHxYHbvdkt4sdK
         AsEGzajg9HvNp2ODegvDffZT0mggKx2eCDS6GZ8oWMiHs5MKA9lFPjcqItSlAszGrD8R
         6PQqsY0rqSPkCikGk3rVcT/BNmInBqtQLkmFbFsSg3dwHGyWprJSmCIC+6PEojD43FZ6
         Oc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=21jKrUVkF66YiKV2sXrARGR2A/0nZBDfj7NXOCvKelA=;
        b=bKknW1Ils4lfW26XklnI/YmNiRPBM9jhw6DNs+uJCDDXaHbduwo62PoJdlaIdpiVdd
         Vs74yJcQ/1dvxqGeUC/1EosY7eNdvweLPsAMlSRSUkIEEGS2ZMI57qgTlDSwoNcNJwGz
         1Z1aQSEi3NxXreVMk6PkF+jROfYAQrVE0VTOQGuEccj6UHliEGkV7PYdVw/wYwK/6WzB
         ZAvR85r0YxCaTrMCG/WUVJooCyyIAOg6vRGuEpZzD/QxLE5lgK+P7Hm9KhMaW0mfOc7A
         KvEK7ygtmN9IzjlZ8qkv3PPGqkpHEdCQZtLuANpdBGEVzNiNMHI+sziD99jfcsSUwBSZ
         ihFA==
X-Gm-Message-State: AOAM533g20JS3vhsQhay6xzhOLJw7O7BtsXLq3NtRc9ORfodv3kurMuH
        +xOS3jB4yuc/KxgPLYcqhNk=
X-Google-Smtp-Source: ABdhPJxVdugbSGoBel+nf3MnQAUyXgpAyv9vsTtOpLV+sv1ywOHc+fsJPl/QAC+Cnj+s/sBPTuan6g==
X-Received: by 2002:a63:a1a:: with SMTP id 26mr5909913pgk.212.1641941339672;
        Tue, 11 Jan 2022 14:48:59 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id v15sm651825pfu.203.2022.01.11.14.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:48:58 -0800 (PST)
Date:   Wed, 12 Jan 2022 07:48:53 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] counter: fix an IS_ERR() vs NULL bug
Message-ID: <Yd4JVSTUcFVFNhaJ@shinobu>
References: <20220111173243.GA2192@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oLfUn8xMOtC9EV9z"
Content-Disposition: inline
In-Reply-To: <20220111173243.GA2192@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLfUn8xMOtC9EV9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 11, 2022 at 08:32:43PM +0300, Dan Carpenter wrote:
> There are 8 callers for devm_counter_alloc() and they all check for NULL
> instead of error pointers.  I think NULL is the better thing to return
> for allocation functions so update counter_alloc() and devm_counter_alloc=
()
> to return NULL instead of error pointers.
>=20
> Fixes: c18e2760308e ("counter: Provide alternative counter registration f=
unctions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
> v2: make additional style changes
>=20
>  drivers/counter/counter-core.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-cor=
e.c
> index 7e0957eea094..869894b74741 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -90,10 +90,8 @@ struct counter_device *counter_alloc(size_t sizeof_pri=
v)
>  	int err;
> =20
>  	ch =3D kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
> -	if (!ch) {
> -		err =3D -ENOMEM;
> -		goto err_alloc_ch;
> -	}
> +	if (!ch)
> +		return NULL;
> =20
>  	counter =3D &ch->counter;
>  	dev =3D &counter->dev;
> @@ -123,9 +121,8 @@ struct counter_device *counter_alloc(size_t sizeof_pr=
iv)
>  err_ida_alloc:
> =20
>  	kfree(ch);
> -err_alloc_ch:
> =20
> -	return ERR_PTR(err);
> +	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(counter_alloc);
> =20
> @@ -208,12 +205,12 @@ struct counter_device *devm_counter_alloc(struct de=
vice *dev, size_t sizeof_priv
>  	int err;
> =20
>  	counter =3D counter_alloc(sizeof_priv);
> -	if (IS_ERR(counter))
> -		return counter;
> +	if (!counter)
> +		return NULL;
> =20
>  	err =3D devm_add_action_or_reset(dev, devm_counter_put, counter);
>  	if (err < 0)
> -		return ERR_PTR(err);
> +		return NULL;
> =20
>  	return counter;
>  }
> --=20
> 2.20.1
>=20

--oLfUn8xMOtC9EV9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHeCUoACgkQhvpINdm7
VJIVuA//SVLH57LkeS1FkN5e+LkoLiZFN2RImHGDSdhRQnsWLB1lssun+R79IZJz
3G3ZrW6uy2AKq13kYDNxBeZmgKH1fHwLWgBsyErHU0BRkrJZExZVlULHEbVPFW6F
58FO5RHTFxPLl6VdLmjD99IC1nMPYvoGhgJ+qJdhwTOupErvDxw9jVDq6CvNTTEv
H5aiAt5LLSaNqSFw+QT01EMe2Q5N3FMQWqwjnox3FnJPp8AEsN9Tlzo4gr3q8ne9
2zUf4ias2w5CDLAsRj6CJlxEXwokViRljIXGPem4eF0LRXqo3Fl695qwo/XPY9kk
pcJ0JV/hl9RVHyo2sXNU/NS7rv0IiVT0TXtL91b8+zYywxnzrArF0XliPta+VKwI
QCrSzmi7UV4u1zSHH3Webn+RTpUlGBVYPPoyPBYevWLzrfw5GvJ86a8godwKGXXf
HltY1sVb3av180/f2l9VbPOgLitiIAyg6zwSU6OrpHin7cIlo+oInJuLCQtncCtI
JtLdRuAZNGXJQcepePS916OHLAK7we7BJHZ/U3qM1VKnIHeQDZJuB5WRFbuwlmIi
8FNz9egAUZ1z4g0wk+EzWoz18whgM35jCGbfWznFRDFT6iKlikSqoPSLfoCk+CPP
cBRpEKEkwiLJyN9GYEvZIg6ia+hogkjH3ta9zdrefYzX9GxF59k=
=9Edj
-----END PGP SIGNATURE-----

--oLfUn8xMOtC9EV9z--
