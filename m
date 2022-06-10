Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA77545B59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 06:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbiFJEuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 00:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiFJEuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 00:50:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280CF31714C;
        Thu,  9 Jun 2022 21:50:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LK7mm43hfz4xZ0;
        Fri, 10 Jun 2022 14:49:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654836603;
        bh=GJecETtcF+CcFT0RpOLHBOEvWAWAoW0sqEUBxQmvil4=;
        h=Date:From:To:Cc:Subject:From;
        b=kK+oegz4PdthnZafBDVT2hO4TTcV+Q1P0A73sHA8uFYOUD3Xq26DqW1cMJ/wSnA9f
         P+W1mSReFGR/5sKEtd9/y9LL7BvQTx+O3k9HPbwDDMntWJL08tDIDL/8YZfq6f67aX
         HzZnv5rrrvRcH1OrayviX7VGpwcB18LMdPJUYq2P/nyAjl2o5Coev7jbVS0k8aqC70
         ekaKCE43SdR/7jl6DuGkNG2SQSqDNMl1ke48usaidP2VxSja+NtCyQR9NKns8Zt2xI
         /+TMQBaNT5EKI44JxkzUz1sPiydeyYZDrzN78pUrCKpCDyGmMZXEovAe1pUEm32Q/u
         kAm67qmx9mKsg==
Date:   Fri, 10 Jun 2022 14:49:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20220610144958.5b90e8d3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/trBsv9OQy7natagn_x.Q+.J";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/trBsv9OQy7natagn_x.Q+.J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/firmware/efi/sysfb_efi.c:29:10: fatal error: asm/efi.h: No such fil=
e or directory
   29 | #include <asm/efi.h>
      |          ^~~~~~~~~~~

Caused by commit

  fa0e256450f2 ("fbdev: vesafb: Allow to be built if COMPILE_TEST is enable=
d")

$ find arch -name efi.h
arch/arm/include/asm/efi.h
arch/arm64/include/asm/efi.h
arch/ia64/include/asm/efi.h
arch/loongarch/include/asm/efi.h
arch/riscv/include/asm/efi.h
arch/x86/boot/compressed/efi.h
arch/x86/include/asm/efi.h

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/trBsv9OQy7natagn_x.Q+.J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKizXYACgkQAVBC80lX
0GzJ9wf/UZfcCcfZFtOIxf69VSO/I4SoUQd7WHNFRrjiIh5fn9/7NyGCB8ZZE0aY
aAkPVQ1/haanooNM18BoaKY3FNxqehU2jrI70VmZrU1L72eZt0r1uMvZajNgWp0L
pD7BHFKysW/NxllpVMY5LiNVUrRIY2VMGWjpJx8GgBqxQTZwLDGZJq2aSzrLhiKS
uWGWw/uN2Lxoa2RmMKk4yEUqhCNuf628IBqRjVu2Ik6wN35mLavYUo38bkJB9Qoc
h/U55n6x7ELv6oOILIN6CoNPQ4c28gWIp9q41xya4muJpt51+oiu6+v4+pbPTXKM
B0A++zMhKdBT+EPeyk34I3xfJHqCbA==
=b1wL
-----END PGP SIGNATURE-----

--Sig_/trBsv9OQy7natagn_x.Q+.J--
