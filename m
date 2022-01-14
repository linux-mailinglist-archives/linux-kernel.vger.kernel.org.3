Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8219548E451
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiANGmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiANGmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:42:19 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381B3C061574;
        Thu, 13 Jan 2022 22:42:18 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JZsD76Mg7z4xQp;
        Fri, 14 Jan 2022 17:42:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642142536;
        bh=SNvPMfPKFeAN3UxFhwUESeesZJM1ozquQSLQ6yaN/xk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=siNA53gx841+6QDoYA2OHKw8gaWQKquFLEfK8oXAuphpdy7Cy0mZAd1Z2NBnmz7CK
         XQTSYwPZ13Y2DUOlLKtSqeysUC3m/HK6VBtzhYC9BPd8dvsUr2tT3Qfj3B52XK1qSp
         Jamz/MXyVvVCoIFPdwQE0UZXg6BAWZPuhZquih9jtAp0qo+xgJopv0R1DCFVbhoqy3
         PP3k5zH65WFe7rGltjwxVR6NDI8mO1CYcn5KSJJA/8/sG21O5a0OVc4dVk7O2/6O48
         18K1rxcp3seuxUO2q2oDJ8SX0jXnU6w3NJ22zsi2j4zD1iv2unGnGrkvl8MCG0ZxSD
         p2jot5PkEpERA==
Date:   Fri, 14 Jan 2022 17:42:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <20220114174214.1fde716e@canb.auug.org.au>
In-Reply-To: <20220113225048.17d4d9b7@rorschach.local.home>
References: <20220112113103.7e03448f@canb.auug.org.au>
        <20220114120240.4b592480@canb.auug.org.au>
        <20220113211633.4f9bea57@gandalf.local.home>
        <20220114135808.391398d0@canb.auug.org.au>
        <20220114140258.2fe2f076@canb.auug.org.au>
        <20220113222539.30202e01@rorschach.local.home>
        <20220114143418.06035a75@canb.auug.org.au>
        <20220113225048.17d4d9b7@rorschach.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Hwo0t9D2rPj8RqZOMv3qWOH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hwo0t9D2rPj8RqZOMv3qWOH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Steve

On Thu, 13 Jan 2022 22:50:48 -0500 Steven Rostedt <rostedt@goodmis.org> wro=
te:
>
> On Fri, 14 Jan 2022 14:34:18 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>=20
> > > Does it fail on anything else?   =20
> >=20
> > This is the first build I do after merging each tree, so I don't know
> > about others.  I may be able to do some testing later today (after
> > linux-next is released). =20
>=20
> Could you see if this fixes it? This is a revert of part of the patch.
> Yinan, was there a reason you moved this code?

It is my fault, sorry.  I got the merge resolution wrong and managed to
remove both copies of:

info SYSMAP System.map
mksysmap vmlinux System.map

putting it back before

if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then

makes it work!

I am so sorry.  I will fix up my merge resolution for Monday.

--=20
Cheers,
Stephen Rothwell

--Sig_/Hwo0t9D2rPj8RqZOMv3qWOH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHhG0YACgkQAVBC80lX
0GwatQf/XT0EePLc7igQs9pL+N0S+Av68irdHwY5K7xyQqWW+c0+MbbnyMS/kh1A
tSddA0QY5u99E8V5a9TrYwY3J2nnNDwPOCDII7c77dIGVxIv9nQS6l+YUL7Bkmxh
XZ8PsLkC+YSfgr06mNhsGzjo25cfe5feQ2H+P+/o+04xNn0+UgLN093+DRJ4V9IX
44wu5sLCCHEnNenjiNVMngb8FTfJq1Guo6vYJfpW7HuCfJdTa4XBccWHunUqrWDD
DG+npTFRwtMf9fdEfl7w910/vgWJk2yPeP6NV7PGLbH3cRc4TGpjWTZgRUmfVrk7
olKzv+moPAnQtvD4OLqnOV8dKjq3yA==
=kAht
-----END PGP SIGNATURE-----

--Sig_/Hwo0t9D2rPj8RqZOMv3qWOH--
