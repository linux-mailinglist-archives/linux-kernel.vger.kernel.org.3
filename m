Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3B54B086A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiBJIdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:33:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbiBJIdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:33:04 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290D7D8A;
        Thu, 10 Feb 2022 00:33:04 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JvVPW1kZPz4xNn;
        Thu, 10 Feb 2022 19:33:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644481983;
        bh=E+FtqzckTxmcWbMLn2k22WXUJefWAeHDdlsXk10dyok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NsDBkqsuJr7HIQ6Baa/iBaKSMYAYaD9+gWizkSxAl9C4nfOtH412vLq4+kmDItkD+
         eC69PtyF9O5AKyy4tMNHyMZlPoiMcH8clKu8J3BH8qnOcHnztiauDD2xOkGZu224WL
         fyVUhwGkdRmJS4gAkSOO/BhytSTEjjTvKZPtlOKgdzUl1l7nyoQ49DBqku9N6p44Uw
         fwLV6hz6sH94pwhle9VJeJw7v0V5ffHUy/ta1O3Y4U6pBMANg9hfF+yQLspWeVrubr
         nyhROu5m60eQyNFe54E7+h/BCEkvtvPCl7i66vzqsdsmUZMIELNn1pK9YkOxwh3Zjj
         KJiLnojVRIjMg==
Date:   Thu, 10 Feb 2022 19:33:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Domenico Andreoli <domenico.andreoli@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boottime warning from todays linux-next
Message-ID: <20220210193302.686fa61a@canb.auug.org.au>
In-Reply-To: <20220210184340.7eba108a@canb.auug.org.au>
References: <20220210184340.7eba108a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2ADvCwIdjLZxpqlDQgzJpML";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2ADvCwIdjLZxpqlDQgzJpML
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 10 Feb 2022 18:43:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> My qemu boot of a powerpc pseries_le_defconfig kernel produced these
> kernel messages:
>=20
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc3 #2
>   Call Trace:
>   [c0000000073e3a80] [c0000000007bfd40] dump_stack_lvl+0x74/0xa8 (unrelia=
ble)
>   [c0000000073e3ac0] [c00000000057e3dc] __register_sysctl_table+0x60c/0x9=
f0
>   [c0000000073e3bd0] [c000000002041170] init_fs_stat_sysctls+0x48/0x60
>   [c0000000073e3bf0] [c000000000012110] do_one_initcall+0x60/0x2d0
>   [c0000000073e3cd0] [c0000000020049f0] kernel_init_freeable+0x334/0x3dc
>   [c0000000073e3db0] [c000000000012710] kernel_init+0x30/0x1a0
>   [c0000000073e3e10] [c00000000000cd64] ret_from_kernel_thread+0x5c/0x64
>=20
> Presumably introduced by commit
>=20
>   b42bc9a3c511 ("Fix regression due to "fs: move binfmt_misc sysctl to it=
s own file"")

OK, I cannot reproduce this with just Linus' tree.  I will try to bisect.

--=20
Cheers,
Stephen Rothwell

--Sig_/2ADvCwIdjLZxpqlDQgzJpML
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIEzb4ACgkQAVBC80lX
0GwOPggAo8y9fTP5XIjhAfCoybh2AdkSVWLYHqC/wrZLgmIgTzbiPQTNg93x+YzJ
zgXATsbKibq/Vjnm1ph1zxhTkd7ku/azsjTuqdUeiaE1XcHK9txJHxQ0YrX2x+au
a4ZOCBZZoPr6dkszIfPPRCMWtfJiuu2WP+SYfRKoRYjP4zo9qIyyBorLfqdYZsoz
TAbUi4in0tx1Dske+1nfzUzdb7vQP80QtkKJM7bGHoR2DvHMT0gYEwsMW/c8Tmgc
DiAmwWrsAYmLc858aeIBxPZvlR+rvjFYyRXGucb6UrkEZ2WL3rKbTxZ058O+uvcy
CjNtvV3Po0VFua7GZbZaccGJASFsbA==
=wnAm
-----END PGP SIGNATURE-----

--Sig_/2ADvCwIdjLZxpqlDQgzJpML--
