Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAF448BBC3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236068AbiALAVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiALAVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:21:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9A0C06173F;
        Tue, 11 Jan 2022 16:21:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JYSt520fWz4xtf;
        Wed, 12 Jan 2022 11:21:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641946909;
        bh=pWR0F1Pzz3t59vyhhhWsePr/xIsKtinI1MrS69LcH+E=;
        h=Date:From:To:Cc:Subject:From;
        b=Qp0ldJbU0d/Rd2hPuHjiW+GEBW95zbCIwqP7tDqUQOrKDyRjeqVqC3Wu4k7L2LBLP
         LJpA5sA03en1Eb2fjT/SdythcGQtPXr+YeBLWXcNpbendl+wwpEkzgdtQ0MC3a/Njn
         Qx4QnJe5q0NWYbNgs4DYhnQwSSS5hAsPJXOGkTLQi2SXCt62/R6I05dy0fmz3HJfqE
         2QRbz2lPcOpET7SsxDXgxZJgFRBcExNrKQSLORCQd/bkyLlW4agPXVpeMYZJsK/rpw
         dwJ86owSINhgwAoRdvnWpKWnL8g7qKGbskt1oj4UyY/6No4NPVim1ZsjTVTWT3XkMg
         8nXQz8iUpcKSA==
Date:   Wed, 12 Jan 2022 11:21:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Yinan Liu <yinan@linux.alibaba.com>
Subject: linux-next: manual merge of the ftrace tree with the kbuild tree
Message-ID: <20220112112147.3e19ce23@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hbqfl/N6O/56_5migZ9LuR=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hbqfl/N6O/56_5migZ9LuR=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ftrace tree got a conflict in:

  scripts/link-vmlinux.sh

between commit:

  7d153696e5db ("kbuild: do not include include/config/auto.conf from shell=
 scripts")

from the kbuild tree and commit:

  4f1f18311591 ("scripts: ftrace - move the sort-processing in ftrace_init")

from the ftrace tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc scripts/link-vmlinux.sh
index 5189c9a12066,dd9955f45774..000000000000
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@@ -412,11 -411,8 +412,8 @@@ if is_enabled CONFIG_BUILDTIME_TABLE_SO
  	fi
  fi
 =20
- info SYSMAP System.map
- mksysmap vmlinux System.map
-=20
  # step a (see comment above)
 -if [ -n "${CONFIG_KALLSYMS}" ]; then
 +if is_enabled CONFIG_KALLSYMS; then
  	mksysmap ${kallsyms_vmlinux} .tmp_System.map
 =20
  	if ! cmp -s System.map .tmp_System.map; then

--Sig_/hbqfl/N6O/56_5migZ9LuR=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHeHxsACgkQAVBC80lX
0GwiFQf/dKVwG65IVK08HsTS76vrpVY0Lboqs8j2pZhrtGQ0oACESCPUjYLm+asy
PPgYevr4d52IqG9pWx79eokHKc/bXlLV5fuWth2M6fu/QN2oCFlreDmFoF7hzYg3
x9syhYf+Cfiz6RifcVaxDaWtaQqNMvwRNX9hmcT5EruLQu8OT1YwBnst237p4nsu
j3NIRXe/ab2HTBJwmOYSX0MZMGfnauvm0qkV3Df1NMuqqIF8+Qa6V96IFVIr/UHA
hscvu2CuYA44uT6RMNbywzwgZAQD/d9XznocRvcAHnKfH0GPu1cKihxTk6CwXMs3
Q5I6HsSzJNXkDw+qiW5we/5bQfqkqQ==
=sXRj
-----END PGP SIGNATURE-----

--Sig_/hbqfl/N6O/56_5migZ9LuR=--
