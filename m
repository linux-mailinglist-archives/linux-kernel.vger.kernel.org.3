Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF861478545
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbhLQGtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhLQGs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:48:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95DC061574;
        Thu, 16 Dec 2021 22:48:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFfhk0KS4z4xd4;
        Fri, 17 Dec 2021 17:48:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639723734;
        bh=gFk5/QqDd8VJz6rqZGtf1IKla5sQ6pkJ8hS21Pz6AtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u1ynZpLs725npANjqRPRAuAJ4CNjvdLUQ98cQcXUzD3URaknbzZe28S2f1YLwG4XW
         b9mT/5qY5AwZIbFjauJ/ItJJ4R8xTlPgjtmPO+AbvjCRFHH2apVH8jB2wFEU67TslG
         x/K4B5Hm2u7rRSTfLnlBzyZftnLFrGzMsKcMMnpyODgcC802u+/OhxiWNyYLSLG+qM
         a6JCCaLqe6wDeWDQK7uX7li7UcCvV+BChg8NimR5fQBTbc1JHyKR7EkMxPAxx7GGcb
         8AtcyjOw1HvuTRMEmbuiCiodz66bPoTIpOwSurrt00hqi9YvWaDD8R33a3+BwU9Gdk
         HDSxRO1xFIJkQ==
Date:   Fri, 17 Dec 2021 17:48:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     broonie@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: Re: linux-next: manual merge of the userns tree with the cel tree
Message-ID: <20211217174853.752c032f@canb.auug.org.au>
In-Reply-To: <20211216193412.2441434-1-broonie@kernel.org>
References: <20211216193412.2441434-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XPcCR3XZL5Mlb4khvQ+9MYm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XPcCR3XZL5Mlb4khvQ+9MYm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 16 Dec 2021 19:34:12 +0000 broonie@kernel.org wrote:
>
> Today's linux-next merge of the userns tree got a conflict in:
>=20
>   fs/nfsd/nfssvc.c
>=20
> between commit:
>=20
>   cfb05a7336741 ("NFSD: narrow nfsd_mutex protection in nfsd thread")

This is now commit 9d3792aefdcd

> from the cel tree and commit:
>=20
>   ca3574bd653ab ("exit: Rename module_put_and_exit to module_put_and_kthr=
ead_exit")
>=20
> from the userns tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc fs/nfsd/nfssvc.c
> index 14c1ef6f8cc74,5ce9f14318c4e..0000000000000
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@@ -977,25 -982,11 +977,25 @@@ out
>   	/* Release the thread */
>   	svc_exit_thread(rqstp);
>  =20
>  -	nfsd_destroy(net);
>  +	/* We need to drop a ref, but may not drop the last reference
>  +	 * without holding nfsd_mutex, and we cannot wait for nfsd_mutex as th=
at
>  +	 * could deadlock with nfsd_shutdown_threads() waiting for us.
>  +	 * So three options are:
>  +	 * - drop a non-final reference,
>  +	 * - get the mutex without waiting
>  +	 * - sleep briefly andd try the above again
>  +	 */
>  +	while (!svc_put_not_last(nn->nfsd_serv)) {
>  +		if (mutex_trylock(&nfsd_mutex)) {
>  +			nfsd_put(net);
>  +			mutex_unlock(&nfsd_mutex);
>  +			break;
>  +		}
>  +		msleep(20);
>  +	}
>  =20
>   	/* Release module */
> - 	module_put_and_exit(0);
>  -	mutex_unlock(&nfsd_mutex);
> + 	module_put_and_kthread_exit(0);
>   	return 0;
>   }
>  =20

--=20
Cheers,
Stephen Rothwell

--Sig_/XPcCR3XZL5Mlb4khvQ+9MYm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG8MtUACgkQAVBC80lX
0Gxfcgf/fByZMYKohnucUb30kNvtm100Zygyt0qTkGEEnnvKu1VgcTZe3UnZcGmQ
zGVJUIi9zxPnZLX1b30hVZSW2UNwwZbBYfiv/LpXdTjvU5AWLr2tnpl1Gdan+wo3
mWn5nRh90g3CD3xltkXNVCfEYBQDdwCRtgRA3SMl/L+BA6wx7fVVCEfYuBIp0O+T
Aex9mb9dDZ4hraQk008k1/4LxL3ms99FMPnSsempg6Im3/3XHtCgJctFacTrlXw6
RokpfoAsjygE2dmKKnnE8q8q2c2qv2d1u461ZneYFRc9abpiXgjwdk16O8g8Lklh
00LKa+YuZPGb1mTsr/IDsfi0mM4QkQ==
=PvYi
-----END PGP SIGNATURE-----

--Sig_/XPcCR3XZL5Mlb4khvQ+9MYm--
