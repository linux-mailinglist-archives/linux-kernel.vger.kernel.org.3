Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2A44863CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 12:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238585AbiAFLkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 06:40:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51970 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiAFLkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 06:40:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6403B61B1C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 11:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5296C36AE3;
        Thu,  6 Jan 2022 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641469238;
        bh=QloY4hxw5qQTmEWd/pxAvyCYSdvIo7rLJa4yNbpP2Pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=imcpVtGSUoX6vwGcZCswYzrfLK3Xv3rAJ8kjTZVp/L93HmVfeai/xMOe8Epbk5BaT
         iWcE/ez8Mh06yVOHqizMCXQT1FjYoZOe1Mw5Ey4/jEEt/Cm6cE91nrIvowDWzSpV0t
         dyL4LniAVByY8Nr5UEfe+LmAECT23Ao3TqIMkb4+zn6BQ2aBLOgf0X/nEalP63KMr/
         o8X6AWr9+KNMUjQdRIVQLm4duhTWVhQUiP05KcQfJ/koM2Su3O/ifh+CH4elh7Qure
         YQ8+IY8gB5BSIV8fDRqmjdcORr/pkC+S2GXBnec3D9FBnSMoK1n+6wAYsLyLl8wbri
         1VfDHV/x84mHg==
Date:   Thu, 6 Jan 2022 11:40:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 2/2] regulator: Add MAX20086-MAX20089 driver
Message-ID: <YdbVMqKt6iKa/pY+@sirena.org.uk>
References: <20220102211124.18435-1-laurent.pinchart+renesas@ideasonboard.com>
 <20220102211124.18435-3-laurent.pinchart+renesas@ideasonboard.com>
 <YdRWwWmoQGQuUyLz@sirena.org.uk>
 <YdRa0GoSoX8CP694@pendragon.ideasonboard.com>
 <YdYoW2me4aHpJzfm@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="emIq0MHe9V5fJ8DT"
Content-Disposition: inline
In-Reply-To: <YdYoW2me4aHpJzfm@pendragon.ideasonboard.com>
X-Cookie: I think we're in trouble.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--emIq0MHe9V5fJ8DT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 06, 2022 at 01:23:07AM +0200, Laurent Pinchart wrote:
> On Tue, Jan 04, 2022 at 04:33:54PM +0200, Laurent Pinchart wrote:
> > On Tue, Jan 04, 2022 at 02:16:33PM +0000, Mark Brown wrote:

> > > It is worrying that a regulator driver should need the interfaces for
> > > machines...  the driver doesn't look like it actually does though.

> > I'll try to remove it.

> It compiles fine, but I won't be able to check the init data to figure
> out the initial enable GPIO state if I don't include machine.h, as
> that's where regulator_init_data is defined. Am I missing something ?

Right, forgot about that bit - it's more of an issue with the gpiod
conversion.  You could just request always enabled but it's probably
fine to leave as is with looking at but not modifying the constraints.

> > > > +static const struct regmap_config max20086_regmap_config = {
> > > > +	.reg_bits = 8,
> > > > +	.val_bits = 8,
> > > > +	.writeable_reg = max20086_gen_is_writeable_reg,
> > > > +	.max_register = 0x9,
> > > > +	.cache_type = REGCACHE_NONE,
> > > > +};

> > > No readback support?

> > I'll fix that.

> Actually I'm not sure what you mean here. All registers are readable,
> what's wrong with the above regmap_config ?

It's not *wrong* if that's the case, it just looks weird to only provide
writable but not readable.

--emIq0MHe9V5fJ8DT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHW1TEACgkQJNaLcl1U
h9BFaAf+MO/bJyr38KNE7RLXPr0W7NkXsUPofV1bCQr0s3HxNVCFuMhqd4pBGeq0
Lhs7TnbxraaoGRrI14HvZag8UfAr+E/ffIILi6cc392jm4dnI3lPRVaGQiNMkriO
aeJp9yHJLT8UVaI5hyGnTqQd/g5q7Pw5IewpIcqG/pTIvEk5cFavLRAWCVnZaipN
cmXwPqrsEp+imtmxqkshWkIutwnHoOX+k3rNgiB1cubyiVpt87VKGRjwnXTnARoW
2l8nNVp9E5eyvBf2gDrjyOD+lbl8vz6DFQIf8P1zB6Ke2iL3YhBZmrAvwwBCnXtu
NMzmt5wIwuinBFTlAcjvbfs68imQgA==
=Evrb
-----END PGP SIGNATURE-----

--emIq0MHe9V5fJ8DT--
