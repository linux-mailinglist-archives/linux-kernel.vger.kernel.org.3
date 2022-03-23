Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047944E5A55
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbiCWVGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344844AbiCWVF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:05:58 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEE911C1C;
        Wed, 23 Mar 2022 14:04:26 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 313FB1C0B87; Wed, 23 Mar 2022 22:04:24 +0100 (CET)
Date:   Wed, 23 Mar 2022 22:04:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Manuel =?iso-8859-1?Q?Sch=F6nlaub?= <manuel.schoenlaub@gmail.com>
Cc:     lains@riseup.net, jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
Message-ID: <20220323210423.GA10741@duo.ucw.cz>
References: <Yifr4etBFPu1a2Ct@hermes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <Yifr4etBFPu1a2Ct@hermes>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The HID++ protocol allows to set multicolor (RGB) to a static color.
> Multiple of such LED zones per device are supported.
> This patch exports said LEDs so that they can be set from userspace.
>=20
> Signed-off-by: Manuel Sch=F6nlaub <manuel.schoenlaub@gmail.com>

Please cc LEDs stuff to the LED lists.

> +static int hidpp_mc_led_register(struct hidpp_device *hidpp_dev,
> +				 struct led_classdev_mc *mc_dev,
> +				 int zone)
> +{
> +	struct hid_device *hdev =3D hidpp_dev->hid_dev;
> +	struct mc_subled *mc_led_info;
> +	struct led_classdev *cdev;
> +	int ret;
> +
> +	mc_led_info =3D devm_kmalloc_array(&hdev->dev, 3,
> +					 sizeof(*mc_led_info),
> +					 GFP_KERNEL | __GFP_ZERO);
> +	if (!mc_led_info)
> +		return -ENOMEM;
> +
> +	mc_led_info[0].color_index =3D LED_COLOR_ID_RED;
> +	mc_led_info[1].color_index =3D LED_COLOR_ID_GREEN;
> +	mc_led_info[2].color_index =3D LED_COLOR_ID_BLUE;
> +
> +	mc_dev->subled_info =3D mc_led_info;
> +	mc_dev->num_colors =3D 3;
> +
> +	cdev =3D &mc_dev->led_cdev;
> +	cdev->name =3D devm_kasprintf(&hdev->dev, GFP_KERNEL,
> +				    "%s:rgb:indicator-%d", hdev->uniq, zone);

So this is keyboard backlight? We should add the documentation at the
very least, so that other drivers use same name.

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYjuLVwAKCRAw5/Bqldv6
8kx0AJ9oRQqFcCr56nwvRNMMN+qF5d6glgCfbBf5ZasT2VlWCFhfy+uI65wakSk=
=ru61
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
