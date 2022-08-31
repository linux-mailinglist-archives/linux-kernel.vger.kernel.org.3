Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B24E5A7BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 13:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiHaLCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 07:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiHaLCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:02:13 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C17A9F8D4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 04:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:
        From:Subject:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VnuzXvi/r6r6IliU1js/OsrQoTnENR453xGhcd9X4ts=; b=P0iVndoLG0wOrIgh9DfoeYddIq
        BaKbwUYrEKwGGvM1ZuJp544fR5V2ur3rYLY4BNzLICFPFwFvMd1ZN76nPHi/pFTTGskiIfv+jcr+D
        s2TNT4n71M41CJ3cnbSwLhJRf6Tw3UqjHSmgVjDBTNjvv4qHKs8wJbmPdQn/26NKmG+tiCXEDtBlZ
        gftcX3YvBSa9nIN7fuK7KSo0Nhiw2VGZyNdZUuGz5+NVxg412A4MZDrRa6y5Qg5o3Y+6PQy2raBN1
        HUwsB5xOmRXQbZ1luwc+oyThp9DfL7t7bkx/TemRdTMSioA1xcynKnmcsBxJzHuPBxzkYapKTGsrV
        Jp0hMY9Q==;
Received: from 1.pool85-50-22.dynamic.orange.es ([85.50.22.1] helo=[192.168.1.125])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oTLTh-005yGW-CX; Wed, 31 Aug 2022 13:01:49 +0200
Message-ID: <16e141fc3d9cce0f46718ffb9e861e5d3b9da6ab.camel@igalia.com>
Subject: Re: [PATCH] ipack: Check dev_set_name() return value
From:   Samuel Iglesias =?ISO-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
To:     Bo Liu <liubo03@inspur.com>, jens.taprogge@taprogge.org,
        gregkh@linuxfoundation.org
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2022 13:01:38 +0200
In-Reply-To: <20220805091057.19951-1-liubo03@inspur.com>
References: <20220805091057.19951-1-liubo03@inspur.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-42SrFaz+DLoXKjPro8/p"
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-42SrFaz+DLoXKjPro8/p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bo,

Thanks for your contribution!

Patch is,

Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>

Greg, Would you mind picking this patch series through your char-misc
tree?

Thanks!

Sam

On Fri, 2022-08-05 at 05:10 -0400, Bo Liu wrote:
> It's possible that dev_set_name() returns -ENOMEM, catch and handle
> this.
>=20
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
> =C2=A0drivers/ipack/ipack.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/ipack/ipack.c b/drivers/ipack/ipack.c
> index b1c3198355e7..74d449858a61 100644
> --- a/drivers/ipack/ipack.c
> +++ b/drivers/ipack/ipack.c
> @@ -429,8 +429,11 @@ int ipack_device_init(struct ipack_device *dev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.bus =3D &ipack_b=
us_type;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.release =3D ipac=
k_device_release;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->dev.parent =3D dev->=
bus->parent;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_set_name(&dev->dev,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D dev_set_name(&dev->dev=
,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ipack-dev.%u.%u", dev->bu=
s->bus_nr, dev->slot);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return ret;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device_initialize(&dev->d=
ev);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (dev->bus->ops->set_cl=
ockrate(dev, 8))


--=-42SrFaz+DLoXKjPro8/p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEQP+ZAvaXWkfuKXiEf/S6MvF9w0MFAmMPP5IACgkQf/S6MvF9
w0PxkRAAv1Lv7TRm2HxWebuQY4XSlDQIM0y9z5xmw4S8GipFj/K1LWrHVa9G+Ua4
NMVBAKm5wW31AsrAIfNlEUhwYB3UTfz3wGPdKX2fUCBVjPdUz1pjcgL+MOF3Kdj8
ZhCYwhnhvXp5MRNTKw/UPK25Y54hux6QBllc8WddM9zvnC2ZhI+2lov6a4QIqTgh
6fl4KQ6Pbf2u27VcNzy07X6lgQt2M2I908nG5RedjTAgd4CiiCDN7CO0ckjHRWO/
w8Z7BxzaCTS9cQsQu0zX3IOyXHvyEWmBYGcIdjOKKOFk/+dW1J11C5MJySW4iddn
WhNh7b/cAV6N1ohtRFHsKsSZ9T4fWxPsxQvDjtSDHnkP/cdZ+XCSs6K3+f0Bhd9b
ijtnOkek0GDdsaNr+AX0S3jDQLevHUyf52hVadXYOEJhPZbjRLcYN6SavmeU40nv
G0B8CtAyrDfySkJ8usq5SFkZ1fl6/MRsUhyjOoMfE1I7Wck/ZLpxIfLQbYXpoa71
oNR7d2Lgsj3XHaVHxxE7Hn0uMSdxT6pzDhbHS7JF4c1BZI/Zjti9tkyb/uRuPlgk
i276LneUe8/2J3TCGauV8wH6b07avppKKC7vMEogjdDMmGfX/ISa9wmVCtsh/N5M
gVDYur8B4xXOlBQW/kcfFoWaKi6hyrUS+g/klJN8HL42lvqAJkY=
=2Yrp
-----END PGP SIGNATURE-----

--=-42SrFaz+DLoXKjPro8/p--
