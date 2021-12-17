Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A254789E2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhLQL1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:27:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40556 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhLQL1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:27:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC5A96211E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 11:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4A3C36AE5;
        Fri, 17 Dec 2021 11:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639740443;
        bh=gCj6M3fgYAowhTn0haiHmB2bEGG+t+sL1+hhnl1D+Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=noOfF5QfATS6h2XJ7bbPpixX+sCebZ0/24d7gSLMG7CpYv8B5xl4ixa4UimMEpwrF
         fJDx/dnccIJd5w7cRPZj2gEsKtSabX6UnwtM9cKAelfGcjmWVhrmx6rq02k/UTbzUM
         Ik3wrH3aQ8TkXc6qLQmY0AffBavin1TuVrpVxBsGRKTDoVpoyF4jNYnaTpNN5QUKpH
         n4WQ1l5tvXMvn481l9whS/9gxzZO4ZQUZMSpQQhoV0V53NHCZP46mHwNW7YqvtJJ+p
         F0Isp1xiqd7bg8sjXt+j0oPjO7YUsIIRutdnDY/lW2SxFg/YyMUoUYgtbj3MKd+b5c
         CiC3Q4XdNS6mQ==
Date:   Fri, 17 Dec 2021 11:27:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     matthias.bgg@gmail.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isoc: mediatek: potential use of error pointer
Message-ID: <Ybx0FouFzlI79zjU@sirena.org.uk>
References: <20211217064140.517160-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8QwhTE1g/UziorTz"
Content-Disposition: inline
In-Reply-To: <20211217064140.517160-1-jiasheng@iscas.ac.cn>
X-Cookie: Pause for storage relocation.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8QwhTE1g/UziorTz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 17, 2021 at 02:41:40PM +0800, Jiasheng Jiang wrote:

>  		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> +		if (!clk[i])
> +			return -ENOMEM;

The whole point with returning an error pointer is that there's an error
code in there, we should use that rather than overriding it with another
value which might be misleading.

--8QwhTE1g/UziorTz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG8dBUACgkQJNaLcl1U
h9DsBQf9FTg6jkzyG1wK1SgbhFjoSeICsQhrkB/lOxpY+krjK5nB7PacLuSPEQcd
9kiM1QqQYFtAxQsHTxJ5j8l4zrimA1BQ67miLtrMN/Uv+/fb47HWaKqOqNCaXqYg
aKNbTREM1+fyeQuj1s24vM77eNQ098721WcVaecNYWdf7eWOETIcrkrkX/JlEW25
jQoDYDZ+qB/z2odrPdBz5Kh23F/u/+Q9wkqlgbHxKPGSVGbjKRYfkuGuae3sN+96
7V9DPtzTL9iTy+w/3Sx1RW0X7M65C5d2CN5X+gd6C+nUJyD1ibMl/qENRiXD659k
pgoYR2SCBW+IawM37lVegfSx877blg==
=pcgO
-----END PGP SIGNATURE-----

--8QwhTE1g/UziorTz--
