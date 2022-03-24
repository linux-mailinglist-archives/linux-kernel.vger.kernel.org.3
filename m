Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D64E651F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350937AbiCXOaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350950AbiCXOaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAD5A27D7;
        Thu, 24 Mar 2022 07:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D93316158E;
        Thu, 24 Mar 2022 14:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6E4C340EC;
        Thu, 24 Mar 2022 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648132120;
        bh=4qAeM0JdotrQvJ/HZMb0Us3bJl6HxRWRX8r9heyrxaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SoA0D6N5l8aWdF5RxYtg1Dp9h0kTny57KHxmvKFrFjYZ/VnWibNOlKdFq+Ra8XeAm
         /Q26XmCBrfYJBuAJM2gOgXgj5W4hsR5c/ms7Uj736aiQLVIj0XSqqsqOWUlTPUO5aL
         9cnDO4rRY9zRNW7BauF2wztarK8DrGKOsB2R2ZUap9KjnvLiwer2+zj6xhAwFBSaZB
         hAfuHwi1FH+QuFV0aRNEPoxlKYBQ96XfonYizUXOcMWYstdzJwlzuBV8WGEXddMK2U
         bec2mMoX+XFHGFs2KAT956jtMnj+VP0Dd/s0isgEDbIOeexndAzpPFrrgloH09wO+b
         WZj5MzmU2gpAw==
Date:   Thu, 24 Mar 2022 14:28:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] spidev: Do not use atomic bit operations when
 allocating minor
Message-ID: <YjyAFNYpDjSQnIN1@sirena.org.uk>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
 <YjtNJe4Pgp3WIwOa@sirena.org.uk>
 <YjtXbDyCWZxKnf4Y@smile.fi.intel.com>
 <YjtvsYs+x3LRaLVP@sirena.org.uk>
 <Yjw4yjgordnSo+7M@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dKOZZHhcOIvaUSFy"
Content-Disposition: inline
In-Reply-To: <Yjw4yjgordnSo+7M@smile.fi.intel.com>
X-Cookie: Orders subject to approval.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dKOZZHhcOIvaUSFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 24, 2022 at 11:24:26AM +0200, Andy Shevchenko wrote:
> On Wed, Mar 23, 2022 at 07:06:25PM +0000, Mark Brown wrote:

> > Yes, it's not needed but what meaningful harm does it do?

> There are basically two points:

> 1) in one driver the additional lock may not be influential, but
>    if many drivers will do the same, it will block CPUs for no
>    purpose;

> 2) derived from the above, if one copies'n'pastes the code, esp.
>    using spin locks, it may become an unneeded code and performance
>    degradation.

I think if these are serious issues they need to be addressed in the API
so that code doing the fancy unlocked stuff that needs atomicity is the
code that has the __ and looks like it's doing something tricky and
peering into internals.

--dKOZZHhcOIvaUSFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI8gBMACgkQJNaLcl1U
h9By4gf7BRudaID9+lgjz75qSGjV25y2Q4R5DrX7G8DYKkNssivBFsA8BxGmrvpV
O2kz4kYAx1YjnxwklsKdVXAxomQOfdvNl9CWgBJM8VqkIyVS5XQSJunudbOpjJ45
5jFQZuuj9iaCx8TiH9UKc4/hMIbvtuV8i/aWd6KAPzxpIVh3IZGnlSOOS+mAnLux
2HVDROxvCi8a3/UnG7phOEOFzWFuDDWMpeLJlN+wO4c1w3LsxcBa+N1TavT3ZQlL
Yiopw+GQam3hQn8B5C+j3YzfESvK/ghYtFHHLGBoY7BcWQ82h/WXEKcf8DMFnfyo
UMZh7ZjlESFCSVDuRclf2sRaOMS8yQ==
=oZfL
-----END PGP SIGNATURE-----

--dKOZZHhcOIvaUSFy--
