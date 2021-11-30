Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70F0463F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbhK3Ui2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 15:38:28 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:52759 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhK3Ui1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 15:38:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J3Yqs6TGqz4xR7;
        Wed,  1 Dec 2021 07:35:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638304506;
        bh=mD60RP7abxz0LTkN0LokOd+KJofCAnrjXIk27vJ5P6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=quuF2oNZynHJKaATdJYo/otW1PLNte26tvGhKnEYaGx+TSUpmWnypM0Gw3Gjjokys
         te+KyWwpWEVqQ8JZACD5EkVa4g/p2msEj3X0WKGygP4segsoPgCmxY1XEoIwszoZ4M
         wx6s0nw1EHqZGauCJn+U6gFKmVuFAX0QvOsEhxwGzCoeER5xM6/GDt8fgh49FNcQP+
         1hbB+IRIvYxX5F2o8pqJGctkYjS/UxDDJzWfsNGp7iyWwAhykkc7BAs/f2o+NGLO+L
         tkEqwygafMpdVToOESf1cuQRJHUQZhlTTCNczvqOI6rNBqOtSmDmK067TBMW0p5uC2
         NBmNH6j9iCbZA==
Date:   Wed, 1 Dec 2021 07:35:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm tree with the
 drm-misc-fixes tree
Message-ID: <20211201073504.24a6494b@canb.auug.org.au>
In-Reply-To: <20211130085831.wghfw7l4qksg2dbm@houat>
References: <20211130103353.0ab1a44f@canb.auug.org.au>
        <20211130085831.wghfw7l4qksg2dbm@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2EKH4NfA_IxKvEmYjAKFHwb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2EKH4NfA_IxKvEmYjAKFHwb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Tue, 30 Nov 2021 09:58:31 +0100 Maxime Ripard <maxime@cerno.tech> wrote:
>
> Unfortunately the merge resolution isn't entirely correct :/
>=20
> There's multiple conflicts between those two branches on that file, but
> things went wrong between 16e101051f32 and 0c980a006d3f
>=20
> The first one changes the logic a bit for the clk_set_min_rate argument,
> and the second moves the clk_set_min_rate around.
>=20
> However, the merge resolution reintroduced the initial clk_set_min_rate
> call line (line 373), without changing the logic of the proper call site
> (line 396).
>=20
> This is the patch to fix the resolution:
>=20
> -- >8 -- =20
> --- a/drivers/gpu/drm/vc4/vc4_kms.c	2021-11-30 08:56:28.748524275 +0100
> +++ b/drivers/gpu/drm/vc4/vc4_kms.c	2021-11-29 15:46:11.692151678 +0100
> @@ -365,14 +365,6 @@
>  		vc4_hvs_mask_underrun(dev, vc4_crtc_state->assigned_channel);
>  	}
>=20
> -	if (vc4->hvs->hvs5) {
> -		unsigned long core_rate =3D max_t(unsigned long,
> -						500000000,
> -						new_hvs_state->core_clock_rate);
> -
> -		clk_set_min_rate(hvs->core_clk, core_rate);
> -	}
> -
>  	for (channel =3D 0; channel < HVS_NUM_CHANNELS; channel++) {
>  		struct drm_crtc_commit *commit;
>  		int ret;
> @@ -392,8 +384,13 @@
>  		old_hvs_state->fifo_state[channel].pending_commit =3D NULL;
>  	}
>=20
> -	if (vc4->hvs->hvs5)
> -		clk_set_min_rate(hvs->core_clk, 500000000);
> +	if (vc4->hvs->hvs5) {
> +		unsigned long core_rate =3D max_t(unsigned long,
> +						500000000,
> +						new_hvs_state->core_clock_rate);
> +
> +		clk_set_min_rate(hvs->core_clk, core_rate);
> +	}
>=20
>  	drm_atomic_helper_commit_modeset_disables(dev, state);
> -- >8 -- =20

Thanks, I have fixed that up in my resolution.

--=20
Cheers,
Stephen Rothwell

--Sig_/2EKH4NfA_IxKvEmYjAKFHwb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGmivgACgkQAVBC80lX
0Gwxfgf9HRdU6pis3b8dQs8qmOiujsA2zuiEqOYyfKD/4c26T08NzIUV1n++eaGk
nxBRB9w4ulIhNeDFmdc4xgdDTsCf/ixBuVdjVOvVTlhglcNeYxx507rmZv3VSp9/
IZI1B1mXuJ4IJBeDXRy5/Y7/UX7Z+WI0se18/Su4NhouEs5AoAUpJ/d6jdorkOnC
Wb2mPeeSYD7pVCcm8QwF9nWQfcntD7J+Fc3APRjBaQUxhkmFTvZYEh0Lv45qUxQB
YfGStPEFf+J89eQsFO50EWhXJPv+urSrDNJ8hR+PlFs3NaEfqIsELd0aZmjtYHS3
p3Qbzvrdub5OpWkZ4KHeLnNMrqH6eg==
=AABu
-----END PGP SIGNATURE-----

--Sig_/2EKH4NfA_IxKvEmYjAKFHwb--
