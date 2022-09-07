Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6FB5B0405
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiIGMfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiIGMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:35:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACA621256;
        Wed,  7 Sep 2022 05:35:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MN1t90vLnz4xD3;
        Wed,  7 Sep 2022 22:34:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662554097;
        bh=YgmchHEVIGc+yBRq/y0sNCzkY6cDZYGs9g6L0rL7znc=;
        h=Date:From:To:Cc:Subject:From;
        b=SR7qDzIIlj0I+m2jTt7uBB+Sgw4Y/+ekKbYZOhomsXktB7px+OWpciSp01ABWcbz/
         jGCNRV815j+ribkdn0GLwUYKRLdnTav5VcerZgwC76/h3tAhtNf3x9dFNCXvGtvCpQ
         JLEy8sG+8uyLbbbWGU5Es6yX9Ms/an8EnERpBy0hl9ptaqcf3rYzfmCvVm3P3HacNO
         T3IvzhAt18ABMvYwlR9zLtKKyvKWF+45ovWSgwrg9CRkid5AWwLupk7NWID2OWYSIo
         cXghYenyQ6rQ9dpsD3sU2mirxzrAa1z07Q0wp7sHOTfcZCDT6Xhf3FpaBMy+taPYlY
         z/ccjMWFVjq/A==
Date:   Wed, 7 Sep 2022 22:34:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kbuild tree
Message-ID: <20220907223452.7f781217@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PhfdmFRzneLwVJT2cE2i=nj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PhfdmFRzneLwVJT2cE2i=nj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (powerpc
ppc44x_defconfig) failed like this:

/home/sfr/next/next/scripts/mkuboot.sh: line 23: 153700 Bus error          =
     ${MKIMAGE} "$@"

Caused by commit

  c4a7f46f7105 ("kbuild: build init/built-in.a just once")

Reverting that commit (and the following ones) fixes the problem. It
looks like UIMAGE_NAME gets corrupted in scripts/Makefile.lib as the
arguments to mkuboot.sh change from

A ppc -O linux -T kernel -C gzip -a 0x00700000 -e 0x007015a4 -n Linux-6.0.0=
-rc4 -d arch/powerpc/boot/cuImage.sam440ep.gz arch/powerpc/boot/cuImage.sam=
440ep

to

-A ppc -O linux -T kernel -C gzip -a 0x00700000 -e 0x007015a4 -n Linux-6.0.=
0-rc4 6.0.0-rc4 -d arch/powerpc/boot/cuImage.sam440ep.gz arch/powerpc/boot/=
cuImage.sam440ep

(note the extra "6.0.0-rc4") when the above commit is present.

So I have reverted commit c4a7f46f7105 and all the following commits in
the kbuild tree for today.

I had to do the above build with -j40 to make it consistently fail.

--=20
Cheers,
Stephen Rothwell

--Sig_/PhfdmFRzneLwVJT2cE2i=nj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMYj+wACgkQAVBC80lX
0GxY5Af/ZXA3WJ9kRAMIgyft6Eoa6F9/x3zTweNKZNgofBkJxQvq643gBoujC/a9
MgCSBXgkED//n+wOpA/sJiWw7FbnsEbNkzm/Kw1WxDU47t9Dp27PdVm6BAdptspQ
z7PfaN31w/UJF3txIDu+MjvUWRToqXv/E7sR0iCyBlmPUfHvxmeSBudiiNju5+4j
JIgpD0BOO25zAQ6Ulm8fmjS2idpOaOwRXkR6xeyOP7+k1/NJ4G7w/Uduzpba3o7d
WIpgf73pzxl0KDGQPi+1gl2Cw02XW/SNqxV4yLaClklVpFeWsnprDx6R267IComS
YX/ZHfTPCMtiZN4+fVdSwVXudT6vhw==
=7NPB
-----END PGP SIGNATURE-----

--Sig_/PhfdmFRzneLwVJT2cE2i=nj--
