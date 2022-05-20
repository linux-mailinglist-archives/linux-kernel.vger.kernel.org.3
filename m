Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D8852E1BC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344233AbiETBOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiETBOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:14:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C702D9E87;
        Thu, 19 May 2022 18:14:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L47zx13rQz4xD3;
        Fri, 20 May 2022 11:14:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653009277;
        bh=KGHuo0pOnphFmXsNxGt1++Zt2qGBcDd2u6R3YD4xIdU=;
        h=Date:From:To:Cc:Subject:From;
        b=p8jzjmGU7iRyAy6Xqk0dQbsbRkAeet0U+SMQZJ9BtNLF7Ac23c8lLhy4e9ZkbBhfq
         hnkTXW7eLBjpjeyMQ+F19YGTB1TPmKfVjY9Ikyz65PbNN98yDMHoH+IwjugnmUKH8+
         +xtgMfxAAQDWsp2+rAUs08bVhaCqeCW69ZYjE8kH6CHTO72L1cEXsIbtBiL2OxfqZj
         H9IAFNCHQK8Yr8w9B5/icpCBFsZHwP2ji9Ij9qxHr3LWzPWwg6/z8l9qem+PgVPBvx
         Gx76k33uBzx+rf1+/1zhsDbfHydjKepXbWMjTapCT9q7YZJ1beThRtsFPNAYe7QbbK
         6uyhuP5Xj7xJw==
Date:   Fri, 20 May 2022 11:14:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the fscache tree
Message-ID: <20220520111435.34d660d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NG=CYKoXHCq/tLUihblEgOB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NG=CYKoXHCq/tLUihblEgOB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the fscache tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/cifs/fscache.c: In function 'cifs_fscache_get_inode_cookie':
fs/cifs/fscache.c:106:14: error: 'struct cifsInodeInfo' has no member named=
 'netfs_ctx'
  106 |         cifsi->netfs_ctx.cache =3D
      |              ^~
fs/cifs/fscache.c: In function 'cifs_fscache_release_inode_cookie':
fs/cifs/fscache.c:134:22: error: 'struct cifsInodeInfo' has no member named=
 'netfs_ctx'
  134 |                 cifsi->netfs_ctx.cache =3D NULL;
      |                      ^~

Caused by commit

  a3457aa9c40f ("netfs: Fix gcc-12 warning by embedding vfs inode in netfs_=
i_context")

I have used the fscache tree from next-20220519 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/NG=CYKoXHCq/tLUihblEgOB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKG63sACgkQAVBC80lX
0GyNWwf9EBAYijD5EV3RKTxBne8rImoRqVGGzH0yt9JHysCVDSi/HvDf/nua/y2/
ZQtm42SOqfB3VcEkotxCou8XAaTkCy3FAz4uZj7iTjDFuXpEHJJanr0Z0c2tn/Oo
HNouAqxHciRgYEpFK2o1Gm55LXsWhFVLh7VrmoaKjjBJhL+2LaHbRZg9vH/j+7uk
tdEElzQUkoeZpWZ1eGE/wqcwHM587s5nte7PxVNWVKKDkv/AERoG+X1nc3w/Pevf
stsJlOBpUUXVEjSKv0agYKA7hwQxS1ctNjBfvzNn5r5EbHAYkL+N2yf1qNdcVl0O
7/4nCWbMjC138oeVcjuBzSyLYljmpw==
=38K8
-----END PGP SIGNATURE-----

--Sig_/NG=CYKoXHCq/tLUihblEgOB--
