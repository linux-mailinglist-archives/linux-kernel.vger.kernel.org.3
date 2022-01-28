Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A0749F374
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbiA1GVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242352AbiA1GVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:21:00 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6385C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:20:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so10104513pju.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=271wWJNHEiR0TyjR6rdEh0lmclJBwJawzmgXlEO7GdQ=;
        b=K/owWhHPPyLJ8e+RTAdifuqw1Lts5+MANTWlvDIYkiTrB5w9F0VIq/dnPYOhla27mU
         m6uuch5zox6BpJu9pJHKPLc7B/fMXAqI5FjxVgZ9I4igwo0gSVjJd7leEQwkYNLvdI/N
         /R9UICyBTEgWmPRts1CX3zp0pDocz7rFzhEpa7F4KcikqsQlT+ilCyw3e8kDFdH8bIKR
         bWY30IiweqWvltlcJqjv+Ab0X6RV651Np9r4CF8WkTJGmM3spNEfFDofpbYFvQDRD5Xz
         XrwTc9fPpfE4KKtPb06YBOKnzGqTFzw/SviZ1rtmWKgjSXxOhYPaHRM9qTYdyOIvZJmm
         noEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=271wWJNHEiR0TyjR6rdEh0lmclJBwJawzmgXlEO7GdQ=;
        b=vqO59SMo85X97Bk6toRKDNDs9t3xMR11bGnXnIctogz/3phe+Pu3QPvdGP9YHUcOvs
         BNEvmgMd3lVqoJ42LRcFXaZ6KamBWt2HeWOvmHaSAEKDg5mNEnOVmfdhql9GR4T2EdQV
         Ogvd9+3uQ1yT3Ry50BuMSsbLXqnQ7nRjsprIX6hEn1mkQ8WVeenp7lsMyj91rHEgpFXc
         yPzNESZ9DuAHPMKUztvR4h2rvGibHVmnfQEUWbvLRFfCZfFaUg201YiYvB8WDE0LM2Fb
         JKitsO+F57wlUXD0+FxONGy9mckBx7NWVmE/9Cou1SGktV7zYWbHgUiDGb8T8tkgkLur
         slSw==
X-Gm-Message-State: AOAM533GZ1VKBnu1MXYtgFnbiU908SguVpoWtdKpMkq557BvPQL+8F8B
        wb2BDkuX1WV28PCWDjM9PPBxUTXoQPEfYQ==
X-Google-Smtp-Source: ABdhPJwM9MkDOQDrYBBBBLkVESeUIF5gas7EuZ7Ruwc+VeNecD0F6v94vSN/m2QiBXG+Asyjr0O5TA==
X-Received: by 2002:a17:902:ea0f:: with SMTP id s15mr6710101plg.118.1643350858994;
        Thu, 27 Jan 2022 22:20:58 -0800 (PST)
Received: from google.com ([2620:15c:202:201:7713:237d:48f3:f690])
        by smtp.gmail.com with ESMTPSA id ha21sm1135807pjb.48.2022.01.27.22.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 22:20:57 -0800 (PST)
Date:   Thu, 27 Jan 2022 22:20:52 -0800
From:   Benson Leung <bleung@google.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        "open list:CHROMEOS EC USB TYPE-C DRIVER" 
        <chrome-platform@lists.linux.dev>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Make try power role
 optional
Message-ID: <YfOLRBGmwGKwCksR@google.com>
References: <20220127191659.3560810-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DXB3UyVkHi0h/pnn"
Content-Disposition: inline
In-Reply-To: <20220127191659.3560810-1-pmalani@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DXB3UyVkHi0h/pnn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Prashant,

On Thu, Jan 27, 2022 at 07:16:59PM +0000, Prashant Malani wrote:
> Some boards prefer not to specify a try-power-role. Update the port
> property parsing logic to not error out in case a try-power-role is not
> specified.
>=20
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

This looks good to me.

Heikki, if this usage of TYPEC_NO_PREFERRED_ROLE looks good to you, I can
merge it.

Benson

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index 5de0bfb0bc4d..ee12658009e5 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -115,17 +115,18 @@ static int cros_typec_parse_port_props(struct typec=
_capability *cap,
>  		return ret;
>  	cap->data =3D ret;
> =20
> +	/* Try-power-role is optional. */
>  	ret =3D fwnode_property_read_string(fwnode, "try-power-role", &buf);
>  	if (ret) {
> -		dev_err(dev, "try-power-role not found: %d\n", ret);
> -		return ret;
> +		dev_warn(dev, "try-power-role not found: %d\n", ret);
> +		cap->prefer_role =3D TYPEC_NO_PREFERRED_ROLE;
> +	} else {
> +		ret =3D typec_find_power_role(buf);
> +		if (ret < 0)
> +			return ret;
> +		cap->prefer_role =3D ret;
>  	}
> =20
> -	ret =3D typec_find_power_role(buf);
> -	if (ret < 0)
> -		return ret;
> -	cap->prefer_role =3D ret;
> -
>  	cap->fwnode =3D fwnode;
> =20
>  	return 0;
> --=20
> 2.35.0.rc0.227.g00780c9af4-goog
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--DXB3UyVkHi0h/pnn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCYfOLRAAKCRBzbaomhzOw
wr3iAQD/4S0peXsqQPgEW97XtZgI0CWsqWPDzkEiLGb1GzRVRAD/beUy77nVEHUn
TvwKDo2LAlHrBFbVWaThHWLRSIFB1gU=
=+z/0
-----END PGP SIGNATURE-----

--DXB3UyVkHi0h/pnn--
