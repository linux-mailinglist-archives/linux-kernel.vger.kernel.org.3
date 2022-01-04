Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABDB484B04
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 00:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbiADXEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 18:04:12 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:55143 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiADXEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 18:04:11 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JT7Tj1zVJz4xRC;
        Wed,  5 Jan 2022 10:04:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641337449;
        bh=2hjqMokp5MNvh+FhWmWu2KMUzD5KtY5XS/CC1qC8kBI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OCpf8IswYm34iQ5w4tecNpoJEoNTu2d5m//YTmtFksbtTOYwQlOt/358L+dls63Be
         JDNM3kMBOkh7OrhsyJOaIk0Wv15oKdMsnaFsjlYjVElFO+9hrOkO8KGlasBpN+9eRf
         qfk1JDGFwunGBHypLrWgEzQ+VuoUIMTJcaNxf6xbM/Jmw3FPGbrSxh9V4ZwAEylCkx
         3SZEbxPr8iT9KtUJ0DANud6vd/49Lat/8UzIfShlCSd3Mna+ULFvXAgtquhwddLGZk
         BPXRt/H+ozLPbeg8cEFTGhTF1xqaIgRSqyL7ZwgGzMlNCRgEXQBf78bJS0Es1i5aaQ
         A1vS+VvSNj3Bg==
Date:   Wed, 5 Jan 2022 10:04:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: manual merge of the dmaengine tree with the
 dmaengine-fixes tree
Message-ID: <20220105100407.69b16fe2@canb.auug.org.au>
In-Reply-To: <36975790-c9f8-a6f6-cbc2-493da4bdd8c1@intel.com>
References: <20211214172437.1552740-1-broonie@kernel.org>
        <CAMuHMdUQjKOp6B7_-pG8t8OzrH=H+dYjn65YMHHy7CLaw6OU1g@mail.gmail.com>
        <36975790-c9f8-a6f6-cbc2-493da4bdd8c1@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6VXOagx5JIWDYO/18DDF4Br";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6VXOagx5JIWDYO/18DDF4Br
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Tue, 4 Jan 2022 14:41:00 -0700 Dave Jiang <dave.jiang@intel.com> wrote:
>
> >>   +       */
> >>   +      list_for_each_entry_safe(d, t, &flist, list) {
> >>   +              list_del_init(&d->list);
> >> -               complete_desc(d, IDXD_COMPLETE_NORMAL);
> >> ++              idxd_dma_complete_txd(d, IDXD_COMPLETE_NORMAL, false);=
 =20
> > Is "false" correct here? =20
>=20
> Hi Geert, took a closer look today. I believe it should be 'true'
> here since this is a normal completion that needs to release the
> descriptors. Sorry about the previous incorrect response.

I have updated my resolution from today.  Thanks for the feedback.

--=20
Cheers,
Stephen Rothwell

--Sig_/6VXOagx5JIWDYO/18DDF4Br
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHU0mcACgkQAVBC80lX
0GyHjwf8DomIKJzlLq8qjHrTAjNgBtYl1yz2fiMpohaRlf5pBUAQQejkc15bXm7d
qJvz3bRkxohjBUGL203HnZErHuboDtlr81SS0SgDq1UuM8+ki9qqPN2xfUk0ZSOn
9hExQPzQHC3x8QtUDz4cnKsYN/hJh1Eqp0Xm30Dq0KzHN2nFPCSHLX/NG0Wv98mb
PK9Zk3vlDgmiy87OtjZQ6iu3jesrkWiFAwc+4CXM1bsbHYY7SqpnwPRIcYjGgJka
yLeJegif4S7kc9LYiohpvahgkDP9Cq03RTJNsju88tKcZZIRgKEyE46s3yo5plCw
hMS+WTUHhrNvekP/OL8iycu1ExaXXw==
=yXzF
-----END PGP SIGNATURE-----

--Sig_/6VXOagx5JIWDYO/18DDF4Br--
