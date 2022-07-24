Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E5157F7BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 02:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiGYAAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 20:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGYAAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 20:00:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94342AD9;
        Sun, 24 Jul 2022 17:00:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LrgDC6q68z4xD9;
        Mon, 25 Jul 2022 10:00:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658707245;
        bh=Mzb3S0zhZB5099fE67pDAVxb56KP80OzxcaKW0EISm4=;
        h=Date:From:To:Cc:Subject:From;
        b=DgUMjRBwp9f/zH6r0ab6rLwj5/GA4Lc3D6JLjBb3X4Gq8REVy2zglhLlDF/Bs10jy
         qJkfVoqNmEKV2Ykxy7j2u8ofUcDtyuaXzXMHyYydg9U+j+X1M50SMtpU9jPP3NqDWK
         rBSEU/6HaaZMue3gSdbfFdK7derfSu/PDsc5Qx8D+EhARekrSFWY+AKUPE42pJfhSn
         yLeo8oAgqiuHLFkvPRe0skf92NbjJH7ER2yDUK4QMCpDNeWlQY/IEIPgPfuDRUf+VM
         GOvChjTIRJrgpvGfp43ZTJyUGwTP1kfO8nygsMUO1/jHxKvya/sNYlfDgfX1WZsD5v
         Iz/i/E75FUZ+g==
Date:   Mon, 25 Jul 2022 09:33:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20220725093316.2a3a7b05@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/y.lNQ2AI/mgks3NtZRsevPe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y.lNQ2AI/mgks3NtZRsevPe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/include/asm/errata_list.h

between commit:

  e83031564137 ("riscv: Fix ALT_THEAD_PMA's asm parameters")

from Linus' tree and commit:

  9c2ea4a36364 ("riscv: convert the t-head pbmt errata to use the __nops ma=
cro")

from the risc-v tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/include/asm/errata_list.h
index 416ead0f9a65,e4ee53551343..000000000000
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@@ -68,19 -68,13 +68,13 @@@ asm(ALTERNATIVE_2("li %0, 0\t\nnop"
   */
  #define ALT_THEAD_PMA(_val)						\
  asm volatile(ALTERNATIVE(						\
- 	"nop\n\t"							\
- 	"nop\n\t"							\
- 	"nop\n\t"							\
- 	"nop\n\t"							\
- 	"nop\n\t"							\
- 	"nop\n\t"							\
- 	"nop",								\
+ 	__nops(7),							\
 -	"li      t3, %2\n\t"						\
 -	"slli    t3, t3, %4\n\t"					\
 +	"li      t3, %1\n\t"						\
 +	"slli    t3, t3, %3\n\t"					\
  	"and     t3, %0, t3\n\t"					\
  	"bne     t3, zero, 2f\n\t"					\
 -	"li      t3, %3\n\t"						\
 -	"slli    t3, t3, %4\n\t"					\
 +	"li      t3, %2\n\t"						\
 +	"slli    t3, t3, %3\n\t"					\
  	"or      %0, %0, t3\n\t"					\
  	"2:",  THEAD_VENDOR_ID,						\
  		ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)		\


--Sig_/y.lNQ2AI/mgks3NtZRsevPe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLd1rwACgkQAVBC80lX
0Gx8Mgf/aJaFoirExIuQx9TeAihT0lfk6p6S53tS8abnEduHH1L2JXsaQZKQdhZ0
Wm95CjbJ9xehMu6DLXkMZmIDAWV8O0Hrj1z8rNntNhDUxxW09irV70vQmnF0phAP
L6C8tOsSvJTe53s7w6si11G+e0irVgAF/f9/wN8NuAgaB9YRuUiqIqqfCInFep5D
qbE90iYiZaw2W8HN8mruRLFe+x8p86T6A+FhtsYTaFeLtx4BNz86QvJNHxsQZPXj
/kb86DDubHH49RIixs3/3oPKwMm4n2o6hInykSsCzx8brZ1qCy4wc1z+uXZiO5jj
jnGCp4odBs2qg7tTsYJOUwWVAZcVIw==
=X1Xr
-----END PGP SIGNATURE-----

--Sig_/y.lNQ2AI/mgks3NtZRsevPe--
