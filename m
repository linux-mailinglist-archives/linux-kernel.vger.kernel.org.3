Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A9E516D55
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384186AbiEBJ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384173AbiEBJ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:28:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3769A2DEA;
        Mon,  2 May 2022 02:25:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KsHkQ69N6z4yST;
        Mon,  2 May 2022 19:25:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651483519;
        bh=IcZ6omKND5FLEVyamlgI53r/grm7FjajqIZhCPrHX0I=;
        h=Date:From:To:Cc:Subject:From;
        b=FdM3Gx8df/La5cv/wlCtKvE0MafYao7+4eSTbRaue9Yu/Uxg+tmWZNszlnwwRrwt+
         /Rx9g22y5vc4DZlH2A2lSxTN8TI0957Xl6O6MHJoffuFaRF7UBqaETbEnMhp/5ygTo
         KN3+Ikwj9w48jFeSLbeyppZ/XSWXw6FbSH0F1ybf2J9WkOipiTbNWnQZ68i1MS8uJA
         B+ADeG4BIv2ouqjtsvUTLqIGLV1kF5r81bIzRaIlG5Sr5t3QWCmydk88Tm4XMorb5B
         +4dY5vG0fIoSyx/qIV1RY0e+Fzg4jnZtpfeMReyqi/HQ7gLTM2JQzFj0diud/M7eVa
         u2bS3fyULr8RQ==
Date:   Mon, 2 May 2022 19:25:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Collingbourne <pcc@google.com>
Subject: linux-next: manual merge of the mm tree with the slab tree
Message-ID: <20220502192517.28161b32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z3zMWuT4tSOkpA1Q=w1ja6e";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/z3zMWuT4tSOkpA1Q=w1ja6e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  include/linux/slab.h

between commit:

  71aeb554a274 ("mm: slab: fix comment for __assume_kmalloc_alignment")

from the slab tree and commits:

  3f0cd9a623ec ("mm: make minimum slab alignment a runtime property")
  78c0585fdbac ("mm-make-minimum-slab-alignment-a-runtime-property-fix")

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

diff --cc include/linux/slab.h
index 58bb9392775d,3d2f2a3ca17e..000000000000
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@@ -216,10 -209,22 +216,22 @@@ void kmem_dump_obj(void *object)
  #define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
  #endif
 =20
+ /*
+  * Arches can define this function if they want to decide the minimum slab
+  * alignment at runtime. The value returned by the function must be a pow=
er
+  * of two and >=3D ARCH_SLAB_MINALIGN.
+  */
+ #ifndef arch_slab_minalign
+ static inline unsigned int arch_slab_minalign(void)
+ {
+ 	return ARCH_SLAB_MINALIGN;
+ }
+ #endif
+=20
  /*
 - * kmalloc and friends return ARCH_KMALLOC_MINALIGN aligned
 - * pointers. kmem_cache_alloc and friends return ARCH_SLAB_MINALIGN
 - * aligned pointers.
 + * kmem_cache_alloc and friends return pointers aligned to ARCH_SLAB_MINA=
LIGN.
 + * kmalloc and friends return pointers aligned to both ARCH_KMALLOC_MINAL=
IGN
 + * and ARCH_SLAB_MINALIGN, but here we only assume the former alignment.
   */
  #define __assume_kmalloc_alignment __assume_aligned(ARCH_KMALLOC_MINALIGN)
  #define __assume_slab_alignment __assume_aligned(ARCH_SLAB_MINALIGN)

--Sig_/z3zMWuT4tSOkpA1Q=w1ja6e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvo30ACgkQAVBC80lX
0GxLDgf/UIPTnpHeUkb6fDuQEabpZf2lWKmUpCY7uzBn0sBwakfMkZzQfu25UiC8
GF6bqSAW/5I2gX7Xmc0EW7FMcCf8d3i672QD2vyd2VfCIYVxvudu6hQzV1S9l2s+
SNKDkhGZD4H7KVCUkJeKCAfc3TwFvd+6rsGwuq6rk2NAYn171gbGzNtGEQyS0J6v
IEtnXYbKETakQmORSHOBrRsVVFcRD4Kgg9bTCm0mOhATax+//9JwAsoHagnSo2TA
ug+Z13SX6vHF7xo0ce1q/yqEMU3XLUEJXNBw7tqaLsYQOWB14yx824l2rceFrUMv
ni6iq0Y+PNXm+0FohfJfTsob+uZjng==
=uNBC
-----END PGP SIGNATURE-----

--Sig_/z3zMWuT4tSOkpA1Q=w1ja6e--
