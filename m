Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA2D508073
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350066AbiDTFTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiDTFTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:19:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEAB33EA2;
        Tue, 19 Apr 2022 22:16:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KjpmX5TLjz4xL3;
        Wed, 20 Apr 2022 15:16:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650431773;
        bh=ohQm0ybDAEeCD6ANA3z5Cyaa8KYCNzq1SGorUbpPK8A=;
        h=Date:From:To:Cc:Subject:From;
        b=hZn+sS7jI9Yjvtjs9ZE6kF+WJbGt3JGgIXtKCp5d2myGsXgM3jhpQXvzXku2zOIs5
         EEdDRzhTHpNM1iAcF3mUCQIt1XpZbBwXgp9ab4oPKsukbSBFbLDgppKWMCqKM6VWWW
         XTSwq8eATKlGKDD+YB9SvQYywij7+bH8ORtJezjgYClYZ+Qe8NIJs1I2FcKX1LNe0g
         ZC2nxxj9llELo+kqTUMcL4l0J8P9b9+5PKVuDbBkP61PU00HDEJXiVheaIKB+i9yIo
         V4jxfrBXdPFJZRCzsP2BTrcXhrcYSsqz7ehTxvDlGELlE8NFVA5nDR9P9ZNt1eH4RP
         rYzC9YkyXeNUA==
Date:   Wed, 20 Apr 2022 15:16:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: linux-next: manual merge of the kunit-next tree with the
 thunderbolt tree
Message-ID: <20220420151612.117f84b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HvMgL7h4QdUD.vekO5RYSY0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HvMgL7h4QdUD.vekO5RYSY0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kunit-next tree got a conflict in:

  drivers/thunderbolt/test.c

between commit:

  9d2d0a5cf0ca ("thunderbolt: Use different lane for second DisplayPort tun=
nel")

from the thunderbolt tree and commit:

  7aadf8433357 ("thunderbolt: test: use NULL macros")

from the kunit-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/thunderbolt/test.c
index 66b6e665e96f,be9b1d7e63d2..000000000000
--- a/drivers/thunderbolt/test.c
+++ b/drivers/thunderbolt/test.c
@@@ -1348,8 -1348,8 +1348,8 @@@ static void tb_test_tunnel_dp(struct ku
  	in =3D &host->ports[5];
  	out =3D &dev->ports[13];
 =20
 -	tunnel =3D tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 +	tunnel =3D tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0);
- 	KUNIT_ASSERT_TRUE(test, tunnel !=3D NULL);
+ 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
  	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
  	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
  	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
@@@ -1394,8 -1394,8 +1394,8 @@@ static void tb_test_tunnel_dp_chain(str
  	in =3D &host->ports[5];
  	out =3D &dev4->ports[14];
 =20
 -	tunnel =3D tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 +	tunnel =3D tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0);
- 	KUNIT_ASSERT_TRUE(test, tunnel !=3D NULL);
+ 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
  	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
  	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
  	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
@@@ -1444,8 -1444,8 +1444,8 @@@ static void tb_test_tunnel_dp_tree(stru
  	in =3D &dev2->ports[13];
  	out =3D &dev5->ports[13];
 =20
 -	tunnel =3D tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 +	tunnel =3D tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0);
- 	KUNIT_ASSERT_TRUE(test, tunnel !=3D NULL);
+ 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
  	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
  	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
  	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
@@@ -1509,8 -1509,8 +1509,8 @@@ static void tb_test_tunnel_dp_max_lengt
  	in =3D &dev6->ports[13];
  	out =3D &dev12->ports[13];
 =20
 -	tunnel =3D tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 +	tunnel =3D tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0);
- 	KUNIT_ASSERT_TRUE(test, tunnel !=3D NULL);
+ 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
  	KUNIT_EXPECT_EQ(test, tunnel->type, TB_TUNNEL_DP);
  	KUNIT_EXPECT_PTR_EQ(test, tunnel->src_port, in);
  	KUNIT_EXPECT_PTR_EQ(test, tunnel->dst_port, out);
@@@ -1627,8 -1627,8 +1627,8 @@@ static void tb_test_tunnel_port_on_path
  	in =3D &dev2->ports[13];
  	out =3D &dev5->ports[13];
 =20
 -	dp_tunnel =3D tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 +	dp_tunnel =3D tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0);
- 	KUNIT_ASSERT_TRUE(test, dp_tunnel !=3D NULL);
+ 	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel);
 =20
  	KUNIT_EXPECT_TRUE(test, tb_tunnel_port_on_path(dp_tunnel, in));
  	KUNIT_EXPECT_TRUE(test, tb_tunnel_port_on_path(dp_tunnel, out));
@@@ -2009,8 -2009,8 +2009,8 @@@ static void tb_test_credit_alloc_dp(str
  	in =3D &host->ports[5];
  	out =3D &dev->ports[14];
 =20
 -	tunnel =3D tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 +	tunnel =3D tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0);
- 	KUNIT_ASSERT_TRUE(test, tunnel !=3D NULL);
+ 	KUNIT_ASSERT_NOT_NULL(test, tunnel);
  	KUNIT_ASSERT_EQ(test, tunnel->npaths, (size_t)3);
 =20
  	/* Video (main) path */
@@@ -2245,8 -2245,8 +2245,8 @@@ static struct tb_tunnel *TB_TEST_DP_TUN
 =20
  	in =3D &host->ports[5];
  	out =3D &dev->ports[13];
 -	dp_tunnel1 =3D tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 +	dp_tunnel1 =3D tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0);
- 	KUNIT_ASSERT_TRUE(test, dp_tunnel1 !=3D NULL);
+ 	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel1);
  	KUNIT_ASSERT_EQ(test, dp_tunnel1->npaths, (size_t)3);
 =20
  	path =3D dp_tunnel1->paths[0];
@@@ -2282,8 -2282,8 +2282,8 @@@ static struct tb_tunnel *TB_TEST_DP_TUN
 =20
  	in =3D &host->ports[6];
  	out =3D &dev->ports[14];
 -	dp_tunnel2 =3D tb_tunnel_alloc_dp(NULL, in, out, 0, 0);
 +	dp_tunnel2 =3D tb_tunnel_alloc_dp(NULL, in, out, 1, 0, 0);
- 	KUNIT_ASSERT_TRUE(test, dp_tunnel2 !=3D NULL);
+ 	KUNIT_ASSERT_NOT_NULL(test, dp_tunnel2);
  	KUNIT_ASSERT_EQ(test, dp_tunnel2->npaths, (size_t)3);
 =20
  	path =3D dp_tunnel2->paths[0];

--Sig_/HvMgL7h4QdUD.vekO5RYSY0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJflxwACgkQAVBC80lX
0Gzg4wf/aVZoT/xHLpQPZ30rJJ9daCNzl3IO1BWeYcgeR2sMdvSPeYx2mfabcbST
lhqaC1BxUV6AkWEZjSpUE1BYcVCiDEFY4pfo6XkEvKhIJBWPRXz/k9vEbRSSrlfZ
VA/hNjWyzWal/Xixt3r1IBFk6+js1wVNtTSosXPFH/w+sXUVGuPJwhSwgDOEaf//
IZqTS1Y/sqwdICQkJahd7DygYgk3tTufaPh1qMRF4qlgZ+cBzeSuNrDkbNdDjETX
5sfw0zxqlu688GaTJDL0rM/GCBWu40Fp3KamYDODlPdEjZ+QK6h0/q5Nj5vl5nlu
TgvpA9bNNuoJ9YJUlEYf7mV8OiCxEg==
=plfX
-----END PGP SIGNATURE-----

--Sig_/HvMgL7h4QdUD.vekO5RYSY0--
