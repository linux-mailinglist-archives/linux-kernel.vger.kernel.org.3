Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B894B2EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353394AbiBKUnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:43:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348029AbiBKUnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:43:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6477F1A2;
        Fri, 11 Feb 2022 12:43:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F41E41F472E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644612192;
        bh=oWgZHE9fHCY/0v/Hzi8mevgHh7lV1HyeByt1kmcVti4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SEGgezdoKEGTnAoFXxM0aFjBs/4lAZ630dBWRr2F+2e4SsTUxuI3ftGDHxrlfitlf
         +btqYJbwbX/RQAohFdqqeGYUtMBTgMP28pGU2q8xpVExYEbm77mBcb2H+3N51rKv+y
         Hif6bW4vOaq1xlc1Syg6fBugIY08HFKs8l0HZbwHeOCPKEzcPXGcG7bKj3SpHrk+Ci
         shS03z7E/gRJILlF5gcsZanUruO1wVH6PNjafzT5vAYmte4pMPqWu/Y3N/IudJvglJ
         cKvLGRJM+xw0APetQ3caettSbh+AnpTWEiw078zrXj8ZEDdGqzyVIQj3A7UZdfoCmq
         fJQSdgX0Q0Vtw==
Received: by mercury (Postfix, from userid 1000)
        id 528661060908; Fri, 11 Feb 2022 21:43:09 +0100 (CET)
Date:   Fri, 11 Feb 2022 21:43:09 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [RESEND v2 1/2] power: supply: Introduces bypass charging
 property
Message-ID: <20220211204309.apzep7w233vh7iin@mercury.elektranox.org>
References: <20220210154108.641369-1-rriveram@opensource.cirrus.com>
 <20220210154108.641369-2-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mqjkkptof3zuwwtj"
Content-Disposition: inline
In-Reply-To: <20220210154108.641369-2-rriveram@opensource.cirrus.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mqjkkptof3zuwwtj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 10, 2022 at 09:41:07AM -0600, Ricardo Rivera-Matos wrote:
> Adds a POWER_SUPPLY_CHARGE_TYPE_BYPASS option to the POWER_SUPPLY_PROP_CH=
ARGE_TYPE
> property to facilitate bypass charging operation.
>=20
> In bypass charging operation, the charger bypasses the charging path arou=
nd the
> integrated converter allowing for a "smart" wall adaptor to perform the p=
ower
> conversion externally.
>=20
> This operational mode is critical for the USB PPS standard of power adapt=
ors and is
> becoming a common feature in modern charging ICs such as:
>=20
> - BQ25980
> - BQ25975
> - BQ25960
> - LN8000
> - LN8410
>=20
> Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
> ---

Sorry for the wait. This needs to update the sysfs ABI documentation:

Documentation/ABI/testing/sysfs-class-power

I think your patch description is a good explanation for that file.
Also I obviously missed to point this out for the "Long Life" charge
type, so please also add a sentence for that so that the property
is properly documented.

(Otherwise the patchset looks fine to me)

Thanks,

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 1 +
>  include/linux/power_supply.h              | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 6ac88fbee3cb..52c909bae457 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -89,6 +89,7 @@ static const char * const POWER_SUPPLY_CHARGE_TYPE_TEXT=
[] =3D {
>  	[POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE]	=3D "Adaptive",
>  	[POWER_SUPPLY_CHARGE_TYPE_CUSTOM]	=3D "Custom",
>  	[POWER_SUPPLY_CHARGE_TYPE_LONGLIFE]	=3D "Long Life",
> +	[POWER_SUPPLY_CHARGE_TYPE_BYPASS]	=3D "Bypass",
>  };
> =20
>  static const char * const POWER_SUPPLY_HEALTH_TEXT[] =3D {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 86b4d5c4dab9..164779bc7e8f 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -49,6 +49,7 @@ enum {
>  	POWER_SUPPLY_CHARGE_TYPE_ADAPTIVE,	/* dynamically adjusted speed */
>  	POWER_SUPPLY_CHARGE_TYPE_CUSTOM,	/* use CHARGE_CONTROL_* props */
>  	POWER_SUPPLY_CHARGE_TYPE_LONGLIFE,	/* slow speed, longer life */
> +	POWER_SUPPLY_CHARGE_TYPE_BYPASS,	/* bypassing the charger */
>  };
> =20
>  enum {
> --=20
> 2.25.1
>=20

--mqjkkptof3zuwwtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGyloACgkQ2O7X88g7
+pq8IQ/9H9mzMXMYF2R4nFAzMTvSf/mLqe5+PnGqRWj/Nfy+LkB4zQoW5sICcdUf
J9vO64ZNjAgrEIryl9o63pKs09xx+ATdlKdkhSV0rc1N8U0C30/qhewalFGAXHYL
cTe46ju9nAYegg8bXt/slV0zliokfIBLXUBx7EFxmI6YdXNk6BNsLVWSoRkVycEt
3wiXjfn3/QcNdRLZpJnkMAnZ4zidaJXu4prDk1suGS0GcQN0M3o2+XyQmeSrPwCy
to8qGXDEVbM0CSHkjiUyWjzlMV1mkf5pU/uv3Foj8hQu1m6f3WTAkkWqR/snqRqp
P8DIGoRERkGu53LMAdhgF4lwFd1uHIeHXRN9eEdsCqxJ+OPWH5HKFRn9KV0zvtxb
0RnJn8Hsj9tJT/axk8HgNG5RXH3BGdSQPwVuBewzUwEC0hz1G8M7Zaqk8arylXnd
9P2vqhNC015jtO0L7z293Z1rrqwYnN3SW5ehwYT0lSsWOeo6CVAN153+0U9+LW0s
WhjYYxadYqe1izDzqui6HZ8/YR6WaHyW336po1RbmXe7WW3NdFqk+sOJH1SF9CzQ
nMhmc5QatzKQr4gEZsZrNNBWKwB9SzO+f2heW/QLzQ8qmbJ0dE1tGReH/59TkGRw
Awf1zNDBLc0UGniA4jXBawgqNuNVEOqbslCtWUsgKqb5tQ+k7Vk=
=pWAX
-----END PGP SIGNATURE-----

--mqjkkptof3zuwwtj--
