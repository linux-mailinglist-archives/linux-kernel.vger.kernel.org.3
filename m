Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21F3502EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344897AbiDOSYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiDOSYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:24:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E198E183;
        Fri, 15 Apr 2022 11:21:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bv19so16590795ejb.6;
        Fri, 15 Apr 2022 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aY2i70GcxPM0t2j3zWxTuNc97f9BOBUas6jIJc8m0/0=;
        b=e2/JQZr5KfImS1MZLgF8x0G8Ugy+IalHb4/nfvLGJljKEkBueU3lYaCB6l++dVJ2T2
         ct7bfOhn4kEOMv+637QbdyhS9JUFuWIoT9foyYKwaGCbT9bFqZUYsTnaiKTD9uskqf1j
         Ek9/HZErQ7IiXqI6RvMJuUn9R8IxNG2NlBjMcwnlzzK17Ov3AF0ti/AzlowENM8JsNq4
         pXnobt4hQF+ymQv/PVIbX3kgj1HEiuqYxgu1jMqbL7gO0MGI0zbaxM2B3Q4eqEy79MlW
         VNgXQHbrgoHdPuzekv1iCnAbGCs3o6x/0wFq/NQm/cRzvlIeNqPwCPoNz/bAoJG8VhuK
         EsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aY2i70GcxPM0t2j3zWxTuNc97f9BOBUas6jIJc8m0/0=;
        b=G6lleSX1SgwLSr2wA3k8Jg6VXp6v/i3CywHieje0/OshcBjlqBRwwuYee5vbH68Y4i
         fBV6Rbr2y0ToZKPpDcK+bu/MK9UwEBkVYMjf5N/UM+7v/IJcIUQRE5rovIPirwNdePsx
         ScQMlhTdxlUI4nWTrlY9COQQOEgciZ9qXB4WKpmMhBN27QF+CE9eM14oh5/rdUtxj4ZS
         9A1VNngYoMgJ+WyoPdr6W0C++LiMZwTUa0Z0/VwWKIDT8/5ymL8d5vorBrPJL7CO9f5s
         0T9eKJkW+FCLyh9vgN0U46w3SKBJSEwJLcTz6pC2BWN6nlBaKjm1Tl41zBXaaL611F6k
         mdxQ==
X-Gm-Message-State: AOAM532em0Nmsa4iSZ0HuTAvHpKnXLWqihgeuW1y8f/75Je6l2XkIQY7
        9r3OtUT+QjcK4YVSk6D/E4M=
X-Google-Smtp-Source: ABdhPJzCq6JERosCiAk6D1rln8EykVMZGfAoAS2LM2VBpWXvpllvzlCPidoEpqmP3Q4iCLXYpm4R5w==
X-Received: by 2002:a17:907:168a:b0:6e8:d125:1d24 with SMTP id hc10-20020a170907168a00b006e8d1251d24mr273806ejc.508.1650046896395;
        Fri, 15 Apr 2022 11:21:36 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id lb4-20020a170907784400b006e0d13f65e5sm1910608ejc.167.2022.04.15.11.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 11:21:36 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 3/3] Input: sun4i-lradc-keys: Add support for R329 and D1
Date:   Fri, 15 Apr 2022 20:21:34 +0200
Message-ID: <2097461.irdbgypaU6@jernej-laptop>
In-Reply-To: <20220414002349.24332-3-samuel@sholland.org>
References: <20220414002349.24332-1-samuel@sholland.org> <20220414002349.24332-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 14. april 2022 ob 02:23:48 CEST je Samuel Holland napisal=
(a):
> This LRADC variant uses the same 3/4*AVCC reference voltage as the A83T
> variant. The R329 and D1 LRADCs appear to be identical, so D1 support is
> accomplished through having the R329 LRADC as a fallback compatible.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>=20
> Changes in v2:
>  - Set the new flag for the R329 variant.
>=20
>  drivers/input/keyboard/sun4i-lradc-keys.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c
> b/drivers/input/keyboard/sun4i-lradc-keys.c index
> 5630334a6c09..8f9bfb05244d 100644
> --- a/drivers/input/keyboard/sun4i-lradc-keys.c
> +++ b/drivers/input/keyboard/sun4i-lradc-keys.c
> @@ -78,6 +78,12 @@ static const struct lradc_variant r_lradc_variant_a83t=
 =3D
> { .divisor_denominator =3D 4
>  };
>=20
> +static const struct lradc_variant lradc_variant_r329 =3D {
> +	.divisor_numerator =3D 3,
> +	.divisor_denominator =3D 4,
> +	.has_clock_reset =3D true,
> +};
> +
>  struct sun4i_lradc_keymap {
>  	u32 voltage;
>  	u32 keycode;
> @@ -323,6 +329,8 @@ static const struct of_device_id sun4i_lradc_of_match=
[]
> =3D { .data =3D &lradc_variant_a10 },
>  	{ .compatible =3D "allwinner,sun8i-a83t-r-lradc",
>  		.data =3D &r_lradc_variant_a83t },
> +	{ .compatible =3D "allwinner,sun50i-r329-lradc",
> +		.data =3D &lradc_variant_r329 },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_lradc_of_match);




