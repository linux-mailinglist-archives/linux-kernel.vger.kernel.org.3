Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DEA47EF5D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbhLXOGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:06:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56750 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhLXOGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:06:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0451362031
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 14:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF4DC36AE8;
        Fri, 24 Dec 2021 14:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640354802;
        bh=T7LlPkzUBjVEPbD6AIg/zCyhIKZrRMsVhbF0gD6KXjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MtzpCEL1gOyA1CMS+xKApP9gKaSnROb9RYrtdWHvkChKWlpCU/jbQ6d2mXMAQ4vS2
         hK8doxQf+eSZsHlrS4tCHORZaCAI1/CwAxRiesTEMPc5ZawANttykHEDKtgiAU98b2
         Nm1b8tqO5ZgpbphoMN1fuCuIupnahPcNtNNWLtGrsqt6crR+I1Y4wfWKbbfaEngDAr
         jhzLTtQClGIToDWGooK9W0QYG6sBs5+uNgH8aL4+FHoJdH9w+pDZFTVxo0M2ksGTr9
         YkJcCCTdBj8e9s0kR05eSvpx7nvu73GG/5y9CNhrSl6flFWLgt+FW20Km8z9uHyaHc
         QvevOaRyo3PXA==
Date:   Fri, 24 Dec 2021 14:06:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     matthias.bgg@gmail.com, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isoc: mediatek: Check for error clk pointer
Message-ID: <YcXT7bUpVL/JyAz4@sirena.org.uk>
References: <20211222015157.1025853-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YSEnFLCeyQGawA2l"
Content-Disposition: inline
In-Reply-To: <20211222015157.1025853-1-jiasheng@iscas.ac.cn>
X-Cookie: Time and tide wait for no man.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YSEnFLCeyQGawA2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 22, 2021 at 09:51:57AM +0800, Jiasheng Jiang wrote:
> On Wed, Dec 22, 2021 at 01:57:15AM +0800, Mark Brown wrote:
> >> +	for (i =3D CLK_NONE + 1; i < CLK_MAX; i++) {
> >>  		clk[i] =3D devm_clk_get(&pdev->dev, clk_names[i]);
> >> +		if (IS_ERR(clk[i]))
> >> +			return PTR_ERR(clk[i]);
> >
> > This now pays attention to the error code here which is good but...
> >
> >> -	init_clks(pdev, clk);
> >> +	ret =3D init_clks(pdev, clk);
> >> +	if (ret)
> >> +		return ERR_PTR(-ENOMEM);
> >
> > ...then discards it here with a random most likely inappropriate error
> > code.
>=20
> Yes, you are right and now the return code depending on the
> init_clks().

Please submit patches in the format covered in submitting-patches.rst -
write a proper changelog for your patches.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--YSEnFLCeyQGawA2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHF0+wACgkQJNaLcl1U
h9ClSwf9G7UDRag5kdedyFEo47nCabkadilrQ6nYUYbag4e0I2vSap5h04MAalS8
J6Kih1+U6lc4PouNCcHb70X2DeS4PntOIdiqfPNBCTfQjkbncq3JXmthcJdRu7OC
nvcEM8xBTHNJ13xMenWZRL3zVMb5v9d8UlsPm7TgDf9XLZayNrx3YPSRglRvCnQM
UHoHkZa/3vMKmz9hZk31vSy6Wh4QuhEqgeVoUw8WCnc9oNOntwwhTOjsP5KtlAd7
9bIgPpLFgyXU8vlwKVJYaZ7levvzIGGgIJNhG49LDFRuegUab5KhT+BPcegvdtMV
koBzaHgZSUBujKOrTNCDV3G+nbyjTw==
=UCt8
-----END PGP SIGNATURE-----

--YSEnFLCeyQGawA2l--
