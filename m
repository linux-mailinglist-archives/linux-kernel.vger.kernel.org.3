Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64460554BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351215AbiFVOAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiFVOAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:00:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1673369C0;
        Wed, 22 Jun 2022 07:00:45 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i10so19796721wrc.0;
        Wed, 22 Jun 2022 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kUoPBZyP0axk6nRKrhH6g/mHLGZVisdHs+5kDGpekpo=;
        b=k1Ju7wSZg82QWvOtXh5C+tGY8yQTX/08iv3KdTAcyuRnqE58hCx1JQexXSe+URDpdE
         p0ImgnAGaHjE4JislySg6qecoHYrJEejC/GKLB6sT9jN3wrUP9rOG2XIOForITnd02x0
         jhYNwfPB2Ui/+rtwPhJukncCC+3XlAS1L+lRz2bl36BP7Jua1NPToYPE73iRGmqhze51
         o7wdeYArozyn8VTtFZYDGYT6lbHLJjuhRIUJRJsvCozJh1TMeIXHlFc7KREnPbjXtdY+
         CfZiTET5VyMN8qT2QjXSp7TEVMHYK/7YO0SOSiusTq/eFQ92Wv1PlC+bAT9u9ZB3fSWN
         vzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kUoPBZyP0axk6nRKrhH6g/mHLGZVisdHs+5kDGpekpo=;
        b=Zwh8DngaovadWe5moBvxoMu2tq+eUVu1XA9rhxLq1nkPaV9ewPTFzNwS3UoxvBu3C6
         NCfz9NYaxsHQ8bjiU3ptPor2ZvQCT1uEC3I5KkdsaSUTy2uh7h20nwvYvJF08BHDQv/r
         LiP1wk7CA/7loK7xDwfVit5rOMt15Y8vnh/uw792HTRoRr1A+kUjYYZHuZqbcHXutZOD
         4W1tCpCKEmJ4OK0U5PkngKRAb53vLyEnOsePpVBdfDd3HwiOTVv7u9N3NzqUlPBvxesr
         8kap05B9e46t7vNhmC+INenr0CzhhgbxLWzwy3h/wFU0shNXta8UwYlpEyAbEcrx1J1d
         PzWg==
X-Gm-Message-State: AJIora8e9M0SoojE/6WjI6WvlMnWUPNrA4kpMxnTQHizvNGS48+XUKih
        OwXxxbkuYIMH9yJfYSQE1lA=
X-Google-Smtp-Source: AGRyM1tHnt/jgPsUPVHQvg5sU4veue4z+CecoIbCr7Phmv2bIYomTp7Bt+U4+PUBWvt0gfS8ohWH7g==
X-Received: by 2002:adf:fb10:0:b0:207:af88:1eb9 with SMTP id c16-20020adffb10000000b00207af881eb9mr3598860wrr.238.1655906444093;
        Wed, 22 Jun 2022 07:00:44 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o4-20020adfcf04000000b0020ff877cfbdsm16655568wrj.87.2022.06.22.07.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 07:00:43 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:00:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: add MT8365 SoC binding
Message-ID: <YrMgiCPMsb3Y8Zd9@orome>
References: <20220530205038.917431-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iKffDT5KCf9O/u8c"
Content-Disposition: inline
In-Reply-To: <20220530205038.917431-1-fparent@baylibre.com>
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


--iKffDT5KCf9O/u8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 30, 2022 at 10:50:37PM +0200, Fabien Parent wrote:
> Add binding documentation for the MT8365 SoC.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
> v2: fix clock description (five -> three)
>=20
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
>  1 file changed, 2 insertions(+)

Both patches applied, thanks.

Thierry

--iKffDT5KCf9O/u8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKzIIgACgkQ3SOs138+
s6EZwhAAtTbNvEnm90ZYyOiXMFI5+PaLF4vJyVAEMi3M8wnJERzD+fx6zlfpdey5
HUOgg7d+R4Oma1wuGFo3HAMcIuG+/pel+eE8f7zGiYkcb2QNpzTrRsVQwBrjCPoY
6upls6fu2Xhzebdkntda3Nnj+JqbPExxmAmrDVgudViBVXKGLLo8l+aFAf1xJYoZ
AphfyPCLyxnC+MB4G0qrQVcPOdTQq433t+BnXZ9C4EnaEZA0vcjFk/CpIYXYme03
sPbI06xJDZVuGluoEaoRq4O6r/v0foxfThn5tjZuwQJvSc2qEX5eJD0U1IFZdsj9
3fJKnrmTQYA7zORslHNQV7aGCIRTtf9v87XvilY9G9P8n0Lp7rGiJrBQg0Kx/cXN
Bb3j+0JnXQtzBB+v4226k/PMP/SDMviTKkQMp3Ls4DM4QOFb8Rn0pdGEhtKVV/FS
ms3inwjO91jM11En+7DZgQHcA2Lm6fuHBhqiOzvyVTzRFj8BHrjg7iddjnhRW5uU
I3V7ln95+aPaQzTQd0qFdg0cngmtc7Tgs04YmV2Rb1e2Nk4Db64h17jiOaeHsU03
9gOBNpRUQ1neEkTRQ+dZCnXfUxnPgSeWHsOkrYIQgEmc4YrGAEIkgSFZUVSYQJFZ
uCQYV9nCrnBcs+PoOwb7aX+5Bk3Cj+xeM0xp9KChkwt4Km/hM1E=
=9amw
-----END PGP SIGNATURE-----

--iKffDT5KCf9O/u8c--
