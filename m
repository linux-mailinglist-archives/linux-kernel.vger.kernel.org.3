Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6386451A05D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350299AbiEDNK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350326AbiEDNKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02259403FD
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 886AC618CC
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 13:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A5FC385A4;
        Wed,  4 May 2022 13:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651669570;
        bh=dnmH5WsMczQ058TyPUXueeJIA4Rl1nxkTJuqpWN88fg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2HZpKjcw5cXF85ECYNoseK1TqjpP0u5iJcZ6SyxDz+sw9bTD3rE/sZ3UfHwzhKSX
         poYd27FmZovchz2DB/FeLieZ82BsepvvEFhF3rEUBpI3mKU6yjeDe4ZsFWckZaSMAp
         7zMOfvp8rtSYu+ecQquuWJTtmXRrdTSte53SIDjGMGO2qIhdTV6Nj+Nili+G8NWO1g
         bfOESBtBPm2ud6P3TDaXPsu0vceOlbdxKb7bk9Ua1351Hfr9lyueYgBBEUpolH9+dh
         gEcIGGiawL7000X4f9oR4x6MBFVFF+IWNRSxslFa1xecpHcygj3AHaZFHW1JHhaneK
         9s29mTGXUeW1w==
Date:   Wed, 4 May 2022 14:06:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 4/6] regulator: core: Add external-output support
Message-ID: <YnJ6Pbmv9G3cy62n@sirena.org.uk>
References: <20220504065252.6955-1-zev@bewilderbeest.net>
 <20220504065252.6955-4-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MgdOf/e57b7o062W"
Content-Disposition: inline
In-Reply-To: <20220504065252.6955-4-zev@bewilderbeest.net>
X-Cookie: Mother is the invention of necessity.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MgdOf/e57b7o062W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 03, 2022 at 11:52:50PM -0700, Zev Weiss wrote:
> Regulators feeding external outputs (i.e. supplying devices we don't
> control) can be switched on and off by userspace via the 'state' sysfs
> attribute, which is now (conditionally) writable.  They are also not
> automatically disabled in regulator_late_cleanup(), since we have no
> way of knowing that they're not actually in use.

No, this is an abstraction failure.  Enabling and disabling a regulator
is something that should be handled in consumer drivers, just as with
every other use case there's no reason why the regulator should be
offering direct control to userspace.  Putting this directly in the
regulator will cause problems as soon as you for example have multiple
outputs supplied from a single regulator and can't be integrated with
any other control mechanisms.

--MgdOf/e57b7o062W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJyejwACgkQJNaLcl1U
h9B6SAf+K0NM4GhP/wUxHWZLOu4RT872T+i8mSfQlF7aIQvREU4jlHJQrg/zkzm3
8HjhQQzPn+wKz7WEZwgL8N4HgZ9lzNIQYukpJBiGv60QgFlc1lbq7i9J6SX8LNjy
0QZLgcQYjOSIXV6ZMLCn/K8d/D4fS+Lt47REvp/KsxOH3T1U7/ISNrrrUVb3C8p0
bJS2vZ8rUwfSAjPQa/D/SBUeC8WLn5CFskonP492okTiAGKGZn35dTghvEuiQgOT
UH7DipdelxmAALYu3SxxFjfv9dBNELXzLcjtlR0snY2P6mkNbsZnombeWcx2McG3
Pu6RpgoJ/MUlEgDp9XzmY4wXeadGpQ==
=M4o/
-----END PGP SIGNATURE-----

--MgdOf/e57b7o062W--
