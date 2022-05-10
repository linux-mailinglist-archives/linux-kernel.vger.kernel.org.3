Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB15520A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiEJA3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiEJA3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:29:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF4C29C89;
        Mon,  9 May 2022 17:25:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxzMN5Vnhz4xTX;
        Tue, 10 May 2022 10:25:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652142306;
        bh=U/bLL5rAJ04MddIGEAl1yJGQ6eFlpN952WRrVKixc/4=;
        h=Date:From:To:Cc:Subject:From;
        b=UTxdj9Gng8Y1CoIP/todBd98Ssv0FtwftM8bVKBftLsVvNXQud2XqhZlS2Zb9L6xB
         RZglmZcvjg8Nj3PAuzevijNjJm0VOaCFtFjXqEUVqZboSYuG4hfH+9Zr45vVg9HEjB
         ltnunXotFvdtuWbkTCZROltqo70MlgYfbniFafViBItD9LnFhywRoz6gUvZoXEYL9M
         QhoMJWcCOwmi8HFD7krtJYEbdwp92SCH0ew0+XGoWii8DRetVK166RLQEPypYcJ+t9
         swRak+weTFuux8z+iEM540M8L+jvoN8si7LVQjSdSphUWf+FZvv66ri5z9K/hHUUpf
         aOu3IB+8z6aHg==
Date:   Tue, 10 May 2022 10:24:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        David Sterba <dsterba@suse.cz>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the gfs2 tree with the btrfs tree
Message-ID: <20220510102458.0ab0172f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I3KPZVnYWc7GqTNfMyrkRXw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I3KPZVnYWc7GqTNfMyrkRXw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the gfs2 tree got a conflict in:

  fs/gfs2/file.c

between commit:

  39c93b0bf7a6 ("iomap: add per-iomap_iter private data")

from the btrfs tree and commit:

  db0c1968e935 ("gfs2: Variable rename")

from the gfs2 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/gfs2/file.c
index 76307a90bf81,d18a7c2201c0..000000000000
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@@ -839,11 -839,12 +839,12 @@@ retry_under_glock
  	pagefault_disable();
  	to->nofault =3D true;
  	ret =3D iomap_dio_rw(iocb, to, &gfs2_iomap_ops, NULL,
- 			   IOMAP_DIO_PARTIAL, NULL, written);
 -			   IOMAP_DIO_PARTIAL, read);
++			   IOMAP_DIO_PARTIAL, NULL, read);
  	to->nofault =3D false;
  	pagefault_enable();
+ 	/* No increment (+=3D) because iomap_dio_rw returns a cumulative value. =
*/
  	if (ret > 0)
- 		written =3D ret;
+ 		read =3D ret;
 =20
  	if (should_fault_in_pages(ret, to, &prev_count, &window_size)) {
  		size_t leftover;
@@@ -906,7 -908,7 +908,7 @@@ retry_under_glock
 =20
  	from->nofault =3D true;
  	ret =3D iomap_dio_rw(iocb, from, &gfs2_iomap_ops, NULL,
- 			   IOMAP_DIO_PARTIAL, NULL, read);
 -			   IOMAP_DIO_PARTIAL, written);
++			   IOMAP_DIO_PARTIAL, NULL, written);
  	from->nofault =3D false;
 =20
  	if (ret =3D=3D -ENOTBLK)

--Sig_/I3KPZVnYWc7GqTNfMyrkRXw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ5sNoACgkQAVBC80lX
0GxD4QgAmX+CHRc11ucoONaj3dsjpYuxYdqwvuAT51cnvh5WGc/8G09WyQ3pEvf+
4lnDdtwbo4Yjc4/mnyzdDcjUKMgv9Ac4oLDvzLtvhkufy7bpdqLT0TS8/yFqnjMm
7EWAbTIMBUccmXz9b8SZRcgMGrOLaAqGp751FxKLEw5MDmptFLPysBMxXMWLKVcK
A9HEo+hZZazHwJmkUJPBmSl04Pw8jmpqc+bMckUcdmPHmbYKZ4rC3zyPY+m31SHf
LibouplYJfuhZCx6kfd5UzvJaGQN91jVltGHy/T1caXCd0w8TPEWTGgbSDsALPg0
aDRJsC5AErVzWg9Si3rCYBhkI+I6bg==
=WxL/
-----END PGP SIGNATURE-----

--Sig_/I3KPZVnYWc7GqTNfMyrkRXw--
