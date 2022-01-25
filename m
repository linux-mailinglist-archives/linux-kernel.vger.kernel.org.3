Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4E49ABC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiAYFdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 00:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiAYF3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:29:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9B7C068083;
        Mon, 24 Jan 2022 19:50:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JjXtR4TKWz4xNn;
        Tue, 25 Jan 2022 14:50:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643082608;
        bh=mh/3fZT6a0RmxN01aJ4+imsp/te7qFkTGoUMaKYybE0=;
        h=Date:From:To:Cc:Subject:From;
        b=s1HCFCzcEshpkJgMrTJVAI/NUkEFxOpNeChit6W+Z4ca/eYWivM28jAhhVJocyrdY
         BES0VRvRmg72QigCyXa3wdVdDLYyAohJlfYvBvA6nr3ITFuBVkBUFYbib8wWR0HlmK
         f0EVMx4Ij4nKlXuyN3rWQHBFRyrDl15gRwSxdgjpBXPl81fAipmAlOkiFSHhAGy+7i
         CGx0qJIfdpb+8R1DKjXVGBxnq+hTftGJvjX79OQOIUZjwO/y9YPu9CBm+z5S0uP1Vj
         QluU7b/sckdB+AOVxp6LT1u8Nz1KMs0vk+lR5Npn2LFMU2BDM/IsIiKnXDfIlrG0sW
         N0MZoqZvU/kkw==
Date:   Tue, 25 Jan 2022 14:50:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20220125145006.677e3709@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/agPJiRZ7dyij3hrjwZjaV=g";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/agPJiRZ7dyij3hrjwZjaV=g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (powerpc
allmodconfig) failed like this:

In file included from include/linux/string.h:253,
                 from include/linux/bitmap.h:11,
                 from include/linux/cpumask.h:12,
                 from include/linux/mm_types_task.h:14,
                 from include/linux/mm_types.h:5,
                 from include/linux/buildid.h:5,
                 from include/linux/module.h:14,
                 from samples/trace_events/trace-events-sample.c:2:
In function '__fortify_strcpy',
    inlined from 'perf_trace_foo_rel_loc' at samples/trace_events/./trace-e=
vents-sample.h:519:1:
include/linux/fortify-string.h:47:33: error: '__builtin_strcpy' offset 12 i=
s out of the bounds [0, 4] [-Werror=3Darray-bounds]
   47 | #define __underlying_strcpy     __builtin_strcpy
      |                                 ^
include/linux/fortify-string.h:445:24: note: in expansion of macro '__under=
lying_strcpy'
  445 |                 return __underlying_strcpy(p, q);
      |                        ^~~~~~~~~~~~~~~~~~~

Exposed by (probably) commit

  602670289b69 ("fortify: Detect struct member overflows in memcpy() at com=
pile-time")

Introduced by commit

  b466b1332164 ("samples/trace_event: Add '__rel_loc' using sample event")

I have reverted that latter commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/agPJiRZ7dyij3hrjwZjaV=g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHvc24ACgkQAVBC80lX
0GyCyQf9HBst7Vl72mAAAEPbbaN8wCF9qqSzOB94V/f6bSaJpS7ZFMfq4Pfbnu+C
SF+RTynwdLo2Nz4CtkFGFgonI4BR0wfNv8M3GEvQU2ckBfHZewYXC6NTQc1uY+gy
yKItZhQhshc2ZSYlxPBb3HVpXdFhrCW8S+78kbnP2pQ4AE8U2qfsqDuwjcmefpms
FEhX7gNjRIxQ+PMT60eUT7YXiHY1KwM5q6rRWLI5cyLe42AmvoxIKYVWsRtaae6Y
EV2N4gS533rWjUfOSaEJ6hCs6JOfmkbsjOmXOD8Jua7ku/dUzBC3M7OxMdWzLiUs
gPymP7U74TLwqgDgdPoGtJveJKA5ww==
=hvev
-----END PGP SIGNATURE-----

--Sig_/agPJiRZ7dyij3hrjwZjaV=g--
