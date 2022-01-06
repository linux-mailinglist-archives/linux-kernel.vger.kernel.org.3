Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B878A486890
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbiAFRb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:31:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33162 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbiAFRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:31:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA9E7B82296
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 17:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF31C36AEF;
        Thu,  6 Jan 2022 17:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641490309;
        bh=DWUb70EqUNGqpynK9qIu2Jz/xw4KmZw58v+XcOcQxeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loe9/OEfImfU1V3yCKDFiPVBRlDRAbtStqMKGl51dt+ZxIB/W7IBeKPtu6HFAkYBr
         EuENbe2SQNhqRabhkhf+yxQ7fAd33/JfWq9uSwTNNDZbMFUeFjhWhdWgWouk3kgGo2
         X2KKFAUhw4b99Qg1gzccefL03cqVIxUGkFxnPhbZJyh3axpOlpJv7xHLPiRUEd7Zkd
         XPWS6syQoou04aHEuEoaRn+H/qAXSqmyqCPmX8qhI44q/NgxXu9BxQ0Y2mSnS9GO17
         2xOAEDyO3M9E5mBrR4LFlFHzfaqs67PT6ymQvGVThAGtBRhsitomEvsxxFNxn1gsMn
         qhfaIS/glISag==
Date:   Thu, 6 Jan 2022 17:31:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     matthias.schiffer@ew.tq-group.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: debugfs: Free the previous allocated
 debugfs_name buffer
Message-ID: <YdcngYVZwC2s+Pin@sirena.org.uk>
References: <20220106171537.3091643-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uGmHJ3AUYiAioGCT"
Content-Disposition: inline
In-Reply-To: <20220106171537.3091643-1-festevam@gmail.com>
X-Cookie: I think we're in trouble.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uGmHJ3AUYiAioGCT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 06, 2022 at 02:15:37PM -0300, Fabio Estevam wrote:

> debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent 'regmap' alread=
y present!
>=20
> By inspecting the duplicate directory name:=20
>=20
> [    0.274418] platform panel: Fixing up cyclic dependency with ldb
> [    0.276896] ************ 1: devname is dummy
> [    0.276926] ************ 2: name is iomuxc-gpr@20e0000

It's quite hard to read these kernel logs and tie them into anything -
they're fairly verbose and weirdly formatted with all the *********s.

> +++ b/drivers/base/regmap/regmap-debugfs.c
> @@ -589,6 +589,7 @@ void regmap_debugfs_init(struct regmap *map)
>  				return;
>  		}
>  		name =3D map->debugfs_name;
> +		kfree(map->debugfs_name);
>  	} else {
>  		name =3D devname;
>  	}
> @@ -600,6 +601,7 @@ void regmap_debugfs_init(struct regmap *map)
>  		if (!map->debugfs_name)
>  				return;
>  		name =3D map->debugfs_name;
> +		kfree(map->debugfs_name);

This is fairly clearly introducing a use after free bug - we've taken a
copy of map->debugfs_name in name then immediately free map->debugfs_name
so any use of name will be referencing freed memory.  If this works it
will be because something went and zeroed the memory, it's just as
likely to cause us to crash.

--uGmHJ3AUYiAioGCT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHXJ4AACgkQJNaLcl1U
h9C7Cwf/cfREzK+slDlKxKwlzgyTvagPlh3Np0n2zqlMt3YRum8nByZhtUXWQzjD
qiC35DcdldJMw571dmfywMDcfBREHUZWmwFmYXiatr5d9upMV6zNUwW4Iv8izcq3
3YQNIbocUULyQ34fqtcgr1Kf0CJECT8tj1ZH5/MsBy4eDhRfHmRFHT0ZXe1qBumP
9tdisAVBzmRHZmiZeMv5CLt5Om5/c8QcQTCaKGq7X7hdXw1D1kinlAycBhW2G3Jf
sQ31oDzDzMX7o91AK4rSHzBm817V2rC2UH4nyO6qu6YCQdEw43IG/dLyzu6soFW/
a4VzAOmouXVMtXDSESM9LroxddiuoA==
=c000
-----END PGP SIGNATURE-----

--uGmHJ3AUYiAioGCT--
