Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC82554BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357699AbiFVNy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiFVNyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:54:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3843933E0B;
        Wed, 22 Jun 2022 06:54:54 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r20so3113933wra.1;
        Wed, 22 Jun 2022 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lvPaRLtCTYl6sHnDh9zdd2Yepnm2QSSHxZs+bnRqTmY=;
        b=X4WJQmJnGwvBqXXiIvKubKCYTpNnmNVLJZhwQgHLHamALmAwX6ZMGK6Zl0BGTrnOo0
         xlQjbwtKSZ9LMSmAvvnSeRfOylKzJdTDCon7/CGl8b3knBRBw+yyFuHx7Kd0O2VSlPBy
         NcSIsZz1Wi2Z9qhQ3M8z4qM2xzVrqEy7Af/Y3wyrDZGFN1J5G0Y6cEyRbirb+0XFmBxj
         klEFLzyXvJoStFiyccfyKW19EQk8XPMZzfH7Z+aSxKsh9c72yVbm9qodt1Q8REP5W/Ia
         b0RfEEqYN7lOom5W019BKpn0bCZeB7NE30s9yAPHDJXHm06L71JFAptlO3cx+ouQyiKg
         Ccpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lvPaRLtCTYl6sHnDh9zdd2Yepnm2QSSHxZs+bnRqTmY=;
        b=q2ORwCNO+wCH2SGpG1s0LptZCKLiKtMDgKGXY5oSQyk5w+VjBlX76gkLQQdGUEKAs1
         8AueRniTjWUFuYdkRtwskP3jdmHY3LO5Pu4fED26u/lvBLb6aP5Q6Zjg6QCUkZPsgTpv
         pwBQ17QO9tuKJiykGzSiXbJbgGwLaDXKbMfrH5S6WVcQeXYFA4qfTkqBDaUnuJ1jMBVD
         kvDUirltR0g1HzISt/k7C7JxDnKTfMIWiMeupTS3uv0NeEPIcgGlOqH7xM8gBx6p8QBD
         avrVYuIErU9KMXkm3eg5LYHD/nVADNiZZjYoCca+i5U/QwebAYusXqf5851RW+0AsBYx
         TyHg==
X-Gm-Message-State: AJIora+gkLKuo1uowt1U6HFmxXn6pjYCUf6hhTbcNfS+KCQ4ZhKPDnhu
        dyHqOiYROkuxYGbtAmudcck=
X-Google-Smtp-Source: AGRyM1uQ4+Wn2JupuYPb4eiWdXiFXc8bCyqu6hOCrfKvthXdnok4hRxRXaf/LoxKfeBAVhrqnLQTrA==
X-Received: by 2002:a5d:64e8:0:b0:218:519e:7896 with SMTP id g8-20020a5d64e8000000b00218519e7896mr3443007wri.207.1655906092761;
        Wed, 22 Jun 2022 06:54:52 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 129-20020a1c0287000000b0039db31f6372sm3632782wmc.2.2022.06.22.06.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 06:54:51 -0700 (PDT)
Date:   Wed, 22 Jun 2022 15:54:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        andrew@lunn.ch, thomas.petazzoni@free-electrons.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 3/3] dt-bindings: gpio: gpio-mvebu: document offset
 and marvell,pwm-offset
Message-ID: <YrMfKRF+13GZvRc5@orome>
References: <20220526012946.3862776-1-chris.packham@alliedtelesis.co.nz>
 <20220526012946.3862776-4-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SkTTDVTmLy6JJbVk"
Content-Disposition: inline
In-Reply-To: <20220526012946.3862776-4-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SkTTDVTmLy6JJbVk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 26, 2022 at 01:29:46PM +1200, Chris Packham wrote:
> The offset and marvell,pwm-offset properties weren't in the old binding.
> Add them based on the existing usage in the driver and board DTS when
> the marvell,armada-8k-gpio compatible is used.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>=20
> Notes:
>     Changes in v4:
>     - Reword commit message slightly
>     - Add review from Krzysztof
>     Changes in v3:
>     - Split off from 1:1 conversion patch
>=20
>  Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml b/Doc=
umentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> index 459ec35864fe..f1bd1e6b2e1f 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> @@ -45,6 +45,10 @@ properties:
>        - const: pwm
>      minItems: 1
> =20
> +  offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Offset in the register map for the gpio registers (in b=
ytes)
> +
>    interrupts:
>      description: |
>        The list of interrupts that are used for all the pins managed by t=
his
> @@ -68,6 +72,10 @@ properties:
>    "#gpio-cells":
>      const: 2
> =20
> +  marvell,pwm-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Offset in the register map for the pwm registers (in by=
tes)
> +

It would probably have been better to add multiple compatible strings to
hide parameters like this, but given that this has been in the DTS files
for more than a year at this point, it's probably too late now.

Acked-by: Thierry Reding <thierry.reding@gmail.com>

Linus, Bartosz, will you pick up the series into the GPIO tree?

Thierry

--SkTTDVTmLy6JJbVk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKzHykACgkQ3SOs138+
s6HfMg/+IXbNLZGYotD14cA93MJJgysADEHRcrOJlhkF9pBSWUTs9Zm7S8ANF0MV
tzT7MP4X+Y9RINBnwGWMswPiUzEGA5NZTMaKIBp9fcChzf9TQQipkxbIRIf1Yh+F
qfP3uxiHo02iL7elmHuhuCAp7RFVVYexwGe6tRT6m8kDY88N5ql3tXyf0xFlw5NW
6xDFtE6Z2DeWk4MGmmqlX0qaehZT5PSdKi21CkJri2qO2VS9jBRDQ90ylUSxGhxz
0FVyU6ZVbfeUCAhW2Ea4hs+aiUgLeOsn8BzSte1wTDD53J37eW0rsDhXYVE1DYkQ
Hmkmr/GcXGa4bRCpTmdVUlgKLMt0DZDKsn/rBcyGTan7uLXm3mDeapmpvxFkiGPx
TAW+X+fG4sdVryaJFdTnPVTZDvDNgAbOsPbzWgypXFM/Dztus1zty5dYRZ06c/0A
o6KMZad01NpsDgTfDLvoVJ8hWrOqzLkFHQzpsCm0uN8+q32afR4hcWn6X2SlUZ+9
6iSg9wVlJ/4yUtelu/c0NpExlf72aqSKiy/d0vrLrMgx+RXWxqGEJT1sqDhfIq7j
+zEuHaywwU2oBWf6V1vZeO0+u35Akpl1D7BsDIE3Bf/fty1DW5rNTYmk2b8+p5nn
sHiltrlZ6UQJWXoglpqZPoKYOtgkg8Y2/FcoYqo0vwvFrtFFJyI=
=KFs0
-----END PGP SIGNATURE-----

--SkTTDVTmLy6JJbVk--
