Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D17488D64
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 00:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbiAIXx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 18:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbiAIXx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 18:53:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED410C06173F;
        Sun,  9 Jan 2022 15:53:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JXDLp2WQ2z4xtf;
        Mon, 10 Jan 2022 10:53:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641772434;
        bh=6HOUCmNugf2XGu363vjtyjbKWU7Ib45fZOI78YJ+wv8=;
        h=Date:From:To:Cc:Subject:From;
        b=YF9aYkSSYUK1cvGVU+CdhzFbHinVIV8eafOS6KGmvEr1g354uUuLuXzA7FZME8sHy
         vvmmbQmOUaA46c+g8Q4NQ2RN9VuJRci4RHotfxEVzRXQrVVED1KyXDSZ5CGK7AmIgu
         ShXUNGQBQbpINt5lKb9d/15k+UqnOodG2KwfEPkagWoX86J3i6/kYY5o38m8GgUIg8
         5SAWDJVH0ud2Ak64y9BKDHkOvl5c+bVBo8iK32yDz3Rn/uxUXi68ST1eySiktDQkJj
         F4C+oyfMuAxC8ttAtV9Pqy2W4JVTsSTSS/g7e2oiZjymXXWpN8sR3Rr6RjwXAWLMAS
         pKdswjxbo3TQA==
Date:   Mon, 10 Jan 2022 10:53:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the input tree with Linus' tree
Message-ID: <20220110105353.266873fb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B4jPmG7BV93__j4jOfyeuyx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B4jPmG7BV93__j4jOfyeuyx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the input tree got a conflict in:

  drivers/input/misc/axp20x-pek.c

between commit:

  5ecc1e947822 ("Input: axp20x-pek - Use new soc_intel_is_cht() helper")

from Linus' tree and commit:

  8a78050ee257 ("Input: axp20x-pek - revert "always register interrupt hand=
lers" change")

from the input tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/input/misc/axp20x-pek.c
index e09b1fae42e1,c8f87df93a50..000000000000
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@@ -293,19 -339,7 +323,7 @@@ static int axp20x_pek_probe(struct plat
 =20
  	axp20x_pek->axp20x =3D dev_get_drvdata(pdev->dev.parent);
 =20
- 	axp20x_pek->irq_dbr =3D platform_get_irq_byname(pdev, "PEK_DBR");
- 	if (axp20x_pek->irq_dbr < 0)
- 		return axp20x_pek->irq_dbr;
- 	axp20x_pek->irq_dbr =3D regmap_irq_get_virq(
- 			axp20x_pek->axp20x->regmap_irqc, axp20x_pek->irq_dbr);
-=20
- 	axp20x_pek->irq_dbf =3D platform_get_irq_byname(pdev, "PEK_DBF");
- 	if (axp20x_pek->irq_dbf < 0)
- 		return axp20x_pek->irq_dbf;
- 	axp20x_pek->irq_dbf =3D regmap_irq_get_virq(
- 			axp20x_pek->axp20x->regmap_irqc, axp20x_pek->irq_dbf);
-=20
 -	if (axp20x_pek_should_register_input(axp20x_pek, pdev)) {
 +	if (axp20x_pek_should_register_input(axp20x_pek)) {
  		error =3D axp20x_pek_probe_input_device(axp20x_pek, pdev);
  		if (error)
  			return error;

--Sig_/B4jPmG7BV93__j4jOfyeuyx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHbdZEACgkQAVBC80lX
0Gy6MAf7B7vlT/RHE/J/wW8hpRCF+OfmexcNzxdIpkP4dwzLbj4EQc73CFtiSp6i
gORpfyFEW00ixLmKUVzWDMAHGiKz8l62GKiCSJu7i3buQLdyNpQKeXawQ4V+01a/
q0WBiPlVqhklObqq6kptApvYAXfHccqyv5aX2XdoTFdq7HqzByhuecQGHFpPFBrN
feqFKbAq779fw5nqM3Ag/FDmRoXFnAww5XteobHAt6RyiVX2CddKzjmENMXYlrGZ
UfIPhQeH1SeeVI6SRiIV+BkJcuwq8dZn+K/DAHF9dvyNeCwChru5/OTb2XcP1X/4
xqiF281nsY/DH6ub91lUty7b8xGFug==
=0Q2q
-----END PGP SIGNATURE-----

--Sig_/B4jPmG7BV93__j4jOfyeuyx--
