Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA5357F7D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 02:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiGYAqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 20:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYAqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 20:46:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC4FD19;
        Sun, 24 Jul 2022 17:46:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LrhDV0w2Rz4xCy;
        Mon, 25 Jul 2022 10:46:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658709963;
        bh=IZ+ONIlMRbSzJOCazcSJOiac0EEAgIdLc957tceZ6iY=;
        h=Date:From:To:Cc:Subject:From;
        b=AjJK7YGsvvgoS0Ux1QQW2Uyz1P5j1SyTHkB9B3xLdQtx4veDmAP4Jh3i7Up+oKGg2
         guGe2xXyaRdzR5lx07Xg4OKA/AcxrGhrXqyq7Z01si7QMhAXccVL+8Elec3ugzwFGe
         uAzCE6iuMdfceLSRrekmMU/a14VT06ypS4NDK01eglgv0T/kOMJK4TcG+rIoPJ7EGr
         eXrKGHR09aDldd/mCh+8RnUG3ce7UugkU2OUa0E13F6Xb2sxdqPyGWnKFwyWHd4SSN
         od77nAG3Dnt2lnwqtfN9rFCqtvOd2XX9rmdnZetqwz4Sxgnd2Ccwl10+Q7YCEYKGNk
         MeoBa2+j/N8dg==
Date:   Mon, 25 Jul 2022 10:22:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Stafford Horne <shorne@gmail.com>
Subject: linux-next: manual merge of the pci tree with the risc-v tree
Message-ID: <20220725102221.20fe2ca2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IC/OQ.q28hFebuoQuJZbO=L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/IC/OQ.q28hFebuoQuJZbO=L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pci tree got a conflict in:

  arch/riscv/include/asm/pci.h

between commit:

  bb356ddb78b2 ("RISC-V: PCI: Avoid handing out address 0 to devices")

from the risc-v tree and commit:

  a2912b45b082 ("asm-generic: Add new pci.h and use it")

from the pci tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/include/asm/pci.h
index 830ac621dbbc,6ef4a1426194..000000000000
--- a/arch/riscv/include/asm/pci.h
+++ b/arch/riscv/include/asm/pci.h
@@@ -12,31 -12,7 +12,10 @@@
 =20
  #include <asm/io.h>
 =20
 +#define PCIBIOS_MIN_IO		4
 +#define PCIBIOS_MIN_MEM		16
 +
- /* RISC-V shim does not initialize PCI bus */
- #define pcibios_assign_all_busses() 1
-=20
- #define ARCH_GENERIC_PCI_MMAP_RESOURCE 1
-=20
- extern int isa_dma_bridge_buggy;
-=20
- #ifdef CONFIG_PCI
- static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
- {
- 	/* no legacy IRQ on risc-v */
- 	return -ENODEV;
- }
-=20
- static inline int pci_proc_domain(struct pci_bus *bus)
- {
- 	/* always show the domain in /proc */
- 	return 1;
- }
-=20
- #ifdef	CONFIG_NUMA
-=20
+ #if defined(CONFIG_PCI) && defined(CONFIG_NUMA)
  static inline int pcibus_to_node(struct pci_bus *bus)
  {
  	return dev_to_node(&bus->dev);

--Sig_/IC/OQ.q28hFebuoQuJZbO=L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLd4j0ACgkQAVBC80lX
0GxL5wf/XAZm3NHQ4Hswnc9OjQzFic3s6PB2lNAQcV/8HRdBOLYxskKRkOrIf5rF
n7HZZsPbOcs0q4JzdyCNkaCjbk80FZGj6AjVRhl6uHizG5fW47ajTDHmMJ2nMVB6
2PAbFePQ+C0r3qvgQh3g7D1u4fEIDHmewBANthgPmuARzb+4K5XUSSZJ3ULfBF71
cR9zvMM6TP145HG/OEjHW0FSpCo3OOGNycwiMmrLpWzWrVizGlNgKN6rgSEdTLOl
Z0ySVd3P0vvBO+l/FprRU9fHeTlSvGK6964qgJO8boM0VyHqL6UN8oLj14W89onk
fMYNeUQT/zn0kJ58/8pq33S0CQFiAQ==
=b8ap
-----END PGP SIGNATURE-----

--Sig_/IC/OQ.q28hFebuoQuJZbO=L--
