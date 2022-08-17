Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90096596F83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbiHQNS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiHQNSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:18:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC24295AF6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:16:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79098B81DC8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEC3C433C1;
        Wed, 17 Aug 2022 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660742193;
        bh=aDRIqa8eaijPVXqeqJfGk+sLeJDArCHTw/EZrUOXu+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1RygQVWbvBT+13SzBAlXWjGZQnpI8KQWcpnYrKeJCN/5uLVfnBrrEImG75kqvjrM
         e0W7Q5WM9rfIeSFsOuhW3Ny/iV/v43ptQ6jPULmhuZnRWuW9GRzbc0y+o9aEQycStE
         zV9IzyrOAO4nYemVhGInEm3+M5I50MTrFirT6znOqj2Jy3oYcxe+QWd6pnon2EQRqa
         XhhbeZ9/0wYYz/7S5XYw25LE8L/hBFw6eguFxZmglHqLIqlw/MbFVYh91cl0NP/SNv
         +MrLBZj6RgD7fqfdXJbxvK72oSol/z7KkbyQPXMj0IgXL7MkENvHCmnz7756iQY+ti
         8LbCJszxKVdrw==
Date:   Wed, 17 Aug 2022 14:16:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: head: rely on CONFIG_RANDOM_TRUST_CPU
Message-ID: <YvzqLFDuXtDRxilZ@sirena.org.uk>
References: <20220817094618.67063-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8H8XdsxnlYFybTHf"
Content-Disposition: inline
In-Reply-To: <20220817094618.67063-1-andrea.righi@canonical.com>
X-Cookie: Use extra care when cleaning on stairs.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8H8XdsxnlYFybTHf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 17, 2022 at 11:46:18AM +0200, Andrea Righi wrote:
> The CONFIG_ARCH_RANDOM .config option has been removed by
> commit 9592eef7c16e ("random: remove CONFIG_ARCH_RANDOM").
>=20
> Depend on CONFIG_RANDOM_TRUST_CPU to determine whether we can rely on
> __arm64_rndr() to initialize the seed for kaslr.
>=20
> Fixes: 9592eef7c16e ("random: remove CONFIG_ARCH_RANDOM")

> -#ifdef CONFIG_ARCH_RANDOM
> +#ifdef CONFIG_RANDOM_TRUST_CPU
>  		 if (!__early_cpu_has_rndr() ||
>  		     !__arm64_rndr((unsigned long *)&seed))
>  #endif

I think the sense here would be more that we should just unconditionally
use RNDR if it's present - previously we'd use the result even if we
didn't have strong trust in the CPU implementation and I don't see why
we'd want to change that.

--8H8XdsxnlYFybTHf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL86isACgkQJNaLcl1U
h9Df7wgAhn45rtL5BTafxsbRFNuND0n6Pq7ioAq/s35QXOWV1WRw4gRfDAaGRS3R
090kZUquUoRAHIf8IroKI3ZQmI1QG9GcZeOU7jCj4RsDcoWpWru3OUG1gogU3VDd
w44LtXw6ymbWROWPa5O3bS+/4isQpori6p7FTze1zL2KDrET9iKFKNQcgImVU014
0gQIkyqy+HmypLsu4MkPO/qXanmTEbQkQyCMnHX8cQgJXkAMaFhFj1EeYzwleHIS
wTuJsGZ1dzgYjS+p1XCBUYtZpL+sICn1g4BfTsOVDqqKEosg511NM98wLS7883+z
Rg2ajzZZarO9svnhv1hOIP6pqN3rqA==
=kiFb
-----END PGP SIGNATURE-----

--8H8XdsxnlYFybTHf--
