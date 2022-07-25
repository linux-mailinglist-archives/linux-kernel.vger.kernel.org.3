Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3AF57F979
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiGYGeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYGeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:34:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A9DEBC;
        Sun, 24 Jul 2022 23:34:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lrqxz1JkWz4xD7;
        Mon, 25 Jul 2022 16:33:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658730839;
        bh=njZnaEzKyQWeqd0NU980VSPeXlpqXaYAhTlk1CiBmW0=;
        h=Date:From:To:Cc:Subject:From;
        b=YDUqwBDvQ6OO6/V/bdLa0pprvF7QAgq2bJtVcrMp3moHCtc/F9c1WZoAlCgTK8mQZ
         +U2hwiBIdLh6d5MMjzM6VFwmnMymG+3xbkMUh9jwuJYrnvdb2ZZ7AGxh12Necu1+kb
         /PbKaQhwsrZ7TbLh+hGdTwmeaM5XF0WKUqXEJMh1KDxoJuZLi/EBT2Fn4krYPE9U1n
         Pk7jD68mp6Y72o/zzS+LzUsZ21SDUe1uG16VvSRn7sGa08ICJrli5nehDO1CSGp2rE
         Uu0Qk8iMKwE+SXkjHRE3ddviUHH0aL4eNDsVrT2iDoCK0qwE/FCcEFU4KiWBL6AiHx
         992yq5POARqIQ==
Date:   Mon, 25 Jul 2022 16:33:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: linux-next: manual merge of the vfio tree with the s390 tree
Message-ID: <20220725163356.4f2b507e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uALW3Z.OQzLsqR2L1v+gerG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uALW3Z.OQzLsqR2L1v+gerG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

FIXME: Add owner of second tree to To:
       Add author(s)/SOB of conflicting commits.

Today's linux-next merge of the vfio tree got a conflict in:

  drivers/s390/crypto/vfio_ap_private.h

between commit:

  49b0109fb399 ("s390/vfio-ap: introduce shadow APCB")

from the s390 tree and commit:

  ce4b4657ff18 ("vfio: Replace the DMA unmapping notifier with a callback")

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

diff --cc drivers/s390/crypto/vfio_ap_private.h
index 2d03871597bf,abb59d59f81b..000000000000
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@@ -97,9 -81,6 +97,7 @@@ struct ap_queue_table=20
   * @node:	allows the ap_matrix_mdev struct to be added to a list
   * @matrix:	the adapters, usage domains and control domains assigned to t=
he
   *		mediated matrix device.
 + * @shadow_apcb:    the shadow copy of the APCB field of the KVM guest's =
CRYCB
-  * @iommu_notifier: notifier block used for specifying callback function =
for
-  *		    handling the VFIO_IOMMU_NOTIFY_DMA_UNMAP even
   * @kvm:	the struct holding guest's state
   * @pqap_hook:	the function pointer to the interception handler for the
   *		PQAP(AQIC) instruction.
@@@ -114,8 -90,6 +112,7 @@@ struct ap_matrix_mdev=20
  	struct vfio_device vdev;
  	struct list_head node;
  	struct ap_matrix matrix;
 +	struct ap_matrix shadow_apcb;
- 	struct notifier_block iommu_notifier;
  	struct kvm *kvm;
  	crypto_hook pqap_hook;
  	struct mdev_device *mdev;

--Sig_/uALW3Z.OQzLsqR2L1v+gerG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLeOVQACgkQAVBC80lX
0GxZcQgAkitRcqogZY6Yq4jYT3XROXFUKDrMQwu94CQE5Wi6eVyDtPZIVHdT6hDk
XpdSAKrlYXdN/MJ+3A//8DPVmwtspiKh3g9+jkR3wqSwm3L4HS8dCqcFAwr1Ugu1
AfNTWlqm5WbUJCkrXv+enseghl025kfxI9ONwDr4un0ZQTmzUHj/iPrQjid5qW86
F7KPhQdHy2tBpHECpWeBEI1wlfKS0FpPHDAeclGMdfBXsb5PLahlSB5kvjHgkjgV
s0ZMpfwN5Uo4GiUhRUqo3eCGHOj5vUK5Pn6Xib72aQwn7MJZKKJllMWzRZpCYNEF
HnY6lQi+ze7m3ZBwS7TwuSEoKQn0aQ==
=fiOt
-----END PGP SIGNATURE-----

--Sig_/uALW3Z.OQzLsqR2L1v+gerG--
