Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A228549CA2F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbiAZM6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:58:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36196 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241575AbiAZM6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:58:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B558B81D05
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 12:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F57DC340E8;
        Wed, 26 Jan 2022 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643201885;
        bh=wwU+tnK1eUMgwaHuPMF+WVqKYm6bBk9k4K2YQcP3bjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8GAxMNUriS6oQyq9vKrcrtTrp/dW/3M66NWvd7HkQc94AGS3d8JeBDz/xEz6Yoi8
         Uw2Qbwjbfl4czkluzZXEZl8yrgYLYbNOtyRObL9qwjX7mR83Sqf64Dn/YrvGhqeMt0
         ecu0wpmXEQ7fJg9f6u2M4WrlLxIQVrltbgSDQxIb7dfGy+JSebNDe4u+sF+2k/2h5N
         EQAYUMya973vEi4HDML7m9G4ceZeMTFnN0CAK3BxmeWfFI7YULrScjRPQ1KPs3kdTw
         3myYN7YI7b26LgkUAL/P0DmUkop+wF04eQADykCqWeQNWyMd9kuE7hnmEVMsK4YWC6
         XK7w6GFjYxupw==
Date:   Wed, 26 Jan 2022 12:58:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Eric Millbrandt <emillbrandt@dekaresearch.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl: Add missing error handling in
 pcm030_fabric_probe
Message-ID: <YfFFWSVgnbL6ETxo@sirena.org.uk>
References: <20220126113307.1673-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NmCm27cBeyhb9V5C"
Content-Disposition: inline
In-Reply-To: <20220126113307.1673-1-linmq006@gmail.com>
X-Cookie: Use only in a well-ventilated area.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NmCm27cBeyhb9V5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 26, 2022 at 11:33:04AM +0000, Miaoqian Lin wrote:
> Add the missing platform_device_put() and platform_device_del()
> before return from pcm030_fabric_probe in the error handling case.

>  	ret =3D platform_device_add(pdata->codec_device);
> -	if (ret)
> +	if (ret) {
>  		dev_err(&op->dev, "platform_device_add() failed: %d\n", ret);
> +		goto exit_device_put;
> +	}
> =20
>  	ret =3D snd_soc_register_card(card);
>  	if (ret)
>  		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
> =20
>  	platform_set_drvdata(op, pdata);
> +	return ret;

This means we'll skip the cleanup of the platform device that you just
added if card creation fails:

> +exit_release_dev:
> +	platform_device_del(pdata->codec_device);
> +exit_device_put:
> +	platform_device_put(pdata->codec_device);
>  	return ret;

It needs to return early only if the card registration failed.

--NmCm27cBeyhb9V5C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHxRVgACgkQJNaLcl1U
h9A7WAf+JZkt/zEa/dvgMZU5Q/VVk/9sewHPs0PgMWrUdfeW8UimVO//E3AAX9UK
ht2lweYpZ86PFZBtz5nsNO08huPNbN6qD5TcNN4f1dIZXUaqwV88pQPPS7yAsVQD
LIOhBTfYasGQXEBjClW54BzHLZ/6EjPijoBcYNyc65+ys2AJxeScoiUUpNWFdqsH
FTm8URWPkzMYEbNCw7+bb+E/ZdCXE4z2Eo8gu1ENnW/AJsowB6U/qtphM5qvlgHo
70F9alVxTYCYjHthrQEryGzGpuUAfrgB6O4lti7xXbdl6HFcROCLPa0VWhw3EQvu
L8CTKGLtwn1HN5kEU9kaW1eHTqFvIg==
=Cy4u
-----END PGP SIGNATURE-----

--NmCm27cBeyhb9V5C--
