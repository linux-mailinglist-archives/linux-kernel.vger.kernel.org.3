Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC1E4E3AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiCVIgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiCVIgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:36:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E4B6A01D;
        Tue, 22 Mar 2022 01:35:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KN4YX6WyYz4xgw;
        Tue, 22 Mar 2022 19:35:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647938113;
        bh=DXIHC1zlCCiL1zQ6AEGnel2GmwoCybK9LmRX/nvsSsE=;
        h=Date:From:To:Cc:Subject:From;
        b=BVQup1LnwaM8r9CWky4KKrR6tNIjlWAPlIgnyYRiFshd/LUgLHZAdAbZSsYW+NB7h
         8eVQDnYfmotZ+oGnBeIvQCTSl7laIyRH+T7D0FnS1n5Qd/GTWm41XufYGWAtavsT65
         o2hTTWqqkiYESRIUM4enUKCkEiZccwfYkCXcJtnQlmdTEO475MI2O7jhkoR8HCPnfV
         Tw3EYE5ES24eKwPHQ1rW9gvFbYGlhTxgC6ntauZerDSzBZ5xUfLS6598ywZIfHvSQc
         XOSnAsikhvILIlv6ksJfYDU2N8H6p4P/bne3EtXk6upxxDwVwLN7LvQ3f/345aqbg1
         VRFBjjXbePAIg==
Date:   Tue, 22 Mar 2022 19:35:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: linux-next: manual merge of the akpm-current tree with the folio
 tree
Message-ID: <20220322193511.1269bfa1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d3i.4hc5yp3vER1Hh20YOQ.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d3i.4hc5yp3vER1Hh20YOQ.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/internal.h

between commit:

  ece1ed7bfa12 ("mm/gup: Add try_get_folio() and try_grab_folio()")

from the folio tree and commit:

  c5a8dccce9cd ("mm: handle uninitialized numa nodes gracefully")

from the akpm-current tree.

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
index 293eca1360dc,dd42be01e628..000000000000
--- a/mm/internal.h
+++ b/mm/internal.h
@@@ -752,11 -713,6 +747,13 @@@ void vunmap_range_noflush(unsigned lon
  int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
  		      unsigned long addr, int page_nid, int *flags);
 =20
 +void free_zone_device_page(struct page *page);
 +
 +/*
 + * mm/gup.c
 + */
 +struct folio *try_grab_folio(struct page *page, int refs, unsigned int fl=
ags);
 +
+ DECLARE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
+=20
  #endif	/* __MM_INTERNAL_H */

--Sig_/d3i.4hc5yp3vER1Hh20YOQ.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI5ij8ACgkQAVBC80lX
0GxgCAf+NQdL6TE88gywVoY6uLRTPnnTVNqvTABYBOtkd9BXOlyu7qnzpB6UNIAe
T2OMovGxFtRIIGCJpguFAyVD9MYDTrdboVRQC+0fgX2S+XwaxRG8ittiathr5Wzu
tIGrOI/naVIuHPav86hU1PJvigdtuUscueSd8Bk/xSDve2BTMViCx16hT1BUgdWU
kOAaedctAzgrTal9E3SiD0FY/vWEgpX1q1tfYE2sSgxxL/EyMab8TBQSoYHX0CEj
QOH9F03et3fPiBRHpvQetATotBuqoCV4lKaa3dVJ/wVwWeIL+lSlTApZfxxZHn00
hdQK7jwdvfE9JLOmwuMecMvIWw8UGg==
=ULQa
-----END PGP SIGNATURE-----

--Sig_/d3i.4hc5yp3vER1Hh20YOQ.--
