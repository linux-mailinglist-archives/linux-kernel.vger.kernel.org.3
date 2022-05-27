Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E2E5358BF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 07:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiE0FVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 01:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiE0FVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 01:21:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE21A8889;
        Thu, 26 May 2022 22:21:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L8Y6y2WFFz4xYY;
        Fri, 27 May 2022 15:20:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653628859;
        bh=ibK13A/3tHbpREzEni/xsDgo3KPLS5KPT0yq1eh6Xjw=;
        h=Date:From:To:Cc:Subject:From;
        b=lKGkTIsT5LI3C9Tk245V8D2Hhv31jxdc5uTS6DAXcRqeVnkLVTmKr+bpIEVqse9sL
         EfTbYgTUYkL6nOjYSkyEu7Xh0oWbKkTx1yapzKRrjMfZePhl9LNVarmBn/j1IabnM0
         JVfp6CTQO9sH1GQrDBcvhOJWdDzXDWrL6IxkiqI9+YYjAo2qbuuqZwNDq1CS1mqZ6M
         Zxue/MvF0N3Woi4/+zBhreG4N6Xu8KBgya2JZAoO3VDzF8Qhn/Jio507OQH42fA8kW
         b3GJk2OhJRmg+klFNtBf+Z8+zsCXMRm4N2l3mQjftwN7stLrk27pwfgO7eYQUQ6K6z
         JFUDQyllHctqQ==
Date:   Fri, 27 May 2022 15:20:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     David Disseldorp <ddiss@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: linux-next: manual merge of the mm-nonmm-stable tree with the
 ftrace tree
Message-ID: <20220527152057.399bfc2b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I7USWoSPXy.qoAqEvaVM1/r";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I7USWoSPXy.qoAqEvaVM1/r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-nonmm-stable tree got a conflict in:

  init/Kconfig

between commit:

  a2a9d67a26ec ("bootconfig: Support embedding a bootconfig file in kernel")

from the ftrace tree and commit:

  1274aea127b2 ("initramfs: add INITRAMFS_PRESERVE_MTIME Kconfig option")

from the mm-nonmm-stable tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc init/Kconfig
index 006e086f2724,90cb1ac936db..000000000000
--- a/init/Kconfig
+++ b/init/Kconfig
@@@ -1370,25 -1361,16 +1370,35 @@@ config BOOT_CONFI
 =20
  	  If unsure, say Y.
 =20
 +config BOOT_CONFIG_EMBED
 +	bool "Embed bootconfig file in the kernel"
 +	depends on BOOT_CONFIG
 +	help
 +	  Embed a bootconfig file given by BOOT_CONFIG_EMBED_FILE in the
 +	  kernel. Usually, the bootconfig file is loaded with the initrd
 +	  image. But if the system doesn't support initrd, this option will
 +	  help you by embedding a bootconfig file while building the kernel.
 +
 +	  If unsure, say N.
 +
 +config BOOT_CONFIG_EMBED_FILE
 +	string "Embedded bootconfig file path"
 +	depends on BOOT_CONFIG_EMBED
 +	help
 +	  Specify a bootconfig file which will be embedded to the kernel.
 +	  This bootconfig will be used if there is no initrd or no other
 +	  bootconfig in the initrd.
 +
+ config INITRAMFS_PRESERVE_MTIME
+ 	bool "Preserve cpio archive mtimes in initramfs"
+ 	default y
+ 	help
+ 	  Each entry in an initramfs cpio archive carries an mtime value. When
+ 	  enabled, extracted cpio items take this mtime, with directory mtime
+ 	  setting deferred until after creation of any child entries.
+=20
+ 	  If unsure, say Y.
+=20
  choice
  	prompt "Compiler optimization level"
  	default CC_OPTIMIZE_FOR_PERFORMANCE

--Sig_/I7USWoSPXy.qoAqEvaVM1/r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKQX7kACgkQAVBC80lX
0Gw8kAf/SBYC/hUFcIrLqgoKn+1n02iq4DctJIUXI9Y1wzOrxfvQRjx5v0dCPYAq
TS+7XBEPGlCq9SuzaT06KRzFG6SwesK8wG0tCCyeSI3IIv2aWMDppwKQmKiH0wra
Esj+rBZN+hsUSoTSXdlnu0TG6cdYPqOTQNej/cK67YibcbsHKqI9iNBxECxXOgad
etwlFUQqY9WkOVAYheM64KGs+12gWzbfmKyuxbB/oLnIoeBiIeMStkVm67r7uYIW
8B6IlxfAJ97i0rE/+W7l5SJ/1J97toCZakRIIe4eu0PvuQc1jsNwExqPlWMqwHtg
NmYZBHDcnNgeJzcEkzmABEfBabHfIA==
=G7a/
-----END PGP SIGNATURE-----

--Sig_/I7USWoSPXy.qoAqEvaVM1/r--
