Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BE656AF02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 01:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbiGGX2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 19:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiGGX2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 19:28:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79919298;
        Thu,  7 Jul 2022 16:28:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LfCK22BwWz4xL4;
        Fri,  8 Jul 2022 09:28:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657236518;
        bh=CrMKnJMPN9f3mCAwl6Rh6j8UtkWI5IywlvNYWCVU2Wo=;
        h=Date:From:To:Cc:Subject:From;
        b=WIfpuv7FV3sNqt7iCzPadtMvhHYbxcH/tyBeZqrkJn83SalQbgzsFe4UYFwtpPjSn
         Ar+lWC5C2co1C89/J6A3ne8dZymGYiyngIpo/oEpAfXqOxQLvlLIm2uQJaWmyZFyrH
         uhW8oT2AoenuCA7W2XmlyGIMO+D6xVHN8BD5/2rvh8nYF0zs03czY9+to5cfPgTOkD
         nLtzXjPgkSzbF5scIdB5hcfRGt3M2c+7FzoLJMcfvdJtqUWVYgqp9Y1oWNwrYbnw8Y
         kLF0XSpZztloy+9uFTqei+p3ZUwrWbU/6PJdUMRDAJxsSYi61mza6wgF9e3mNYN2og
         d73Sqfwl8/3Rg==
Date:   Fri, 8 Jul 2022 09:28:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: linux-next: manual merge of the perf tree with Linus' tree
Message-ID: <20220708092836.1a24d5c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/contwonC74Yzn8dqmovPQcs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/contwonC74Yzn8dqmovPQcs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the perf tree got a conflict in:

  tools/perf/util/evsel.c

between commit:

  49c692b7dfc9 ("perf offcpu: Accept allowed sample types only")

from Linus' tree and commit:

  9ab95b0b15a0 ("perf record ibs: Warn about sampling period skew")

from the perf tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/perf/util/evsel.c
index 094b0a9c0bc0,8fea51a9cd90..000000000000
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@@ -1373,8 -1372,7 +1378,10 @@@ void evsel__config(struct evsel *evsel
  	if (evsel__is_dummy_event(evsel))
  		evsel__reset_sample_bit(evsel, BRANCH_STACK);
 =20
 +	if (evsel__is_offcpu_event(evsel))
 +		evsel->core.attr.sample_type &=3D OFFCPU_SAMPLE_TYPES;
++
+ 	arch__post_evsel_config(evsel, attr);
  }
 =20
  int evsel__set_filter(struct evsel *evsel, const char *filter)

--Sig_/contwonC74Yzn8dqmovPQcs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLHbCQACgkQAVBC80lX
0GyfmAf/Q6m9gbCivfMChtl3jlKMHDI/oBbK5hrL5Ewdv0+1gxQef5ciuY7Sb5OU
PbCBu/4duEwmDuxUqVjWn2MKg+qKYabTclQLOa0S0bWL8YXwDtem/zyIT552lJV/
X+dvn/IKPw3d0roCsB5KYlFBa3UAtAKMDBYRJ/ZUrVVIUM97mj0/EVPOXo5+l4i4
sqMNFHUcJ9uKBbwu9Jb3K25B6me8s+CduLVmk9XRSeL+U7h8AK+4CzsLtSwq4s+/
5TG7EyKzXJq/ziaJaO9oImDfWiBMnNeU3gtqzZns0pBd+NlA8KnEMXWPeCG0Ppt1
jnDyt/4m2lymQEhkiKyeMjlEXT2ddQ==
=/KCH
-----END PGP SIGNATURE-----

--Sig_/contwonC74Yzn8dqmovPQcs--
