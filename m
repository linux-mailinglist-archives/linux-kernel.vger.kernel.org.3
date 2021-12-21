Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AC047C59A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240771AbhLUR5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhLUR5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:57:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:57:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FC8B616AD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 17:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EEBC36AE9;
        Tue, 21 Dec 2021 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640109440;
        bh=ed9LAFFxmkjkEyfpFrbWs3q90RhuKwcyZUvVJ/3hLok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2PZYQW5bGTHUK33CAFywnHhMNT5a2zDst0AkksTErU5AyWiVN5lW+MOPQn1d+m+/
         R2och2njJjBV99xWrVYVNKUmMEVcZt7yJL3KWXx4tkxajK7PauPOaIAukpf0ze8c6o
         2D5fdlLBsvxOLL3Zfj1OqmAhIAaI3fJ4IYS3VP/zoq1B4FN//+i9J4Ar/Fua72v/s2
         PhVa4sQqq5vw9hW1Ze3oVuteqzKkqlXECGRZFyo3L3sTNK9MRBwrEuNsDP5CgwPkeU
         BSsOcQrFDJMPAyeMkmA43Eos5t/84kYLPCRVSELrEYIm4WQHe7ZeMdSh3MulUiOFbG
         q6syM+p5BixQQ==
Date:   Tue, 21 Dec 2021 17:57:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     matthias.bgg@gmail.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isoc: mediatek: Check for error clk pointer
Message-ID: <YcIVe+dDoE4SWa3D@sirena.org.uk>
References: <20211217173005.698876-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y1QX5gkzmV5X6OYo"
Content-Disposition: inline
In-Reply-To: <20211217173005.698876-1-jiasheng@iscas.ac.cn>
X-Cookie: knowledge, n.:
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y1QX5gkzmV5X6OYo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 18, 2021 at 01:30:05AM +0800, Jiasheng Jiang wrote:

> +	for (i = CLK_NONE + 1; i < CLK_MAX; i++) {
>  		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> +		if (IS_ERR(clk[i]))
> +			return PTR_ERR(clk[i]);

This now pays attention to the error code here which is good but...

> -	init_clks(pdev, clk);
> +	ret = init_clks(pdev, clk);
> +	if (ret)
> +		return ERR_PTR(-ENOMEM);

...then discards it here with a random most likely inappropriate error
code.

--y1QX5gkzmV5X6OYo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHCFXoACgkQJNaLcl1U
h9Agfgf/f7m/N2DMVZ5PNdYe9h34gphjGr4sR1SnO0LB7atpG9EZ3nAUrR8Dq8HA
v9qoZ9vqPvdaJvzkAQ6Uyk0xeL2MZzalzBicaPDk0ZPMZyMtpGNOBfQ7Hg/eebw0
FgcFdAt7eBcIflPVHE7HxP2Qfma/Yf73nGyF0PClWPeJBUv+D/+IUs2FEmhuOfKT
jK1pw4xc/u8zUYQGR1J8NY3h9e9rLgW/sTwlvDa+o1O+qzZqHdMFDyZd6YUsidQD
/jbPQsA6KMyu0EcUs5r9+JqSJMVhKI1VqfTYxcGfzxKNPs2jyOeBYBbBCqoiWozL
6XZrX1QiHVCptfxh5JkNz2c0Jfppag==
=uxBx
-----END PGP SIGNATURE-----

--y1QX5gkzmV5X6OYo--
