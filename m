Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E4956B3CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbiGHHrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbiGHHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:47:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A4C7D1E4;
        Fri,  8 Jul 2022 00:47:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LfQNp3q1wz4xXD;
        Fri,  8 Jul 2022 17:47:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657266460;
        bh=BufiTmFOjOTRKTxthIni/3WqGCUldD57kd+VeVSwYLc=;
        h=Date:From:To:Cc:Subject:From;
        b=aX56pxlG/2Wuw25ozUllP6Pjl+Vrz6E9WVq1as29r4ToQZlyI8EjXipFxbqSYHxKJ
         dXwcQEqWWdoclHnf2DFHlR30N2CH5ovO92qq3nDcOISR+8Ix+mjOV5Ygryc/GbmzLH
         i673RtW61oL1ZJZEnk/2TlNWGfEdWrzgwuJgoAxb8NZ7A/eQ+rqyfsnDHaJgrvot9y
         Aq9PjVEIlQDMupLUFYEq4rj7/dbmkfv44cN0ANACOxa1/X+dGe4ZmSR5aisx44ZxFK
         rP1GS5PQDaxGIrd8F090ARv4ebCfRBebJ/svr6Oh3/B37OdisLQ5JWihz7uJjRVXE8
         nBmd4F/R2ob3w==
Date:   Fri, 8 Jul 2022 17:47:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bitmap tree
Message-ID: <20220708174737.52d569c8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QE_j9YWfk8R.jkLw/IhID=R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QE_j9YWfk8R.jkLw/IhID=R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bitmap tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

lib/bitmap.c:351:6: error: conflicting types for '__bitmap_set'; have 'void=
(long unsigned int *, unsigned int,  unsigned int)'
  351 | void __bitmap_set(unsigned long *map, unsigned int start, unsigned =
int len)
      |      ^~~~~~~~~~~~
In file included from lib/bitmap.c:7:
include/linux/bitmap.h:167:6: note: previous declaration of '__bitmap_set' =
with type 'void(long unsigned int *, unsigned int,  int)'
  167 | void __bitmap_set(unsigned long *map, unsigned int start, int len);
      |      ^~~~~~~~~~~~
In file included from include/linux/linkage.h:7,
                 from include/linux/printk.h:8,
                 from include/asm-generic/bug.h:22,
                 from arch/powerpc/include/asm/bug.h:158,
                 from include/linux/bug.h:5,
                 from lib/bitmap.c:9:
lib/bitmap.c:370:15: error: conflicting types for '__bitmap_set'; have 'voi=
d(long unsigned int *, unsigned int,  unsigned int)'
  370 | EXPORT_SYMBOL(__bitmap_set);
      |               ^~~~~~~~~~~~
include/linux/export.h:87:28: note: in definition of macro '___EXPORT_SYMBO=
L'
   87 |         extern typeof(sym) sym;                                    =
             \
      |                            ^~~
include/linux/export.h:147:41: note: in expansion of macro '__EXPORT_SYMBOL'
  147 | #define _EXPORT_SYMBOL(sym, sec)        __EXPORT_SYMBOL(sym, sec, "=
")
      |                                         ^~~~~~~~~~~~~~~
include/linux/export.h:150:41: note: in expansion of macro '_EXPORT_SYMBOL'
  150 | #define EXPORT_SYMBOL(sym)              _EXPORT_SYMBOL(sym, "")
      |                                         ^~~~~~~~~~~~~~
lib/bitmap.c:370:1: note: in expansion of macro 'EXPORT_SYMBOL'
  370 | EXPORT_SYMBOL(__bitmap_set);
      | ^~~~~~~~~~~~~
In file included from lib/bitmap.c:7:
include/linux/bitmap.h:167:6: note: previous declaration of '__bitmap_set' =
with type 'void(long unsigned int *, unsigned int,  int)'
  167 | void __bitmap_set(unsigned long *map, unsigned int start, int len);
      |      ^~~~~~~~~~~~

Caused by commit

  aaa4ab5ec044 ("lib/bitmap: Make length parameter `len` unsigned")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/QE_j9YWfk8R.jkLw/IhID=R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLH4RkACgkQAVBC80lX
0GzC4wf/fZvuuy8PT/HsMWEk0gbxdXRLtobp2h471ccc0PE85+oTUMMZ68G+5FyM
DnT8kNucZNxCbJdCcsbXBaGwcAF8DkJQqdkmWdxroe/y3yPllGzzeLprVY6uNmM9
sWrJL2s9HPpUPwRW3r0mKQPPkH99pORB+5Pm39r8suN+sNZm3HpW/mbSziwyeM5M
/HGU5fmDgCeXf9gfkPw/NWQ+e3LgMjxL5uFWoeBAJQ4/pSxbZF/zgXUxqnbmf5HU
n574GCfFJ16XwI54ZMdl1XJORifjWNZcNUF3dl0O3et6Jw9MCWapjIN3h5VjGyxy
KvG4gJfL8j2liPoVGnaVJdt4hd9wrA==
=0app
-----END PGP SIGNATURE-----

--Sig_/QE_j9YWfk8R.jkLw/IhID=R--
