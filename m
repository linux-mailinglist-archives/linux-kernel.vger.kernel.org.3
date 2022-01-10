Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7A488D90
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 01:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiAJAue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 19:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237625AbiAJAu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 19:50:27 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E87C061751;
        Sun,  9 Jan 2022 16:50:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JXFbz2bm5z4xdd;
        Mon, 10 Jan 2022 11:50:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641775824;
        bh=la3J+UN/pitFoUokaxHuZm+3w6axNczsn/rrvoi6yhY=;
        h=Date:From:To:Cc:Subject:From;
        b=FY6RBOyMPfsmbwJKTIiCB2FsNUZG7+nZB+F4nAeoIvG3h46QRnkLfuIajtslAWZv1
         wRjNxjijtj3/Ljwn4GhIn9pParYtbfeHLXvRN0q7Jv/09SOEG+fQ75p5/f1Pwit84m
         QI5NIMZx2o0zV00fn3eyRN418MpANpKRWK1Vuu97TjL6zOX5nrbBhXBQ6BpEmlj0L7
         U2E4L21JhoJyKmRujA32hIwKFZMliq1/6NV+EDYObmOvAlUyzf+Fnq+oMcI8nHGIF5
         ZOv7UDVDW4k2tKZzZrqvXVPb+IFmlY1AzPISEMWbWLELWcifbnIITVHqvuFfpQt5de
         QlwN5eCq24X5A==
Date:   Mon, 10 Jan 2022 11:50:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the devicetree tree with the pci tree
Message-ID: <20220110115022.31223c61@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iRd.D+fAKOzVHMVrQz55E+j";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iRd.D+fAKOzVHMVrQz55E+j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml

between commit:

  d91e775e661f ("dt-bindings: PCI: ti,am65: Fix "ti,syscon-pcie-id"/"ti,sys=
con-pcie-mode" to take argument")

from the pci tree and commit:

  dcd49679fb3a ("dt-bindings: PCI: Fix 'unevaluatedProperties' warnings")

from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
index 98d933b792e7,a6896cb40e83..000000000000
--- a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
@@@ -69,9 -65,7 +69,7 @@@ examples
                 <0x5506000 0x1000>;
          reg-names =3D "app", "dbics", "addr_space", "atu";
          power-domains =3D <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
 -        ti,syscon-pcie-mode =3D <&pcie0_mode>;
 +        ti,syscon-pcie-mode =3D <&scm_conf 0x4060>;
-         num-ib-windows =3D <16>;
-         num-ob-windows =3D <16>;
          max-link-speed =3D <2>;
          dma-coherent;
          interrupts =3D <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;

--Sig_/iRd.D+fAKOzVHMVrQz55E+j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHbgs4ACgkQAVBC80lX
0GxWYwf+NMjdpb/XK1ckWh2ES6NepZv68BAPHZ8oGEhiV2FNDlKoV1E3NJ/Uy9go
+QDCwItsUkA/Eu1I1w0U8WCFnwRVVf82RA0xNjTLKbvgz6YzfhQ8Je4bQ2UTs+93
tJ/eYnd0rOHLolJzQhDQgnYb1XCIArhCarMkyJVRd+epYYzbOvKDH4amF1tjMVdT
pGBxBmUtP1Xo7D9GMoxpLT6CJ912W2GUZh2OI5MO9TzQ7KIdaT5b+h8/J4mtnmeu
M8lpkZZYQgWhtdXddWjlTD9C1ZYrberE3zM+4h23mqz+aXEvLORWHsiv01SnZkZm
4Tq+r/oOeLBzCSIUINLPXz9wHIuGOA==
=IIOC
-----END PGP SIGNATURE-----

--Sig_/iRd.D+fAKOzVHMVrQz55E+j--
