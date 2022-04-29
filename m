Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF5C514176
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 06:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbiD2EjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 00:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237489AbiD2Eip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 00:38:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1011A8FF9F;
        Thu, 28 Apr 2022 21:35:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KqKRB5d1qz4x7Y;
        Fri, 29 Apr 2022 14:35:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651206921;
        bh=XRK02m0YRBnw3sdEEHgmBiUzgatUEgLw0RNhgGm0qK8=;
        h=Date:From:To:Cc:Subject:From;
        b=GGSEqi0mxcSkyaTm6FXgqT3YNu/kXtQERZQmWud6nBUm1RnUW+UEp2OMPlDiXx5WV
         oSFqgY2XH1+y9qFH+yFkGi+K9wOXtv2GMymZmNhn4Tv55BZrnXNPkeuy/7R176f+pR
         ZsX8zWJHmOsAWjzoilSu5FAtdhlngX2XnmM490tuFYBabpXWnhHOHxaLreSOXUfGZ9
         ycqxLmT13eJDIeSc5lqllPIvVKq7hSG6dawxklKql2Hrs7QgwZrJx4MPgk9xURrY3K
         3ZLBuXvuVl03Y4DHXN34KFDqdzF2tDFG9Hf0Anww7w5uoeS6bmyRdzDKUB1LadbnVC
         3iFZuQM642S9A==
Date:   Fri, 29 Apr 2022 14:35:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Jose Cazarin <joseespiriki@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>
Subject: linux-next: manual merge of the iio tree with the char-misc.current
 tree
Message-ID: <20220429143517.75be9c04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fzORYtNOOQ584lP8rCFAe3+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fzORYtNOOQ584lP8rCFAe3+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iio tree got a conflict in:

  drivers/iio/dac/ti-dac5571.c

between commit:

  a2a43fd9d84a ("iio: dac: dac5571: Fix chip id detection for OF devices")

from the char-misc.current tree and commit:

  542fd5f1f657 ("iio: dac: ti-dac5571: add support for ti,dac121c081")

from the iio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/iio/dac/ti-dac5571.c
index 0b775f943db3,96b86e2dcc6b..000000000000
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@@ -393,15 -386,16 +394,16 @@@ static int dac5571_remove(struct i2c_cl
  }
 =20
  static const struct of_device_id dac5571_of_id[] =3D {
 -	{.compatible =3D "ti,dac5571"},
 -	{.compatible =3D "ti,dac6571"},
 -	{.compatible =3D "ti,dac7571"},
 -	{.compatible =3D "ti,dac5574"},
 -	{.compatible =3D "ti,dac6574"},
 -	{.compatible =3D "ti,dac7574"},
 -	{.compatible =3D "ti,dac5573"},
 -	{.compatible =3D "ti,dac6573"},
 -	{.compatible =3D "ti,dac7573"},
 -	{.compatible =3D "ti,dac121c081"},
 +	{.compatible =3D "ti,dac5571", .data =3D (void *)single_8bit},
 +	{.compatible =3D "ti,dac6571", .data =3D (void *)single_10bit},
 +	{.compatible =3D "ti,dac7571", .data =3D (void *)single_12bit},
 +	{.compatible =3D "ti,dac5574", .data =3D (void *)quad_8bit},
 +	{.compatible =3D "ti,dac6574", .data =3D (void *)quad_10bit},
 +	{.compatible =3D "ti,dac7574", .data =3D (void *)quad_12bit},
 +	{.compatible =3D "ti,dac5573", .data =3D (void *)quad_8bit},
 +	{.compatible =3D "ti,dac6573", .data =3D (void *)quad_10bit},
 +	{.compatible =3D "ti,dac7573", .data =3D (void *)quad_12bit},
++	{.compatible =3D "ti,dac121c081", data =3D (void *)single_12bit},
  	{}
  };
  MODULE_DEVICE_TABLE(of, dac5571_of_id);

--Sig_/fzORYtNOOQ584lP8rCFAe3+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJrawUACgkQAVBC80lX
0GxtLAf/SiElYfdPVHT3/ioU0KMYx5jZ2VvaBAUgYKJrowQRTkwmPXaFyOH/mNVF
9qJA1iAgwxkDEWZL0IajmRqpCZe7HoHT0DnnVy+howmbgkWOYVJBuJflgiOJmz+t
HYeA6FWJMmPN89aswf9XnJU//llcyokNq4oKIEyNbfF0Hd00qxLyrYLdkj6QRp6E
VbxsfILRqwSexJPSVVBbjBMDkc+Z0TmkLDjf0yoJvcF/srO4ApDWeMog4Is13B7/
qwBQByhvInfiK+xX8g1y05ywhSzxcNFB3URl8DglgJyr0h/QKokUY2z8dn+o/fK2
ZS5WUqkN8nMg1GweZcuiGjzHeWahOQ==
=CTu9
-----END PGP SIGNATURE-----

--Sig_/fzORYtNOOQ584lP8rCFAe3+--
