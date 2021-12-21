Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E1447C9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 00:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbhLUXz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 18:55:27 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:52861 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhLUXz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:55:26 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JJYHJ4pbGz4xRC;
        Wed, 22 Dec 2021 10:55:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640130925;
        bh=j0V/wOWv/iisTcFw3H1yQ3cpV6UloRtM5aIMFr4CsDI=;
        h=Date:From:To:Cc:Subject:From;
        b=oBzo1n/Jix/s1zjaxMayF90T4JqH26U6G4WoRdqQyAIDeUAZhdd2nqPs+C72oR2or
         olX2LNupZy7XiOJ6rZuYV4SjZ1AzE9tSDG14uOxN/ryYYb2i7sEW+QfLSn5Wc/jgug
         XJLE7ZGgjYbM2IVgmteC+XxSc34erfeyr9PIaZi5Jnl1blKTKDG/W23o1Yic09C36f
         jEF1TOAybp8SXZyC7Lq7c75bmItLhCMDgB0q9tBeWR2QNKGjYumb3OYkVZ32mtb/OY
         TPnobVhCMY+dGaGZ+b5ywZjvIWqvb3CNQyYzsyPqz7G5y3cglTVoOOSstTKhBYPjdf
         wPuhhAmg0F9XQ==
Date:   Wed, 22 Dec 2021 10:55:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Richard Weinberger <richard@nod.at>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: linux-next: build failure after merge of the uml tree
Message-ID: <20211222105521.31b14a32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AWURcZ3_tsObtcwfNcrH0WP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AWURcZ3_tsObtcwfNcrH0WP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the uml tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

arch/x86/kvm/mmu/spte.c: In function 'kvm_is_mmio_pfn':
arch/x86/kvm/mmu/spte.c:85:6: error: implicit declaration of function 'pat_=
enabled'; did you mean 'kasan_enabled'? [-Werror=3Dimplicit-function-declar=
ation]
   85 |    (!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
      |      ^~~~~~~~~~~
      |      kasan_enabled
arch/x86/kvm/mmu/spte.c:85:23: error: implicit declaration of function 'pat=
_pfn_immune_to_uc_mtrr' [-Werror=3Dimplicit-function-declaration]
   85 |    (!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

I am not sure what caused this - presumably some include file tidying up.

I have used the uml tree from next-20211221 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/AWURcZ3_tsObtcwfNcrH0WP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHCaWkACgkQAVBC80lX
0GzgHQf+Kj39OT5TXQYDPqOMBMVCX166UnS+dYMY5PCkjJM+tYAuE7ubqqo6gdc1
KFdWugIudVFhDZb8qInwS8R8JZsI9rnedN7xt1nQhC7piOFBz9l3gomWfIOxmtr/
NK1MU4dQgE4FYDqDX/Ca7YefD8v363iRyxXVQcwJt7RS8QDnMlWddwdQTVQNKslb
+dTzyearUd2Gxr9c+KHbMxqk5CQJiuhLVtFKo/BzLU+BB/jkjgDsoQ28WD96v+1J
oWza+iH1TNIMI94k9Z+I9Bw17qv2GfH+rrOIV4zBRm8EJm1TTqNYxtncNC94ZLDb
sdenU+1tb5tFQr2Dj7Mmpixz11BCIQ==
=kbrX
-----END PGP SIGNATURE-----

--Sig_/AWURcZ3_tsObtcwfNcrH0WP--
