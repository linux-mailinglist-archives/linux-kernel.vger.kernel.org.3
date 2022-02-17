Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492044B986C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbiBQFqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:46:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiBQFqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:46:21 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC7027FB8A;
        Wed, 16 Feb 2022 21:46:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzkMc3f6sz4xNq;
        Thu, 17 Feb 2022 16:46:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645076766;
        bh=p+Um8RNaCHTI1zf6BsFpsoyhkmB9hkJgJE8X6Y245rg=;
        h=Date:From:To:Cc:Subject:From;
        b=Um94UWKP8xqWPoHU7twbMRWCs1Q3XmPCZBgyaHk3nmBV4M23p687IF2wWnluhwdC+
         zu5nnOTbBg9fNWkfMvq11cw6QeojQSLKvXUqZ4cjunAMc+RSPCaS9YQPnyj3cUMlfE
         xPgg32TWMi8WFB+LY67MOhZ+XOfsFBgBQ5DWSIRu2GAnGHyFf7IE9zISourGNTCTM9
         SkmlbPn/R2vmhRQa8AiIlmCqN8ELRVCiV/xYE8Hlga644BKhgeQBk4/B3AClYWplyP
         g+DaFukHM86pUw3BIpw5kAaCn8aJoijFmYjbEkfV3ePFrQVZ4RgdhNhUgqEuMRcfB/
         JsJAfkLo79nkQ==
Date:   Thu, 17 Feb 2022 16:46:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liam Howlett <liam.howlett@oracle.com>,
        Helge Deller <deller@gmx.de>,
        Parisc List <linux-parisc@vger.kernel.org>
Cc:     Dave Anglin <dave.anglin@bell.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: linux-next: manual merge of the maple tree with the parisc-hd tree
Message-ID: <20220217164603.33035dab@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hc9TgN0STIYtzt7V.=7RBdI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hc9TgN0STIYtzt7V.=7RBdI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the maple tree got a conflict in:

  arch/parisc/kernel/cache.c

between commit:

  aca41f39ad08 ("parisc: Add vDSO support")

from the parisc-hd tree and commit:

  59f11d074faa ("parisc: Remove mmap linked list from cache handling")

from the maple tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/parisc/kernel/cache.c
index a08f8499b720,c3a8d29b6f9f..000000000000
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@@ -582,8 -585,8 +585,8 @@@ void flush_cache_mm(struct mm_struct *m
  	}
 =20
  	preempt_disable();
 -	if (mm->context =3D=3D mfsp(3)) {
 +	if (mm->context.space_id =3D=3D mfsp(3)) {
- 		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+ 		for_each_vma(vmi, vma)
  			flush_user_cache_tlb(vma, vma->vm_start, vma->vm_end);
  		preempt_enable();
  		return;

--Sig_/hc9TgN0STIYtzt7V.=7RBdI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIN4RsACgkQAVBC80lX
0GxGkgf+IkYTSbVodyoDkCXe2GkBYFXOZRC5FBnlvowgBETifg7uaj4wGqWATbd+
Mkujh/yuDGdOKu3Q8+i+ESpVkNd76hoJaSpOSUqIh1mHEmZKAHH0bTS3F8LD8Jmc
z1KDSksbGkEpX05dIt/LGHfJuFQj1/gxo6wqRq8TD2UqM00TGoZCH+L0t2ohcV/e
XcqAIBdh8boaiNUPaFTvaHq80EQujy3eJ0BAViiPGWORPV3nFkmrVdkFtCbdJP4h
aB9Il2eWsQqS1wPZhkfQhxvVHNBM2L1BQbfC6AEwlbDIcV0WhSz/wlMRsp4sp9bD
KUA65RzTxer+aqH0V5nq2YzA3eYa5g==
=pu+k
-----END PGP SIGNATURE-----

--Sig_/hc9TgN0STIYtzt7V.=7RBdI--
