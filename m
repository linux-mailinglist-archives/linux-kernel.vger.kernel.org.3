Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E1D4CF0B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 05:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbiCGElM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 23:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiCGElK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 23:41:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EBA50E27;
        Sun,  6 Mar 2022 20:40:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBm3H6j4Fz4xvc;
        Mon,  7 Mar 2022 15:40:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646628015;
        bh=Skx7w42lXX4Na6TJ6HNOxxMbl1TjV3IviKBd7kMLL70=;
        h=Date:From:To:Cc:Subject:From;
        b=TRSKb2vx54nCQ6feTyyaR+I/m2konJQpkq7M7/7WpOtQ05tosGrW38YDL4UFoA1dU
         jzdZogDAuQYCFlu6NiubC+pWHyXkSPw114Tj7QjhufkKDT8ZSVz/XJ2trltKakJamm
         OliNCZNG9r3m5Pm+YgiOnoyOjCQwB3AU1fUKolkFBdfCs9xQ7hM3RqBoAersDab8z1
         cmSiojZOzrlbd3EUYxNRNQGJWSRjNWWQpgvIuguBEaCjI3LbIQ4OtADKbSa/jCEgrs
         kllyaN2Pa9gY7sc+t1pAAn2yVJnSmp74YrcbIVC408QI/N6vnO81O9EvV2L+TobQC+
         hgBpgEQVACecg==
Date:   Mon, 7 Mar 2022 15:40:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the vhost tree
Message-ID: <20220307154011.6d456f28@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KeU6xk1rng=pDzvcyomL2+d";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KeU6xk1rng=pDzvcyomL2+d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vhost tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/net/virtio_net.c: In function 'virtnet_rx_vq_reset':
drivers/net/virtio_net.c:1823:63: warning: format '%ld' expects argument of=
 type 'long int', but argument 3 has type 'int' [-Wformat=3D]
 1823 |                    "reset rx reset vq fail: rx queue index: %ld err=
: %d\n",
      |                                                             ~~^
      |                                                               |
      |                                                               long =
int
      |                                                             %d
 1824 |                    rq - vi->rq, err);
      |                    ~~~~~~~~~~~                                =20
      |                       |
      |                       int
drivers/net/virtio_net.c: In function 'virtnet_tx_vq_reset':
drivers/net/virtio_net.c:1873:63: warning: format '%ld' expects argument of=
 type 'long int', but argument 3 has type 'int' [-Wformat=3D]
 1873 |                    "reset tx reset vq fail: tx queue index: %ld err=
: %d\n",
      |                                                             ~~^
      |                                                               |
      |                                                               long =
int
      |                                                             %d
 1874 |                    sq - vi->sq, err);
      |                    ~~~~~~~~~~~                                =20
      |                       |
      |                       int

Introduced by commit

  920ee0c540a2 ("virtio_net: support rx/tx queue reset")

--=20
Cheers,
Stephen Rothwell

--Sig_/KeU6xk1rng=pDzvcyomL2+d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIljKsACgkQAVBC80lX
0Gx1VQgAkki+U9LBwj3xngs0Gxri/4EYCiJF7zauxozIAi+ORzXykwU4txz22oef
RI1HBZ6oGgB1m2su/F1clr2tRA+g3gzI4tJajYNryqPxf1I8aKzcYPh3o1/ErG8L
UoGmhBiGR5Zb/7NtBfuMTK+fEGBZcdTkYPhVUZDQk0ZsLMhoHD7fIhNVJIT8tmlp
PZ9FN/jnjaZyU1hr8Ffia4b9BocCNt8twCFgxWzL7xwHj9Klh4Gq2232ApxVWLyB
ii1zjkiWOjQ6xjbR1wQcL0PDB3DX60wuq/KF+feoGFpzbFKgwtwM40AeUT5LZb/n
dh2IFjyLOboYLrG2rIyMyTBAbyfHCA==
=pyXm
-----END PGP SIGNATURE-----

--Sig_/KeU6xk1rng=pDzvcyomL2+d--
