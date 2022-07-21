Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB76957CE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiGUPBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGUPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:01:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEBF76EB0;
        Thu, 21 Jul 2022 08:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD42EB82389;
        Thu, 21 Jul 2022 15:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C38C3411E;
        Thu, 21 Jul 2022 15:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658415685;
        bh=r+lgIJOmDQrLmbvNFgMmdz6shCg1+ntIlt/QGiQZSnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knURc9prSyAJJcu+Prn04cRhlzAz9FyZ+WMkURoudpl+P82/twHVzj5qflD5M7WlH
         OgpAxKUagJh9RC85XUkAgWiFzB0UydlZ2tQKqt+bF7SzaOzKVrk9jc7XYH1Qr7mfWS
         QgJfF0MAw927/Och684dYc6sb2YTtMFyvtTK6gfMFQ+wcISjjNkirizd0o3j5jx2zY
         h08xLgJTqjLcSpc+Lwhm4kb5puNz4D8SXv+gjtRUpVfiu/0Irgp6gR/FlMv51gg8Ye
         J6EC1dlXIqpcEPRiFirXItSBli4fCeo8oMaFuJ07VsyxCYpzRbdLDnEUsCz4dsQ8JM
         1KqWTXjRf3Iag==
Date:   Thu, 21 Jul 2022 16:01:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christian =?iso-8859-1?Q?Kohlsch=FCtter?= 
        <christian@kohlschutter.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, wens@kernel.org,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] regulator: core: Resolve supply name earlier to prevent
 double-init
Message-ID: <YtlqPbbBceBmekcV@sirena.org.uk>
References: <3B4AE882-0C28-41E3-9466-F8E301567627@kohlschutter.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i0TkaW/gVp5KwYgS"
Content-Disposition: inline
In-Reply-To: <3B4AE882-0C28-41E3-9466-F8E301567627@kohlschutter.com>
X-Cookie: Exercise caution in your daily affairs.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i0TkaW/gVp5KwYgS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2022 at 10:32:16PM +0200, Christian Kohlsch=FCtter wrote:
> Previously, an unresolved regulator supply reference upon calling
> regulator_register on an always-on or boot-on regulator caused
> set_machine_constraints to be called twice.

One small thing below but otherwise I think this should be fine, however
since we're very near the merge window I'd rather hold off any apply at
-rc1, just to give more time for things to get tested.

> -	/* set regulator constraints */
> -	if (init_data)
> -		rdev->constraints =3D kmemdup(&init_data->constraints,
> -					    sizeof(*rdev->constraints),
> -					    GFP_KERNEL);
> -	else
> -		rdev->constraints =3D kzalloc(sizeof(*rdev->constraints),
> -					    GFP_KERNEL);
>  	if (!rdev->constraints) {
>  		ret =3D -ENOMEM;
>  		goto wash;
>  	}

The check for allocation failure should get pulled earlier in the
function along with the allocation, no sense in doing any of the other
work if we're going to fail.

--i0TkaW/gVp5KwYgS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZajwACgkQJNaLcl1U
h9D6GAf/aKtJVjiaVbiy92RgxmpXa+sxM+nEmIzXqPyiJSiUDTcobnmI2+w7WN2Z
6h/rewa+Ujgm0CSwmO4fiQLkeGhZZOeYsbkavj2pGeVm33xMfkaST4bvjgywvT55
5vh93NWHdo59avBtRZegPSjdR8QWQOXLl7bP/6JEKEu91LGfolis1uR7AnDXwsDB
c53Z1b96y/2VQ62VLavQ1+0E51afB0J3M318ISAky1CEIep8cQ9KyIIwRAQhJgW4
V1KB/WmbRW6yaDA1Oy29n5gWJQIJBh/bUMHN35axsdfcZSaQoXjz4opKGpiEhefm
zQpzGfqBoLU6I9sbfDFAKaGIeNiy8A==
=b4kq
-----END PGP SIGNATURE-----

--i0TkaW/gVp5KwYgS--
