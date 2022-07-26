Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1578E581041
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbiGZJq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbiGZJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:46:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9DB31DD7;
        Tue, 26 Jul 2022 02:46:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LsX9w2JNPz4xFw;
        Tue, 26 Jul 2022 19:46:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658828804;
        bh=1hZAmQtWhpOwSYS6MR1TNkfeiDgGHV+OPMWjpWLMBjA=;
        h=Date:From:To:Cc:Subject:From;
        b=udn6mxT5sW+56aMT01eqrop2d4OVfoUcay3GaVYUVREce/X+YpXz6EZoGW4bAdU8u
         37O9HdlT+HE55h46MrtEPxlHThiMH3KCPDqZZLI7m9xLUl1xLNMeH4b+WXZiwFu3Ig
         qtUSG5UNdIWbuv1HfVCio1kUmDBL1Zu7/biXbBOAomY315FmDHJetWs0DrzqEb9uGl
         k7TUMAaVe2iIY8s0yoJ029/Z27/sZKHCzkXBYl+lWz4tvw1hHd7eVX8epR+LK0tLSH
         qm6sS8HXpVM6xfWSUk5D9RVEXKsGZ7TDuyeQKNwJwJlSpycv+PiUpDiQk4/EM0aEzd
         Ip6nJCIC/jf7w==
Date:   Tue, 26 Jul 2022 19:46:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ma Wupeng <mawupeng1@huawei.com>, Peter Xu <peterx@redhat.com>
Subject: linux-next: manual merge of the mm tree with the efi tree
Message-ID: <20220726194643.47f6c020@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QfTZ_GX/1J20rO0UK_+JYPv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QfTZ_GX/1J20rO0UK_+JYPv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  mm/internal.h

between commit:

  902c2d91582c ("memblock: Disable mirror feature if kernelcore is not spec=
ified")

from the efi tree and commit:

  9a4722162210 ("mm/mprotect: fix soft-dirty check in can_change_pte_writab=
le()")

from the mm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/internal.h
index b73385df867d,e2d442e3c0b2..000000000000
--- a/mm/internal.h
+++ b/mm/internal.h
@@@ -862,6 -860,22 +860,24 @@@ struct folio *try_grab_folio(struct pag
 =20
  DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 =20
 +extern bool mirrored_kernelcore;
 +
+ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
+ {
+ 	/*
+ 	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
+ 	 * enablements, because when without soft-dirty being compiled in,
+ 	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
+ 	 * will be constantly true.
+ 	 */
+ 	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
+ 		return false;
+=20
+ 	/*
+ 	 * Soft-dirty is kind of special: its tracking is enabled when the
+ 	 * vma flags not set.
+ 	 */
+ 	return !(vma->vm_flags & VM_SOFTDIRTY);
+ }
+=20
  #endif	/* __MM_INTERNAL_H */

--Sig_/QfTZ_GX/1J20rO0UK_+JYPv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLfuAMACgkQAVBC80lX
0Gxa/wf6A8Btpds8se3n23TUoh0UGFTu/I31sP7CelvmNIJFiPNJeenenpU/w30P
dRFBm4DqyZSE7oC7jp8mjGR3DtTk58/A6G4hKbsXyQUg4b/XDhc4OU87dAZWiIC7
TQFe+HAR9qYx31ttYCcwHtY6T0Kwu9laUw3PqmuhJFrJhDz8gB7GjZfN43+Rsv2I
UrIOiV/hs+Y5K17hHMsoeeuyVRAxz6j8nk4rSUNMvAZjbiJ0BAx0y3wP95pM4tFZ
gRC5M1FxoIH/fywr94Y3M2n7b7MwV0LsnK0RAxsMHdQuFU1TM71dIoVP12X8ipjZ
UPkTc6wV2IFLAb40q5waukCf4xHHMQ==
=fPvN
-----END PGP SIGNATURE-----

--Sig_/QfTZ_GX/1J20rO0UK_+JYPv--
