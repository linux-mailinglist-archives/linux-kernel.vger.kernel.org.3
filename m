Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CF94D92A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344488AbiCOCeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiCOCeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:34:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8A62AE0;
        Mon, 14 Mar 2022 19:32:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHcrd6mM9z4xv5;
        Tue, 15 Mar 2022 13:32:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647311570;
        bh=L+cNl27lhFxbaGy+Y7296fmSWIVWSTPRwGSVOwmVTVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VJxRIC4ksKA1S0XDBIA/mt5tDj1sUSCLBnPdUxsPkidROp1bTVWBJPgxPuQ0jBNO3
         vQucnmQf/mYcwU5jEPVqQUfqRBGsrPleJdkccEnWy2hfe9w4ic5Coz6xE9wxTTwSVw
         EYgLdro2cv7uvlUhQL6kkccv/5mcteJFlkpKq7wBKQnuLJ+Hr/CC9lXlRCJ0/o82Hu
         xmBQD1Nq4sO3wzwLHB4Ap2kpW45CwCgpwQiT9oSD0UqAbWD//WOjUQaWfDPiG2kBYT
         f9eajp1b7Pg3jW6IrER4jRGp7pBDFPGrAu5noiqpLsY/liOxwFVHDUMBTDEHQJEvaw
         IvrstC5D8EWBw==
Date:   Tue, 15 Mar 2022 13:32:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <20220315133249.146b8bac@canb.auug.org.au>
In-Reply-To: <20220122105806.3b710900@canb.auug.org.au>
References: <20211217144004.0c00fabc@canb.auug.org.au>
        <20220122105806.3b710900@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fa=9QQeq4JL5lCcjlNPD_LS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fa=9QQeq4JL5lCcjlNPD_LS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, 22 Jan 2022 10:58:06 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Fri, 17 Dec 2021 14:40:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the tip tree, today's linux-next build (x86_64 allmodconf=
ig)
> > produced these warnings:
> >=20
> > lib/strnlen_user.o: warning: objtool: strnlen_user()+0xc9: call to do_s=
trnlen_user() with UACCESS enabled
> > lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x129: c=
all to do_strncpy_from_user() with UACCESS enabled
> > vmlinux.o: warning: objtool: mce_start()+0x5c: call to __kasan_check_wr=
ite() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: mce_gather_info()+0x5f: call to v8086_mode=
.constprop.0() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: mce_read_aux()+0x8a: call to mca_msr_reg()=
 leaves .noinstr.text section
> > vmlinux.o: warning: objtool: do_machine_check()+0x192: call to mce_no_w=
ay_out() leaves .noinstr.text section
> > vmlinux.o: warning: objtool: mce_severity_amd.constprop.0()+0xca: call =
to mce_severity_amd_smca() leaves .noinstr.text section
> >=20
> > I am not sure which changes caused the above. =20
>=20
> I currently still get the following warnings from an x86_64
> allmodconfig build fo Linus' tree:
>=20
> vmlinux.o: warning: objtool: mce_start()+0x5c: call to __kasan_check_writ=
e() leaves .noinstr.text section
> vmlinux.o: warning: objtool: mce_gather_info()+0x5f: call to v8086_mode.c=
onstprop.0() leaves .noinstr.text section
> vmlinux.o: warning: objtool: mce_read_aux()+0x8a: call to mca_msr_reg() l=
eaves .noinstr.text section
> vmlinux.o: warning: objtool: do_machine_check()+0x192: call to mce_no_way=
_out() leaves .noinstr.text section
> vmlinux.o: warning: objtool: mce_severity_amd.constprop.0()+0xca: call to=
 mce_severity_amd_smca() leaves .noinstr.text section
>=20
> $ x86_64-linux-gnu-gcc --version
> x86_64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0
> $ x86_64-linux-gnu-ld --version
> GNU ld (GNU Binutils for Debian) 2.37

I gained these new ones after merging today's tip tree:

arch/x86/crypto/chacha-x86_64.o: warning: objtool: chacha_2block_xor_avx512=
vl() falls through to next function chacha_8block_xor_avx512vl()
arch/x86/crypto/chacha-x86_64.o: warning: objtool: chacha_4block_xor_avx512=
vl() falls through to next function chacha_8block_xor_avx512vl()
arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx() =
falls through to next function poly1305_blocks_x86_64()
arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_emit_avx() fa=
lls through to next function poly1305_emit_x86_64()
arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx2()=
 falls through to next function poly1305_blocks_x86_64()
arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx512=
() falls through to next function poly1305_blocks_x86_64()

--=20
Cheers,
Stephen Rothwell

--Sig_/fa=9QQeq4JL5lCcjlNPD_LS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIv+tEACgkQAVBC80lX
0GyRBAgAgmNjs0824Yd3XY9U01ZlbgSDODCHolJelw5GH0KrBuYJd4z426YLBNsi
eeeZxyOUoBI4YH5xxLY+4XJWT1xokLz4OqcpzOvWui8kbFl1lajz3lF6MZRkwS/g
1LaapEmAXwBGHEmfbXF26uhUaEJnAwXLmQ8dZBZlr07bJ6/NUJ00kQp/1PSHrdLX
8i91tyvKTQJvadpL16CZgU+L3XbqtzPFadAk1xQnfh+lQ+Xw8H2TkGim+BQ+wJ+r
w0T0Zz96erB1OTTvhpRnSvHfa+wPu0pJ5qbLe9l2kD4L9BauH87Kewz7raefgTt1
BRKoPj6PuNY61vqN6Ru5Ad+mGyrSbQ==
=yJOT
-----END PGP SIGNATURE-----

--Sig_/fa=9QQeq4JL5lCcjlNPD_LS--
