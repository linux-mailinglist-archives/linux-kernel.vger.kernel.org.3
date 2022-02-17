Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31B14B9964
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiBQGoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:44:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbiBQGoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:44:22 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F8E17895D;
        Wed, 16 Feb 2022 22:44:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzlfZ58r5z4xNq;
        Thu, 17 Feb 2022 17:44:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645080247;
        bh=8tq5gxmpNk+6Ty5exOnUc93rvTlkCc/6KPKXJAre4Q8=;
        h=Date:From:To:Cc:Subject:From;
        b=rsWMPL+mJhQT1BBmf019U0l5E0HKiYTJ+46pbvLIgtmPB65ne1Q/8tVB1Y/GACCCZ
         Alai5ot7ivWaJ0HjROQmPeWPTvo17+HC5wJI0vjxGYSUPHNQsbeTEYYgZjyFTGRZM5
         B66HzC2rZ/JA/TgPMPIxCXxiAZIXzvPOjAGg7niiAKS8VEjos7rEIH1RFY/IeGn4Z7
         k8rMHJQP1xzsrcoOfAc6wxj6+0KZe/vBxKP+9NB7pxwP/Pl3a3/4IsMhpIcOyUSIPU
         6UhGb3NJQV360gE34IFiALH6QBFOmZCN/HunTqSgwXfunfNrmfPjri+B0WiNppssZE
         ty2FGpT85X9yA==
Date:   Thu, 17 Feb 2022 17:44:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the maple tree
Message-ID: <20220217174405.0af8d2e7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rBqtWN2whSTkDjfvEYusGnp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rBqtWN2whSTkDjfvEYusGnp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  mm/oom_kill.c

between commit:

  4a9727878b42 ("mm/oom_kill: Use maple tree iterators instead of vma linke=
d list")

from the maple tree and commit:

  ad56e23dec9a ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")

from the folio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/oom_kill.c
index 9cbc05fa356c,6b875acabd1e..000000000000
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@@ -526,8 -525,8 +526,8 @@@ bool __oom_reap_task_mm(struct mm_struc
  	 */
  	set_bit(MMF_UNSTABLE, &mm->flags);
 =20
 -	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
 +	for_each_vma(vmi, vma) {
- 		if (!can_madv_lru_vma(vma))
+ 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
  			continue;
 =20
  		/*

--Sig_/rBqtWN2whSTkDjfvEYusGnp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIN7rYACgkQAVBC80lX
0GxpuggAkg/YKYb0xYLXWmjvTSE4SV9ZXn+3fCsZOrS517GsU1FV1O4rkXdEeTSw
ffp2GDWAKaJ3f0P49BK3rIRu8HzBAY/oo6o1szdkeKUf1ktRRPidWfHVcszdiQLR
xCYgYIS8jeN/MdVr3InfQghRqDe5jVJ5+HaRMsW/E6o9GzgF5SJz7vLt0bgSEAmh
E6VlI3gu30mQtqshctk8yxAR2n4VhVL3/P8cw2kCS4AoFKwux+a4vVJ+mTXy+MD6
MFk3/8AKre6AJxahYu8gHLWJ40CMMfNCmCvYXvsRjMQmfcdv86+1hXQYMgCt2bjQ
T+B1HUcCL5iLPxo6IB27pdJbOE3C3g==
=IumU
-----END PGP SIGNATURE-----

--Sig_/rBqtWN2whSTkDjfvEYusGnp--
