Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231B359663C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 02:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237916AbiHQAHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 20:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbiHQAHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 20:07:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A093E5E568;
        Tue, 16 Aug 2022 17:07:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M6pHM4qH4z4x7X;
        Wed, 17 Aug 2022 10:07:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660694848;
        bh=X7mST+yYyaoOV2wp5pw01+Z72H1f0M1ZT6KDi1Gsk+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D8vw3PMWxcNrIZ0hDSf7zSbcfCdTwG8rXV5DDqW9WrthJaO7+7qu6HoCJ2FNIhqFs
         UpoaQRKxRtJZr3Cg9fjVoVPLk4iS18yaYZjp3Z6QhL8nnZORbOJxzKJl556ls4l9SX
         lHoQd51bgoWSCebo6uw64tRr5Uvk/JD1Dnoj1651OYq4Z8Gq+/nxx6F7CuaERuENXR
         BmZPlWaogu4C3u1+gq87DNXTibZ6feVkHyQ+mkj6Hj5nZDZijmx+p1+U8MR9qDOqE0
         6Dt6hK4ZIP8UMpzBbnOypLSgLWfl6/jdc64/rIynaF8MwYPege84JZZRtWgqqHV17D
         FFBw+VYL/huag==
Date:   Wed, 17 Aug 2022 10:07:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Wolfram Sang <wsa@kernel.org>
Subject: Re: linux-next: build failure after merge of the input tree
Message-ID: <20220817100726.1aaf04cb@canb.auug.org.au>
In-Reply-To: <20220817100007.2827652a@canb.auug.org.au>
References: <20220817100007.2827652a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZPRvAi7L5s4_.nvCduDQ1rQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZPRvAi7L5s4_.nvCduDQ1rQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 17 Aug 2022 10:00:07 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the input tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/input/misc/ibm-panel.c:195:19: error: initialization of 'void (*)=
(struct i2c_client *)' from incompatible pointer type 'int (*)(struct i2c_c=
lient *)' [-Werror=3Dincompatible-pointer-types]
>   195 |         .remove =3D ibm_panel_remove,
>       |                   ^~~~~~~~~~~~~~~~
> drivers/input/misc/ibm-panel.c:195:19: note: (near initialization for 'ib=
m_panel_driver.remove')
>=20
> Caused by commit
>=20
>   95331e91e9da ("Input: Add IBM Operation Panel driver")
>=20
> interacting with commit
>=20
>   ed5c2f5fd10d ("i2c: Make remove callback return void")
>=20
> from v6.0-rc1.

Actually it is from the i2c tree and not in Linus' tree.  Sorry about
that.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZPRvAi7L5s4_.nvCduDQ1rQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL8MT4ACgkQAVBC80lX
0GzW4Qf7BYSzHMlldxky1SKMNf6zwlW+iYEeq77+3SWATLgo6+/WZu0SOBXprry6
DPw6uLUGFdU5pjCW317Vi00d9O2AixdUgpA/Zg5jK55qZBs/B5p4tf/lg+hYIa0B
+/Np27qmEjDI+Y7/g6fTNVVh8CMZnY8/m1uOgurS3nNjNIBGKUZ8CTWmAJ5+4lyF
JwtSKlkufnN332LGt06s9Ecw+bZTL0AE4vRFYbCou1bxdxRDYKfUHH6VrDD6JI+T
uU/+QSWKqj3g8ULuKjUbRmX8KIjO22SspzYsEW0O34PZ+VUU4Dl8Xqmn7lLc3J4f
EEHHXuwhS+AUiNCmVN030xlz2wwSlQ==
=P3As
-----END PGP SIGNATURE-----

--Sig_/ZPRvAi7L5s4_.nvCduDQ1rQ--
