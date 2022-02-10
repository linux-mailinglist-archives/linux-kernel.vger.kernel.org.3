Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F124C4B0C66
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbiBJL34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:29:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239612AbiBJL3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:29:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0741015;
        Thu, 10 Feb 2022 03:29:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvZKZ0C7Tz4xdJ;
        Thu, 10 Feb 2022 22:29:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644492594;
        bh=6jXUJsBHjs3f1iq/8MbNLq2zqeotd+RgdX7tUxBzy+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GonPrJWAta1OBNOsrAdnZvUXsgDbpmrpBott4IougAwd2NozWipPvZDi7yTV9gyj0
         FMLj/Pnr+A0INx+q6JNPl6mksFF4zc6qQXaVC8SUYYRrff3aqmdY3rUsEVi5jYWKxW
         +I5H1zG9UlbZeYFT2woO4Hx4+qfAp8eu1oC3uHyGyKWWmA0UQzG9Zeg2RVNtdvoC/U
         sMbnZWgk2CMMFqKUyMOf8j2b4MVkASzyTRGT/aWPqGVKgkatLHOFjT566cIKQ9qT2F
         EZ0aSykl94r4nRW3HE7e2rQv/xzCGiN/Nxhn60YooRVZpxUQJ55Z3cNqU4lgaIwtT2
         /4bZVWQTg8Wug==
Date:   Thu, 10 Feb 2022 22:29:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boottime warning from todays linux-next
Message-ID: <20220210222953.6e078d20@canb.auug.org.au>
In-Reply-To: <20220210214125.2b248790@canb.auug.org.au>
References: <20220210184340.7eba108a@canb.auug.org.au>
        <20220210193302.686fa61a@canb.auug.org.au>
        <20220210214125.2b248790@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//9=tcrmM.GLU/Z.eZRK7BH5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//9=tcrmM.GLU/Z.eZRK7BH5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 10 Feb 2022 21:41:25 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 10 Feb 2022 19:33:02 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Thu, 10 Feb 2022 18:43:40 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> > >
> > > My qemu boot of a powerpc pseries_le_defconfig kernel produced these
> > > kernel messages:
> > >=20
> > >   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc3 #2
> > >   Call Trace:
> > >   [c0000000073e3a80] [c0000000007bfd40] dump_stack_lvl+0x74/0xa8 (unr=
eliable)
> > >   [c0000000073e3ac0] [c00000000057e3dc] __register_sysctl_table+0x60c=
/0x9f0
> > >   [c0000000073e3bd0] [c000000002041170] init_fs_stat_sysctls+0x48/0x60
> > >   [c0000000073e3bf0] [c000000000012110] do_one_initcall+0x60/0x2d0
> > >   [c0000000073e3cd0] [c0000000020049f0] kernel_init_freeable+0x334/0x=
3dc
> > >   [c0000000073e3db0] [c000000000012710] kernel_init+0x30/0x1a0
> > >   [c0000000073e3e10] [c00000000000cd64] ret_from_kernel_thread+0x5c/0=
x64
> > >=20
> > > Presumably introduced by commit
> > >=20
> > >   b42bc9a3c511 ("Fix regression due to "fs: move binfmt_misc sysctl t=
o its own file"")   =20
> >=20
> > OK, I cannot reproduce this with just Linus' tree.  I will try to bisec=
t. =20
>=20
> It bisected to commit
>=20
>   43a9443d5da2 ("Merge branch 'akpm-current/current'")
>=20
> and both parents of that commit are fine :-(

So it seems that the parent of "fs/binfmt_misc" is a permanently empty
directory - the is_empty_dir() check in insert_header() succeeds.
--=20
Cheers,
Stephen Rothwell

--Sig_//9=tcrmM.GLU/Z.eZRK7BH5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIE9zEACgkQAVBC80lX
0GwDZAf/RwZJos/6GDUzbMTExOg34sC0MFTYScOtUT4/RP3xQbq5dKN67BPU2efg
2xWf9AuERRsXZgz9CmHWeML4bs0sMyAYLe1/xD2rujIpkc31VpWryWEBjABTlbri
D1tbbspr0bfegxzQ41FpQksgyRQk2nNXMZbbCoUhaiU3gDxfwor/9lKxwq0deTfJ
UgeyQz38Ic+BAlyTKdQ1HrSRO50lcFpIcJxLMwU/ponMiSNl//O7pSJ0/YvBDWSI
bZPel1hq2bunfH6AXjL6wPGtTqhklF5UWyzRQltL5GMCxq6rg19uAYYJBjhSGaOr
sDKmvipkqA7NPJNGTjvAtEUx1QCVqA==
=NJXh
-----END PGP SIGNATURE-----

--Sig_//9=tcrmM.GLU/Z.eZRK7BH5--
