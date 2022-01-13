Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8448748E11E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiAMXpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:45:53 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:42231 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiAMXpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:45:52 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JZgzc15Rlz4xdl;
        Fri, 14 Jan 2022 10:45:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642117548;
        bh=P1oHUqqn/eV0/p46wXQ8gE8oaGC8GZ689Js6UJbblhc=;
        h=Date:From:To:Cc:Subject:From;
        b=XGH1Q+BLcCQljQLz3QcfohVToAjnNUjZ/dthDThjt3/8RI454ASKqSw86Y7q7OpwB
         IDpPanaIR8wf1DI/zrdBnyDDa3W5DRZ+NWmA65HDhDu+CARQm1b35DQKOY2bfV8Zm1
         Sexgnb4ttiodx9YAAREvohrpVP8B+tws4VJAJtgCjgOPWBBE8139RZtdKOyMBrp5w+
         59amqshf3EzTK/Qytf4GavqbGXDPaDZJIFw+bRKGpfFOc8AaITqcoum6XCD06umskE
         49HVMrgQN8L4yg6MCAJbDuVBud4pziuQwUwgelGIGtSMZK0PJt8grRKN4PwqIJx09F
         uJJdG4v2lhYnw==
Date:   Fri, 14 Jan 2022 10:45:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Subject: linux-next: manual merge of the pci tree with Linus' tree
Message-ID: <20220114104547.55e2f188@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/17_McLNeUpDca94VKUnrm4M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/17_McLNeUpDca94VKUnrm4M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pci tree got a conflict in:

  drivers/pci/controller/Kconfig

between commit:

  aa50faff4416 ("PCI: mt7621: Convert driver into 'bool'")

from Linus' tree and commit:

  44ddb791f8f4 ("PCI: mt7621: Allow COMPILE_TEST for all arches")

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

diff --cc drivers/pci/controller/Kconfig
index aec8c9a3488b,f7e44d9c6965..000000000000
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@@ -332,8 -332,8 +332,8 @@@ config PCIE_APPL
  	  If unsure, say Y if you have an Apple Silicon system.
 =20
  config PCIE_MT7621
 -	tristate "MediaTek MT7621 PCIe Controller"
 +	bool "MediaTek MT7621 PCIe Controller"
- 	depends on SOC_MT7621 || (MIPS && COMPILE_TEST)
+ 	depends on SOC_MT7621 || COMPILE_TEST
  	select PHY_MT7621_PCI
  	default SOC_MT7621
  	help

--Sig_/17_McLNeUpDca94VKUnrm4M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHguasACgkQAVBC80lX
0GwuYwf/YU/sj+Gt7e7zbdWhxExASLAdhpBUvPwoPUJr2z1JyP5aY5hiuobGAHZ2
SIhjfZe5mZQVH5Pfjs4Ro/Wgx/U8JVVSNe+sPundOERrLhJU730eIb/PA53JGMr9
kJNsIS1pXriQWE3XsIuvhDT5tHOVxypC0EY3IXL+wtVisziYJemBH5Z8AvmHuO/O
qpcZmO54aJUGEzFRKwNHPXXn4gvCarxg2Ys5+OU+UpiqROManBnoZj67vkCUV0cX
d0sFM5mQAq1a2OwhIDuIP8SDnA9nks97MfzHloDkUssCLLh2mxxjLZkvvoJPgCpy
5ezx1ZFsJSrDspDZcIRHqLvz6o8g4g==
=XfED
-----END PGP SIGNATURE-----

--Sig_/17_McLNeUpDca94VKUnrm4M--
