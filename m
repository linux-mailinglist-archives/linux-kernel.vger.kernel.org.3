Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B9535DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiE0J5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350708AbiE0J5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:57:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D0C338B0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:57:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nuWiX-00035H-D2; Fri, 27 May 2022 11:57:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nuWiX-004qKc-Oe; Fri, 27 May 2022 11:57:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nuWiV-00CRDZ-B9; Fri, 27 May 2022 11:57:11 +0200
Date:   Fri, 27 May 2022 11:57:11 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: mxc-nand: Drop undocumented properties
 from example
Message-ID: <20220527095711.j42sxprwddrieczz@pengutronix.de>
References: <20220525205947.2487165-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="omrohr6kiqycho6o"
Content-Disposition: inline
In-Reply-To: <20220525205947.2487165-1-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--omrohr6kiqycho6o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 25, 2022 at 03:59:46PM -0500, Rob Herring wrote:
> With unevaluatedProperties issues fixed, 'nand-bus-width' and
> 'nand-ecc-mode' are flagged as undocumented. Removing them from the examp=
le
> is the easiest solution to silence the warnings.

It's not clear to me, what has to be done to see this warning. Can you
tell me how to reproduce?

My current WIP patch is:

diff --git a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml b/Document=
ation/devicetree/bindings/mtd/mxc-nand.yaml
index 73b86f2226c7..6e3e346e4448 100644
--- a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
@@ -14,7 +14,18 @@ allOf:
=20
 properties:
   compatible:
-    const: fsl,imx27-nand
+    oneOf:
+      - const: fsl,imx21-nand
+      - const: fsl,imx25-nand
+      - const: fsl,imx27-nand
+      - items:
+          - const: fsl,imx31-nand
+          - const: fsl,imx27-nand
+      - items:
+          - const: fsl,imx35-nand
+          - const: fsl,imx27-nand
+      - const: fsl,imx51-nand
+      - const: fsl,imx53-nand
=20
   reg:
     maxItems: 1

which I think is right, but obviously doesn't fix the problem you
pointed out :-)

> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> These properties may be deprecated, but they are still widely used in
> bindings. They either need to be documented (and marked deprecated) or
> removed from current users (i.e. dts files).

Or documented and not marked deprecated?

Best regards
Uwe

> diff --git a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml b/Docume=
ntation/devicetree/bindings/mtd/mxc-nand.yaml
> index 73b86f2226c7..66da1b476ab7 100644
> --- a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
> @@ -37,6 +37,4 @@ examples:
>          compatible =3D "fsl,imx27-nand";
>          reg =3D <0xd8000000 0x1000>;
>          interrupts =3D <29>;
> -        nand-bus-width =3D <8>;
> -        nand-ecc-mode =3D "hw";
>      };

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--omrohr6kiqycho6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKQoHQACgkQwfwUeK3K
7AkfaAf/d1/EwccFh9yzkjPgHa2JzORRKDOHp9H8fuN2pO27GoFz8n3VowuV44pV
puzHKJyJxB9ZSPHLZpF7x306KGtBflg+Ttr7pgeRqrbE0LjwkCR5k+XzsrnDtboB
R8FxWnbaVYZToIkrNNWkTw1bvgjJ3uwwE3YDFEOXEZQZniZDh2KYDNJNNBs0fwrq
ZR751ZEXpTadOVlaKnjsUqAtiB2Ln0R4SnzBBOm7QkablUP6NpcumYWcOpahKQH2
Zox77WJaKqQSo226qvYEIxETljtPiqTA+KT83jxslUFnMAtHsEycbN7ZsZfuFdJn
VsMPz94QDd/Hy7UQxnV/y5xOzH1Aow==
=ndui
-----END PGP SIGNATURE-----

--omrohr6kiqycho6o--
