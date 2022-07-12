Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35315710CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 05:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiGLDYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 23:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGLDYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 23:24:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AC1BF44;
        Mon, 11 Jul 2022 20:24:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LhmM13YtPz4xD0;
        Tue, 12 Jul 2022 13:24:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657596253;
        bh=Wwl/SRlzmgky0H1M2Q123D86lnMqoO0qrvtqbbgBEyE=;
        h=Date:From:To:Cc:Subject:From;
        b=qjRsfiB6S28hQ3zthDhs1CYmrFF1CeoCkPTWeJ150kmAu07k41eK2WDHgxlYtGhcI
         7HTHLnNdGG7sKjaZJNaKmNQ3kmLEtYa5EJuAsx9QSR5bxX5TWKJ44TShvdZkFlQ4wZ
         fYwc7/E85sXh0073xGjXVIhGxZ68gxyh6vBXN2yBrL4ehnKkMgUDlM71ln8jOfc5wu
         IoKivbVQS3lgQMz3YbLKjYk5lvnUUXjDiUqyiOaw3AS4qrPXRCUJTOqquNrwPWRKTp
         T2t/mld82n2BE0+t2jcGQZg2JLvJN7MDMM/nX9d85HA92vZtkufPrHn+IuIENeGItU
         RkEjhdbgzd6bQ==
Date:   Tue, 12 Jul 2022 13:23:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the apparmor tree
Message-ID: <20220712132339.383219ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gnY2l1L842n58wNYaTqO6I9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gnY2l1L842n58wNYaTqO6I9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the apparmor tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from security/apparmor/include/policy.h:29,
                 from security/apparmor/include/policy_ns.h:19,
                 from security/apparmor/include/cred.h:19,
                 from security/apparmor/net.c:13:
security/apparmor/net.c: In function 'aa_label_sk_perm':
security/apparmor/net.c:148:40: error: 'sock' undeclared (first use in this=
 function)
  148 |         struct aa_sk_ctx *ctx =3D SK_CTX(sock->sk);
      |                                        ^~~~
security/apparmor/include/net.h:54:21: note: in definition of macro 'SK_CTX'
   54 | #define SK_CTX(X) ((X)->sk_security)
      |                     ^
security/apparmor/net.c:148:40: note: each undeclared identifier is reporte=
d only once for each function it appears in
  148 |         struct aa_sk_ctx *ctx =3D SK_CTX(sock->sk);
      |                                        ^~~~
security/apparmor/include/net.h:54:21: note: in definition of macro 'SK_CTX'
   54 | #define SK_CTX(X) ((X)->sk_security)
      |                     ^

Caused by commit

  6ff81169592d ("apparmor: add a kernel label to use on kernel objects")

I have used the apparmor tree from next-20220711 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/gnY2l1L842n58wNYaTqO6I9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLM6TsACgkQAVBC80lX
0Gzclgf/Y/6iffVk+DSlujjISqMEWpRpCJXbZYzwb9fLGhV/BX5v4XHaCpxT/KkN
27iLUcXRH6zKwAPxWlGLerFtzTntBBUJtFkWSnxzZ0cIQpRk74a5S+iX1liqGHcQ
EdSp05K1pDbtMWxfv5073ORT5Dqb23p979Mu3KAc4WcZ8rR0jiDFzTLsyq5lulrS
ws4C/s89tNxTeHZTjmAqU6zfrVJU/OLiVNVxCAOiyw8014UJpo8yWGVRiKjjKhbK
Bmtet+nvPCz5ieyPb4m5/K7A5/z4etKp4GKT/Y3gpfwBr5Eck7cOrF3FkRJ5IBtp
xRlgMmKdxawlS7Yb9HcnF17bB8ospg==
=L7gX
-----END PGP SIGNATURE-----

--Sig_/gnY2l1L842n58wNYaTqO6I9--
