Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431AC58F4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiHJXRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbiHJXRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:17:11 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112B37C1A7;
        Wed, 10 Aug 2022 16:17:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M35Rz2xR9z4wgv;
        Thu, 11 Aug 2022 09:17:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660173423;
        bh=hlomVIW+zQ2Pm2QEEqfkomGuAlPWAsJ6GltjAkz6AEM=;
        h=Date:From:To:Cc:Subject:From;
        b=hpPc4HOmLSU0mFj9n0Cb2syCK/VxbJ/B9icIkWsU6KX2pwh9Pch0Ov9AAv3e6GOyS
         6xzAY3eoIe6ovoq2w18T4FfEBCmDqI49XZUZZ3cOQYtqvyIRP622Pmz2816CdY0SFW
         ZJTNBW1adIEu8mBVJFOVTcauuAbYlHuipek6Yis9g/IW2nBAzIxkrRz5oPlXL+PHtr
         1vYyhTLBPGbDANyhq1OX5DY4YGPGSMKb2Ahpr0VxdH5fmtwuiaQr0xEhm9bcl+glNj
         glcSTa8gSINkN9EveAxrVRbXGxpzCL0AaorTSw/1oyKmUHtmNKjBmeItBebWBU9cz6
         u9inR+uK5S3mg==
Date:   Thu, 11 Aug 2022 09:17:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Huacai Chen <chenhuacai@loongson.cn>, Marc Zyngier <maz@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the loongarch tree with the
 irqchip-fixes tree
Message-ID: <20220811091701.1dfd4e6c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o2uYzWbygjBQ2CXxyN_3e1C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o2uYzWbygjBQ2CXxyN_3e1C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the loongarch tree got a conflict in:

  arch/loongarch/include/asm/irq.h

between commit:

  fda7409a8fcf ("irqchip/loongson-pch-pic: Move find_pch_pic() into CONFIG_=
ACPI")

from the irqchip-fixes tree and commit:

  4e9fa7e1c08d ("LoongArch: Parse MADT to get multi-processor information")

from the loongarch tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/loongarch/include/asm/irq.h
index 093aee99167d,4b130199ceae..000000000000
--- a/arch/loongarch/include/asm/irq.h
+++ b/arch/loongarch/include/asm/irq.h
@@@ -81,8 -81,7 +81,6 @@@ extern struct acpi_vector_group msi_gro
  #define GSI_MIN_PCH_IRQ		LOONGSON_PCH_IRQ_BASE
  #define GSI_MAX_PCH_IRQ		(LOONGSON_PCH_IRQ_BASE + 256 - 1)
 =20
- extern int eiointc_get_node(int id);
-=20
 -extern int find_pch_pic(u32 gsi);
  struct acpi_madt_lio_pic;
  struct acpi_madt_eio_pic;
  struct acpi_madt_ht_pic;

--Sig_/o2uYzWbygjBQ2CXxyN_3e1C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL0PG0ACgkQAVBC80lX
0GxFqgf/fK10kNkuCospecMWJKDm6f2caHcXO+X4VhLP3zkKBniDTrCfq0JPhULP
xSailITHmz8oRlFnH0EjNcJCILMaJGxPojjelivIKq/IBTY7CijYPTuqPBdvmB11
GzHPKT/SBIVTiCNf3PTr9WmX4JFW+ESIGwMYnGjY61IhukSAQb1ehxS8Y8t4qM+E
Jq9NnMeT1pzX6oBAKESS0y6SuwrsgIxcNJz2eYBdR769W4rWrSzZpkROgRT2C0Zn
061FlvdONYcx2Ub0lxRx6Ot+MLsjHjUR7k1Lv8FCrwi+RIZ4uDisv42fpZfNhfZ/
xXJ8R2Ksomv4gXdkJ8r9OVnQQtemnQ==
=bpyO
-----END PGP SIGNATURE-----

--Sig_/o2uYzWbygjBQ2CXxyN_3e1C--
