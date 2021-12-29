Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F506481758
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 23:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbhL2WmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 17:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhL2WmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 17:42:11 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78B8C061574;
        Wed, 29 Dec 2021 14:42:10 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id s15so19745061pfk.6;
        Wed, 29 Dec 2021 14:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GAeVyk5DLHPFAzL99xxp0ydPVN80AWvenA4FAxG504s=;
        b=Is9NBWACTv+cGo1z0JaIjLGKrxdQnoy+20glcyPUO/vnM8PVXuNONiplY1cIp0VF8K
         LPbfRbT9a7sE13YDCAU5J9HNNCn85lY0OCJBglcOLelW6PxjTOrL1gc0EzYRq8bc4ps5
         EjzeIm8g8UwkhfOwTln0C4woNW9gbReoOXzQey59hCXrXweTULQ5yK9t8+MpmgGvC/R0
         9pb0sQKZs1W0A/ycJTaq69SU0uLmzos3i4yDDi/S5NVq6z+y8neG/fZri7m5UqSi7qys
         4RJMJ2BP9XMXToqJ2Zi+FZ5Ho2n25HzFHG7qVcA2FbQ3pTNO/1jxMm/NmNmbob5un+eV
         SwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GAeVyk5DLHPFAzL99xxp0ydPVN80AWvenA4FAxG504s=;
        b=1rR1wWoja2CO+mTRkyXbiQvMpBUMiRoGLS3CkDdse7qXRREHFvZCrCcqHGEQxPNPhy
         RwJChxWCa8PXdh6XL7A7aEWUQFHZQlLoQjQSlm2kLvQEdeHWqnNAa9Gcjff3gqS44QJ5
         7qF1lF5H4IWIqX1h54lbO8/n+ehPRlCuu7z9EZd12Zsk5Lft9Z0PE68qn7u3389uKlOP
         lU+x6KZUpOvO3S8dLI9JjFrsz1+L97X2srKyqR8H5wNaLXKOJ3x82ygHu3S/+lEru8Cw
         tjZ7Lw1BaPyqB+tsPo2YehTGfHVgR0PZq/0tb2orCl2SvQ9T1/bjVLSyhwY9MiIhbAQJ
         NsLA==
X-Gm-Message-State: AOAM532f/Dv8mDd/rvhxvsBnky2T4UsLKI6ZNcsHevIj4hDhfgsfZIvi
        mjMNaK31GKx9xtb6f1NwNqk1uQutkshCwdRt
X-Google-Smtp-Source: ABdhPJz6n8kC77ice9pzGhZsPsjOTpI9tqAto6mc9EdyDlxGwepPAh/l+RUZWY7qRBpCfKbSJEbB6A==
X-Received: by 2002:a63:7845:: with SMTP id t66mr17376850pgc.103.1640817730402;
        Wed, 29 Dec 2021 14:42:10 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id w76sm23713616pff.21.2021.12.29.14.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 14:42:09 -0800 (PST)
Date:   Thu, 30 Dec 2021 07:42:03 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: Re: [PATCH v3 10/23] counter: ti-eqep: Convert to counter_priv()
 wrapper
Message-ID: <YczkO4CUoImGNL4I@shinobu>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
 <20211229154441.38045-11-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="se8yMUX9Y3rZt39Q"
Content-Disposition: inline
In-Reply-To: <20211229154441.38045-11-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--se8yMUX9Y3rZt39Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 29, 2021 at 04:44:28PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This is a straight forward conversion to the new counter_priv() wrapper.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

> ---
>  drivers/counter/ti-eqep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 9e0e46bca4c2..2c70b900a6cf 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -89,7 +89,7 @@ struct ti_eqep_cnt {
> =20
>  static struct ti_eqep_cnt *ti_eqep_count_from_counter(struct counter_dev=
ice *counter)
>  {
> -	return container_of(counter, struct ti_eqep_cnt, counter);
> +	return counter_priv(counter);
>  }
> =20
>  static int ti_eqep_count_read(struct counter_device *counter,
> --=20
> 2.34.1
>=20

--se8yMUX9Y3rZt39Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHM5DsACgkQhvpINdm7
VJJcBg//fXtnUp2I5Jray+w3bXnFwdus+UsZEur9THGBBzjkj7ks6u8l14LsDT49
/5E4ruSNGbnd2mKI0KB/4a2X2myk0HIc3V/S+xXjGIAfVSUXEXk96GHkyCzyp7Dq
6jKYSVV4sJOuBn7W0L862q3A5KBNMICPdp8SXxRjko+8BybKwrMsMWE/f/b08zwx
4YVGanRSfEFzjpD1jNSFmU1SwQgD66itU5PMLlZRGB7kheJCVPl9NhE4woioPrrP
XIn4XSjSlspO7Qsq/AYgM5jWaqPuIKxlxg0g98nVphMBtQnuwXReI1ybrMY7NCSv
SseGnPF7COtRpSRsaUfzUDVo8Sj6IsAN1u09pW+rteRpPeOKBSQJpNN6cpf01dbm
pRakSi6rsuqSUGgjXkkpQKE/dbJxFiQ+3WOLmMofrFBL1ibmvKxzqvO79KQ0NkFW
LoA74EuXfYJxPMOVe2c0Jrskgf/MRhmUHh7/LAr9sNQ4dM8XLRcfRwo9zR9gDoVo
GX7KEb/x/E9iTbukO9zqvG3AS3c8sowMT/MFAoQbkP84IEXF0CLG96dY/c+4Av9X
KItarba/oJjNRiOabfNaHVWsRDN1rQtUrrO0mDYFi1D0yxiKv/3a8yYHxHZLVmMN
+UO9GxDitIeJQrG4NBC5rjMpBDQwVXCHecA2DK7J+x2yOjf3KyA=
=4hDx
-----END PGP SIGNATURE-----

--se8yMUX9Y3rZt39Q--
