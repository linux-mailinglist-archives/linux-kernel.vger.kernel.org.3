Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4AA48FFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 01:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbiAQApT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 19:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiAQApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 19:45:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9950AC061574;
        Sun, 16 Jan 2022 16:45:17 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JcY8q2ZZlz4xmt;
        Mon, 17 Jan 2022 11:45:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642380315;
        bh=yzeaUQ5dSikJBUxOrRx5zSa/uuITEFws0u4rI5Ty13Y=;
        h=Date:From:To:Cc:Subject:From;
        b=ntmhBpG/wpmy+SK+Uf4Bep3OVGsASO7JouUcZ4MSaf55DrVMIs11b7gnKR1ikhwb5
         Ukpua6BuTogWlCnmZx1myojNAW87tBr4s/WRfKBe8VYBljZvgA44Vs/thAC1m1Ajdq
         PoOcfE7MezwY1nrIO3WJ8103x3i8vNoNkd++g/GXo1Vwe8nFN6J4ln4L6QTaDME/tI
         22HRr+6zIkJhbyWrDhS6Y4lbZHPTeUDZ+Eo/hDRNDmqLCLLI/8j35UzLt+eDPsHlnq
         /oZYggZj/wxn9dSQqTmTvvhaoXB5IMpJtWXqZe9mv7OIwv6CMTpYJsY0o7DhWGQstU
         WLps3NnAC9YVA==
Date:   Mon, 17 Jan 2022 11:45:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the origin tree
Message-ID: <20220117114514.5b6daa04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wz0uWVukcK95FradZV36eVb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wz0uWVukcK95FradZV36eVb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the origin tree, today's linux-next build (powerpc
allnoconfig) produced this warning:

kernel/sysctl.c:125:12: warning: 'one_thousand' defined but not used [-Wunu=
sed-variable]
  125 | static int one_thousand =3D 1000;
      |            ^~~~~~~~~~~~

Introduced by commit

  39c65a94cd96 ("mm/pagealloc: sysctl: change watermark_scale_factor max li=
mit to 30%")

It seems to only be used when CONFIG_PERF_EVENTS is set.

I didn't see it in linux-next because there is a patch later in the
akpm series (not yet in Linus' tree) that removes this variable.

--=20
Cheers,
Stephen Rothwell

--Sig_/wz0uWVukcK95FradZV36eVb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHkvBoACgkQAVBC80lX
0GxmFAgAlbke24M/7qid0gwGsKiptaoJQqH9KKdIiWqdhvU+lupeiw54hBTs+7tF
AURUUL12G9UDjiYTR3NttM69I15dtRiNcbSiHsm113cBZJqkFqOx7v9u1KNb+18/
RIHLtK7ERMB7taM2kiX0V944D+bvNStmwPzAuwv48TsfSs2Sd3Tf1AR/JoOqZt1G
yqqn6XdoDla0pWFTn+oCYDA0DEexP7hbAsSIaT/kYf1x7osJqhm/5WeThPK+UA4k
tMrmHcO7mDnCJfvXfSc+VKN3gPcI7ElxQNhnDnlodGH/jYcTJkJXWSHJ/2PsFexU
9xCMriBoO4+k0PXNhPcKF8VLwA94Lg==
=Mpip
-----END PGP SIGNATURE-----

--Sig_/wz0uWVukcK95FradZV36eVb--
