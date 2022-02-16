Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E1C4B809B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiBPGV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:21:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBPGV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:21:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932921A9E4D;
        Tue, 15 Feb 2022 22:21:11 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jz7BZ1JBDz4xcY;
        Wed, 16 Feb 2022 17:21:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644992470;
        bh=bM8L3lvECd65NuVMQ2/7Mm5rU3b3w5oT279rVAUXjuU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b/KXBbYuGz3fIqEt7XdMU45i4VTsAdgp/WIdYqvC7Lj9DzhOyYs+aXu6rKEtQUl8b
         t/EMPyrnXIwtwhMM9Ig8OmFX3bY2a69s1RO0LJqWCCQK4+xmP9dfZLvlsCiUTCjUgX
         WLOYqHwjEq/bTSvvm/2m8H/K1oGzzq6YwY33XHOUGWnYn3qMGrykjT7EvkC1J8I9RS
         jeL3iQIPui6zSmMPYS6kGzrYdw5QwzPFVDGg8bkeBZx9ryi3OzUiSJsQMEmV7ZsHTM
         GgL6Lk8vyMO3UKuBqVyLsWZiA7a/Kuraj9hVX2TxcMZDNYRMJ+oeG0jXRm4P2Rd/kH
         GdvAJgnU8c5Lg==
Date:   Wed, 16 Feb 2022 17:21:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 folio tree
Message-ID: <20220216172109.72fd0a38@canb.auug.org.au>
In-Reply-To: <YgumpQrC+cuYe91H@casper.infradead.org>
References: <20220215180043.23879691@canb.auug.org.au>
        <YgumpQrC+cuYe91H@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d7MEtPDNcdphfEixjBBcwgI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d7MEtPDNcdphfEixjBBcwgI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Tue, 15 Feb 2022 13:12:05 +0000 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> On Tue, Feb 15, 2022 at 06:00:43PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the block tree got conflicts in:
> >=20
> >   include/linux/mm.h
> >   include/linux/rmap.h
> >   mm/gup.c
> >   mm/huge_memory.c
> >   mm/internal.h
> >   mm/memory-failure.c
> >   mm/migrate.c
> >   mm/mlock.c
> >   mm/rmap.c
> >   mm/vmscan.c
> >=20
> > There is no way I can figure out in a reasonable time (or at all
> > probably) the resolution needed here.  You guys need to get together
> > and figure out how the folio tree changes are going to progress to
> > Linus' tree.
> >=20
> > I have gone back and used the folio tree from next-20220204 again for
> > today. =20
>=20
> Thanks!
>=20
> My plan is to take v2 of Hugh's mlock rewrite into my tree today and
> redo the folio changes on top of those.  That should reduce the amount
> of conflict between akpm's tree and the folio tree to the usual
> managable amount.  Let's see how that goes.
>=20

It looks like Andrew now has a new version of Hugh's patches and there
are quite a few other conflicts as well (see my attempt at mm/gup.c).

I have used the folio tree from next-20220204 again for today, sorry.
--=20
Cheers,
Stephen Rothwell

--Sig_/d7MEtPDNcdphfEixjBBcwgI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIMl9UACgkQAVBC80lX
0Gx9NggAoR5ZrOZkPYWYajxpf/ie5j8zUFFQgdiHuxtq0bcN3uBrXe22hu14QVrc
lkzMU+D5Vb3AAzvZRA2/lK3Q8vfYRZSZMDBaoNP5FJ+PXy/fOfhNfc/fe58Eeido
k+coZsr2F0sWr3sw5lIGK6vrcnXng+c8e5YnPynwJBafhKHnx7ljwAxd+CoV2g/Z
HwgPUB76gkIkNUK82W+qyOhw86R8UDUDD0xVU1y14ddCAx2WCu/bwnmTusNlXPZw
+mVDwjZPtDodtf9JoPIfKksftwLTeBTvwN5nlWEnrEHX7xUN/xuAgD7nhRmxK2yI
9xi46/a7V1+lKkzrCHMz5IZPKFcdkg==
=+iTL
-----END PGP SIGNATURE-----

--Sig_/d7MEtPDNcdphfEixjBBcwgI--
