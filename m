Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E7E4CFCB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbiCGLZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241735AbiCGLY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:24:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C9C7085D;
        Mon,  7 Mar 2022 02:55:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBwNL62S2z4xyH;
        Mon,  7 Mar 2022 21:55:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646650531;
        bh=J1/W/1e2Ay1wq7HwjLRvzE7/YEvZthoj5pPO9/JrDVo=;
        h=Date:From:To:Cc:Subject:From;
        b=UutuYFL6oxk6yMOvAdEsshZ482cpOU+vMT2bPRAycT6E4alDsKjHGq8m16QQ0EvNr
         AeWm3YnveCs+Hh/z/wBpmm7eq7F+vTuer0V46pFuOFet3lc11D/KkX9YU8cW6VykJU
         rFCE6Q5N5kWu1cN2sEoLazi9G90tIYa+7xeh1eAulcaboKuwgvEl4cR3Rts8GJNtLG
         aerWC9JSYqFIcBBFAYGAiaZZwYXmKPSsY74EYMtMFj9GKJjjzhKz+l8pTZcTgm821u
         611mSHQq/HirxPoKpVUPqIptUeVIJIbD2EmbVa9oaWT7oVPVDqoGlliu3Dmpl8KfZ0
         NF3Vck6Rr3Deg==
Date:   Mon, 7 Mar 2022 21:55:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the akpm tree
Message-ID: <20220307215530.7c981424@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SZbBxw=3QLnHmWfdz67BRm2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SZbBxw=3QLnHmWfdz67BRm2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm tree, today's linux-next build (mips
malta_defconfig) failed like this:

mm/madvise.c: In function 'madvise_need_mmap_write':
mm/madvise.c:55:7: error: 'MADV_DONTNEED_LOCKED' undeclared (first use in t=
his function); did you mean 'MADV_DONTNEED'?
  case MADV_DONTNEED_LOCKED:
       ^~~~~~~~~~~~~~~~~~~~
       MADV_DONTNEED
mm/madvise.c:55:7: note: each undeclared identifier is reported only once f=
or each function it appears in
mm/madvise.c: In function 'madvise_dontneed_free_valid_vma':
mm/madvise.c:789:19: error: 'MADV_DONTNEED_LOCKED' undeclared (first use in=
 this function); did you mean 'MADV_DONTNEED'?
   if (behavior !=3D MADV_DONTNEED_LOCKED)
                   ^~~~~~~~~~~~~~~~~~~~
                   MADV_DONTNEED
mm/madvise.c: In function 'madvise_dontneed_free':
mm/madvise.c:859:47: error: 'MADV_DONTNEED_LOCKED' undeclared (first use in=
 this function); did you mean 'MADV_DONTNEED'?
  if (behavior =3D=3D MADV_DONTNEED || behavior =3D=3D MADV_DONTNEED_LOCKED)
                                               ^~~~~~~~~~~~~~~~~~~~
                                               MADV_DONTNEED
mm/madvise.c: In function 'madvise_vma_behavior':
mm/madvise.c:998:7: error: 'MADV_DONTNEED_LOCKED' undeclared (first use in =
this function); did you mean 'MADV_DONTNEED'?
  case MADV_DONTNEED_LOCKED:
       ^~~~~~~~~~~~~~~~~~~~
       MADV_DONTNEED
mm/madvise.c: In function 'madvise_behavior_valid':
mm/madvise.c:1129:7: error: 'MADV_DONTNEED_LOCKED' undeclared (first use in=
 this function); did you mean 'MADV_DONTNEED'?
  case MADV_DONTNEED_LOCKED:
       ^~~~~~~~~~~~~~~~~~~~
       MADV_DONTNEED
mm/madvise.c: In function 'madvise_dontneed_free':
mm/madvise.c:865:1: error: control reaches end of non-void function [-Werro=
r=3Dreturn-type]
 }
 ^

Caused by commit

  55e85812e13f ("mm: madvise: MADV_DONTNEED_LOCKED")

Maybe some of these files need a definition as well?

arch/alpha/include/uapi/asm/mman.h
arch/mips/include/uapi/asm/mman.h
arch/parisc/include/uapi/asm/mman.h
arch/xtensa/include/uapi/asm/mman.h

--=20
Cheers,
Stephen Rothwell

--Sig_/SZbBxw=3QLnHmWfdz67BRm2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIl5KIACgkQAVBC80lX
0GwuLgf5AXMyDmXnol/QQghlvfffq/XksVa4vpc+WYi1I0K7DbVOgaWICgwWAjxR
vkMpLWxRdIb8RSB9QIRQFSzRkD3UDUcymf7E93FQr6npi2fa+VZvtFN/v88QxyFZ
EEcWCWXB4VTZ+HZUP3/GLUnAIHC8p+djLdWqgGIX6RKc8aL1iwxOxI21VVURoC8c
feHverxeD8tdjSC0QMVfCyiOXB7UOmVc3ex5jPJGA92Oi5umzcGXD+w+G83avyzU
DvmPW8dZL1gCAhlSoZtB5AMAeK9n3U8gOy6/ig1VN/WgSVzbZJYwssG/U2+uanmt
5/XS3AeUGVWcChGg7BX11MFbXNNXTw==
=aPsF
-----END PGP SIGNATURE-----

--Sig_/SZbBxw=3QLnHmWfdz67BRm2--
