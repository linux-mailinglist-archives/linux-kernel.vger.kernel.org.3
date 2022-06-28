Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C4E55D972
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241592AbiF1AHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiF1AHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:07:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C75E60F5;
        Mon, 27 Jun 2022 17:07:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LX4f235PKz4x7V;
        Tue, 28 Jun 2022 10:07:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656374826;
        bh=n0C8Ew71RuSbb7zCuywn6i1cjvojph9HJLA07PqJJTc=;
        h=Date:From:To:Cc:Subject:From;
        b=GMfxjzNNwQtPYAojOjcI0kk3dcfHgak0I/ZNczS7mbl4LsSPxXgsBz9DQ0sy0pJSE
         eWIsGpITuskDUbSLM9QPfsVdvpihax2jM8XHBxszW0XUOXPUb8Uur/eDUKpT7BW7cC
         RkrJlv++6955ojx4YiOAgpWyQ6tQypZUjmX+aaqATggloErcQ++rf3ySJsWdG38/qN
         LNQzxGLgjN0JRv8Tp8ydHNdBSVqLCCOnnFPHrKGkRI7RH1RoRMHILzGc3aZfANHrLO
         lRczhAMs+aZE8vGpaj+DX5bLKemzwN70W7l6+fOkFqX1CpE+AX40PXh4SrxA/uxAux
         urcEhVzf1DgFQ==
Date:   Tue, 28 Jun 2022 10:07:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the broadcom tree
Message-ID: <20220628100705.449df135@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0hD+4M5d1KbjO28OBD5BzVh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0hD+4M5d1KbjO28OBD5BzVh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the broadcom tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/soc/bcm/bcm2835-power.c: In function 'bcm2835_power_probe':
drivers/soc/bcm/bcm2835-power.c:643:31: error: 'struct bcm2835_pm' has no m=
ember named 'rpivid_asb'
  643 |         power->rpivid_asb =3D pm->rpivid_asb;
      |                               ^~

Caused by commit

  d5eba4a03b1d ("soc: bcm: bcm2835-power: Add support for BCM2711's RPiVid =
ASB")

I have used the broadcom tree from next-20220627 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/0hD+4M5d1KbjO28OBD5BzVh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmK6RikACgkQAVBC80lX
0GyZpwf/dvu6lj8a0Au2pQRQPF8O6PAg76156SCWY6RwM7cyWh2Z6N/OZn6RqlLF
A7LsXado5qqv+vexCHQ61jYYNBMT6nOhCwTEJ9jdPphOGvTQ2q3jklcjiowsxV4+
GmDiq0hAQ30v0kTZIXQF+yFWacMVGRaoVWmKqvl1XNFXN9PUbRqDonUP1JduV1yD
bMAC+PfViR9qOG6ikmk2dRqAk4GlHLVkHjjg0vb59PPgfLceWwCHYESA0KxbHy3F
8HnftQdEgnjg6gf+mzMAn/G6HDUOhzYFtjaSxQ7EIBzhMMuJ3zlcdPJFUhvqILWX
eG/w7CZpHYzynjLXd24HyOARGsRKCA==
=BJBG
-----END PGP SIGNATURE-----

--Sig_/0hD+4M5d1KbjO28OBD5BzVh--
