Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E399B478B81
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbhLQMhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:37:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44624 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhLQMhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:37:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EA38B8273A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF93EC36AE2;
        Fri, 17 Dec 2021 12:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639744655;
        bh=5CtqiJ7f5AzZgI8XLwwVBxYzfvfyk+EKiJkQa4XB0fM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJG1BJJDKdhZRifs/1R/XXWOYK2sYD7hefP3K8h7V+9KiT4uxIahhcYP2lD+D7Hdx
         brbn4mOe3QsLWr1hgXVntQBXNqkO8MsFNN/EI6WFMTFqbPNaLZFKfJKg0qOuIbXD1G
         6zs5hSEcDUKG7XYq+ylTHZTXuU4UiHMDQlFKE8YIUGD4I8N4wjq+YMwiLCQLKLi32B
         l+Sn9giOwtxQm1XvOH+49iG1L0Mz/cdoToGE1UJ4Z3+UaR3wbyHmM1//7xJljU6U7E
         Y7Ps+EwdJujkmqozm5oeWemjiX4FD5dzyoUleqSDBn1A6vEat0ID45ctakhfwrb65S
         0DKB0fhNUIXng==
Date:   Fri, 17 Dec 2021 12:37:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     matthias.bgg@gmail.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isoc: mediatek: potential use of error pointer
Message-ID: <YbyEigc8o5zxrEIh@sirena.org.uk>
References: <20211217120845.628024-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zMLeK8tkMwZF4Dyq"
Content-Disposition: inline
In-Reply-To: <20211217120845.628024-1-jiasheng@iscas.ac.cn>
X-Cookie: Pause for storage relocation.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zMLeK8tkMwZF4Dyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 17, 2021 at 08:08:45PM +0800, Jiasheng Jiang wrote:

> -	for (i = CLK_NONE + 1; i < CLK_MAX; i++)
> +	for (i = CLK_NONE + 1; i < CLK_MAX; i++) {
>  		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
> +		if (!clk[i])
> +			return ERR_PTR(-ENOMEM);

That's not how to check the error code from clk_get(), still has the
problem with unconditionally using -ENOMEM.  Please at least check that
the patches you are sending build...

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--zMLeK8tkMwZF4Dyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmG8hIkACgkQJNaLcl1U
h9AwEgf+MymMJRprn0AO42rTHOUqzPhgzGnAPqUzKB/o0cBQ6ykHPPVr+u/U1OEc
Zb3iwpu8LKn89t+Dg9mYzkax6PHyT2LE/mhKUJWfBGsCIj22EeJXWweiIKra3RYO
cLek+igwWU0uw+g4BTJpdMvQ3U7+a1+Y83aEHqy2d8pefzwSVZLLId1Pjq9kwEYT
y+fOjTe4rrQtu9JD6AXLiJWiUlbuzeENh6pif2LpkDTIciOGzAX4AFLuxqxZcdxi
/5fBBxUGo9XT/xlKfO8lDKAzmiLXIj9BDW9QK2PgVMYRIuKLJFO9s5KQVwDazCRr
m1gsMsi/R3F9wy/ejTujdvrni+N6Lg==
=txnz
-----END PGP SIGNATURE-----

--zMLeK8tkMwZF4Dyq--
