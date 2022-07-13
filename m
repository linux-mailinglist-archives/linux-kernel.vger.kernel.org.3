Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74048572A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 02:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiGMAhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 20:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiGMAhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 20:37:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48B1904CC;
        Tue, 12 Jul 2022 17:37:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LjJbd2h4kz4xZB;
        Wed, 13 Jul 2022 10:37:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657672621;
        bh=wmH100ajOrVlyV6MDX/pgUKDNO0aIQ7V+VErj+gRPwo=;
        h=Date:From:To:Cc:Subject:From;
        b=oyXHgwujNJxAXAYGaHfy5m6AKoSCZX7jI/GnepM8XfkRYdiKwnASFNwheyMyYYQ+o
         VCT/gy3X1+68f/l5uUrFG8U3zAbDDF2LBLi9e1Gts8wCR+qmWJtacPa5kdo+8twQXJ
         uoJc3OsU/lpA1uZ+qRXlHs4aEgheNXNxb/Z34ISmKAUT/GG/fZ+c6g1xDXfedX+pbB
         99b8yHsISEVDWuZi00ZuTg7k/u+PLKZ0lIE0NTyDpl10ric8z4RVqG7x0DrWKzW4mu
         L0hyoAgTdPkVnXcDfRR6/ZZyWUm4v2NemgOkqTtoNk8gYpWxm4CDz55TCF5Xgr2Mnw
         WqmIMtiBkinpg==
Date:   Wed, 13 Jul 2022 10:37:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the v9fs tree
Message-ID: <20220713103700.2d6023d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M9HmHV_so+8XafTR1viig7f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M9HmHV_so+8XafTR1viig7f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  net/9p/client.c

between commit:

  c249fb4f9193 ("9p: roll p9_tag_remove into p9_req_put")

from the v9fs tree and commit:

  f0be81780879 ("9p: convert to advancing variant of iov_iter_get_pages_all=
oc()")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc net/9p/client.c
index 9aaef9c90666,cb4324211561..000000000000
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@@ -1604,32 -1526,34 +1522,34 @@@ p9_client_read_once(struct p9_fid *fid
  	}
 =20
  	*err =3D p9pdu_readf(&req->rc, clnt->proto_version,
- 			   "D", &count, &dataptr);
+ 			   "D", &received, &dataptr);
  	if (*err) {
+ 		if (!non_zc)
+ 			iov_iter_revert(to, count - iov_iter_count(to));
  		trace_9p_protocol_dump(clnt, &req->rc);
 -		p9_tag_remove(clnt, req);
 +		p9_req_put(clnt, req);
  		return 0;
  	}
- 	if (rsize < count) {
- 		pr_err("bogus RREAD count (%d > %d)\n", count, rsize);
- 		count =3D rsize;
+ 	if (rsize < received) {
+ 		pr_err("bogus RREAD count (%d > %d)\n", received, rsize);
+ 		received =3D rsize;
  	}
 =20
  	p9_debug(P9_DEBUG_9P, "<<< RREAD count %d\n", count);
 =20
  	if (non_zc) {
- 		int n =3D copy_to_iter(dataptr, count, to);
+ 		int n =3D copy_to_iter(dataptr, received, to);
 =20
- 		if (n !=3D count) {
+ 		if (n !=3D received) {
  			*err =3D -EFAULT;
 -			p9_tag_remove(clnt, req);
 +			p9_req_put(clnt, req);
  			return n;
  		}
  	} else {
- 		iov_iter_advance(to, count);
+ 		iov_iter_revert(to, count - received - iov_iter_count(to));
  	}
 -	p9_tag_remove(clnt, req);
 +	p9_req_put(clnt, req);
- 	return count;
+ 	return received;
  }
  EXPORT_SYMBOL(p9_client_read_once);
 =20
@@@ -1668,23 -1594,24 +1590,24 @@@ p9_client_write(struct p9_fid *fid, u6
  			break;
  		}
 =20
- 		*err =3D p9pdu_readf(&req->rc, clnt->proto_version, "d", &count);
+ 		*err =3D p9pdu_readf(&req->rc, clnt->proto_version, "d", &written);
  		if (*err) {
+ 			iov_iter_revert(from, count - iov_iter_count(from));
  			trace_9p_protocol_dump(clnt, &req->rc);
 -			p9_tag_remove(clnt, req);
 +			p9_req_put(clnt, req);
  			break;
  		}
- 		if (rsize < count) {
- 			pr_err("bogus RWRITE count (%d > %d)\n", count, rsize);
- 			count =3D rsize;
+ 		if (rsize < written) {
+ 			pr_err("bogus RWRITE count (%d > %d)\n", written, rsize);
+ 			written =3D rsize;
  		}
 =20
  		p9_debug(P9_DEBUG_9P, "<<< RWRITE count %d\n", count);
 =20
 -		p9_tag_remove(clnt, req);
 +		p9_req_put(clnt, req);
- 		iov_iter_advance(from, count);
- 		total +=3D count;
- 		offset +=3D count;
+ 		iov_iter_revert(from, count - written - iov_iter_count(from));
+ 		total +=3D written;
+ 		offset +=3D written;
  	}
  	return total;
  }

--Sig_/M9HmHV_so+8XafTR1viig7f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLOE6wACgkQAVBC80lX
0GwHDAf+N3RkGRKeba+lVvB8QIF5lZx+KkNd1nIH7W84vo3xBqbIMY0sCKKUp3LU
Bpoclv5g87EAjA9sgxyUQCt0izkT2IPsSzsiWxrjsMCg4A75n4ShdUjM4xNd1wFI
34UqxQexBvBKw4k3ut4nLElVxIffRDwoL14eyJmEhoEQkTu/Sk7Gc4HTBMAnUMak
ltoawstaNaHw/62mV/mDQRbm4iYSKBYqkYuhf5VbKWXUVlK54PyVQy7uhM0mQXrV
8lJ4GWs1VYSZ1NHEgz933cpdUz7b/6MuIbkajvqmtmcfGuyi471/r4sGiDsI/g9j
wU7fKb8oA+wZ3bZKfAUiPCMA2PaT6g==
=Ey4h
-----END PGP SIGNATURE-----

--Sig_/M9HmHV_so+8XafTR1viig7f--
