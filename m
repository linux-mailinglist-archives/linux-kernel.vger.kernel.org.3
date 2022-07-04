Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22451564E14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiGDG64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGDG6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:58:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6025F4E;
        Sun,  3 Jul 2022 23:58:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LbxVF17jTz4xLX;
        Mon,  4 Jul 2022 16:58:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656917925;
        bh=ei0cN9xDV6jPw6cDGXqF+49W7mlxNH+Zai/Qj9yQT/E=;
        h=Date:From:To:Cc:Subject:From;
        b=YeksrtKDpdsHqpYYoQ2JeuHf4bRWVPrMrFUvqXWgigXAoAft8D++lqrgMxj+J8ee/
         QHW2YApMynkz7RwexmpUjtatMpFick8+vj6x6oStaY2bKIWKI0Nya/2uCfriecu4MS
         1MReHo4AiaNgK6/SfR3P4xl6xnRx3JqauuuUUTcnBn1PDDilRn5OBPBU01ibbIVLv/
         XJRZCsGDgQRTy0mhwEVwaXaW2DUdednFfAfZ9DKCsv499YZMMa+PC5qf8U9B2u4/Pe
         7ASU3KUXlGWr2myBP6nPUoEwNjjO4YE7yA/PBrc+7VMc+U7DoGDlQs+oHct/ijjXoL
         EWgYGzB/k+u2A==
Date:   Mon, 4 Jul 2022 16:58:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sander Vanheule <sander@svanheule.net>
Subject: linux-next: manual merge of the mm tree with the bitmap tree
Message-ID: <20220704165841.1637cfff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Tozz8I8VR9.a1Q.O0nZQ/2M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Tozz8I8VR9.a1Q.O0nZQ/2M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  include/linux/cpumask.h

between commits:

  50e413c31800 ("lib/cpumask: change return types to unsigned")
  e32bd0390739 ("lib/cpumask: move one-line wrappers around find_bit to the=
 header")

from the bitmap tree and commits:

  2b0b9f2665b2 ("cpumask: Fix invalid uniprocessor mask assumption")
  284d22458843 ("cpumask: update cpumask_next_wrap() signature")

from the mm tree.

I fixed it up (I hope, see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/cpumask.h
index 0738a6c9be40,523857884ae4..000000000000
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@@ -274,29 -179,31 +195,47 @@@ static inline unsigned int cpumask_next
  	return find_next_zero_bit(cpumask_bits(srcp), nr_cpumask_bits, n+1);
  }
 =20
 -int __pure cpumask_next_and(int n, const struct cpumask *, const struct c=
pumask *);
 -int __pure cpumask_any_but(const struct cpumask *mask, unsigned int cpu);
 +/**
 + * cpumask_next_and - get the next cpu in *src1p & *src2p
 + * @n: the cpu prior to the place to search (ie. return will be > @n)
 + * @src1p: the first cpumask pointer
 + * @src2p: the second cpumask pointer
 + *
 + * Returns >=3D nr_cpu_ids if no further cpus set in both.
 + */
 +static inline
 +unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
 +		     const struct cpumask *src2p)
 +{
 +	/* -1 is a legal arg here. */
 +	if (n !=3D -1)
 +		cpumask_check(n);
 +	return find_next_and_bit(cpumask_bits(src1p), cpumask_bits(src2p),
 +		nr_cpumask_bits, n + 1);
 +}
 =20
+ #if NR_CPUS =3D=3D 1
+ /* Uniprocessor: there is only one valid CPU */
+ static inline unsigned int cpumask_local_spread(unsigned int i, int node)
+ {
+ 	return 0;
+ }
+=20
+ static inline int cpumask_any_and_distribute(const struct cpumask *src1p,
+ 					     const struct cpumask *src2p) {
+ 	return cpumask_first_and(src1p, src2p);
+ }
+=20
+ static inline int cpumask_any_distribute(const struct cpumask *srcp)
+ {
+ 	return cpumask_first(srcp);
+ }
+ #else
  unsigned int cpumask_local_spread(unsigned int i, int node);
 -int cpumask_any_and_distribute(const struct cpumask *src1p,
 +unsigned int cpumask_any_and_distribute(const struct cpumask *src1p,
  			       const struct cpumask *src2p);
 -int cpumask_any_distribute(const struct cpumask *srcp);
 +unsigned int cpumask_any_distribute(const struct cpumask *srcp);
+ #endif /* NR_CPUS */
 =20
  /**
   * for_each_cpu - iterate over every cpu in a mask
@@@ -322,7 -229,7 +261,7 @@@
  		(cpu) =3D cpumask_next_zero((cpu), (mask)),	\
  		(cpu) < nr_cpu_ids;)
 =20
- unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int sta=
rt, bool wrap);
 -int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int start=
, bool wrap);
++unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, =
int start, bool wrap);
 =20
  /**
   * for_each_cpu_wrap - iterate over every cpu in a mask, starting at a sp=
ecified location

--Sig_/Tozz8I8VR9.a1Q.O0nZQ/2M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLCj6EACgkQAVBC80lX
0Gy+9wf/RiS6Y02dMKg6ukJKxw/x5qH09bE4baJwwz3Bklf1VLkv20pDvP8yXxEk
qEXVwrbkyCWENgmxnPpegafGQyS5gf0gGeAFaArCzoK1GxM1HA1kYvsgm06Ep99D
xC38EAtcb9WSCpt2+Zyoe2ccB+vrEC0zeSoLAVjnQjkOd4xI75H68W5cycbHrg9A
BMkxpmKRUQGJSXikd3Z7a84YBViOl5v5jCw++tkxRZspW7cDACcvUtl7VSiaXzVJ
YuAC1TUTbxblz1v6aiGemdmOGcsS0yUsfAzdBmaXki9yUTfuFXhJ2D+8Xyg4q0pt
EeO4DVGESOqH+mHKVcmOHnU7pgPDOQ==
=L9nY
-----END PGP SIGNATURE-----

--Sig_/Tozz8I8VR9.a1Q.O0nZQ/2M--
