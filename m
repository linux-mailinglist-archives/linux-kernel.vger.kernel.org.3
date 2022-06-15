Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FA754D168
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350133AbiFOTMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345414AbiFOTMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:12:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAEC65E3;
        Wed, 15 Jun 2022 12:12:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A88760BAF;
        Wed, 15 Jun 2022 19:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3635C34115;
        Wed, 15 Jun 2022 19:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655320355;
        bh=aBOcucEGYvvvWUKMiG7ck3GFTJH/y+rjo3oRAZKefCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L3qN7bWAFQSKXjkYhc9TwspKC2crGuSj7nyK7rS9UK1FSHsdpgcIogd/ldeF9WXP0
         0KQuUQB2krRWqicXjNKySrPbr9t+einpWC6Tqmb+IOLPXNp1cphF1eXAUiXdrbZDhG
         pbL3HAmeqwMKoCe2WtSkfeUGfHFCqgoGbmKDjtlLyFqPQd6j9li2KYRPKGFlixyW37
         LB8W56550jbrJnJH0+tXAWw+0xDH6ToBnw2WmjQEY70bvhRoe9HCL2V3jxORBWnEy3
         okXzIdOXzKzFXiBg5yWMUVNRoufipEpnCTPBI/vlVVM114mRep+SDp6D1miBbqxqn6
         TijqHGg7j1xsA==
Date:   Wed, 15 Jun 2022 20:12:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "max.oss.09@gmail.com" <max.oss.09@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "khilman@kernel.org" <khilman@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>
Subject: Re: [PATCH v1 0/5] power: domain: Add driver for a PM domain
 provider which controls
Message-ID: <YqovGo+ozPMeUERo@sirena.org.uk>
References: <20220609150851.23084-1-max.oss.09@gmail.com>
 <20220613191549.GA4092455-robh@kernel.org>
 <CAMuHMdU+aOw_D3SR6714U_i5WhE8S-FCLdPJaf_+Fncz4aH8VA@mail.gmail.com>
 <CAEHkU3VVM0zUsaKMUGeSzfbLmVJW6rqXGLv7TqaLTEQeXEVkUA@mail.gmail.com>
 <12e3bb72-af2d-653f-b342-c6b4d6a1f292@linaro.org>
 <ddbeba186bf662348e8594f322f750cf89326a66.camel@toradex.com>
 <dacd4a2d-a2b9-d2c2-4d47-f030dd01ee25@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zB2UHw7muFO3meeO"
Content-Disposition: inline
In-Reply-To: <dacd4a2d-a2b9-d2c2-4d47-f030dd01ee25@arm.com>
X-Cookie: byob, v:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zB2UHw7muFO3meeO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2022 at 07:24:50PM +0100, Robin Murphy wrote:

> Multiple consumers sharing a voltage rail provided by a single regulator =
is
> so standard and well-supported that it barely seems worth pointing out, b=
ut
> for the avoidance of doubt I shall. Adding a new non-standard way to hide=
 a
> specific subset of regulator functionality behind behind a magic driver
> because it seems like slightly less work than handling it the well-known
> established way sounds like a great recipe for technical debt and future
> compatibility headaches. What if down the line you end up with a situation
> where if device A is suspended, devices B and C are happy to save some po=
wer
> by running the "domain" at a lower voltage? Do we stubbornly start
> duplicating more of the regulator framework in the magic power domain
> driver, or is that the point where we have to switch all the consumers to
> explicit supplies, and get to regret having "saved" that effort in the fi=
rst
> place...

We also loose the runtime validation that the supplies being described
in the DT correspond to the hardware in any meaningful way which would
also make it harder to transition to explicit control of the supplies
further down the line. =20

--zB2UHw7muFO3meeO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKqLxkACgkQJNaLcl1U
h9A8oQf/Qy+hNv0kHNOoFGSq8IZn9KhUnfZ1urDwa0BVgVd9o3gGVjfyGo2DRi4w
C1+ssj8EA61LDsquEBRULVokHyU9usYmXKfRJRHweArlWyZvbxoHvRfgk+kjCBhZ
A/VYrv2LvZHpYzrAVeviYllJs+ZGCq2Y1wMw8cFP558j8z2o5tEAFMdbpJRJvPNy
WeFvgrixx2yNQr0VgkCWr/RJ+vCY+80hgrhEWvJj6wEtIpGRqgoYbDw6LM9EU4Gu
hmSPorQNZbFBVQ8Dk597Ffq90RK8Y9axZGn1FvqXx07s2CYdS/wn1QiZLWdrLOf8
vpJIHU0pSsKo+plFfCiboC9PItlMLw==
=ratS
-----END PGP SIGNATURE-----

--zB2UHw7muFO3meeO--
