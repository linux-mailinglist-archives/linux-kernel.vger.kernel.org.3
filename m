Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCD74B0B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbiBJKld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:41:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiBJKlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:41:31 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747A5C39;
        Thu, 10 Feb 2022 02:41:32 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvYFk6blpz4xNn;
        Thu, 10 Feb 2022 21:41:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644489691;
        bh=zM4o1zwgm3vw53ogWM5KCUtOhCfuY1zqv412d3b2K3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E0SAWAeeobP5SsoupU89jcdHIvijYDUJsEHXq0NW4l4TAeX3Ih89zQf/IebVg4Zuj
         yrP+S7jUadk9wg4fB9NomjPalK5cWxURQp1YBlp493ghAkGkr3coBQJUf4My0u44jG
         NTxgrU73G7viM0hkGfvp5KB4oNoHVD6Dq/LCo9GuSGTrShkVSrnMmoPbfVirh0DtOU
         NEWQelcFlvW195iNAqd7BHNg9Yd9Bp7xhjB6y1UdPqYj260sBst8HG2oGLuYhoF+YU
         XRD7yrHWPE9X8A9dRrtcZs0fdJ1Fgxbfddx17XFpcHjEaaYsEJDvL8wi/ZG1vSO7ld
         N5KL8OzB9jytg==
Date:   Thu, 10 Feb 2022 21:41:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boottime warning from todays linux-next
Message-ID: <20220210214125.2b248790@canb.auug.org.au>
In-Reply-To: <20220210193302.686fa61a@canb.auug.org.au>
References: <20220210184340.7eba108a@canb.auug.org.au>
        <20220210193302.686fa61a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.9oRFWI6oIp8UvKbLn8tZsd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.9oRFWI6oIp8UvKbLn8tZsd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 10 Feb 2022 19:33:02 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 10 Feb 2022 18:43:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > My qemu boot of a powerpc pseries_le_defconfig kernel produced these
> > kernel messages:
> >=20
> >   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc3 #2
> >   Call Trace:
> >   [c0000000073e3a80] [c0000000007bfd40] dump_stack_lvl+0x74/0xa8 (unrel=
iable)
> >   [c0000000073e3ac0] [c00000000057e3dc] __register_sysctl_table+0x60c/0=
x9f0
> >   [c0000000073e3bd0] [c000000002041170] init_fs_stat_sysctls+0x48/0x60
> >   [c0000000073e3bf0] [c000000000012110] do_one_initcall+0x60/0x2d0
> >   [c0000000073e3cd0] [c0000000020049f0] kernel_init_freeable+0x334/0x3dc
> >   [c0000000073e3db0] [c000000000012710] kernel_init+0x30/0x1a0
> >   [c0000000073e3e10] [c00000000000cd64] ret_from_kernel_thread+0x5c/0x64
> >=20
> > Presumably introduced by commit
> >=20
> >   b42bc9a3c511 ("Fix regression due to "fs: move binfmt_misc sysctl to =
its own file"") =20
>=20
> OK, I cannot reproduce this with just Linus' tree.  I will try to bisect.

It bisected to commit

  43a9443d5da2 ("Merge branch 'akpm-current/current'")

and both parents of that commit are fine :-(

"git diff-tree --cc 43a9443d5da2" looks like this:

43a9443d5da2d53dc06095b90b1aca18b72caef5
diff --cc lib/Kconfig.debug
index f15dd96028b5,efc1a1908e04..682c776ae73d
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@@ -317,6 -339,7 +339,7 @@@ config DEBUG_INFO_BT
  	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
  	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
  	depends on BPF_SYSCALL
 -	depends on !DEBUG_INFO_DWARF5
++	depends on !DEBUG_INFO_DWARF5 || PAHOLE_VERSION >=3D 121
  	help
  	  Generate deduplicated BTF type information from DWARF debug info.
  	  Turning this on expects presence of pahole tool, which will convert
diff --cc tools/include/linux/gfp.h
index b238dbc9eb85,22030756fbc0..56eec4445bc9
--- a/tools/include/linux/gfp.h
+++ b/tools/include/linux/gfp.h
@@@ -2,31 -1,4 +2,30 @@@
  #ifndef _TOOLS_INCLUDE_LINUX_GFP_H
  #define _TOOLS_INCLUDE_LINUX_GFP_H
 =20
 +#include <linux/types.h>
 +
 +#define __GFP_BITS_SHIFT 26
 +#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 +
 +#define __GFP_HIGH		0x20u
 +#define __GFP_IO		0x40u
 +#define __GFP_FS		0x80u
 +#define __GFP_NOWARN		0x200u
 +#define __GFP_ZERO		0x8000u
- #define __GFP_ATOMIC		0x80000u
 +#define __GFP_ACCOUNT		0x100000u
 +#define __GFP_DIRECT_RECLAIM	0x400000u
 +#define __GFP_KSWAPD_RECLAIM	0x2000000u
 +
 +#define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM)
 +
 +#define GFP_ZONEMASK	0x0fu
- #define GFP_ATOMIC	(__GFP_HIGH | __GFP_ATOMIC | __GFP_KSWAPD_RECLAIM)
++#define GFP_ATOMIC	(__GFP_HIGH | __GFP_KSWAPD_RECLAIM)
 +#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
 +#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
 +
 +static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 +{
 +	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
 +}
 +
  #endif /* _TOOLS_INCLUDE_LINUX_GFP_H */

Which looks pretty innocuous.

--=20
Cheers,
Stephen Rothwell

--Sig_/.9oRFWI6oIp8UvKbLn8tZsd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIE69UACgkQAVBC80lX
0GwUbwf/WQUzB5q1bNcnhWYFuMb3Xg6rTxYL4DnzXcsQGkyX43VwGE2oR4mL6ODP
Vq03Zg2hj9Nr/EhO6gkfKPwluTKpJ2Vpk0ht5LYijmPwjuk1afI81cnhoP/ghMI8
iVdfPHcdyBRjp37W5lIUojYRmqKYYaSVW91qm29xjzILAaqQstpsm1k+xf8RqhUH
TjdVa3nP/YirWfdGqbEhNgNjWOvE9tPYnt2e2KgpHvxJBlBjn4xQIaJrlqJTf1qG
e95NKq0gnpmgjogzbHSDMFnCPMCwJkjtrq+Z0CCn1ioXAybRV/27QoZ8pdfrqa5b
IT+dgx3BwhY3Dnuro+QoEcyd+fBFHw==
=3Smq
-----END PGP SIGNATURE-----

--Sig_/.9oRFWI6oIp8UvKbLn8tZsd--
