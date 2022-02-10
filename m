Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FEC4B0767
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiBJHnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:43:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiBJHnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:43:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0D2D71;
        Wed,  9 Feb 2022 23:43:43 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvTJY4C9Xz4xNn;
        Thu, 10 Feb 2022 18:43:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644479021;
        bh=GmNUgiuUI4wGUSUdmWY5dDIG/MzEogexYWKT6/FN4yY=;
        h=Date:From:To:Cc:Subject:From;
        b=emDPeTRTCRm47PXxPT10cG4F0JiPSV2V+r4ZtTaGbpo2r/aYi2xX3zyHo4dBM3QAS
         2jEmHAZdlJp4PN1Qe/fsGMqhLz/e26uj/9Goz7fgk8Xa9JeXVgSecijH31PNhG/Tcn
         nhYKICNfJt4hO1gMOC898vgBDxbyQ5C7CLpxWRqpMFtZFN92CLr4hqyD6yHQMCQTiS
         hdm58m1lcHrf1eKbfr8yW7q339Q648hCXFfRsnMHsp3/cMV0Ntgjv4LpiXZAiRruPw
         4KQx5ZFCL+wsKLSUul480U6jZD8upDnOF0epJFIcu2N0NO6f/53+2abSvSo/4wk+Bo
         O6x9LlXE6tJGQ==
Date:   Thu, 10 Feb 2022 18:43:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: boottime warning from todays linux-next
Message-ID: <20220210184340.7eba108a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8XH3mUK8e..xQKie=tiiqmM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8XH3mUK8e..xQKie=tiiqmM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

My qemu boot of a powerpc pseries_le_defconfig kernel produced these
kernel messages:

  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc3 #2
  Call Trace:
  [c0000000073e3a80] [c0000000007bfd40] dump_stack_lvl+0x74/0xa8 (unreliabl=
e)
  [c0000000073e3ac0] [c00000000057e3dc] __register_sysctl_table+0x60c/0x9f0
  [c0000000073e3bd0] [c000000002041170] init_fs_stat_sysctls+0x48/0x60
  [c0000000073e3bf0] [c000000000012110] do_one_initcall+0x60/0x2d0
  [c0000000073e3cd0] [c0000000020049f0] kernel_init_freeable+0x334/0x3dc
  [c0000000073e3db0] [c000000000012710] kernel_init+0x30/0x1a0
  [c0000000073e3e10] [c00000000000cd64] ret_from_kernel_thread+0x5c/0x64

Presumably introduced by commit

  b42bc9a3c511 ("Fix regression due to "fs: move binfmt_misc sysctl to its =
own file"")

--=20
Cheers,
Stephen Rothwell

--Sig_/8XH3mUK8e..xQKie=tiiqmM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIEwiwACgkQAVBC80lX
0Gwpkgf9FDhRS+oGJo17XZiR5FrLO60Ay9dM8qIytpbmnlTFvtVeLvArQxicdbK8
Kh53VnqgHwF4j4l1D/wrH1tgLR5r3WT8/loOOkx7ZOBl+LyAhfEjzSLMjkVqFDJ4
T0b/7Nbn1ckNZhqCNyk9YVcwC6YJ4Nvb8lQgt8DLc9AWjDJVi/KKO+lZMhEDca4E
0ZKTrDgCOU7YTM2k/Tt8nvn46ZIavA9ilD9AXwkKMlLU7hpVh3y3I1jhQYxZy5M+
fsNjv1LRTthpYaSZMC0gSq7H7RpWV8x30oNb0gEmzkTtvLVAJ1TrYCLnxGzvG4B0
Dq7ZCs44FQO5uKgHRJZP0W3cRj26YQ==
=dnGc
-----END PGP SIGNATURE-----

--Sig_/8XH3mUK8e..xQKie=tiiqmM--
