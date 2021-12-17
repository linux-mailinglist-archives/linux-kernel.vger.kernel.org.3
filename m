Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0193479242
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239564AbhLQRAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:00:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44138 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbhLQRAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:00:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44EA6B8296A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 17:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7AEC36AE1;
        Fri, 17 Dec 2021 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639760431;
        bh=MIwrEAZOSHeYZ/APN7YkKSbncZZtDThY8jn6JIL8CA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DX8FDndfNyFE+N7291noRiXlRb9+qYnSgy9+KOaT2n1UR4J/mr7fr/p92DUPZYSb+
         UBhevf5NlYqXrKHGqtB2qOlYvYGQRKvYIpOloYMHh8JAx9rlsy0gin5AxHvILGoPqv
         lcJBGinU++B42F0Gw9NWGlXo+lJAwCXi78iezQDnVZidBRl27iQ65mjI70o8Djpo8Z
         X5C4ngCBuKne7XJETFr+vL0whCwy/oGXozR1glUBtVWUf9Vu7WZgOt4zl/P1IDJZ+7
         8650JJaqiVvHuFpHVPconmC5xN7k2+YNuTOgoMraHY3sx2Mp3VxnZoh7E5GDB7F8Nn
         /7RM0RSL8HEAg==
Date:   Fri, 17 Dec 2021 17:00:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     matthias.bgg@gmail.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isoc: mediatek: Fix dereference of null pointer while
 alloc fail
Message-ID: <YbzCKoKGpGgAtvdq@sirena.org.uk>
References: <20211217165220.675485-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JJqGkUrwTom4jERC"
Content-Disposition: inline
In-Reply-To: <20211217165220.675485-1-jiasheng@iscas.ac.cn>
X-Cookie: Pause for storage relocation.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JJqGkUrwTom4jERC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 18, 2021 at 12:52:20AM +0800, Jiasheng Jiang wrote:

>  		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> +		if (IS_ERR(clk[i]))
> +			return -ENOMEM;

As I and IIRC someone else pointed out there is an error code encoded in
the pointer if IS_ERR() is true, we should use that error code.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--JJqGkUrwTom4jERC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG8wikACgkQJNaLcl1U
h9C91Qf/fsxCTq7BvFkf3sXZV0g4NXhdBia8H6U+ehwqkyRqwj9irbhmFZPa5a5e
IvWxSJ4e6UBFtL3ej0eVCEj/xcJHytRBC492G3RI+Hr1XPNtpfBY/eaGIZQ5Q9HE
KbwQ/ScMeoYRW3sGHtczrQrmd/LTXY+H47hICtq8CNriO56N6O1iISaXaMeogyfp
RyefEBtM5IUhcZsqbAhOpa4+v6EO6tWu3fUwUexUNF2u4vJm5r+V/yZGQaxmypSj
ecQFljvyjpT04PL/GOlPqgV2/qgiwlRDsy3SjsGPyrNiR2FWzbOXXdDxfjnxQnVY
XO0+74eQQmR/fCFEuXZKe3xxubVPFA==
=/dDZ
-----END PGP SIGNATURE-----

--JJqGkUrwTom4jERC--
