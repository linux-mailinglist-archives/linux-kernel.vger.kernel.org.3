Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8AA52EE09
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350228AbiETOWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345975AbiETOWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:22:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF8916329D;
        Fri, 20 May 2022 07:22:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o22so9837327ljp.8;
        Fri, 20 May 2022 07:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m/O8UBKE0c2cSYufgjXBbNvLdDE1ALuRtN6rsL7jV4U=;
        b=Y1n9Tpe6rOxQyxePWnDR1MaQDvfpGxBGwVuDCY1yXBOYEgPEjnN1XN6rYIHpAeVbL4
         u09U6NhvUpj+CX5cPGqgcEv9QTndEm7qNfvKNBc/Fk2GjqaIqQwmzF8Juns3jFsnfYDI
         OC3OYS5xLjXLkORT6TJCO5Q1KLlccUr2QwrSt5Alee+t49+mDWgrCtM1DO4LZIKyxl4H
         5ZKt9Gug9r11C8IO4WvXs5rSaaAsfdDbhwEW0furWWyejeTQs09uR7HZbifCIhDR7xZ2
         WTF22eaVs2CuwS8jd/3segFqU7vV1MXXMewC7OtmlZagRZDQalKLgEknB8xwBdr9tGQT
         o85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m/O8UBKE0c2cSYufgjXBbNvLdDE1ALuRtN6rsL7jV4U=;
        b=OzVqVqka4KxN+i9gSvIMDmn4bupEh7KjbLC0Ln27Wiqj1RyluEiQlduDI+2wGZYS8a
         JzpnyJbmXOvzxQTbWhcC3i5fHt4oAJQmDeb2KRnT8UMzxp1GTrSfH8+XsxdRRTdmfpdS
         Q8/yX0mhKPL67tJn2tIKRCpGWi1g7G39d2pT2D1iVhRe+0od1eFIV+wtLjR3uz8Cl3IU
         WildLWbSUOvDawODuGOZrDNTptYi5idusUoRy3QuVLMEwWAgZW8YbqQo0DR1Jl//FhVF
         FiCSzgupKu/m+51aaH1mYt67pZpsjaJfQ7KEpVG9y98VkUs2aiawansta6v5YA0xVX1I
         N1KA==
X-Gm-Message-State: AOAM533jEb5coC1a8ep60TyKIG73hh0idbQMh5pBJRWK+71fIsPcx4kN
        8JdcKITveZLXSLyyCOGh8W4=
X-Google-Smtp-Source: ABdhPJyuKO7AzKSZ1dg5Btd/SfXZvnHzAuI8HlG677gz26ktEZ3LD4xIAFSufc94XaudHIKZGHVxCg==
X-Received: by 2002:a2e:9d87:0:b0:253:e12a:916a with SMTP id c7-20020a2e9d87000000b00253e12a916amr2197ljj.502.1653056569307;
        Fri, 20 May 2022 07:22:49 -0700 (PDT)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id c5-20020a056512324500b00477b6ffffa6sm679897lfr.65.2022.05.20.07.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 07:22:48 -0700 (PDT)
Date:   Fri, 20 May 2022 16:22:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: Re: [PATCH 0/2] MediaTek Helio X10 MT6795 - PWM driver
Message-ID: <YoekNfGTvCfjDMDp@orome>
References: <20220503105405.54832-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UWrvBWnZYpzwCo1F"
Content-Disposition: inline
In-Reply-To: <20220503105405.54832-1-angelogioacchino.delregno@collabora.com>
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


--UWrvBWnZYpzwCo1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 03, 2022 at 12:54:03PM +0200, AngeloGioacchino Del Regno wrote:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
>=20
> This series introduces support for the PWMs found in Helio X10.
>=20
> Tested on a Sony Xperia M5 (codename "Holly") smartphone.
>=20
> AngeloGioacchino Del Regno (2):
>   pwm: pwm-mediatek: Add support for MediaTek Helio X10 MT6795
>   dt-bindings: pwm: pwm-mediatek: Add documentation for MT6795 SoC
>=20
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  drivers/pwm/pwm-mediatek.c                             | 7 +++++++
>  2 files changed, 8 insertions(+)

Applied, thanks.

Thierry

--UWrvBWnZYpzwCo1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmKHpDUACgkQ3SOs138+
s6FFHQ/9HkWx87OkIttu0M8J/TwAIYF6wGE76TI54RMoEBlGQLLIbfjkJx4wI7bq
kQh7j6LLB9exFF5WaP+HmskXzadBSEBJH1/H7e9/cLMGiJABtx/KfDjQrKslw4kg
qXupNoRExePzrFUMte/Yo9VOZCb750W7j7ummOoxOJLPBQXZ0TiY/ryiedBvDNHI
qw5tePjX6Tv+hP8SuLeJCH9KGaYK4oUJVNd8P1F+zMlvdlFpVoZ48PBNcTPyUxFA
VC/cwXb7I2qce1FoVjQT9K+hON7qzr/VLo5sSOI/QITo5pvIFVTgU++gY2GvgIuF
ukgWprZSIjFYWxCe053sKNFnzaJZ5V1CFKylpsw5864AsSo8PSwcLjjytsc/cF5I
o4Ke9j0IR22lhc89h/eJOpVPuZEUFes6pQtMUUFUcuCEksfODlJs5l2X1KKnivo4
+b21+ryugvr12Yogf0VGiU0JUS2KgfqbF5hduIuQesXoLoTXVgy885DqmPuI8Tmz
zyoZNj2a1qysVYdsybkFDuNmFy9rqzZmqQjuSIF/jrh4YnEaOaSHCI4ApQFB1vQN
LOIFk8pw+vlH7WV51n+0RIRWpB77Q3LWsu0kIZq0tZZnYXe9td6sOXEtoSAHyxLE
ir6jzWbR/cJEJ8ImS/7YaeQpzUa+OQQ+U4HchIpQQ8E+to20dnM=
=7cPS
-----END PGP SIGNATURE-----

--UWrvBWnZYpzwCo1F--
