Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979E8530FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiEWK7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiEWK7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:59:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78C036B57;
        Mon, 23 May 2022 03:59:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6DqN09G3z4xYY;
        Mon, 23 May 2022 20:59:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653303568;
        bh=lWgsb8qE19hsC1UFPMKFNwGvJxpBxezgeLZ7MS5BSeY=;
        h=Date:From:To:Cc:Subject:From;
        b=GWuxjXQozkX91hkfq0qXhWWUBuY8Apf6asorOCR/TgMkoXTQfllgsSbEXaBVHz8I/
         BF8kq32WSSzjKCbzWZGXBxfnJoMorPLGr05cLmXyrbnd8gTenT3vlPO92HjQZY3njw
         nsCS+I6L2pMJz3jChYAtPGTJBIkKLq/Hk4ZQwvmOkOa9UAom11AyvYJOtp4xeJcDe5
         hFfRSmqG+7O/iRott6VZ8NeosbuJNSHNBA7OJcKIhnnaBfUAGBoCUKWUtL9Q56io7U
         w1gT5amn+5pSCbRBcm2/B8zo/nNfxIxVf+lo5NrVbivdXrCClJZZiJS3XW4yjP3xI1
         VFlG2ViUDj2dg==
Date:   Mon, 23 May 2022 20:59:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20220523205927.4dbeb49f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KF9aed20pnO87_xB7Dhp1MJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KF9aed20pnO87_xB7Dhp1MJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (sparc64
defconfig) failed like this:

make[3]: *** Deleting file 'arch/sparc/vdso/vclock_gettime.o'
scripts/check-local-export: line 36: symbol_types[${name}]: bad array subsc=
ript

Caused by commit

  86e4cdec74f0 ("kbuild: check static EXPORT_SYMBOL* by script instead of m=
odpost")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/KF9aed20pnO87_xB7Dhp1MJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKLaQ8ACgkQAVBC80lX
0GxQIwf6A71FRi+uPa9c1UwlcSFdNF9WlvhCXttMGqkXRCPOgoDSP7Kad/IurYYQ
dH5ZUahV0YReeTadltBSU9cDGkwzwP39jaIHCW1kXZ8yO7K8Eclj7pbgrfEe2GRa
Na0jFF25oHjUUjMP4ws90oRP++7e4f39igpMqhlr7Mqoz03KT/ISPS9DFw6JI+ru
GS1XpHS7TngTJ7CFjR4x3WvsjH5SCpHd4kcTS9P1B3LLd4btfCsKbgca4hIprHpR
Bxp0kKERS6HRw/BQ4a2jWV5rxuM+txpEByGo3lui4E7Bsp0HTABbMpFD+HoLZ05K
zH/+p/VD7hPrxJBy+Ob+QKVvZkfHOA==
=tQ8A
-----END PGP SIGNATURE-----

--Sig_/KF9aed20pnO87_xB7Dhp1MJ--
