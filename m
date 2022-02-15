Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356B04B5FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbiBOA6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:58:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiBOA6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:58:00 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF4FE0CB;
        Mon, 14 Feb 2022 16:57:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyN3t04P8z4xPt;
        Tue, 15 Feb 2022 11:57:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644886666;
        bh=PPj1tfJgoawvPL9xC+uO9YVexy4zC+LFiKKa8BMgNfo=;
        h=Date:From:To:Cc:Subject:From;
        b=esBDZYWC7rCia5u6+ZbWaDw3KIb9rA1lkcNISL2IKSjqpfCYdVVoRklAu5E4daw0o
         xb0fGETd4rYYbWaeR7mVEwWRYb/HIuw2b1JJfaAx5IwUPonYuaj5bjeVePwrFPJFsA
         ToiPW551+Q6tiL0MRIX1xfysLtrBl8CseiONna30f+sUnIwBSs2ogN7/Pf+spI5Ygx
         aHHPc1wfN/sOiCzYbsnao2a45dpTBYGpXKap13PAkF+HEftv6vVUMUaxpRNyDdrl+a
         XeZoFhrLpa+js8mXOrjAudLmbhq60b1RHG8gVaa4U7uuF7fLo3T/x6bJwN1MnVCk2u
         1zCa/RvQbXNrg==
Date:   Tue, 15 Feb 2022 11:57:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220215115743.7830237e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HJEpa6QpFdc8AvspqE3S=Np";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HJEpa6QpFdc8AvspqE3S=Np
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: In function 'dc_constru=
ct':
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:991:17: error: implicit =
declaration of function 'DC_FP_START' [-Werror=3Dimplicit-function-declarat=
ion]
  991 |                 DC_FP_START();
      |                 ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:993:17: error: implicit =
declaration of function 'DC_FP_END' [-Werror=3Dimplicit-function-declaratio=
n]
  993 |                 DC_FP_END();
      |                 ^~~~~~~~~

Caused by commit

  af45a5fe4f0a ("drm/amd/display: Protect update_bw_bounding_box FPU code.")

I have used the amdgpu tree from next-20220214 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/HJEpa6QpFdc8AvspqE3S=Np
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIK+ocACgkQAVBC80lX
0GwwoQgAkXdi8qp93Ss/RWfh4nelt5/jwPeMkIcq11PGQzVseH+TBy11hOlKDDmU
6vKWI/iiY+VtU1qZsynShlw6jKGE2giP7BGtEI2sSvZRr5idb8tC1e0E0AvQ7qhy
OztzXIg07RFRRVQ3O/pFJ3Dj5Mv7y2QwqUXVzDmNIbmtF9ihVllfLPLC+EK1Bkkc
D7b1QZGk1U6Y1b1tGWvxBqlpKTf3nc1PsnCs+hnwR0DDWcBEeUab0HdNWZd2fcKv
zzPegClZRBnUIYhPLOYHCt2d/avsKTQH+Qffn1Viur+g94d648u++Jeq9TdvB/9o
XCUVZky9pR0EipfvirG1jk4xSB2AOw==
=Qwwz
-----END PGP SIGNATURE-----

--Sig_/HJEpa6QpFdc8AvspqE3S=Np--
