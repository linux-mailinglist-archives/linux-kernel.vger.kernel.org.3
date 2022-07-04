Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B446564EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiGDH0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiGDH0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:26:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115B365CA;
        Mon,  4 Jul 2022 00:26:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lby5v27qnz4xTq;
        Mon,  4 Jul 2022 17:26:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656919571;
        bh=heGxT9YtvCSIryKteXnXv9hIua3kk75+pHXFSgaqHvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ClN3sK/tZmoHPWa2LcrfeSnBkir88EhYUr3DnZUDaRMTN7oNvqnUFLk65d7QD+nq8
         k9RYeOIyBPgI/apIYjqqw6umm+6bSA4bNODRLCpWU4K+Hy6dbuW5vR9fvfOf1UoyKI
         ZkCEht1PBJn/6iTIiGJeZ8nviHocJ/+wZ+X4Z7PZN4KpgQFcIahECjHbUfHLvnvSC9
         2ElcbXDhXP5EGNxeriUBvc6UJ7GcuvmrbxX77cQVYX/AkV0UltlR+iaIIBnC85qIU8
         xpWs2KYAAkh8U73/5s489XAEqRm88z9ygiSeWtFAxLEhOvmvQEdXDs1mwEIUHCdh59
         e2iP4dDtjq4GQ==
Date:   Mon, 4 Jul 2022 17:26:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sander Vanheule <sander@svanheule.net>
Subject: Re: linux-next: manual merge of the mm tree with the bitmap tree
Message-ID: <20220704172609.27ec5d8c@canb.auug.org.au>
In-Reply-To: <20220704165841.1637cfff@canb.auug.org.au>
References: <20220704165841.1637cfff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hg8tI/Lmv5H8vIby2MGGkVa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hg8tI/Lmv5H8vIby2MGGkVa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 4 Jul 2022 16:58:41 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the mm tree got a conflict in:
>=20
>   include/linux/cpumask.h
>=20
> between commits:
>=20
>   50e413c31800 ("lib/cpumask: change return types to unsigned")
>   e32bd0390739 ("lib/cpumask: move one-line wrappers around find_bit to t=
he header")
>=20
> from the bitmap tree and commits:
>=20
>   2b0b9f2665b2 ("cpumask: Fix invalid uniprocessor mask assumption")
>   284d22458843 ("cpumask: update cpumask_next_wrap() signature")
>=20
> from the mm tree.
>=20
> I fixed it up (I hope, see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

--=20
Cheers,
Stephen Rothwell

It actually needed to be:

785d45d2ce79973aa13920e855aff8a67c61b1c8
diff --cc include/linux/cpumask.h
index 0738a6c9be40,523857884ae4..6a8f75cc9985
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
@@@ -358,27 -265,6 +297,26 @@@
  		(cpu) =3D cpumask_next_and((cpu), (mask1), (mask2)),	\
  		(cpu) < nr_cpu_ids;)
 =20
 +/**
 + * cpumask_any_but - return a "random" in a cpumask, but not this one.
 + * @mask: the cpumask to search
 + * @cpu: the cpu to ignore.
 + *
 + * Often used to find any cpu but smp_processor_id() in a mask.
 + * Returns >=3D nr_cpu_ids if no cpus set.
 + */
 +static inline
 +unsigned int cpumask_any_but(const struct cpumask *mask, unsigned int cpu)
 +{
 +	unsigned int i;
 +
 +	cpumask_check(cpu);
 +	for_each_cpu(i, mask)
 +		if (i !=3D cpu)
 +			break;
 +	return i;
 +}
- #endif /* SMP */
 +
  #define CPU_BITS_NONE						\
  {								\
  	[0 ... BITS_TO_LONGS(NR_CPUS)-1] =3D 0UL			\

--Sig_/hg8tI/Lmv5H8vIby2MGGkVa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLClhIACgkQAVBC80lX
0GyDXQf/X/WqoxRsRXrefYeHv1acay33b1lu07NMP/mYCLLd42oLk7m9iu72HQAI
660z4LjjK2vSCr4j5iYyPivTQIOz52slSXk1uc57oBj4ZOsDgAUKOFzAaJwcCrrH
Y71fkVGQkN8CLgTQjAnHK5mJc6/sDoe4naACj7I/6Cy5vaaTRfNywCrDfTkbECl5
TXpRZ2R7DcqSrZr8i39n+lPCXKtGdrR0tSARtAw6rdbEGW3/n60FJvqnpGXp2an+
RuRZLeO2JngAk0gO8Ccyf+CHWDF7ga3KbZIJafCgXlv1792gVGatgO5Y5qfBuwly
9koxngiRsYAq+QfcIkhP522yfKTCiA==
=aYpL
-----END PGP SIGNATURE-----

--Sig_/hg8tI/Lmv5H8vIby2MGGkVa--
