Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9836E5B2E09
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiIIFZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiIIFY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:24:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69E46583F;
        Thu,  8 Sep 2022 22:24:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MP4F308Llz4xFt;
        Fri,  9 Sep 2022 15:24:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662701095;
        bh=yf8zbB9mC1uEUph+wIon7IVVUsF9EAnxh8mABesm5Sk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qaQ2LJB721/cLtc+sVFb+g5wltVl7Lv4+mYHMPH1ObwBrHZIF0xaAC93DtTuTs39Y
         /H1/cN85tiszj59RpWP8BWw8vke+IUALaR9pijjh+7c+8QmpXqFoR+6TN0OLm5c4o1
         gnhZzi2O8x5WQ3IAVstgT0AOXMCI72BkAr29Z3eYZOy5qAvi5vwNEf02pF738cdub6
         gxJ7+47pb7Svxr2TDfWKLixRLzkt8UyQU3sNrCNymRNbk2Z7yQle8TzG0ZStavn4eH
         5ALFnWqHftytVR39ObiRmtr47EVrBb8I/W2hdTrd3EfyWqoRpbfk9/rOgazhOUZlQM
         v19F6XnydGy5w==
Date:   Fri, 9 Sep 2022 15:24:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kbuild tree
Message-ID: <20220909152453.5400cf7e@canb.auug.org.au>
In-Reply-To: <CAK7LNARPX2Ov-nLAT6mPWbgqQMDCuoW84VN_C2sS1CJkR_n8YQ@mail.gmail.com>
References: <20220909090024.47458048@canb.auug.org.au>
        <CAK7LNARPX2Ov-nLAT6mPWbgqQMDCuoW84VN_C2sS1CJkR_n8YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/V.+.OC+3qcSvzIhJxMy_WAY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V.+.OC+3qcSvzIhJxMy_WAY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 9 Sep 2022 14:10:06 +0900 Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
>
> Hmm, I am testing allmodconfig in my tree,
> but it is not reproducible so far.
>=20
> Do you have any more hint?
> (which commit exactly?, and what build command did you use? etc.)

I was trying your top of tree commit

  99ea8da56dca "kbuild: use objtool-args-y to clean up objtool arguments"

(merged with Linus' tree and some fix patches).

I am doing a cross build with an out of tree object directory:

$ make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- O=3D../x86_64_allmod=
config -s allmodconfig
$ make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- O=3D../x86_64_allmod=
config -j100 -O -s

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0
$ x86_64-linux-gnu-ld --version
GNU ld (GNU Binutils for Debian) 2.37
$ make --version
GNU Make 4.3
Built for powerpc64le-unknown-linux-gnu

> > make[2]: *** No rule to make target 'objtool/objtool'.  Stop. =20
>=20
> Presumably, it is failing in tools/Makefile,
> but I do not know how this can happen...

Right, I could not see what caused this, either.  I tried reverting
that top commit, but that did not help.

--=20
Cheers,
Stephen Rothwell

--Sig_/V.+.OC+3qcSvzIhJxMy_WAY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMaziUACgkQAVBC80lX
0Gzr5gf/RKgXnSnLw+EDR4WFTKvZF3tTUWGPxR970Q4elOrn/Q+x39nv+noNbzXl
/9n7QZ08miLQWE4Yk7zu8oypPCEKsepDHF+LavTmGDTpST1NWJ1uQSlQSWKDiPQF
OlC9gTAnzkQ+FrupXHR1WeaRIDz79iPfmYwtUWSN0uX76HyBiHBQXF8Ur8HVxHNY
UugwWOn2jhtFe5wdwzNhrPdA2fchNqJbhvyVk3FWbDOKKvljjiNV5SrGtw1aqp0s
GgFk7WWksP23ENHAFyR6AT8cmxOwf1r7hw+KUnfgDgkiLEILkRhUBfY+5OP8YICc
xwHvl1OzFTPwjGDUymYIFBItig7mdA==
=bh2L
-----END PGP SIGNATURE-----

--Sig_/V.+.OC+3qcSvzIhJxMy_WAY--
