Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9782147EC22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 07:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351546AbhLXGYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 01:24:39 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:51513 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351519AbhLXGYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:24:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JKxqB0DzZz4xd4;
        Fri, 24 Dec 2021 17:24:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640327062;
        bh=YE1wtxoSL7iH5/8H8eURuhEpHOr8nEwwfVK4clKW11s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zgj4DVC4TGDGsCLsgOjNR3uppZLmq7SoNy0LD8KM3lcROLwaR+1908lmN6Io9psJF
         uJe7gydAhT1QUVk+fLHCGQJtUxhQBY5BYTNcgRbWjQX+uY7bQwhx4uj8Pbo9go1GHh
         RmF35Avbto6vM++xn7bAwMMUjMxB0oR6toigtvs/pECzKpkgYOnjXvae4W9dQ0yZeK
         9kCwLpSlckMPSb5TrwyKd5SUAAYW7fsnZhLkH9WiMlha/oy6k+c/KwdP/ALvMEa1BD
         twBwJLwv9g5hu7EabxMtb0gpefQQ1PZpDGoWJshnS2zj9ZwazekKCe0jcRFdyKdeF7
         VIFvOZyhxTJWw==
Date:   Fri, 24 Dec 2021 17:24:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the folio-iomap tree with the
 nvdimm tree
Message-ID: <20211224172421.3f009baa@canb.auug.org.au>
In-Reply-To: <20211222211536.2fed6e78@canb.auug.org.au>
References: <20211222211536.2fed6e78@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0M0v2UHopzbSCQ04krWZ2om";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0M0v2UHopzbSCQ04krWZ2om
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 22 Dec 2021 21:15:36 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the folio-iomap tree got a conflict in:
>=20
>   fs/iomap/buffered-io.c
>=20
> between commit:
>=20
>   de291b590286 ("iomap: turn the byte variable in iomap_zero_iter into a =
ssize_t")
>=20
> from the nvdimm tree and commits:
>=20
>   a25def1fe568 ("iomap: Convert __iomap_zero_iter to use a folio")
>   4d7bd0eb72e5 ("iomap: Inline __iomap_zero_iter into its caller")
>=20
> from the folio-iomap tree.

Thanks to the addition of commit

  9e05e95ca8da ("iomap: Fix error handling in iomap_zero_iter()")

to the nvdimm tree, the resolutions is now as below.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/iomap/buffered-io.c
index d3b1169602fa,c6b3a148e898..000000000000
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@@ -888,19 -908,32 +907,23 @@@ static loff_t iomap_zero_iter(struct io
  		return length;
 =20
  	do {
- 		unsigned offset =3D offset_in_page(pos);
- 		ssize_t bytes =3D min_t(u64, PAGE_SIZE - offset, length);
- 		struct page *page;
+ 		struct folio *folio;
  		int status;
+ 		size_t offset;
+ 		size_t bytes =3D min_t(u64, SIZE_MAX, length);
 =20
- 		status =3D iomap_write_begin(iter, pos, bytes, &page);
 -		if (IS_DAX(iter->inode)) {
 -			s64 tmp =3D dax_iomap_zero(pos, bytes, iomap);
 -			if (tmp < 0)
 -				return tmp;
 -			bytes =3D tmp;
 -			goto good;
 -		}
 -
+ 		status =3D iomap_write_begin(iter, pos, bytes, &folio);
  		if (status)
  			return status;
 =20
- 		zero_user(page, offset, bytes);
- 		mark_page_accessed(page);
+ 		offset =3D offset_in_folio(folio, pos);
+ 		if (bytes > folio_size(folio) - offset)
+ 			bytes =3D folio_size(folio) - offset;
+=20
+ 		folio_zero_range(folio, offset, bytes);
+ 		folio_mark_accessed(folio);
 =20
- 		bytes =3D iomap_write_end(iter, pos, bytes, bytes, page);
+ 		bytes =3D iomap_write_end(iter, pos, bytes, bytes, folio);
 -good:
  		if (WARN_ON_ONCE(bytes =3D=3D 0))
  			return -EIO;
 =20

--Sig_/0M0v2UHopzbSCQ04krWZ2om
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHFZ5UACgkQAVBC80lX
0GzWXgf9F1oyJk+5p1QscW/ZdYcSbgu6+ZuKLMiWQLwhLzfO5LDQ6OXqsMuDrt+s
+wTtnw+WKmkoxx0lRhrUMMBDk+JxVFKoBMmtoJOpyXMuiz20tSagb1Y/vsm7dxMS
AXDNN5C/8Kv5DZgXybAZ+Zvj6eMm19MqJDbbltFpBASo8fANQg4K4K1S31+7XA68
6sYdQZI60rcyiyOKcBd61rFCVDVEop20OnN9YPQJxSFCm5ZM7nFPh4Qo/r2UVr5f
YYvKcxQy2hvV0QIE3oinvkfF1kA+mrrx84PVqmlUqrLEnfDb1EuyRWajgM751Hyz
PZYzYvBPmb1xdi16W856QVxACskl3A==
=YAOZ
-----END PGP SIGNATURE-----

--Sig_/0M0v2UHopzbSCQ04krWZ2om--
