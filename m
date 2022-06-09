Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283DE5456FD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 00:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345492AbiFIWMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 18:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiFIWM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:12:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B414D794;
        Thu,  9 Jun 2022 15:12:28 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9545B6601752;
        Thu,  9 Jun 2022 23:12:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654812746;
        bh=UeKHAwZPWYRBlM0ssIlCFA3SoNmcDziraTI4lnAG4pA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ESB8FynxqAB0ZtuFqhjILyFPW8Qt44o3mf8r3aaah/qSTCaOKa4l6MdGxPPkwFaZr
         mrU7aoXWTZqBa2pENpf1ZjqZG6HAN2Edi5vwG47coNqqmr4fYDWX6XnxCHvVE6Q2QZ
         1gSbU5gQ6NnADbIVuMvUC2qIiATIMvRsNYdmnQZUe7nvRO0JEDz+EI7o62ya+4od79
         BzIOWPX2LmNeix1cMuQYNUIP5rbGdF+P20VjTG2WTOBVDG18UgpgnZusg64k2nS7zs
         1jtF0hrlPvmvcAyPqzZpZz1Eu5IQcFhtLDjyXZe0OIMxcLA7GaDmVU+TK86Rn3Ku/6
         pHxHEWkA1DH+g==
Received: by mercury (Postfix, from userid 1000)
        id 646CB10605B9; Fri, 10 Jun 2022 00:12:24 +0200 (CEST)
Date:   Fri, 10 Jun 2022 00:12:24 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@google.com,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Subject: Re: [RESEND 1/2] power_supply: Register cooling device outside of
 probe
Message-ID: <20220609221224.t5k7i4w4dfjza5xc@mercury.elektranox.org>
References: <20220531183054.6476-1-quic_manafm@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dyokn4q3tm7tzwko"
Content-Disposition: inline
In-Reply-To: <20220531183054.6476-1-quic_manafm@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dyokn4q3tm7tzwko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 01, 2022 at 12:00:53AM +0530, Manaf Meethalavalappu Pallikunhi =
wrote:
> Registering the cooling device from the probe can result in the
> execution of get_property() function before it gets initialized.
>=20
> To avoid this, register the cooling device from a workqueue
> instead of registering in the probe.
>=20
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
> ---

This removes error handling from the psy_register_cooler() call, so
it introduces a new potential problem. If power_supply_get_property()
is called to early -EAGAIN is returned. So can you elaborate the problem
that you are seeing with the current code?

-- Sebastian

>  drivers/power/supply/power_supply_core.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 385814a14a0a..74623c4977db 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -132,6 +132,7 @@ void power_supply_changed(struct power_supply *psy)
>  }
>  EXPORT_SYMBOL_GPL(power_supply_changed);
> =20
> +static int psy_register_cooler(struct power_supply *psy);
>  /*
>   * Notify that power supply was registered after parent finished the pro=
bing.
>   *
> @@ -139,6 +140,8 @@ EXPORT_SYMBOL_GPL(power_supply_changed);
>   * calling power_supply_changed() directly from power_supply_register()
>   * would lead to execution of get_property() function provided by the dr=
iver
>   * too early - before the probe ends.
> + * Also, registering cooling device from the probe will execute the
> + * get_property() function. So register the cooling device after the pro=
be.
>   *
>   * Avoid that by waiting on parent's mutex.
>   */
> @@ -156,6 +159,7 @@ static void power_supply_deferred_register_work(struc=
t work_struct *work)
>  	}
> =20
>  	power_supply_changed(psy);
> +	psy_register_cooler(psy);
> =20
>  	if (psy->dev.parent)
>  		mutex_unlock(&psy->dev.parent->mutex);
> @@ -1261,10 +1265,6 @@ __power_supply_register(struct device *parent,
>  	if (rc)
>  		goto register_thermal_failed;
> =20
> -	rc =3D psy_register_cooler(psy);
> -	if (rc)
> -		goto register_cooler_failed;
> -
>  	rc =3D power_supply_create_triggers(psy);
>  	if (rc)
>  		goto create_triggers_failed;
> @@ -1294,8 +1294,6 @@ __power_supply_register(struct device *parent,
>  add_hwmon_sysfs_failed:
>  	power_supply_remove_triggers(psy);
>  create_triggers_failed:
> -	psy_unregister_cooler(psy);
> -register_cooler_failed:
>  	psy_unregister_thermal(psy);
>  register_thermal_failed:
>  	device_del(dev);

--dyokn4q3tm7tzwko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKicEUACgkQ2O7X88g7
+pobxg//et2r5ybQ+rdiNpPXGulCO2f3CjkGSb3U14qmfM9ror6eqk3Ow+BAxVjV
Dp4dYzxjOWZ1jjmUETVH2mgLvxe5EdOFDl/95Lcc8X9RDOl+xAwdf6UheT7omCsw
cvq4HBLPpV0SiZAiSY7H92u4XPc1o5FNlW2ilCP3oFNH+XlI8y/GWKLxYamuEf4k
upJV64TUtlC2NTwkAopIIHB92m5T1CW9+9jUe5ISRP1N0P5wEvz+vypsZ2DSjYDO
nRL9XNcsSq4rnAeol8wxLnSS16IB756/3FgopVq/jFH/6p3ViIYXIEFmkHM8dl7A
jC5N3Zg4Ro8zLOVgNYeppqdvE6xIplroRyRbelYh0K0LcK+ONIsa+pRsCWWF8fgZ
9GNZ3TQdFUgdm2Yf2mWoB6PYT8wWu4W+X4QR4t6YS4VbHXzoHhCJdZNnC84xBU6c
/TxVZG0vXZfscnrEV7NMBYT4l6qJGUnKu4OgEjeua+Uv7bp40qWiMaOd97KKpH3m
lSqkmUwNN9sU1bqRupGUP1UJDnygBGVhcMGd/VbwUpIepNaEITkwoxaoYvNT3LZ/
cJxAdbh4NtkY0xEuZnmjGEvDjNqD84kTc4expQQkmI3QcaLpgGcB/WudMfwP7T65
rEfAAciOmyku6nB05bFmfkkS49uMourYXUPMZ74vv7QQFO7nnFI=
=UWC+
-----END PGP SIGNATURE-----

--dyokn4q3tm7tzwko--
