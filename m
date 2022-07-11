Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6437E56D681
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiGKHPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiGKHPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:15:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C20EE2C;
        Mon, 11 Jul 2022 00:13:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LhFVV62nVz4xD9;
        Mon, 11 Jul 2022 17:13:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657523635;
        bh=FwVzMgPu9RihyYPOqbl+edFsdS/IwChr0XHfM64Sx0g=;
        h=Date:From:To:Cc:Subject:From;
        b=WSroVaE1obXbTbMHBA6kCA4H8Qz7b6fFaFwCVyW6z6mR/Ag0mTXXqFRBLSXDNJFdL
         DSTKVwryW02lkqFf2ixveuHa6OVsczuXNuITtYCEWedUHkEeLJzVSMlBa5FG3EYQfH
         57CBVPjB6iSJH2ltXFyHY3W2C5LCCuOELzqY9N2SJFY9pNB1R1soUhaZacHfSAdS9z
         4tUFUjvXfW0l6KFVTVud3GWdUtT0Y2aj8xlNYMrTqLcJ6kFEs+7KT+D7m1wOWwG6PI
         amXa7ri6c3apypxi31jK8zvZfi93brzy0WsVigq86YH/NXhYD6Ex1OCZ6bAX0No7Ur
         ha/pU5OqCY+5A==
Date:   Mon, 11 Jul 2022 17:13:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: linux-next: manual merge of the vfio tree with the kvms390 tree
Message-ID: <20220711171353.2b8eb09a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ReK7buPj5E6qMs/b5HKmcbs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ReK7buPj5E6qMs/b5HKmcbs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfio tree got a conflict in:

  include/linux/vfio_pci_core.h

between commits:

  b6a7066f4e9b ("vfio/pci: introduce CONFIG_VFIO_PCI_ZDEV_KVM")
  6518ebc68c72 ("vfio-pci/zdev: add open/close device hooks")

from the kvms390 tree and commit:

  d1877e639bc6 ("vfio: de-extern-ify function prototypes")

from the vfio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/vfio_pci_core.h
index d5d9e17f0156,22de2bce6394..000000000000
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@@ -206,11 -205,9 +205,11 @@@ static inline int vfio_pci_igd_init(str
  }
  #endif
 =20
 -#ifdef CONFIG_S390
 +#ifdef CONFIG_VFIO_PCI_ZDEV_KVM
- extern int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
- 				       struct vfio_info_cap *caps);
+ int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device *vdev,
+ 				struct vfio_info_cap *caps);
 +int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev);
 +void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev);
  #else
  static inline int vfio_pci_info_zdev_add_caps(struct vfio_pci_core_device=
 *vdev,
  					      struct vfio_info_cap *caps)

--Sig_/ReK7buPj5E6qMs/b5HKmcbs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLLzbEACgkQAVBC80lX
0GxgpAf+IPMYFUzaTRTImlnl8wqSGE0tFDuGcCRP1pNhvoZ4SxjkUtqxGNJSNXFV
M3oWhF6hL/b/1qvvBJpo4ys4HJYrvWUBJv5p+P1jijhRisUu5BU5yN5RkJxOOYL8
MgCr+Eg7KVCkvYjMIru90QXSc/tQn5Fv3R/iqjPV+hh5V4BJDCbOUr71cmQYxMm5
+puCfDcyNGBhQ46g5eTOqfASEcBFptHKiFZrFFuTgXI4X+qHHA8BvoqTeigxqr6x
4yji5CIVDaUdATiclicIQD9PcXvNRP/tbkEGpkqOAbz1i7xG9pBlen4b2LQn6+JH
O4OiJmIYa2ewUqnmyiVovYEc4UOu2Q==
=wsAr
-----END PGP SIGNATURE-----

--Sig_/ReK7buPj5E6qMs/b5HKmcbs--
