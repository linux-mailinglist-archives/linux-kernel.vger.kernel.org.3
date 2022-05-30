Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFA7538856
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 22:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbiE3Uvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 16:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241431AbiE3Uva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 16:51:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6698214E
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:51:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h5so8016870wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 13:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g7RcvSebEf29B8H+bDmdz7sWUT/TFnBJvVooNtKpo/o=;
        b=vPfXLiASC8Br4/YkILcgFJmZQkhobWqlqZyCIKdn3OyqYgTUuDcSuCLShF9U8YZ44Z
         tChPEAH8m1/vmjFG9E4fbaUDZEFFfUJakWc2atEfllCZUDx5WrXA+e9i6kU3VvnE34la
         ocaLns5gZIgEtG1/Kz4kBcL8sFMliRWpe+KzMFHo4hcsk3lzcS1zScuwGFFwM1lfNivL
         XiRlBC5QcStQIZIC1KLNt79k/dXkON6nXF3Ls7MWw+A+Wn5kYRiigcsDMlpWl+xc0k3X
         fAz7ZgwdRcG2BXPz5phITrzaAy+X2SLXe+qfzMeBd+SS7m+1BD8aqZ8kt+EIivZEJtFE
         lmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g7RcvSebEf29B8H+bDmdz7sWUT/TFnBJvVooNtKpo/o=;
        b=cHbK+EcfUYWD/tcq4UNDPxBmAqbQZmOX9mMqIqH6oRQ3RB/fq8IEsQMoT3fojtZIg3
         LUi7+B0giCDiUgNftuQl9YxfrWf3Mef0Uw+hrk2kvIWtq/9yASDy11BS1IU0DjsuGWab
         BDOrB62i/GB3LYdmUiR6Oc3GFSTEnOlaKi/XAFY0354/vmDCkCOF2urtT1RVt093QH6F
         TuAmd29x0gzNxIjTAFWlpLpjtHD5/lU6kekCYbElLjYgAxIaeOGRay2VWTOej49Pkp8N
         i/CV9GKmUmCpIDbjxS+Uzon0UpOG4/kl6GOyTYlt+ho7OjEvzsjQCfmN59FHZewWgDPh
         Tv8w==
X-Gm-Message-State: AOAM533icrPaVOONX6F1vNf/L/9CsYHN1q17nbHwEnXbepC+O11gVShC
        cJoyMWUANBTNjPXzsd0trx7g2g==
X-Google-Smtp-Source: ABdhPJxX4QGvgimT506lT7zjJVN3DNTUvm4iSrw4GL/r/4dCBtZy852caJFC7R9WI8Pl82GIlq0aNA==
X-Received: by 2002:adf:fb04:0:b0:20c:ff5a:d305 with SMTP id c4-20020adffb04000000b0020cff5ad305mr45997097wrr.95.1653943887631;
        Mon, 30 May 2022 13:51:27 -0700 (PDT)
Received: from helium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d648c000000b0020c5253d90csm10053495wri.88.2022.05.30.13.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 13:51:26 -0700 (PDT)
Date:   Mon, 30 May 2022 22:51:20 +0200
From:   Fabien Parent <fparent@baylibre.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: add MT8365 SoC binding
Message-ID: <20220530205120.q3gi2fhua5lbxnmj@helium.lan>
References: <20220530202136.906407-1-fparent@baylibre.com>
 <20220530203101.5wq52q5pq523ewuu@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kbnb43vxe2gkvrvk"
Content-Disposition: inline
In-Reply-To: <20220530203101.5wq52q5pq523ewuu@pengutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kbnb43vxe2gkvrvk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 30, 2022 at 10:31:01PM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, May 30, 2022 at 10:21:34PM +0200, Fabien Parent wrote:
> > Add binding documentation for the MT8365 SoC.
> >=20
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/D=
ocumentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > index 25ed214473d7..ac5c58bbb22d 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > @@ -8,6 +8,7 @@ Required properties:
> >     - "mediatek,mt7628-pwm": found on mt7628 SoC.
> >     - "mediatek,mt7629-pwm": found on mt7629 SoC.
> >     - "mediatek,mt8183-pwm": found on mt8183 SoC.
> > +   - "mediatek,mt8365-pwm": found on mt8365 SoC.
> >     - "mediatek,mt8516-pwm": found on mt8516 SoC.
> >   - reg: physical base address and length of the controller's registers.
> >   - #pwm-cells: must be 2. See pwm.yaml in this directory for a descrip=
tion of
> > @@ -17,6 +18,7 @@ Required properties:
> >                  has no clocks
> >     - "top": the top clock generator
> >     - "main": clock used by the PWM core
> > +   - "pwm1-3": the five per PWM clocks for mt8365
>=20
> I think you either want s/3/5/ or s/five/three/ here?!

Thanks. Fixed in v2.

BR,
Fabien

>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |



--kbnb43vxe2gkvrvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQyJHfU3UNW7IG61XVJKc6g3CeAAFAmKVLkcACgkQVJKc6g3C
eAD8MhAAq04bhlW59dA7G2QxeUOL60bMUzB6aHtyUWFSLDgMwO410j+eNRD2IT4w
pcuyVtI/DxqdHKqEGxD0on8zwRF2yEN3jxwdKFxoQ7+CDINxWKqyvk6HAZtNmEw8
eEq5xNXGTowOIwkvVoKETjRbnzEnmB89kLYCg+SqlE+8H2LW8GjhhGtFU2Q/8K7v
hsAzwb7rWNwnYLoVdl1gu1he78z//mq5hyNzWVspVS3ZCeekxmd/0dlG+Gz6sEwv
EVJFljX3PwhZZsWYGZGql/FiSwslrtZIDLTvv5UQK8vID7/NhE8lBRsreSiwVux6
8wqvB34HO3eDnRjflHpgyjnzJGCuQa/DN05paCv14abQAig9eSdhbmLpLnp/6N1j
/AQ2jCu8sNhJUzqetocp87qEmzvlYgKbvSv7NfiCklk1MU5cv/KB1tF+V1MpiSTO
P5t6hZVqMG3511ES0Im1VUCQ2WqsMVPhe2PAHmek0hJoUyPIkFGOz0bg04/hDG1s
H25LL/dHcHk8pU3SaM0QnLmxmLYmzEZ9nX4EK8hK0IyhRir3G6u1ruEkr46/VczL
9SNUPumDv3nQvJ9QcrsNooDdPUo0enRX+IiZe2G7QzZCyPW6LdCQFFgPBYAKSjf/
oUONf/ORm1vqWTP7DxtQRTsKiuyeDat+Yt3DgIE4ArZKbUP5LfI=
=qbYd
-----END PGP SIGNATURE-----

--kbnb43vxe2gkvrvk--
