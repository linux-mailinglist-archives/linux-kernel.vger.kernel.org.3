Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BAC4C6018
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 01:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiB1ARA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 19:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiB1AQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 19:16:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B006260CDF;
        Sun, 27 Feb 2022 16:16:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6LWy4f6Dz4xbw;
        Mon, 28 Feb 2022 11:16:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646007376;
        bh=hH17aUcIFirXuu3qRlWLoyirY8kZuh415CPZTH2yVG4=;
        h=Date:From:To:Cc:Subject:From;
        b=VjFA1yCVId+N3r2dOrKaQbKsUIYKxNkyATHP/X1Xs7CTbZhcAG1OtcoPvo3e7GO12
         roG526ZDZEp6jvS0auJwMf59+3SBZAYRXYjGkvgIjLZOgOKhy2CIRDLbYIpVYlZP9e
         yx8xvkMPAo0PCUqC1v8i4tsM6oFIXn0mXeX+jXkUY1+0HSekGTPXFFS/a53B1kvByN
         e6OugKYfWWMuf9qGUnc8jyMROTNM+R65KPEVjwHKkVyfD9zCPyWRNzjGl0UuRz+xxi
         2vBD5zkCxx4k6AS4ucJYzwVIgsk6PZ2+q1dWOlKlwofptsulYvjXgHTnFaR5wyaCpR
         ZDCKcNRXVbFTQ==
Date:   Mon, 28 Feb 2022 11:16:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20220228111613.1e299554@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P/W2lPhzpdDVvBaPNPKt7AW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P/W2lPhzpdDVvBaPNPKt7AW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in:

  arch/arm/Kconfig

between commit:

  54f481a2308e ("ARM: remove old-style irq entry")

from the arm tree and commit:

  00ba9357d189 ("ARM: ixp4xx: Drop custom DMA coherency and bouncing")

from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/Kconfig
index 72150cb8db02,d9142ad18c52..000000000000
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@@ -389,10 -379,10 +386,9 @@@ config ARCH_IOP32
  config ARCH_IXP4XX
  	bool "IXP4xx-based"
  	depends on MMU
- 	select ARCH_HAS_DMA_SET_COHERENT_MASK
  	select ARCH_SUPPORTS_BIG_ENDIAN
+ 	select ARM_PATCH_PHYS_VIRT
  	select CPU_XSCALE
- 	select DMABOUNCE if PCI
 -	select GENERIC_IRQ_MULTI_HANDLER
  	select GPIO_IXP4XX
  	select GPIOLIB
  	select HAVE_PCI

--Sig_/P/W2lPhzpdDVvBaPNPKt7AW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIcFE0ACgkQAVBC80lX
0Gyr+gf+NnhPyTYlY0KGQyt15/KvnqBcvWEhZ6GMEEtzsqqsh5RleJc7NKbsVHAm
fvaiyKrSMNUJBBab9hdXVDP1K+tPkfrVOaaILWWxeTNRVqhgNTt/RGmlpX1s6Fmv
5tXXsaGg2UyBjrScEJb3TKe4VznkvkE7aG8QFHXvWPMFVQq1KnGFrwVuh23dBtnI
e9o9IMBmANPOs7LdUYwUeA9E731F58tekSm0vMUv2eLMiIgBtnlzSOJ3NaEeS1io
kq5WsHZ0mbWoz+SA4QzcLmNQRPK6Uv/+mZCP2QsZc3it7uV+Ind2F8tc4lHdgboD
HlMy00vDQ/0ZaFhmN6yfedva4nF1JA==
=B7DU
-----END PGP SIGNATURE-----

--Sig_/P/W2lPhzpdDVvBaPNPKt7AW--
