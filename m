Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF64F76F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiDGHPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbiDGHPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:15:20 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A872B338A5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=KYVIiPsHXkPVttQVbnB4gKCdS6tz
        CKwJJNpKki0Y3II=; b=KBoMUmGflb76llgWx2YOmjleJvRd6bMYtnkEU86tT+MS
        g02jsfBeif5eGYpVZBrhtY5yoXT1v3gyscuF+ld8czn5ZyH1Jy5neA+QJ+ZNNs/z
        VTn06iY58b/SPXhKCDR+iy33yL+UFqNMVmouoz6Uwhqe0wT0LVrsM4vjyIiyHFU=
Received: (qmail 3054826 invoked from network); 7 Apr 2022 09:13:19 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Apr 2022 09:13:19 +0200
X-UD-Smtp-Session: l3s3148p1@e/NoNgvcsKIgAQnoAEUrAEwALhsXf+iu
Date:   Thu, 7 Apr 2022 09:13:19 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 1/2] mmc: renesas_sdhi: Jump to error path instead of
 returning directly
Message-ID: <Yk6PD/aHJMfTlcjv@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
References: <20220404172322.32578-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220404172322.32578-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922182F6302386EFF2ED66B86E59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8tdkw8-dUfrFG9kZizok8OQdcGHitAdb4E2tsBW3Xrh-g@mail.gmail.com>
 <OS0PR01MB5922C35E8C5259C3DA2A951A86E59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KlpHw6Ilg+eDooaV"
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922C35E8C5259C3DA2A951A86E59@OS0PR01MB5922.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KlpHw6Ilg+eDooaV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I guess it has to move up, first get reset handle and clock handle and re=
turn error
> directly in case of error, Then do clk/reset ops.=20
>=20
> >=20
> > Wolfram, what is your preference on the above?

Yes, moving up makes sense. First check all the handles before we
actually initialize the hardware.

Thanks for pointing all this out.


--KlpHw6Ilg+eDooaV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJOjw4ACgkQFA3kzBSg
KbbgRA//Yc9LB9Ne9jCn3411sIjDRaF53/Sg3d1Fvuhv1t0bBfKkuqYRWKuBhSNP
yDEkPAxQmP8wgbhY2PHjZPyGchfT02OC/PFPzE9hXp99DrhwRkb3Em2c6a6Jsbqp
LPP9x/lzhuMpRJ2K0jFAmPO7p01eIJKHrBLek49z5kgpE7tZktd4uB96E0K1wIxB
8duH4nZZi9x67cSPS2q/JW6J6fz/+yrTiLqLzeLvE9q2ZaTxzga1SOCraW1yJGwx
oHtO/Vznmix+zlQ2hTfD1yBUaFwVZQe8pNt94ujOVH3qWMqbzbPrFXp0YvziwN/t
YFVDu9lGWtDqz8BM0xwd+/0HeHuwcXw42uQihnoONjbl9giteCrVnyxaL4UfZP7x
JKm0+10hEy0VGluMS0eHh4RkE8lLTK++e4pzaRMhy71xBu/FNR+YR2KVZLMi+Y7s
IDdvyJZ4kGlZ9KismDR41laKB+xm6QUL89MY+lbOuDKlzGdd7HSnUBJXGbNKHL4v
cKtoYHPqa3SrSqnpj/So1dVEuoHWledG4IUoYgCytmhDjxEZz1bu10jBtvwcwmHh
SXHyCs5g4vz7oZvdx1QpJL1SB+IwY6yIJfBfvfTu8dJ6bMQ65FWAsATdlkdxRRGP
4fJkmISLnig5fcWz88CGLS/0WhAoNe4qz8dSNKMZEhRqfjk+Ir8=
=nuoX
-----END PGP SIGNATURE-----

--KlpHw6Ilg+eDooaV--
