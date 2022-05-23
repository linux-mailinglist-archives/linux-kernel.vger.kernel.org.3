Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE78A5306EE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 02:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiEWA5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 20:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiEWA5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 20:57:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EEC33A19;
        Sun, 22 May 2022 17:57:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L5zSy5xLWz4xD2;
        Mon, 23 May 2022 10:57:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653267459;
        bh=fUDCzyj8Af0DxC4DaymxJY9DuT/QAHJbfvkEmZ++sfc=;
        h=Date:From:To:Cc:Subject:From;
        b=YfwlUuXGEhtBQES05yQLIcEpzB6pQMTo2r47U1ydiszQ3c2IoF9GKQFTblM9f+6Av
         mg7d4eKtd2cEQ9rhLj62q5rVioJ8gwFe1DwuV9ZjjJbUevmFm83KdW5Gw++IxZmciS
         8hmIJawlOYxw8xX97rhGGwyrCXyIaa4+fCpnqogFZT5HxpCFo2bk2Nfa+xmThUJfGl
         LMu4dlwD/MTQ54nCAI8N2IyLCwxHVz1dodcxj07S8UvcoLRCdSbQ1EA/aiQ/NdUWXZ
         dn4FV8e5kB9wFxWlMiqtaJyTIPrY/Qcg75PpGypG0JmBQy9Tdb7U3QWjf0nAe9T7yT
         2xLVxK77Y1Jng==
Date:   Mon, 23 May 2022 10:57:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the cifs tree
Message-ID: <20220523105736.1f42b837@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6yHFA/DI6U9t6CSTyBAS29o";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6yHFA/DI6U9t6CSTyBAS29o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cifs tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

fs/cifs/connect.c: In function 'is_path_remote':
fs/cifs/connect.c:3436:14: warning: unused variable 'nodfs' [-Wunused-varia=
ble]
 3436 |         bool nodfs =3D cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS;
      |              ^~~~~

Introduced by commit

  421ef3d56513 ("cifs: don't call cifs_dfs_query_info_nonascii_quirk() if n=
odfs was set")

--=20
Cheers,
Stephen Rothwell

--Sig_/6yHFA/DI6U9t6CSTyBAS29o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKK3AAACgkQAVBC80lX
0Gy8FQf/Y/Lv0gfLSOK2iF9IloLXDFfqU+OpGTraYddMNTO++b5tBmagQWLfe7NS
R0wGQvryOFThdngSEhFmN43A07W2QUi5QG1A0khY4h5TXSUoVSHNvZ716Or0SgS2
vnUOkHh9isFqcFCQnsIndRAvsofq313K852Hsd9N6K5Jqbfz6phZm5F39V2IXLNP
1n0gWXUurZ046LHQf5T5yLd3/LOxPnVyyrktl6JQKAELAsmDBEF4zlOIKXnS9SnJ
6+TQMKnhEOr5/YBefeWCx7SN3lHlCiPkRD8GBmgVTbzht80INQ5wUdiI5SKzlSvY
yURyBYynK2/mOkVUbO+3OxCgu28j5w==
=w341
-----END PGP SIGNATURE-----

--Sig_/6yHFA/DI6U9t6CSTyBAS29o--
