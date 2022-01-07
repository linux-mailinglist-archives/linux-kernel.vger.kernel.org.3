Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9EF487835
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347553AbiAGN1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:27:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49740 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbiAGN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:27:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 932EB6104A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B238C36AE0;
        Fri,  7 Jan 2022 13:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641562041;
        bh=vsjEEVdEu3j94SDiQtTHlnokuvTNBttfoof2rV1ZBcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9r/TwwgA6YQkPZh05urxxpu6SRf86kT0wnLUBL+vniMyrEepF3Tj1XyQbXZ8WA2Y
         yCzZ2riTbyPYAaennJVbyc6ex9yOrKC4nJrgMIHJgl6t7gKTE4XHIJRpnh9iO3juS2
         Iye2qonYgAxSf+xf8RVOs13eSf2QRUyCsT+zGZPw7ykiqnY3e4HpemOZhjuWmIx1kI
         vtebshHCsuzyWjrPb29L5ALl4pNVYpKWQuwX8MBpc4eF1PkV9xMcUobg12WvUbYNw9
         1k2BdXTgVIgUbkic/N49kYmDBdqCpIRM/5ZpmZluF9eAwHQh3ojAKrqqdO8JhEsfXt
         tZHxSn7pNxCUg==
Date:   Fri, 7 Jan 2022 13:27:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] regmap: debugfs: Free debugfs_name buffer after usage
Message-ID: <Ydg/tOqbeT1Cg6sh@sirena.org.uk>
References: <20220106175019.3116389-1-festevam@gmail.com>
 <Ydc2EHf5f12w4YcW@sirena.org.uk>
 <CAOMZO5Czbr=vuvZdqc6+odAQv0M-LJEQVz6uke8OXnoG6wLqwA@mail.gmail.com>
 <YddLe8cCvj5fVBTQ@sirena.org.uk>
 <CAOMZO5B63zHEiZc-Z1AR8za6eWXX8y0wbYLmrVkXC85ewFSqbg@mail.gmail.com>
 <CAOMZO5DQEEHYJHv08nC=uYXbFtL9VTAatNAB8V5D_JHiQ0q=3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XeHraxJsdrYekgPA"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DQEEHYJHv08nC=uYXbFtL9VTAatNAB8V5D_JHiQ0q=3A@mail.gmail.com>
X-Cookie: teamwork, n.:
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XeHraxJsdrYekgPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 06, 2022 at 11:22:32PM -0300, Fabio Estevam wrote:
> On Thu, Jan 6, 2022 at 6:13 PM Fabio Estevam <festevam@gmail.com> wrote:

> > > Before we try to reinitialise debugfs for the new name seems like the
> > > obvious place.

> > I am afraid I am not enough familiar with regmap to fix this problem.

> > If you could please submit a patch, I will be glad to test it.

> I tried this change:
> @@ -581,6 +581,8 @@ void regmap_debugfs_init(struct regmap *map)
>         if (map->dev)
>                 devname =3D dev_name(map->dev);
>=20
> +       regmap_debugfs_exit(map);
> +

I would have expected this to be prior to the call to _init() rather
than actually in the call to _init() but OTOH this should work fine so
meh.

> It does avoid the 'already present' error and I see that
> /sys/kernel/debug/regmap/20e0000.pinctrl-gpr
> is present, but /sys/kernel/debug/regmap/20e0000.pinctrl-gpr is not.
> Not sure if this is the desired behavior.

Yes, that's what we're looking for (assuming the second of those names
should be the dummy name) - that means that the old debugfs file is not
hanging around and so won't be stuck there pointing at a deallocated
regmap if the regmap gets freed for some reason.

--XeHraxJsdrYekgPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHYP7QACgkQJNaLcl1U
h9B6QAf+Pu9sgnPjvMTqPr93bsPjx801W6G2LFl8hbxDWnhHlpHj6MdR/Ga4lACm
L+PuveFulBlxOARMfXPAiPXkOJZAMgc5k+pMuP5/T8u9k/GBRoDS8veb29X9cT7C
ufvIj2ry2OR+VwG5JSjXNge9+XRSvYUA8foAfLzN7u6vRFxr29so1PGNp69gWMAw
NQKxnioC7jDDKrJDEfwtMm1V7PqbQrZ3enZUyfoRvFnvIKNpFMowrTbX61kYcIBQ
7jqGkPLd4fVAsX0L5JT0Q3uLdwPQ/OwGdOHh75wDabTnGB77jUQlkqTmc0xBKpE4
trLp26irYjPaBzDSUa4cMnNUBePwFg==
=5rms
-----END PGP SIGNATURE-----

--XeHraxJsdrYekgPA--
