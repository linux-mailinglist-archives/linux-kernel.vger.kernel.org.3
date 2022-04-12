Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5BA4FDD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiDLKu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356784AbiDLKpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:45:40 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE38185669
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=/gXUO03nZs5ebrOzcOsVdIdl53Fr
        WrU9ROXrk54ZXmQ=; b=y8fK2ZqQ0qZhKrAAy0b8yau0wzvfPfhqtXNe8mTnTQlp
        +Q4R/TpV+XThrTJMk3fWmqRRo+d8qI08xvc2HvMQoszleAmz8KC9kEXPBfCR7lwZ
        JkwYJT+J9z2hDI7kFNQ2TqbXgXQ3EYCfAYNmRNY3VnLWfiY0YF6fUgguF5SQSow=
Received: (qmail 985089 invoked from network); 12 Apr 2022 11:42:11 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 12 Apr 2022 11:42:11 +0200
X-UD-Smtp-Session: l3s3148p1@aYgJ4HHcCucgAQnoAGZ4AFi7qjeMIP6q
Date:   Tue, 12 Apr 2022 11:42:11 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: renesas-rpc-if: Simplify single/double data
 register access
Message-ID: <YlVJc3z1xXT2emIc@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        linux-renesas-soc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <19358863deae03b1b26f473e878305a1c6e40d19.1649681638.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OELpkJhUqDCsaz5D"
Content-Disposition: inline
In-Reply-To: <19358863deae03b1b26f473e878305a1c6e40d19.1649681638.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OELpkJhUqDCsaz5D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2022 at 02:55:29PM +0200, Geert Uytterhoeven wrote:
> For manual write and read, factor out the common access to the first
> data register by keeping track of the current data pointer.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Works fine with reading/writing on a V3U, so:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I agree the code is more concise. I am not sure, though, if it is really
more readable. But I don't mind very much, so except for a small nit:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> +			if (nbytes =3D=3D 8)
> +				regmap_write(rpc->regmap, RPCIF_SMWDR1, *p++);
> +			regmap_write(rpc->regmap, RPCIF_SMWDR0, *p++);

Last '++' can be omitted?


--OELpkJhUqDCsaz5D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJVSW8ACgkQFA3kzBSg
KbYcQw//didRmuvAcnLljb4mtQ3VPVMZBcqWDjRgDKtOO8dvvB1ikHVUDTCWDQbS
++a0GC/UfJ9vlC+1Q7Qi6+QeRfA9UEE7BWjGpleY25NNW+BHqAidlG8vYQYQRW8v
axaCY+ifH5k4ui1j3w0peVy2HZp4ruVROEKhOSZP06gHGIg+rTG27ZUPW1/koKd8
4uvyZxaFkv6eqsWUOp7wy3SYBv6lwaNl111u6DdmxMRW/iSYlC220HQKmDFlIr94
aNcHTOjFHyuP3RqNoxqPTKEilUKnaM6Brvu9f2RxThL6qt+Mks6AvkMwvbYxnzan
7X7PWhj8NNiW0BxmoCPgqAp6GMSq0saZr4zO7cXeEa5Kxf5gyb2u+qM+V1bK+WpK
Io4RgYLSss3zONMx8dB4EApzBHga1pk0Z7bssK23GrMHhq52w40ntbLhpg0Ep7PS
NEQ2HhyGi43iH3/hufjAbX+tkmeRmUjrPC4xEA9QGGDyMVoVx379KmYhXQjixAar
B6b675RYUQ7zFZ5bd3sgZaTTsOlhEq7a5tdzesC7b1w2dPTFGXnBeRg8IniSsP/R
rsZFmvPEVb39UlvqoEoKgjDI+EJqfVVo5RhacONnCVYAuyN8oJn2ObtOoe31Y8rn
Lg6exmSkJlMZsFnHzG1GBjOtUtXzk8cyuVSN1Vzv6SR30EfnoS8=
=Kp1i
-----END PGP SIGNATURE-----

--OELpkJhUqDCsaz5D--
