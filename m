Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4FD4E967E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbiC1M1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiC1M1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:27:40 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1EB766A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lrVzwikDhjBGNRcFFbTyAqjkMTBLzQaJc2hHSS4wEmg=; b=U0YKf/ro6hqqx+3l1XJttwBDKF
        vDjhJY0n6WPbgPtJ2ll6rW9EDBb+yeccBWQHCrDhNQ+Y9UJYYush8ulru/PCk7WvEw/EG3sW8bAy0
        9tydBfVnc2Bpr07gk5Q274j/FBrwmc7wDIBX6KrC4MCW4W1mHw8XivgcAA8l9tBq0U3UTdBcJCKvc
        u7Zlwm0FvMYk4K5vW0oMQ9O80CVtt2uAQc198QUVuU+QyAeX11FoBVg2z1smHSKGbuQjTMRC/T0+x
        9JyHZFfQYdPY8IOPwgtrxslAmvSxLfurPf+geAgzW167ILRFvlI7OsSSIFE6M9uKWsQMzdx1NqnyN
        tEZnkMiw==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nYoRU-0005HJ-4I; Mon, 28 Mar 2022 14:25:52 +0200
Date:   Mon, 28 Mar 2022 11:25:36 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] drm/v3d: Use kvcalloc
Message-ID: <20220328122536.cobmqclwtl2ca6k4@mail.igalia.com>
References: <20220312152656.51625-1-harshit.m.mogalapalli@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qeqcrncyu2fdobow"
Content-Disposition: inline
In-Reply-To: <20220312152656.51625-1-harshit.m.mogalapalli@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qeqcrncyu2fdobow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/12, Harshit Mogalapalli wrote:
> kvcalloc is same as kvmalloc_array + __GFP_ZERO.
>=20
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  drivers/gpu/drm/v3d/v3d_gem.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index c7ed2e1cbab6..f7d37228461e 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -308,9 +308,8 @@ v3d_lookup_bos(struct drm_device *dev,
>  		return -EINVAL;
>  	}
> =20
> -	job->bo =3D kvmalloc_array(job->bo_count,
> -				 sizeof(struct drm_gem_cma_object *),
> -				 GFP_KERNEL | __GFP_ZERO);
> +	job->bo =3D kvcalloc(job->bo_count, sizeof(struct drm_gem_cma_object *),
> +			   GFP_KERNEL);

Hi Harshit,

This change seems valid to me, but I believe, in this point, v3d should
move to use the DRM function `drm_gem_objects_lookup()`, and then your
change goes there, since drm_get_objects_lookup() has the same issue
you're pointing. What do you think?

I already sent a patchset to replace steps in v3d_lookup_bos() by
drm_gem_objects_lookup(), as I mentioned. The patchset is here:
https://patchwork.freedesktop.org/series/101610/
Willing to review it? ^

Thanks,

Melissa

>  	if (!job->bo) {
>  		DRM_DEBUG("Failed to allocate validated BO pointers\n");
>  		return -ENOMEM;
> --=20
> 2.31.1
>=20

--qeqcrncyu2fdobow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmJBqTsACgkQwqF3j0dL
ehxezg//bh3x6Kkk5aU9Y0GowW2fk6Lfo/opQx/a9VPa/sCZ9ft0ctam7yGZUz4G
6YvPDT9kPaZJ/4B2+U1MCECuEEciDoelttwXGls3AdRpk7UIZcWsnsHQZeo5tdPe
gNDZHg7h+TiMNxmdPHItJRuNn4XSe36yTjNfHRUTyx67UhHvmcX8sO12DjQ1u+IL
kKpODRaacDQvLc+hiizZl2Y8e7AP8/rDKH2Ydc8XrknlTt4q+IZLRSwljlhk1QhX
Nfwvv4qTD2kMAQPPcRi64sqzEddFk+YJousPmxdIk2fQ0D8+ljEmf/jvxPnUikgj
34moPZD5r0XJtij/uwTnEwljzAqCOv0XZrorQvVw6WHoi+XvEt7gfvYl7aOPAHZ/
Q23CsRsXGE6yLttjbM45p87PZAtV48cSUGssufkzMJBqlj5aQKsyrBHDxIZF9cYH
sRluiDWo18J7TwqKMo9v3sjkYncQgmt4sUrmL2CTkILdim52LnkHflI+balnVg4S
OQKfafzJ/C9I/nhM/4hcnMeAcw0O+oTxuFKbA80hDUviUXie++SmZ++T1nN8KnAk
2AedlB8lfMD/PK3mV0HtKvgSPyoQ2pyV9EYZNSzndJefNvRtt+jD2jxOFI1C4+dg
mJDxWaTRl23qEr8hA0vM1FD8iogjM/HD5cN2eJbdSwbnO7C1gm4=
=LPIG
-----END PGP SIGNATURE-----

--qeqcrncyu2fdobow--
