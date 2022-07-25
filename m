Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5257FB8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbiGYIlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbiGYIlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:41:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E649714015;
        Mon, 25 Jul 2022 01:41:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lrtmh42zWz4x1b;
        Mon, 25 Jul 2022 18:41:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658738472;
        bh=Xc9z+OS9WFCSWiBpxnyLpLzjfFMk6Dpyc1CkrC8qqzQ=;
        h=Date:From:To:Cc:Subject:From;
        b=lDbwRiug68dau1djnwFjwbiFayGSvaT9R/6kuu8McwLNhF8bte7Ehe2OUrycFC5QT
         HsapBREIp41AQd+HWWOcomUUhZV3LsJY/hCSSV6X4pPfwvbzPSFstg0BMwD6AwfTZm
         WTe7vPvJQSR/+0d8PFRegkqDYQlQx9tNcxNg01eh30yP9wMP4uzmvzFZJml34NflfV
         e7dm0wlLq77frRq9y5gQ2BiP9lwFU+MHRzpVSr5A8KHltHbbZNilQQ1xOO/Bf1DKjZ
         V7Ncm+ukVOLjiOAqfsD2PCYrzEGbbpqfG4YKL8KUl1tzgJttY9R1epNDPOjjzfc9kl
         XxSiWppq5CmWA==
Date:   Mon, 25 Jul 2022 18:41:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with Linus' tree
Message-ID: <20220725184107.429e33bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_x9SLabwJlwQ/4l7UmTbugN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_x9SLabwJlwQ/4l7UmTbugN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  arch/x86/Makefile

between commit:

  efc72a665a61 ("lkdtm: Disable return thunks in rodata.c")

from Linus' tree and commit:

  0ea4b9a1bece ("Kbuild: add Rust support")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/Makefile
index 7854685c5f25,5ac9b324751d..000000000000
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@@ -21,13 -21,8 +21,15 @@@ ifdef CONFIG_CC_IS_CLAN
  RETPOLINE_CFLAGS	:=3D -mretpoline-external-thunk
  RETPOLINE_VDSO_CFLAGS	:=3D -mretpoline
  endif
 +
 +ifdef CONFIG_RETHUNK
 +RETHUNK_CFLAGS		:=3D -mfunction-return=3Dthunk-extern
 +RETPOLINE_CFLAGS	+=3D $(RETHUNK_CFLAGS)
 +endif
 +
+ RETPOLINE_RUSTFLAGS	:=3D -Ctarget-feature=3D+retpoline-external-thunk
+=20
 +export RETHUNK_CFLAGS
  export RETPOLINE_CFLAGS
  export RETPOLINE_VDSO_CFLAGS
 =20

--Sig_/_x9SLabwJlwQ/4l7UmTbugN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLeVyMACgkQAVBC80lX
0Gwetgf/Y8wHZHNv6ZGH1fGxOuRPsltj4JJ1bcKWavRdnnqbfkZikSL4+9nrEo5A
MR2uVFFVpq1KQnKryTvRRvxnZil3Ll7Lp6YczbiGSgJSH2LBx3D9lJNTA+kM8Cdo
UVl3vCs3Bv32UvS664WxvHVut2TW5eUH4kSAKRi98Xs59nGtY2j0eNQz42pNRzIB
qsi39bGkzRsNkbqayKBb4XPHRpuQQk4SfsA3Vc0AlGeL3xiq3sKdgzLXxVQNRDAg
6PdvzENcTNkQwtXso/x+sQc8gt4lxUOOGGAQTWTor+YQVIzEmzKzi7NhlcdOyfT7
psN1c0nCT5lVfbTqUkEQYrINdMWXog==
=hhbw
-----END PGP SIGNATURE-----

--Sig_/_x9SLabwJlwQ/4l7UmTbugN--
