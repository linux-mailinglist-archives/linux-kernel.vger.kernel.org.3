Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062804C64F5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbiB1IkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiB1IkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:40:14 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B365C22502;
        Mon, 28 Feb 2022 00:39:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6Yhd27NCz4xcq;
        Mon, 28 Feb 2022 19:39:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646037569;
        bh=h0XSx1Npd7b3TyB2iNgD8xRTfa7M7bAbq+Ep+hez9xM=;
        h=Date:From:To:Cc:Subject:From;
        b=CYFiJwZMtuhc8DuwGj96uH4P7V+05p6YYrtUWwWP2B+9R85fmzYEdrKTYfCi/p4F/
         lAu7sibrtafjB4YDgoCsgQUFp5Bra56D+8uPegit092Mh1/UTJftVlzCx0mwN/djLO
         dYfWdIMrzQke6OEvisJsDArMMiJBem/wcq8ML28Uq04yoKt0pTYxRH8MEgfSXfFhU4
         nw7W10dyiBdDZqPVNx1Ltd/rtH2Tfj5XIMJ5YN0Fct6S8OLQHJQh2GxgzDiA/1ktPA
         RPcsCIXw8WzeIbFRmPiYKCiDeztA/z4kv3ycg+kXDltKImOQREuUbnM6+NV06/vdqI
         n15NpEUI1RoRg==
Date:   Mon, 28 Feb 2022 19:39:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
Subject: linux-next: manual merge of the char-misc tree with the mfd tree
Message-ID: <20220228193928.3ec6ee98@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jfVupS0VJoKj+fs5F1quxlL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jfVupS0VJoKj+fs5F1quxlL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  drivers/mfd/simple-mfd-i2c.c

between commit:

  5913eb45d036 ("mfd: simple-mfd-i2c: Enable support for the silergy,sy7636=
a")

from the mfd tree and commit:

  d0cac2434c8e ("mfd: simple-mfd-i2c: Add Delta TN48M CPLD support")

from the char-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/mfd/simple-mfd-i2c.c
index f4c8fc3ee463,0d6a51ed6286..000000000000
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@@ -62,19 -62,9 +62,20 @@@ static int simple_mfd_i2c_probe(struct=20
  	return ret;
  }
 =20
 +static const struct mfd_cell sy7636a_cells[] =3D {
 +	{ .name =3D "sy7636a-regulator", },
 +	{ .name =3D "sy7636a-temperature", },
 +};
 +
 +static const struct simple_mfd_data silergy_sy7636a =3D {
 +	.mfd_cell =3D sy7636a_cells,
 +	.mfd_cell_size =3D ARRAY_SIZE(sy7636a_cells),
 +};
 +
  static const struct of_device_id simple_mfd_i2c_of_match[] =3D {
  	{ .compatible =3D "kontron,sl28cpld" },
 +	{ .compatible =3D "silergy,sy7636a", .data =3D &silergy_sy7636a},
+ 	{ .compatible =3D "delta,tn48m-cpld" },
  	{}
  };
  MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);

--Sig_/jfVupS0VJoKj+fs5F1quxlL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIcikAACgkQAVBC80lX
0GwzEwgAiNRXXCBxw6SQJCY9UVc5OUIRg4pe93kzdIfmuAkuSz2CRMEBs68KJ3Nu
hUft5m+jR9PI/bw0wRsQ3Lfy4uNocAZKJSm1VahqgscOj6g2kz10HAFDt8OuFehA
8P1XFQuJYzJKVHLGgihmxKi8GG9uPagSPQ1ASREQ5muKvWeTS++V7Hk9CMYCNFa1
8rqRb5sYgbiv0AQPvYrt4Vb3+O/PWXIH+V2VIYqIMqwhVEYTL5/3Z5sueNkreInq
TTK6mlEC+ZokO5bbILqPiuOWwy66PTTb44ap7gdgT3y648ICnzQAYiWWVFJzapt1
/YHX5HBqlLAefUM6m1MSvzeBrD9vWg==
=r9X/
-----END PGP SIGNATURE-----

--Sig_/jfVupS0VJoKj+fs5F1quxlL--
