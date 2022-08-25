Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FA65A12E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbiHYOCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHYOCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:02:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D2922BF1;
        Thu, 25 Aug 2022 07:02:47 -0700 (PDT)
Received: from mercury (dyndsl-037-138-189-169.ewe-ip-backbone.de [37.138.189.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C7B16601D9B;
        Thu, 25 Aug 2022 15:02:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661436165;
        bh=7SIZbVfu23i3fWXeHgVoqyNxcUenu0Rqg73BHIJm/Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UNzH4eNuq/vV3uAMvTM/1TbnRVebcnbnnvJ8s24RP5yMOWSlmTGh5miYbR6UOatAS
         l6PfqaNtBIvxfyvObOSTBE0IqRVPuqq4lOQSAN+5nqoqyoJIxao4SgRtBwyjdsdzRK
         +YD2ys8q/vliex24Z20fkWLfyoKB1GiBOVVX65FiZ9JFFYbRoKnb0cXDG7h/MScV9X
         TJZqU3kjzYG8lWAxWKs4YQ3iqeeN7GCAlY8rE4Cf4HNFDEGJ7pKX+ClrTTfYwPomd0
         ZTZf9B1bY9El+bddDuUu6H4Tuk/HsWCEcifRHxrENQoU3o0pIQZ6yBXL5ZoIgtVPJi
         aRS2i+uXmdeFA==
Received: by mercury (Postfix, from userid 1000)
        id 7114210607D1; Thu, 25 Aug 2022 16:02:43 +0200 (CEST)
Date:   Thu, 25 Aug 2022 16:02:43 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: Ignore -EIO for uevent
Message-ID: <20220825140243.tgotqpymswduzlyy@mercury.elektranox.org>
References: <20220824165459.1.I059ae712dd6d324897162ee9f37c22849aa22745@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wgnvmg5jlieudigr"
Content-Disposition: inline
In-Reply-To: <20220824165459.1.I059ae712dd6d324897162ee9f37c22849aa22745@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wgnvmg5jlieudigr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 24, 2022 at 04:57:20PM -0700, Brian Norris wrote:
> For uevents, we enumerate all properties. Some battery implementations
> don't implement all standard properties, and may return -EIO for
> properties that aren't recognized. This means we never report uevents
> for such batteries.
>=20
> It's better to ignore these errors and skip the property, as we do with
> ENODATA and ENODEV.
>=20
> Example battery implementation: Acer Chromebook Tab 10 (a.k.a. Google
> Gru-Scarlet) has a virtual "SBS" battery implementation in its Embedded
> Controller on top of an otherwise non-SBS battery.
>=20
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

-EIO means input/output error. If a driver is reporting that for an
unimplemented feature it's a bug that should be fixed in the driver.
Handling it here means userspace ABI changes for temporary issues.

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 4239591e1522..36fce572a213 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -439,10 +439,12 @@ static int add_prop_uevent(struct device *dev, stru=
ct kobj_uevent_env *env,
>  	dev_attr =3D &pwr_attr->dev_attr;
> =20
>  	ret =3D power_supply_show_property(dev, dev_attr, prop_buf);
> -	if (ret =3D=3D -ENODEV || ret =3D=3D -ENODATA) {
> +	if (ret =3D=3D -ENODEV || ret =3D=3D -ENODATA || ret =3D=3D -EIO) {
>  		/*
>  		 * When a battery is absent, we expect -ENODEV. Don't abort;
> -		 * send the uevent with at least the the PRESENT=3D0 property
> +		 * send the uevent with at least the PRESENT=3D0 property. Some
> +		 * batteries also report EIO, even for some standard
> +		 * properties.
>  		 */
>  		return 0;
>  	}
> --=20
> 2.37.2.672.g94769d06f0-goog
>=20

--wgnvmg5jlieudigr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMHgP4ACgkQ2O7X88g7
+pqi7RAAg4Qo7K7p69J7lgFtLm4EBAu3eZqz0tp/a2kwS0nYOG+zTtDAafqpkg64
1Den2X5UulI8xETwZUFnQyfJySW4/LGFWhw/xQu75B+eHJlUcP0QVq5R6g69W7j2
PzRjRs3GGnTDpdslQw476h8x0/6CQvf2kBoMR7lAKkwJnUXDoF6GAM8HuHojjpof
/vB5u/0cpVcyp14nsjFj9BVPSzNsCMvzb5sTcXm0+L0a8BPNzwQlh4mdjbH0ISYa
90cPsgGdAnUzu1MjwzT+i4XIND9GhzY3+9K7wVspIhMw4zGQoqhuvURx/invs7jS
diYWHHxM6y5d7BMs08LtOdjy9/kc2eFwwtxgFrKsM6WAY8aGY7HJObVz/LaVTGOj
Hmp/O3dvuBNw1vvPz/3K8SYlTSsqewAJbTIfClZDv+5qH28xDUpRMtdm32UYalQs
SEF9fAUt8hnHx5o5rI82gQCPLngNngPlCKTr+y+Tnd17BDrNsV/kYxQh477NfGAA
3eoOs72lYwCG2/GOOkH3FJ0HT023f/3xp97F4s4Ve2/prterUaVoWP0/16w9K2L+
aRwi1wzxzGBBVouwkAZxggmlaTmByQfm+hw51OXDmfw4mWGmvrn12+4lzan3es7U
anGKLykf2NvR67TWSpRNoKaBN9T5kVSZt+0iwWQkVTdZ1T6enR4=
=7Px2
-----END PGP SIGNATURE-----

--wgnvmg5jlieudigr--
