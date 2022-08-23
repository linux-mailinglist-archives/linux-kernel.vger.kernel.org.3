Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E7F59EC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiHWTeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiHWTeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:34:16 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA648138795;
        Tue, 23 Aug 2022 11:28:00 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7FBBC1C0005; Tue, 23 Aug 2022 20:27:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1661279277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yklnFjZgD43o0mSrBqTG5ikYsePHVB8TnZYM1NtY/cU=;
        b=hb2AzFqYFN9CE4hRDZadbcwtd03KTFOkWhK1CwPavMIu123Qk2cgbwtz3QtillQFoSDNVl
        UXav3t14w6KFqvL31aIkKwRdzaRadPwL6GWlsqMwZctRYFuGgjEE9Qi2zWorAFGtCL1WNI
        nbnYOVCtDrEtEje3YW5vgzbDDX+jqKY=
Date:   Tue, 23 Aug 2022 20:27:57 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Nikita Travkin <nikitos.tr@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Yi Xin <Yixin.zhu@intel.com>,
        Mallikarjuna reddy <mallikarjunax.reddy@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        - NeilBrown <neilb@suse.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <20220823182756.GA13402@duo.ucw.cz>
References: <20220823145649.3118479-13-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20220823145649.3118479-13-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch does way more than that:

Can we get some explanation why that's correct?

Best regards,
								Pavel

> index f8d7963c3a13..8b3b3bf1eaf2 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lgm.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-lgm.yaml
> @@ -56,7 +56,8 @@ properties:
> =20
>      patternProperties:
>        "^led@[0-2]$":
> -        type: object
> +        $ref: common.yaml#
> +        unevaluatedProperties: false
> =20
>          properties:
>            reg:
> @@ -64,6 +65,9 @@ properties:
>              minimum: 0
>              maximum: 2
> =20
> +          led-gpios:
> +            maxItems: 1
> +
>            intel,sso-hw-trigger:
>              type: boolean
>              description: This property indicates Hardware driven/control=
 LED.
> @@ -118,14 +122,14 @@ examples:
>            reg =3D <0>;
>            function =3D "gphy";
>            color =3D <LED_COLOR_ID_GREEN>;
> -          led-gpio =3D <&ssogpio 0 0>;
> +          led-gpios =3D <&ssogpio 0 0>;
>          };
> =20
>          led@2 {
>            reg =3D <2>;
>            function =3D LED_FUNCTION_POWER;
>            color =3D <LED_COLOR_ID_GREEN>;
> -          led-gpio =3D <&ssogpio 23 0>;
> +          led-gpios =3D <&ssogpio 23 0>;
>          };
>        };
>      };

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYwUcLAAKCRAw5/Bqldv6
8ky9AJ9P4Ex4545/zifOiwMeA2XQFpMf8ACfZljZ6R8cY/VTkyid1n336KObjaQ=
=zYWp
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
