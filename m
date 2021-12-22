Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF3847D40C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343638AbhLVO7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343659AbhLVO7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:59:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91021C061574;
        Wed, 22 Dec 2021 06:59:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39BC761AEF;
        Wed, 22 Dec 2021 14:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DBBC36AE8;
        Wed, 22 Dec 2021 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640185174;
        bh=vCnQR+VhWGP/oq1VpBT5c/Gf1g+52375THRgDt52HI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s87AsxSviFqP4w4PKBnDXj2GKaNXUXmKFFD6QY+HcwbjtfnkSECT6y3kZM03F38cQ
         eWyBZgYdigQPgdHrKqlgvaSgb43cXrytr9pAgzM7x4+BsVeww9jtQfJpOGnZMyTmxA
         VQfuxz2eg7Wm9gJzbJIFqSO/HRsO+kWjRuADlyPzQbWNCW4nFgSEE6ob1rD7/ND+gD
         p7w+ZmRs2u6muF4dPtQI4kcMq65sHKD/OK89mjfYSkCGmNRTuEh9DIr3VF7vFQuNHJ
         GZc1gfQdIQGO1vt/4kKMOQuKeshPdfOFVN7xqXid4vRDWMMIiH3+Plispcjh9m830b
         6xT3tecMRLWjQ==
Date:   Wed, 22 Dec 2021 14:59:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Oskari =?iso-8859-1?Q?Lemmel=E4?= <oskari@lemmela.net>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: ar934x: fix transfer size
Message-ID: <YcM9Ug3JhaxynLt0@sirena.org.uk>
References: <20211222055958.1383233-1-oskari@lemmela.net>
 <20211222055958.1383233-2-oskari@lemmela.net>
 <YcMa1TIg3x3oBKBl@sirena.org.uk>
 <98a574a2-45c3-5d7c-6405-0cd279a81816@lemmela.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zTjvtHddp2R5PWDu"
Content-Disposition: inline
In-Reply-To: <98a574a2-45c3-5d7c-6405-0cd279a81816@lemmela.net>
X-Cookie: Weekend, where are you?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zTjvtHddp2R5PWDu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 22, 2021 at 04:27:36PM +0200, Oskari Lemmel=E4 wrote:
> On 22.12.2021 14.32, Mark Brown wrote:

> > Does this actually materially affect what the hardware does?  How much
> > data is transferred in an internal loop in the driver is completely
> > immaterial, bits per word only matters for formatting of the transferred
> > data.

> I don't have logic analyzator to verify what hardware actual does.
> I tested this with transferring 32bits to ATSAMD20J15 slave.
> Running loop in 8bits or 16bits, transfer is done correctly without
> any errors. When running loop in 24bits or 32bits directly I got
> error from spi_sync_transfer.

This doesn't inspire confidence TBH.  Given the lack of any change in
the interaction with the hardware it doesn't seem likely that the word
length is being changed at any point.  Possibly there's a bug somewhere
that needs fixing but it's been misdiagnosed.

Note also that the commit log is not good here, now I look at the code
the driver only supports 8 bits per word at the minute and the change
adds support for higher word lengths.  If you are seeing an issue that
might point towards what it is.

--zTjvtHddp2R5PWDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHDPVEACgkQJNaLcl1U
h9Ah9gf+Lm0wPKvrwj0LPu4zRr+b4A2CLlpCl+wmfy/rCUTf3aesyWfRAAhIhFN8
AX5YWiinPuRcGvpdWeornL64++BSGulLwAXTFukpGAXDBjDNtpuxh3G2UluJkHBR
L8hXEo02iN3M8ZZmmSL1ND6V8CA3Ldq3KVVPx8WuoTmuuuRA293fzHdigVk4Ge8g
FbDOgwBKdbnucEWi2IcRqz/raJL9aGk7+lQP+w5g6mxjrnekQrGiGV2h5Jlwpy8i
6cVWzIwkhPvglFpHQ3C7VO1jWj+MrifUMO2k/KSJm3o3+NjG2nG/0suTdMmXi/3x
z0MvhKft2kO1jwH2BDZ4QW+yv+ggEA==
=zHa7
-----END PGP SIGNATURE-----

--zTjvtHddp2R5PWDu--
