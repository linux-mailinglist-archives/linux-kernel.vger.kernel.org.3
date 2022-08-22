Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E2559C8F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 21:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiHVTdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 15:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239494AbiHVTbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 15:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2391F1D330;
        Mon, 22 Aug 2022 12:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3B5760BC5;
        Mon, 22 Aug 2022 19:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD7CC433C1;
        Mon, 22 Aug 2022 19:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661196573;
        bh=EUirQLLNP7hOsCjZnx2sV4TuIc9Zb4vvS+mAipxKh2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvPiSS4beKT9aG7xQ8zSwQTtIFHPhjUQt4piTXo/fIWLTvu17nhdOvsq+ZeYJe9Te
         7OI0SqqDR3B8cyIBdujMHDWtzE01y5K2LdVq3GnNtXbiiiuIO+XRDOH5d4R4ZI+46R
         lYsH/D9Nmnbegl1CTYfDJqS+NBHiWY4KGNgPRWi/nZDapM1y0XQU3b6BJw77j+6Tp6
         gvDRnzKaFNxJl8Zi+nT7V74OxALy5+Ias1HxWaK6yqn2K2fLoZPryeiDISS/Rdpdig
         Mnd6rjmC1yikw8eljMhFKVg8u8wZLVCpRg28w1PTtseAxldYuGbigqjFpgfTBlDAVh
         KwoaQjcFYtziQ==
Date:   Mon, 22 Aug 2022 20:29:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Message-ID: <YwPZF6fjZkn2tozH@sirena.org.uk>
References: <cover.1646060734.git.christophe.leroy@csgroup.eu>
 <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
 <YhzqbYW1q5bPNWXn@sirena.org.uk>
 <7afaab3d-50e0-4716-18d4-41eabc2a9cb9@csgroup.eu>
 <Yhz0/1kiAy7Mlgtv@sirena.org.uk>
 <f9046e68-ff22-2652-48dc-d277b4af75dd@csgroup.eu>
 <YwO5l/KpXoKJVawq@sirena.org.uk>
 <c4950a61-ba9a-5897-1f04-bb2c56979d7d@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WLYBq0WlMGbH0CuE"
Content-Disposition: inline
In-Reply-To: <c4950a61-ba9a-5897-1f04-bb2c56979d7d@csgroup.eu>
X-Cookie: Do not write in this space.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WLYBq0WlMGbH0CuE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2022 at 06:38:22PM +0000, Christophe Leroy wrote:
> Le 22/08/2022 =E0 19:15, Mark Brown a =E9crit=A0:

> I think we already addressed this possibility back in 2016, see=20
> https://lore.kernel.org/linux-spi/20160824111206.GD22076@sirena.org.uk/

> The conclusion was that it was not possible to accomplish it with cs_chan=
ge.

> Or did we miss something at that time ?

No, I think that's fine - your proposal has some overlap but is fine.

--WLYBq0WlMGbH0CuE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMD2RcACgkQJNaLcl1U
h9BpjAgAgbRxXDYgdu9wb/vJghve0BVH9SPSVadgMxYQGWp/LeFlTbnpbFIM+53F
04wyp3cbGJFllREDxptRBug9rySiuAsRtHD+CkEqz7ztgR8h8qxwjuUDmdjGyaYO
Bw8Luc+BYePG940V3niAE1zza9E15MdDKOpKtcCYxaEzL7WENT98fF1FILjRqAqM
PpRYeDMAmTUyLUmmSnVNHUtYLIhTfahDtI/Zn2mYpZ2OQ0YHv+BP3+yhcWZGsJ0P
2XuYxkl61A42nU3TysJoVEkqd0Xjx2iEFAt2g4L8xyydz1RH1WIHOE2sYgrCWQs9
wiy6bp2p2KbV8Jjt2os2Vpm7eLAYtQ==
=vpgG
-----END PGP SIGNATURE-----

--WLYBq0WlMGbH0CuE--
