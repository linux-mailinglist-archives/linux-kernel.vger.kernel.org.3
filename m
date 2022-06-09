Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3997154554F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbiFIUHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiFIUHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:07:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5925EA890;
        Thu,  9 Jun 2022 13:07:02 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 394FD66016A4;
        Thu,  9 Jun 2022 21:07:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654805221;
        bh=uKKUfNmIi+Zd1mcPoZ1earm4WK5quuiscVKXFqUEUkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7CdeNVQb6vu/ZiCBKU3AEB60L3/CfBegAnAoA+d96NEx+VMlqWcAvuXMQvzlDZLF
         0S1N/pd/qOKYN4mNrqkI9nhEKXg6CaOMqwUKGeDqNWWx4BHSgxQQuhCSW8wTHG1n1L
         3+7oxdq2SMLO+OUX7sSaRloc7vRR0q4Ygu0zV6PzagtFs9yBjqusrfpeviqDC0Xwz9
         MXzaToHkoAtQmy/dasUMggXFfhaeG0V3XnV21g8SYZ1ZJsmNmWa0dywjQSgdQQI/A1
         8NJO+WgdrX0DOD8VebXStrn8yO/870yX+v/b57m4L+DvNHwR3H88lKlk8RA6qV0b3z
         9+Ef+vyUL7ZuA==
Received: by mercury (Postfix, from userid 1000)
        id BF4F610605B9; Thu,  9 Jun 2022 22:06:58 +0200 (CEST)
Date:   Thu, 9 Jun 2022 22:06:58 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] power: supply: cros_peripheral: Use struct_size()
 helper in kzalloc()
Message-ID: <20220609200658.52gkhfmyxlo7m273@mercury.elektranox.org>
References: <20220607150344.30669-1-xiaohuizhang@ruc.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7vwcz63s2insf2fj"
Content-Disposition: inline
In-Reply-To: <20220607150344.30669-1-xiaohuizhang@ruc.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7vwcz63s2insf2fj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 07, 2022 at 11:03:44PM +0800, Xiaohui Zhang wrote:
> Similar to the handling of cros_usbpd_charger_ec_command in commit 441d38=
c60fbe
> ("power: supply: cros_usbpd: Use struct_size() helper in kzalloc()"),
> we thought a patch might be needed here as well.
>=20
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
>=20
> Signed-off-by: Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>

Thanks, queued.

-- Sebastian

>  drivers/power/supply/cros_peripheral_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/pow=
er/supply/cros_peripheral_charger.c
> index 9fe6d826148d..1379afd9698d 100644
> --- a/drivers/power/supply/cros_peripheral_charger.c
> +++ b/drivers/power/supply/cros_peripheral_charger.c
> @@ -63,7 +63,7 @@ static int cros_pchg_ec_command(const struct charger_da=
ta *charger,
>  	struct cros_ec_command *msg;
>  	int ret;
> =20
> -	msg =3D kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> +	msg =3D kzalloc(struct_size(msg, data, max(outsize, insize)), GFP_KERNE=
L);
>  	if (!msg)
>  		return -ENOMEM;
> =20
> --=20
> 2.17.1
>=20

--7vwcz63s2insf2fj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiUuIACgkQ2O7X88g7
+pqBrQ/+NpRAu9t1a5kNmFxbt4E+NHasjLyQb4cX2IBSfj2ZAfuHH0NJWQpCRV7r
LZHqIQhXw33vJrrF8wG7ae5/SEQyEaWi1hpanbOyGE0G5xU5np6+aaBABTa32QY3
skiJcBlBAeLnHsV4ntCyRmNnWB00yHOMJYISm4/jJITgiiecq5F25DPPADAtTJow
rL8akBBHzC/iz7uilTy13vuoGJrPjqE1jEduG1XA/HK6up/sxk8eqqcZoClsH8A2
XFzkIiU387xMf+szrm/rlDFZvs4f1N5B3ai36gZNF2rgmDGFHE9dHJXQi6TJwHl+
NQc/TOtLnfGYOAV+WD2nKr40qKBT8ayfMx+Zdkbcfl6LXFHvHePLkClVipDyBMcT
4QxyX69QHKI64yItweXDqeecyonLP4GxgtkRJtoo/TkklTcRvzLSy3pvrO/IDAlP
GsrH9X7+Du/XPjytQALUziiwqEXFNRcSt17XMp3n+4uuMCyPuzLLzHYfMaZseKK9
04Vm1Zjt1spVFUijl9HgAGarlrNQ9cqEeOALnu/FxPAf1DNojZN1p8iH6e6UHqb9
GHPNkvc5PMWHEmba6Sx7NFSw8l3EMsXwCp85W4v9E6M6oWA11wRXwnbiksVrHOsx
CS6eo7tyQp07kcfvedHIGZS7RNhVh4nAEFrd4UOT6s+mNAOH1nI=
=tccd
-----END PGP SIGNATURE-----

--7vwcz63s2insf2fj--
