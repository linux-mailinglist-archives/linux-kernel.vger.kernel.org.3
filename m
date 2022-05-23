Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEEE531EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiEWWyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiEWWyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:54:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D29BAC9;
        Mon, 23 May 2022 15:54:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6XhY3wCJz4xD9;
        Tue, 24 May 2022 08:54:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653346478;
        bh=kQ61I5q06RiORbU81KMm+TpsZhtefb8NNgB/lmR8l2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lzrZmzIvKCl7FIvSIrwPZF+wpdULBxluYlM9pb7GqXEcczEV2iYkvgo4RuQWkXgkU
         VUbzSOAjW5ZwIhPZolENAmDoIANDubDW5YtO2Kv0Rmf9kzZj0YQVeSo+TSXNJeRjn3
         hr0tNsTYc0NIPVYokD/aHEL3VkcEXw2oaw5w54lmfoBERAG314borKFWku6NoLG4V5
         7BbPCISE4RflTeBKwCUW/rFG77leDQtHseR/kd3Mp/n7HFSxa9pB7x9WZLp1hushpi
         ro4U2EcafDe6kNV2yduvqclPMfxfL8To+3Jj1lMvkPE1o6Gc9Fcuu8tBjw7v4mSZJV
         xQnWMH6R5snLw==
Date:   Tue, 24 May 2022 08:54:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Dylan Yudaken <dylany@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <20220524085435.1763fcfb@canb.auug.org.au>
In-Reply-To: <20220523122827.657f2ab8@canb.auug.org.au>
References: <20220523122827.657f2ab8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//s_58=aJ5yUnfz4Eu5betNS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//s_58=aJ5yUnfz4Eu5betNS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 23 May 2022 12:28:27 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the block tree got a conflict in:
>=20
>   fs/io_uring.c
>=20
> between commit:
>=20
>   4329490a78b6 ("io_uring_enter(): don't leave f.flags uninitialized")
>=20
> from the vfs tree and commit:
>=20
>   3e813c902672 ("io_uring: rework io_uring_enter to simplify return value=
")
>=20
> from the block tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc fs/io_uring.c
> index 82a1eac73de7,fd47002e669d..000000000000
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@@ -10840,8 -12060,9 +12060,8 @@@ iopoll_locked
>   out:
>   	percpu_ref_put(&ctx->refs);
>   out_fput:
>  -	if (!(flags & IORING_ENTER_REGISTERED_RING))
>  -		fdput(f);
>  +	fdput(f);
> - 	return submitted ? submitted : ret;
> + 	return ret;
>   }
>  =20
>   #ifdef CONFIG_PROC_FS


This is now a conflict between Linus' tree and the vfs tree.
--=20
Cheers,
Stephen Rothwell

--Sig_//s_58=aJ5yUnfz4Eu5betNS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKMEKsACgkQAVBC80lX
0GxzvggAgUZBYeFC28p6bDG6SAJfv/uowSl8o0GYst0PvoolGwemW4EdM7mfZola
f1k2fBWa3wcoQVkSFxTBtadDyHzjhOQHdo4RL2I0wXprdD44Zsh1lWIGwez8GscJ
4U26TwRr2QZy9sxX7eFafoKH4FeoKkjFnp6dWkEijLtQT0QaTzW1G0WvSJLs3+rx
haAyq/cqLuceN7Dj3sJFcILKTW6JADbNGxKbY0MtokcrZB3AEQhYjenD4MzAumDO
I7cyb6Bn0DtbRGEIScWP/i8krHRUDnywxnhpZSSH425Hl4okBSUWj/oRyB5rL9LA
GJYyTOk+/Wyx2HF71ga+MyF754wWVA==
=wgrv
-----END PGP SIGNATURE-----

--Sig_//s_58=aJ5yUnfz4Eu5betNS--
