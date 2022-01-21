Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B503E49686F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 00:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiAUX6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 18:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiAUX6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 18:58:15 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C5CC06173B;
        Fri, 21 Jan 2022 15:58:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jgbt83SYnz4xgt;
        Sat, 22 Jan 2022 10:58:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642809489;
        bh=JiV/hnVkXRpcVEe7nCNuSsgZesl3ivyla4N8B2l1iWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QFOWxx78aa3BQa/UD55Q1yjHdFbJ/kxpNdr3Iat6r4/CjypsZbqaktqfqrDcY6s+b
         44paF6xlm82/2ZS13+4ZOuoIry0wqgSYkMZEjAl0fs+n3BeG77l8wwCSWsA+rbMull
         8bSSnw0bH5eyV71Pgyere69Ptr6Ltt68+OOgWGLrIPDKW+9s/C4f9387BDu+xGFbK/
         bThTjPlttKRXPDjAak7LoPFkzVxVDjuu7xvEKSC8jcjB9ozy4HHbMeohtwFr+AhkNz
         Gxd/UKqBWeSX4nVIHCjBdEa0c/uRrYngSq/m8LsjLxXS5RQEl8W2fpvTQ1BYRGBSrp
         qm8ifjb3pL2Qw==
Date:   Sat, 22 Jan 2022 10:58:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <20220122105806.3b710900@canb.auug.org.au>
In-Reply-To: <20211217144004.0c00fabc@canb.auug.org.au>
References: <20211217144004.0c00fabc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Um4Yb3+Do9hb8+1U/ngUN2Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Um4Yb3+Do9hb8+1U/ngUN2Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 17 Dec 2021 14:40:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
> produced these warnings:
>=20
> lib/strnlen_user.o: warning: objtool: strnlen_user()+0xc9: call to do_str=
nlen_user() with UACCESS enabled
> lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x129: cal=
l to do_strncpy_from_user() with UACCESS enabled
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
> I am not sure which changes caused the above.

I currently still get the following warnings from an x86_64
allmodconfig build fo Linus' tree:

vmlinux.o: warning: objtool: mce_start()+0x5c: call to __kasan_check_write(=
) leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_gather_info()+0x5f: call to v8086_mode.con=
stprop.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_read_aux()+0x8a: call to mca_msr_reg() lea=
ves .noinstr.text section
vmlinux.o: warning: objtool: do_machine_check()+0x192: call to mce_no_way_o=
ut() leaves .noinstr.text section
vmlinux.o: warning: objtool: mce_severity_amd.constprop.0()+0xca: call to m=
ce_severity_amd_smca() leaves .noinstr.text section

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0
$ x86_64-linux-gnu-ld --version
GNU ld (GNU Binutils for Debian) 2.37

--=20
Cheers,
Stephen Rothwell

--Sig_/Um4Yb3+Do9hb8+1U/ngUN2Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHrSI4ACgkQAVBC80lX
0GzOcwf/Y6JGKwHFTnpj3CXpVJ5dxRNy1W2LnM6qM1cZwPhyAVDKS3A2xkXBImMB
bMFneIxc7F0hRUZzJ0RQjQA57sH3b4eXm9g+pSr6yE4LxZGBAhtMVtRKFOe4juLy
5ANhY+rCGWqP/nHv7LefX6daid3FZCOscQFLFwFI52fQCK6sK1N8B9azB2araG7A
eT0eYBG78FE9L3gnfdj1RFqUmLtSmRmo1rhTMBTPxR/inkKe33uDio0QBsEb6KXG
itRvQ30PeHZDVCtEuXbRPtR3gb8Uhjhq1PxnxsLQ9qnkiFIN9RnZnm612x/YRY8U
XL+scqTcR/+ddbrhXQxkx5fNxv7VJQ==
=g2EN
-----END PGP SIGNATURE-----

--Sig_/Um4Yb3+Do9hb8+1U/ngUN2Z--
