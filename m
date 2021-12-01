Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7671D465889
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 22:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353129AbhLAVti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 16:49:38 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:44255 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352964AbhLAVsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 16:48:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J4CKZ5gNJz4xR5;
        Thu,  2 Dec 2021 08:44:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638395075;
        bh=pL1g5aLwuieOmlDprmZe4BgNUXg+6/N4bWtIyP0vgEM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QSf0VmDzEbeUjKslzmibtlgxpzNo4fLHrUuzCLCzL0/gdA0jdXme7BpnOgWCjmQuf
         LTiHr/tPD4wfVVO9nzl4rHj1ponEiLY5kHl11Ed1flts7xkn58uuwJO9T88VOfsWNL
         zAgTsIeChoZ57rxUqlNOac2WJ9KjMhajQekrTCGlLfNQCqCe3e099kIj7qBUG/H5yu
         O//UYTVuw4FflcQ4ixEOWepbEGN6hGz3EyxoQ5pLpDYmY+rXeswfkDEdqLv5asG86b
         KW02gVyewn54tFj9XWvVrl3wxVAi5lSlvKbKaC9iyLCSD1pQftN7dvkzHH19HMg/gl
         Jm9FYOS+kE+gQ==
Date:   Thu, 2 Dec 2021 08:44:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: boot failure after merge of the akpm tree
Message-ID: <20211202084434.7d9bde87@canb.auug.org.au>
In-Reply-To: <YafJY3rXDYnjK/gs@bombadil.infradead.org>
References: <20211130184622.71be17e0@canb.auug.org.au>
        <YaZPoEHL2svLLBwS@bombadil.infradead.org>
        <YafJY3rXDYnjK/gs@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KyhLo5LQ9OZNB5jOr+dES1+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KyhLo5LQ9OZNB5jOr+dES1+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Wed, 1 Dec 2021 11:13:39 -0800 Luis Chamberlain <mcgrof@kernel.org> wrot=
e:
>
> On Tue, Nov 30, 2021 at 08:21:52AM -0800, Luis Chamberlain wrote:
> > On Tue, Nov 30, 2021 at 06:46:22PM +1100, Stephen Rothwell wrote: =20
> > > Bisected to commit
> > >=20
> > >   f00ff38c1dfa ("sysctl: add and use base directory declarer and regi=
stration helper")
> > >=20
> > > I have reverted that complete 6 patch series for today. =20
> >=20
> > I'll be trying to reproduce and fix, thanks for the report! =20
>=20
> OK please try this patch, I can boot with this just fine on ppc64le:
>=20
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 70acd2a100fd..180adf7da785 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -201,6 +201,7 @@ static struct ctl_table _name##_base_table[] =3D {			\
>  		.mode		=3D 0555,					\
>  		.child		=3D _table,				\
>  	},								\
> +	{ },								\
>  }
> =20
>  extern int __register_sysctl_base(struct ctl_table *base_table);

That fixes it for me.  I will use that in linux-next today instead of
the reverts.

--=20
Cheers,
Stephen Rothwell

--Sig_/KyhLo5LQ9OZNB5jOr+dES1+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGn7MIACgkQAVBC80lX
0Gzudwf/boO5mMavAkAY/letiXOzJe3S2dyKbHVLC3hRLV9/VVkGWlt4j4thcUyd
0KtzzenfGhuCc2jpztuT/VmCF0C1kmwKu1r9mQ1TZ6OeIWGeQEs4LF3s8N1dYb/V
IL9lAheiP4dFZkn4ZUtAyf98IJVQCw32pPIrpCmVsoTSEJaq3MJdG4pDG31YBwRc
eeCvccB/vv8mB/HaCxnuyqu2AEf7JOFQpuuPI0cITFQlvxMESA/YLGTBo/SNjlkV
H3cwAIe2GxsLax7pBInQSh/rbjvCsRiX81qKyqfSEYjQfEBvhx3p5DiXHXIxAGn6
F4DGR46+rhp1jwUdXIHpKoBZPtYdkw==
=tQ70
-----END PGP SIGNATURE-----

--Sig_/KyhLo5LQ9OZNB5jOr+dES1+--
