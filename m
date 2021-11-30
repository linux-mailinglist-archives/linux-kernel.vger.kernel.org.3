Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FEA463515
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhK3NJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:09:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51150 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhK3NJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:09:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3860EB817AB;
        Tue, 30 Nov 2021 13:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E948BC53FC7;
        Tue, 30 Nov 2021 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638277561;
        bh=4Kk+iPJ9utmQ+No40KEp/M1GCd0HkU5mgNmfY3Ue3fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rX7nGVJBReMQH+ADECiLFvL9rGq8ZfBxRay4EgBHKZ1UMVR6r3mVVvLgY0S6hnhpq
         a8H4etxGPgJOaWLoBfyhJ+b/3BNEOZPItzePUutGVFz0aph5rekDKr3CQKvgi7fHRt
         D3+jPo7MOuLuFWP1jopsi7UCibTD3yL3kBngDQlYKYDDz3U2Ldj/wqzNmbJkNckvCY
         nV1cw0IxW7JVzRrugHRn57OscU+VOKUiJcDeERLbjB9ofyipYR7jVL9J5W8eXOZc0z
         099Xv3UmAgLHzhLXdK8TgTAPg9RgbCeM+zTVyIdtt4TFFcZVa7i2w3+AnyrRuJ8H8J
         TWDHgxXw7mPjg==
Date:   Tue, 30 Nov 2021 13:05:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: tegra210-quad: add acpi support
Message-ID: <YaYhtFnHlZob9s0J@sirena.org.uk>
References: <1637834152-32093-1-git-send-email-kyarlagadda@nvidia.com>
 <1637834152-32093-2-git-send-email-kyarlagadda@nvidia.com>
 <YZ+ImY1LrvB5a5iF@sirena.org.uk>
 <BN6PR12MB124973BF5CBB4AB35CC59B8AC3669@BN6PR12MB1249.namprd12.prod.outlook.com>
 <YaTHKuohUNt/hVLq@sirena.org.uk>
 <BN6PR12MB124927C4F4FAF53B59C2A23CC3679@BN6PR12MB1249.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MHPCoeCF66a+8rsk"
Content-Disposition: inline
In-Reply-To: <BN6PR12MB124927C4F4FAF53B59C2A23CC3679@BN6PR12MB1249.namprd12.prod.outlook.com>
X-Cookie: Check your local listings.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MHPCoeCF66a+8rsk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 30, 2021 at 01:50:07AM +0000, Krishna Yarlagadda wrote:

> > That said frankly I'd expect this handling of ACPI reset to be pushed into the
> > reset code, it's obviously not good to be open coding this in drivers when this
> > looks like it's completely generic to any ACPI object so shouldn't be being
> > open coded in individual driers especially with the ifdefery.  Shouldn't the
> > reset API be able to figure out that an object with _RST has a reset control
> > and provide access to it through the reset API?

> Common reset apis are not handling _RST. Each driver is implementing
> _RST method in ACPI and calling from drivers.

I can see that.  What I'm saying is that this seems bad and we should
instead be implementing this in common code.

--MHPCoeCF66a+8rsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGmIbQACgkQJNaLcl1U
h9CEiAf8CRl+6hMD+/ZKTgrUelUBql3J4AbFnksldvj6F6pz5SuZ0JlM0injXeAl
s61rifuDIJsbC37ovaG3We84Cm2a7KiCtR8itIw/oLZQWDVfUNdNaN00zc7sNCPJ
MnHlielK85ddMbXCYOInOM+LLI8RhuwIH/a2cOfLzWWuumze06hVSCiGuYyV53Pu
ATrbWKy+keX4pciAZDFfpS+VkNvJ9tsmrmEabkH1PXjMfc2jKqgT5GnuHs/udSk9
DxZ7Si3T1hLPdb3Ev/z4xiFP/w+4iIE+t0S6IUZx790SoPilV1QIeFjfM3L+dIq+
710m8ULFLcxUNBs6G3Ut/B5TAO+ArA==
=0vRn
-----END PGP SIGNATURE-----

--MHPCoeCF66a+8rsk--
