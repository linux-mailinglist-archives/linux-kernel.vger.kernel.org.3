Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A39486ADD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 21:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243549AbiAFUFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 15:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiAFUFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 15:05:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B368C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 12:05:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 578D5B82374
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 20:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5D3C36AE3;
        Thu,  6 Jan 2022 20:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641499520;
        bh=bJerYigQ9mJ4v8UePSEWT2XKDjzSacNuUl+qXV6qQgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ME7YiTKTuTrRuoHeBambD1mrAKdTQbbMyrSFk55Wa+61/0jOQB1pE/bk0ne20jdKw
         CQpohYQfvW6Q5IrBNPvIYxnBiBnCIvZ9IDsYisFCeNiCd8WnxUUFbB+4soQR6P9TbL
         vJSkEbuWnbZt3AoMxKB0gJf/NZszdGID34O9sg6n/uCRngWKdmvmNrpgcb+JDuOkOy
         yau6RqLmeNzdQHUWg/PwhcLdK41dVc3CSiBAPABR78oLySYkCgm5tU7KE+xs8i0xbt
         02NFFyPBj9IaxcR3jNROsMbTlLeTnpNhsxdl3nT3+P40X+BdLeT4zmbS4xUNgiAT1/
         J48xNgfq+SAzA==
Date:   Thu, 6 Jan 2022 20:05:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] regmap: debugfs: Free debugfs_name buffer after usage
Message-ID: <YddLe8cCvj5fVBTQ@sirena.org.uk>
References: <20220106175019.3116389-1-festevam@gmail.com>
 <Ydc2EHf5f12w4YcW@sirena.org.uk>
 <CAOMZO5Czbr=vuvZdqc6+odAQv0M-LJEQVz6uke8OXnoG6wLqwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RVSDFDYmBYl7Sb1s"
Content-Disposition: inline
In-Reply-To: <CAOMZO5Czbr=vuvZdqc6+odAQv0M-LJEQVz6uke8OXnoG6wLqwA@mail.gmail.com>
X-Cookie: I think we're in trouble.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RVSDFDYmBYl7Sb1s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 06, 2022 at 04:27:32PM -0300, Fabio Estevam wrote:
> On Thu, Jan 6, 2022 at 3:33 PM Mark Brown <broonie@kernel.org> wrote:

> > OK, but what's the logic here?  The name is getting thrown away here but

> I did more debugging and this is what I found:
> The 'debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent
> 'regmap' already present!' message
> happens since commit cffa4b2122f5 ("regmap: debugfs: Fix a memory leak
> when calling regmap_attach_dev").

Sure, but that just means that the bug with not cleaning up the
directory predates that. =20

> # mount -t debugfs none /sys/kernel/debug/
> # cat /sys/kernel/debug/regmap/dummy-iomuxc-gpr@20e0000/registers
> 00: 00000000
> 04: 48611005

What happens if the underlying regmap gets freed for some reason?  It
now only remembers the new name, not this old one, so it'll only know to
clean up the old name.

> As shown above, I don't see the '
> /sys/kernel/debug/regmap/20e0000.pinctrl-gpr' directory being created,
> so there is nothing to clean.

Creating that file is the behaviour you are demanding...

> Where exactly would you like me to call regmap_debugfs_exit()?

Before we try to reinitialise debugfs for the new name seems like the
obvious place.

--RVSDFDYmBYl7Sb1s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHXS3oACgkQJNaLcl1U
h9ATYwf8Db5lDzaIwmKNmkTn+zVQcLSBvpx1f2AJ42sMfHLnFshQ2kx+faUvMERf
NxQOFW00YOzpwh38myBV9ljQKTyzHQGuO4c5d5EuUIJePwZmMlXuMUofsbvRCU6+
9LsmtEVpAfXt0PR1UYLe72DucQz+k0iA6Amo856z0qCiFJOELosNZN5oqEFnQ6q0
7IBEKleQNka/Ke8orAA224i5RCuE5NHJ/WuWSzyo9fJu+Nsp+wLFuKnCQAGo802Z
i94dnkNj0FgUCtJWHgS0Mtk7JTy38rbGwgGTelwGdX74XDi81QwUUHTfs2oYvWbY
k1DbV0ECg4D+K2cwEu69D6mHqYswxw==
=FmYQ
-----END PGP SIGNATURE-----

--RVSDFDYmBYl7Sb1s--
